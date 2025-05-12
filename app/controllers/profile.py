from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_required, current_user
from app.forms.profile import ProfileUpdateForm, PasswordChangeForm
from app.utils.file_utils import save_file
from app import db
import os

profile_bp = Blueprint('profile', __name__)

@profile_bp.route('/')
@login_required
def profile():
    return render_template('profile/view.html', title='My Profile')

@profile_bp.route('/edit', methods=['GET', 'POST'])
@login_required
def edit_profile():
    form = ProfileUpdateForm(obj=current_user)
    
    if form.validate_on_submit():
        # Update profile info
        current_user.first_name = form.first_name.data
        current_user.last_name = form.last_name.data
        current_user.username = form.username.data
        current_user.email = form.email.data
        
        # Handle profile picture upload
        if 'profile_picture' in request.files and request.files['profile_picture'].filename:
            file = request.files['profile_picture']
            
            try:
                # Save file to disk
                file_data = save_file(file)
                
                # Update user's profile picture
                if current_user.profile_picture:
                    # Remove old profile picture
                    old_pic_path = os.path.join(current_app.config['UPLOAD_FOLDER'], current_user.profile_picture)
                    if os.path.exists(old_pic_path):
                        os.remove(old_pic_path)
                
                current_user.profile_picture = file_data['filename']
                
            except Exception as e:
                flash(f'Error uploading profile picture: {str(e)}', 'danger')
        
        db.session.commit()
        flash('Your profile has been updated successfully!', 'success')
        return redirect(url_for('profile.profile'))
    
    return render_template('profile/edit.html', title='Edit Profile', form=form)

@profile_bp.route('/change-password', methods=['GET', 'POST'])
@login_required
def change_password():
    form = PasswordChangeForm()
    
    if form.validate_on_submit():
        if not current_user.check_password(form.current_password.data):
            flash('Current password is incorrect', 'danger')
            return redirect(url_for('profile.change_password'))
        
        current_user.set_password(form.new_password.data)
        db.session.commit()
        
        flash('Your password has been changed successfully!', 'success')
        return redirect(url_for('profile.profile'))
    
    return render_template('profile/change_password.html', title='Change Password', form=form)
