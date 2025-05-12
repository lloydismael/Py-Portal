from flask_wtf import FlaskForm
from flask_wtf.file import FileField, FileAllowed
from wtforms import StringField, TextAreaField, FloatField, BooleanField, SubmitField
from wtforms.validators import DataRequired, Length, NumberRange, Optional

class ReimbursementForm(FlaskForm):
    title = StringField('Title', validators=[DataRequired(), Length(min=3, max=100)])
    description = TextAreaField('Description', validators=[Optional(), Length(max=500)])
    amount = FloatField('Amount', validators=[DataRequired(), NumberRange(min=0.01)])
    receipt = FileField('Receipt', validators=[
        FileAllowed(['pdf', 'png', 'jpg', 'jpeg'], 'PDF and images only!')
    ])
    submit = SubmitField('Submit Request')

class ReviewForm(FlaskForm):
    notes = TextAreaField('Notes', validators=[Optional(), Length(max=500)])
    approve = BooleanField('Approve')
    submit = SubmitField('Submit Review')
