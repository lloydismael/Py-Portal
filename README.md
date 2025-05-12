# Reimbursement Portal

A modern web application for managing reimbursements, file sharing with QR codes, and user profile management, built with Flask.

## Features

- **User Management**
  - Registration with role selection (Employee, Finance, Manager)
  - Secure authentication and profile management
  - Role-based access control

- **Reimbursement Process**
  - Employees can submit reimbursement requests
  - Managers can approve/reject requests
  - Finance officers can process approved reimbursements
  - Complete tracking of request status

- **File Sharing**
  - Secure file uploading with progress tracking
  - Automatic QR code generation for easy sharing
  - File download tracking and management
  - Public/private file visibility control

- **Profile Management**
  - View and edit profile information
  - Change password functionality
  - Profile picture upload

## Technologies Used

- **Backend**: Python with Flask framework
- **Database**: SQLAlchemy ORM
- **Frontend**: HTML, CSS, JavaScript with Bootstrap 5
- **UI Design**: Modern Azure blue theme with glass-like UI and animations
- **Authentication**: Flask-Login
- **Forms**: Flask-WTF
- **File Handling**: Secure file upload and QR code generation

## Installation

### Standard Installation

1. Clone the repository

2. Create a virtual environment:
```
python -m venv venv
```

3. Activate the virtual environment:
- Windows:
```
venv\Scripts\activate
```
- macOS/Linux:
```
source venv/bin/activate
```

4. Install dependencies:
```
pip install -r requirements.txt
```

5. Initialize the database:
```
python manage.py init_db
```

6. Run the application:
```
python run.py
```

### Docker Installation

1. Make sure you have Docker and docker-compose installed

2. Build and start the containers:
```
docker-compose up -d
```

3. Access the application at http://localhost:5000

## Project Structure

```
app/
├── controllers/        # Route handlers
├── models/             # Database models
├── static/             # Static files (CSS, JS, images)
│   ├── css/
│   ├── js/
│   ├── images/
│   └── uploads/        # Uploaded files
├── templates/          # HTML templates
│   ├── auth/
│   ├── file/
│   ├── profile/
│   └── reimbursement/
└── utils/              # Utility functions
```

## Default Users

The application comes with three pre-configured users for testing:

| Username | Password | Role |
|----------|----------|------|
| employee@example.com | password | Employee |
| manager@example.com | password | Manager |
| finance@example.com | password | Finance |

## License

This project is licensed under the MIT License.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and updates.
