<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

# Reimbursement Portal Project

This is a Python Flask web application for a reimbursement management system with file sharing and user profile management.

## Project Structure

- `app/` - Main application package
  - `controllers/` - Route handlers for different features
  - `models/` - Database models
  - `forms/` - WTForms form classes
  - `templates/` - Jinja2 templates
  - `static/` - Static assets (CSS, JS, images)
  - `utils/` - Utility functions

## Key Features

1. User authentication with role-based access (Employee, Finance, Manager)
2. Reimbursement request workflow
3. File sharing with QR code generation
4. Profile management

## Design Pattern

This project follows the MVC (Model-View-Controller) pattern:
- Models: SQLAlchemy models in `app/models/`
- Views: Jinja2 templates in `app/templates/`
- Controllers: Route handlers in `app/controllers/`

## UI Design Guidelines

- Azure blue theme
- Glass-like UI elements with blur effects and transparency
- Smooth animations and transitions
- Apple-inspired minimalist design

## Database Schema

- Users: Authentication and role information
- Files: File metadata and sharing settings
- Reimbursements: Request details and workflow status

## API Design

RESTful structure for different resources:
- `/auth` - Authentication endpoints
- `/profile` - User profile management
- `/file` - File sharing functionality
- `/reimbursement` - Reimbursement request workflow
