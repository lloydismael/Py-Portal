from datetime import datetime
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from app import db, login_manager

class UserRole:
    EMPLOYEE = 'Employee'
    FINANCE = 'Finance'
    MANAGER = 'Manager'

class User(UserMixin, db.Model):
    __tablename__ = 'users'
    
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(64), unique=True, index=True, nullable=False)
    email = db.Column(db.String(120), unique=True, index=True, nullable=False)
    password_hash = db.Column(db.String(128), nullable=False)
    first_name = db.Column(db.String(64))
    last_name = db.Column(db.String(64))
    role = db.Column(db.String(20), nullable=False)
    profile_picture = db.Column(db.String(255))
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    # Relationships
    uploaded_files = db.relationship('File', backref='owner', lazy='dynamic')
    submitted_reimbursements = db.relationship('Reimbursement', 
                                             foreign_keys='Reimbursement.employee_id',
                                             backref='employee', lazy='dynamic')
    managed_reimbursements = db.relationship('Reimbursement', 
                                            foreign_keys='Reimbursement.manager_id',
                                            backref='manager', lazy='dynamic')
    processed_reimbursements = db.relationship('Reimbursement', 
                                              foreign_keys='Reimbursement.finance_id',
                                              backref='finance_officer', lazy='dynamic')
    
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)
        
    def check_password(self, password):
        return check_password_hash(self.password_hash, password)
    
    def is_employee(self):
        return self.role == UserRole.EMPLOYEE
    
    def is_finance(self):
        return self.role == UserRole.FINANCE
    
    def is_manager(self):
        return self.role == UserRole.MANAGER
    
    def __repr__(self):
        return f'<User {self.username}>'


class File(db.Model):
    __tablename__ = 'files'
    
    id = db.Column(db.Integer, primary_key=True)
    filename = db.Column(db.String(255), nullable=False)
    original_filename = db.Column(db.String(255), nullable=False)
    file_path = db.Column(db.String(255), nullable=False)
    file_size = db.Column(db.Integer, nullable=False)
    file_type = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)
    qr_code_path = db.Column(db.String(255))
    download_count = db.Column(db.Integer, default=0)
    is_public = db.Column(db.Boolean, default=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    
    def __repr__(self):
        return f'<File {self.original_filename}>'


class ReimbursementStatus:
    SUBMITTED = 'Submitted'
    APPROVED = 'Approved'
    REJECTED = 'Rejected'
    PROCESSED = 'Processed'


class Reimbursement(db.Model):
    __tablename__ = 'reimbursements'
    
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text)
    amount = db.Column(db.Float, nullable=False)
    receipt_file_id = db.Column(db.Integer, db.ForeignKey('files.id'))
    status = db.Column(db.String(20), default=ReimbursementStatus.SUBMITTED)
    
    # User relationships
    employee_id = db.Column(db.Integer, db.ForeignKey('users.id'), nullable=False)
    manager_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    finance_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    
    # Timestamps
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)
    approved_at = db.Column(db.DateTime)
    processed_at = db.Column(db.DateTime)
    
    # Management details
    manager_notes = db.Column(db.Text)
    finance_notes = db.Column(db.Text)
    
    # File relationship
    receipt = db.relationship('File')
    
    def __repr__(self):
        return f'<Reimbursement {self.id}: {self.title}>'


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))
