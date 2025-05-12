from flask import Blueprint, render_template, redirect, url_for, flash, request, abort
from flask_login import login_required, current_user
from app.models import User, Reimbursement, ReimbursementStatus, File, UserRole
from app.forms.reimbursement import ReimbursementForm, ReviewForm
from app.utils.file_utils import save_file
from app import db
from datetime import datetime

reimbursement_bp = Blueprint('reimbursement', __name__)

@reimbursement_bp.route('/')
@login_required
def index():
    # Show appropriate view based on user role
    if current_user.is_employee():
        return redirect(url_for('reimbursement.my_requests'))
    elif current_user.is_manager():
        return redirect(url_for('reimbursement.pending_approvals'))
    elif current_user.is_finance():
        return redirect(url_for('reimbursement.pending_processing'))
    
    abort(403)  # Forbidden if unknown role

@reimbursement_bp.route('/requests')
@login_required
def my_requests():
    if not current_user.is_employee():
        flash('Only employees can view this page', 'danger')
        return redirect(url_for('reimbursement.index'))
    
    reimbursements = Reimbursement.query.filter_by(employee_id=current_user.id)\
        .order_by(Reimbursement.created_at.desc()).all()
    
    return render_template('reimbursement/my_requests.html', 
                          title='My Reimbursement Requests',
                          reimbursements=reimbursements)

@reimbursement_bp.route('/create', methods=['GET', 'POST'])
@login_required
def create_request():
    if not current_user.is_employee():
        flash('Only employees can create reimbursement requests', 'danger')
        return redirect(url_for('reimbursement.index'))
    
    form = ReimbursementForm()
    
    if form.validate_on_submit():
        # Create new reimbursement request
        reimbursement = Reimbursement(
            title=form.title.data,
            description=form.description.data,
            amount=form.amount.data,
            employee_id=current_user.id,
            status=ReimbursementStatus.SUBMITTED
        )
        
        # Handle receipt upload
        if 'receipt' in request.files and request.files['receipt'].filename:
            file = request.files['receipt']
            
            try:
                # Save file to disk
                file_data = save_file(file)
                
                # Create file record
                receipt_file = File(
                    filename=file_data['filename'],
                    original_filename=file_data['original_filename'],
                    file_path=file_data['file_path'],
                    file_size=file_data['file_size'],
                    file_type=file_data['file_type'],
                    description=f"Receipt for reimbursement: {form.title.data}",
                    user_id=current_user.id
                )
                
                db.session.add(receipt_file)
                db.session.flush()  # Get ID for the newly created file
                
                # Link receipt to reimbursement
                reimbursement.receipt_file_id = receipt_file.id
                
            except Exception as e:
                flash(f'Error uploading receipt: {str(e)}', 'danger')
                return redirect(request.url)
        
        db.session.add(reimbursement)
        db.session.commit()
        
        flash('Reimbursement request submitted successfully!', 'success')
        return redirect(url_for('reimbursement.my_requests'))
    
    return render_template('reimbursement/create.html', 
                          title='Create Reimbursement Request',
                          form=form)

@reimbursement_bp.route('/<int:reimbursement_id>')
@login_required
def view_request(reimbursement_id):
    reimbursement = Reimbursement.query.get_or_404(reimbursement_id)
    
    # Check if user has permission to view
    if current_user.is_employee() and reimbursement.employee_id != current_user.id:
        abort(403)  # Forbidden
    
    return render_template('reimbursement/view.html',
                          title=f'Reimbursement: {reimbursement.title}',
                          reimbursement=reimbursement)

@reimbursement_bp.route('/pending-approvals')
@login_required
def pending_approvals():
    if not current_user.is_manager():
        flash('Only managers can view this page', 'danger')
        return redirect(url_for('reimbursement.index'))
    
    reimbursements = Reimbursement.query.filter_by(status=ReimbursementStatus.SUBMITTED)\
        .order_by(Reimbursement.created_at.asc()).all()
    
    return render_template('reimbursement/pending_approvals.html', 
                          title='Pending Approvals',
                          reimbursements=reimbursements)

@reimbursement_bp.route('/review/<int:reimbursement_id>', methods=['GET', 'POST'])
@login_required
def review_request(reimbursement_id):
    if not current_user.is_manager():
        flash('Only managers can review reimbursement requests', 'danger')
        return redirect(url_for('reimbursement.index'))
    
    reimbursement = Reimbursement.query.get_or_404(reimbursement_id)
    
    if reimbursement.status != ReimbursementStatus.SUBMITTED:
        flash('This request has already been reviewed', 'warning')
        return redirect(url_for('reimbursement.pending_approvals'))
    
    form = ReviewForm()
    
    if form.validate_on_submit():
        # Update reimbursement status
        if form.approve.data:
            reimbursement.status = ReimbursementStatus.APPROVED
        else:
            reimbursement.status = ReimbursementStatus.REJECTED
        
        reimbursement.manager_id = current_user.id
        reimbursement.manager_notes = form.notes.data
        reimbursement.approved_at = datetime.utcnow()
        
        db.session.commit()
        
        flash('Reimbursement request reviewed successfully!', 'success')
        return redirect(url_for('reimbursement.pending_approvals'))
    
    return render_template('reimbursement/review.html',
                          title=f'Review: {reimbursement.title}',
                          reimbursement=reimbursement,
                          form=form)

@reimbursement_bp.route('/pending-processing')
@login_required
def pending_processing():
    if not current_user.is_finance():
        flash('Only finance officers can view this page', 'danger')
        return redirect(url_for('reimbursement.index'))
    
    reimbursements = Reimbursement.query.filter_by(status=ReimbursementStatus.APPROVED)\
        .order_by(Reimbursement.approved_at.asc()).all()
    
    return render_template('reimbursement/pending_processing.html', 
                          title='Pending Processing',
                          reimbursements=reimbursements)

@reimbursement_bp.route('/process/<int:reimbursement_id>', methods=['GET', 'POST'])
@login_required
def process_request(reimbursement_id):
    if not current_user.is_finance():
        flash('Only finance officers can process reimbursement requests', 'danger')
        return redirect(url_for('reimbursement.index'))
    
    reimbursement = Reimbursement.query.get_or_404(reimbursement_id)
    
    if reimbursement.status != ReimbursementStatus.APPROVED:
        flash('This request is not approved for processing', 'warning')
        return redirect(url_for('reimbursement.pending_processing'))
    
    form = ReviewForm()
    
    if form.validate_on_submit():
        # Update reimbursement status
        reimbursement.status = ReimbursementStatus.PROCESSED
        reimbursement.finance_id = current_user.id
        reimbursement.finance_notes = form.notes.data
        reimbursement.processed_at = datetime.utcnow()
        
        db.session.commit()
        
        flash('Reimbursement request processed successfully!', 'success')
        return redirect(url_for('reimbursement.pending_processing'))
    
    return render_template('reimbursement/process.html',
                          title=f'Process: {reimbursement.title}',
                          reimbursement=reimbursement,
                          form=form)
