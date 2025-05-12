from flask.cli import FlaskGroup
from app import create_app, db
from app.models import User, UserRole

app = create_app()
cli = FlaskGroup(app)

@cli.command("init_db")
def init_db():
    """Initialize the database and create sample data."""
    db.drop_all()
    db.create_all()
    
    # Create admin users for each role
    admin_employee = User(
        username="employee",
        email="employee@example.com",
        first_name="John",
        last_name="Employee",
        role=UserRole.EMPLOYEE
    )
    admin_employee.set_password("password123")
    
    admin_manager = User(
        username="manager",
        email="manager@example.com",
        first_name="Sarah",
        last_name="Manager",
        role=UserRole.MANAGER
    )
    admin_manager.set_password("password123")
    
    admin_finance = User(
        username="finance",
        email="finance@example.com",
        first_name="Mike",
        last_name="Finance",
        role=UserRole.FINANCE
    )
    admin_finance.set_password("password123")
    
    db.session.add(admin_employee)
    db.session.add(admin_manager)
    db.session.add(admin_finance)
    db.session.commit()
    
    print("Database initialized!")
    print("Sample users created:")
    print("Employee: employee@example.com / password123")
    print("Manager: manager@example.com / password123")
    print("Finance: finance@example.com / password123")

if __name__ == "__main__":
    cli()
