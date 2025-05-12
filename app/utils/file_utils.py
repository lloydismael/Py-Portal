import os
import uuid
import qrcode
from PIL import Image
from flask import current_app, url_for

def allowed_file(filename):
    """Check if the file has an allowed extension"""
    return '.' in filename and \
        filename.rsplit('.', 1)[1].lower() in current_app.config['ALLOWED_EXTENSIONS']

def save_file(file):
    """Save file to disk and return filename"""
    # Generate unique filename
    file_ext = file.filename.rsplit('.', 1)[1].lower()
    unique_filename = f"{str(uuid.uuid4())}.{file_ext}"
    
    # Save file
    file_path = os.path.join(current_app.config['UPLOAD_FOLDER'], unique_filename)
    file.save(file_path)
    
    return {
        'filename': unique_filename,
        'original_filename': file.filename,
        'file_path': file_path,
        'file_size': os.path.getsize(file_path),
        'file_type': file.content_type
    }

def generate_qr_code(file_id):
    """Generate QR code for file download link"""
    file_url = url_for('file.download_file', file_id=file_id, _external=True)
    
    # Create QR code
    qr = qrcode.QRCode(
        version=1,
        error_correction=qrcode.constants.ERROR_CORRECT_H,
        box_size=10,
        border=4,
    )
    qr.add_data(file_url)
    qr.make(fit=True)
    
    # Create image
    qr_img = qr.make_image(fill_color="#1E88E5", back_color="white")
    
    # Save image
    qr_filename = f"qr_{file_id}.png"
    qr_path = os.path.join(current_app.config['UPLOAD_FOLDER'], qr_filename)
    qr_img.save(qr_path)
    
    return qr_path
