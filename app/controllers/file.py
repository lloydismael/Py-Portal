from flask import Blueprint, render_template, redirect, url_for, flash, request, send_file, current_app, jsonify
from flask_login import login_required, current_user
from app.models import File, User
from app.forms.file import FileUploadForm
from app.utils.file_utils import save_file, generate_qr_code
from app import db
import os

file_bp = Blueprint('file', __name__)

@file_bp.route('/')
@login_required
def file_list():
    files = File.query.filter_by(user_id=current_user.id).order_by(File.created_at.desc()).all()
    return render_template('file/list.html', title='My Files', files=files)

@file_bp.route('/upload', methods=['GET', 'POST'])
@login_required
def upload_file():
    form = FileUploadForm()
    if form.validate_on_submit():
        if 'file' not in request.files:
            flash('No file part', 'danger')
            return redirect(request.url)
        
        file = request.files['file']
        if file.filename == '':
            flash('No selected file', 'danger')
            return redirect(request.url)
        
        try:
            # Save file to disk
            file_data = save_file(file)
            
            # Create file record in database
            new_file = File(
                filename=file_data['filename'],
                original_filename=file_data['original_filename'],
                file_path=file_data['file_path'],
                file_size=file_data['file_size'],
                file_type=file_data['file_type'],
                description=form.description.data,
                is_public=form.is_public.data,
                user_id=current_user.id
            )
            
            db.session.add(new_file)
            db.session.commit()
            
            # Generate QR code for file
            qr_path = generate_qr_code(new_file.id)
            new_file.qr_code_path = os.path.basename(qr_path)
            db.session.commit()
            
            flash('File uploaded successfully!', 'success')
            return redirect(url_for('file.file_detail', file_id=new_file.id))
            
        except Exception as e:
            flash(f'Error uploading file: {str(e)}', 'danger')
            return redirect(request.url)
    
    return render_template('file/upload.html', title='Upload File', form=form)

@file_bp.route('/<int:file_id>')
@login_required
def file_detail(file_id):
    file = File.query.get_or_404(file_id)
    
    # Only owner can see file details unless it's public
    if file.user_id != current_user.id and not file.is_public:
        flash('You do not have permission to view this file', 'danger')
        return redirect(url_for('file.file_list'))
    
    return render_template('file/detail.html', title=file.original_filename, file=file)

@file_bp.route('/download/<int:file_id>')
def download_file(file_id):
    file = File.query.get_or_404(file_id)
    
    # Check if user has permission to download
    if not file.is_public and (not current_user.is_authenticated or file.user_id != current_user.id):
        flash('You do not have permission to download this file', 'danger')
        return redirect(url_for('main.index'))
    
    # Increment download count
    file.download_count += 1
    db.session.commit()
    
    return send_file(file.file_path, as_attachment=True, download_name=file.original_filename)

@file_bp.route('/delete/<int:file_id>', methods=['POST'])
@login_required
def delete_file(file_id):
    file = File.query.get_or_404(file_id)
    
    # Only owner can delete file
    if file.user_id != current_user.id:
        flash('You do not have permission to delete this file', 'danger')
        return redirect(url_for('file.file_list'))
    
    try:
        # Delete file from disk
        if os.path.exists(file.file_path):
            os.remove(file.file_path)
        
        # Delete QR code if exists
        qr_path = os.path.join(current_app.config['UPLOAD_FOLDER'], file.qr_code_path)
        if os.path.exists(qr_path):
            os.remove(qr_path)
        
        # Delete database record
        db.session.delete(file)
        db.session.commit()
        
        flash('File deleted successfully', 'success')
    except Exception as e:
        flash(f'Error deleting file: {str(e)}', 'danger')
    
    return redirect(url_for('file.file_list'))

@file_bp.route('/upload-progress', methods=['POST'])
@login_required
def upload_progress():
    # This is a placeholder for upload progress
    # In a real app, you would implement this with proper file upload progress tracking
    return jsonify({
        'status': 'success',
        'progress': 100,
        'message': 'Upload complete'
    })
