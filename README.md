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

1. Make sure you have Docker and docker-compose installed (see [DOCKER_INSTALL.md](DOCKER_INSTALL.md) for instructions)

2. Build and start the containers:
```
docker-compose up -d
```

3. Access the application at http://localhost:5000

### Using the Docker Hub Image

You can also use the pre-built Docker image from Docker Hub:

1. Pull the image:
```
docker pull lloydismael12/py-portal:latest
```

2. Run the container:
```
docker run -d -p 5000:5000 --name reimbursement-portal lloydismael12/py-portal:latest
```

3. Access the application at http://localhost:5000

### Docker Scripts

The project includes several scripts to help with Docker operations:

- `docker_build_push.ps1` / `docker_build_push.sh`: Build and push the image to Docker Hub
- `docker_pull.ps1` / `docker_pull.sh`: Pull the latest image from Docker Hub
- `docker_run.ps1` / `docker_run.sh`: Run the container locally

For detailed Docker documentation, see [DOCKER.md](DOCKER.md).

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
