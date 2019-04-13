from flask import Flask, render_template, jsonify, make_response, request, url_for, Response, redirect
from flask_bootstrap import Bootstrap
# from compute import compute as compute_function
# from forms import ComputeForm
import pyodbc
import os
import os.path
import numpy as np
import pandas as pd
from io import StringIO
from flask_wtf import FlaskForm
from wtforms import StringField, SubmitField
from wtforms.validators import DataRequired
from wtforms.fields.html5 import DateField
from flask_datepicker import datepicker


# given patient id to mosaiq mainly used pat_id1
query1 = open('./SQL/patientselection.sql', 'r')

sqlquery1 = s = "".join(query1.readlines())

cnxn =pyodbc.connect('DSN=svm-db-stois1-odbc; UID=CrystalReportsUser; PWD=impac01')

data1 = pd.read_sql_query(sqlquery1, cnxn)

patient_list = data1['"Patient ID pat_id1"'].tolist()



#select treatment site and course, choose timespan

startdttm = '2019-04-21 00:00:00'

enddttm = '2019-04-28 00:00:00'

query2 = open('./SQL/treatmentselection.sql', 'r')

sqlquery2 = s = "".join(query2.readlines())

raw_data2 = [patient_list[0], startdttm,enddttm]

data2 = pd.read_sql_query(sqlquery2, cnxn, params =  raw_data2)






def query_mosaiq_fraction():
    query = open('./SQL/fractions.sql', 'r')
    sqlquery = s = "".join(query.readlines())
    raw_data = [startdttm,enddttm]
    data = pd.read_sql_query(sqlquery, cnxn, params =  raw_data)
    return data

def query_mosaiq_schedule():
    query = open('./SQL/schedule.sql', 'r')
    sqlquery = s = "".join(query.readlines())
    raw_data = [startdttm,enddttm]
    data = pd.read_sql_query(sqlquery, cnxn, params =  raw_data)
    return data

def query_mosaiq_appointments():
    query = open('./SQL/appointments.sql', 'r')
    sqlquery = s = "".join(query.readlines())
    raw_data = [startdttm,enddttm]
    data = pd.read_sql_query(sqlquery, cnxn, params =  raw_data)
    return data

def query_mosaiq_startrx():
    query = open('./SQL/startrx.sql', 'r')
    sqlquery = s = "".join(query.readlines())
    raw_data = [startdttm,enddttm]
    data = pd.read_sql_query(sqlquery, cnxn, params =  raw_data)
    return data

app = Flask(__name__)

bootstrap = Bootstrap(app)
datepicker(app)
app.secret_key = 'SHH!'

class MyForm(FlaskForm):
    date = DateField(id='datepick')

class NameForm(FlaskForm):
    name = StringField('Patient ID?', validators=[DataRequired()])
    submit = SubmitField('Submit')

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/appointments', methods=("POST", "GET"))
def appointements():
    data = query_mosaiq_appointments()
    return render_template('appointments.html',  tables=[data.to_html(classes='table table-striped table-sm')], titles=data.columns.values)

@app.route('/schedule', methods=("POST", "GET"))
def schedule():
    data = query_mosaiq_schedule()
    form1 = MyForm()
    def output_dataframe_csv():
        output = StringIO.StringIO()
        data.to_csv(output)
        return Response(output.getvalue(), mimetype="text/csv")
    return render_template('schedule.html',  tables=[data.to_html(classes='table table-striped table-sm')], titles=data.columns.values, form=form1)

@app.route('/schedule/csv')


@app.route('/fraction', methods=("POST", "GET"))
def fraction():
    # form = NameForm()
    # if form.validate_on_submit():
    #     name = form1.name.data
    #     form.name.data = ''
    data = query_mosaiq_fraction()
    return render_template('fraction.html',tables=[data.to_html(classes='table table-striped table-sm')], titles=data.columns.values)

@app.route('/startrx', methods=("POST", "GET"))
def startrx():
    data = query_mosaiq_startrx()
    return render_template('startrx.html',  tables=[data.to_html(classes='table table-striped table-sm')], titles=data.columns.values)
