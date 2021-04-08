from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
# from sqlalchemy import func
from datetime import datetime
from flask_mail import Mail
import json
import os
from werkzeug.utils import secure_filename
import math
import mysql.connector
#learner blog

with open('config.json', 'r') as c:
    params = json.load(c)["params"]


local_server = True
app=Flask(__name__)
app.secret_key='super-secret-key'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:pass@localhost/site'

app.config['UPLOAD_FOLDER']= params['upload_location']

app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USE_TLS=False,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password'])

mail=Mail(app)
db = SQLAlchemy(app)


class Contact(db.Model):
    srno=db.Column(db.Integer, primary_key=True, nullable=True)
    name = db.Column(db.String(500), unique=False, nullable=False)
    phoneno = db.Column(db.String(20), unique=False, nullable=False)
    email= db.Column(db.String(50), unique=False, nullable=False)
    msg= db.Column(db.String(500), unique=False, nullable=False)
    date=db.Column(db.String(20), unique=False,nullable=True)

class Posts(db.Model):
    srno=db.Column(db.Integer, primary_key=True, nullable=True)
    titel = db.Column(db.String(500), unique=False, nullable=False)
    slug = db.Column(db.String(30), unique=False, nullable=False)
    subtitel = db.Column(db.String(100), unique=False, nullable=False)
    content= db.Column(db.String(120), unique=False, nullable=False)
    img_file= db.Column(db.String(30), unique=False, nullable=False)
    author= db.Column(db.String(500), unique=False, nullable=False)
    date=db.Column(db.String(20), unique=False,nullable=True)

class Subscribe(db.Model):
    srno=db.Column(db.Integer, primary_key=True, nullable=True)
    email= db.Column(db.String(500), unique=False, nullable=False)
    date=db.Column(db.String(20), unique=False,nullable=True)


@app.route('/')
def index():
        posts=Posts.query.filter_by().order_by(Posts.date.desc()).all()
        last=math.ceil(len(posts)/int(params['no_of_post']))
        page=request.args.get('page')

        if (not str(page).isnumeric()):
            page=1
        page=int(page)
        posts=posts[(page-1)*int(params['no_of_post']): (page-1)*int(params['no_of_post'])+int(params['no_of_post'])]
        if (page==1):
            prev='#'
            next="/?page="+str(page+1)

        elif (page==last):
            prev="/?page="+str(page-1)
            next="#"

        else:
            prev="/?page="+str(page-1)
            next="/?page="+str(page+1)
        return render_template('index.html', params=params,posts=posts, next=next, prev=prev)

@app.route('/contact', methods=["GET","POST"])
def contact():
          if (request.method=='POST'):
                    name=request.form.get('name')
                    email=request.form.get('email')
                    phoneno=request.form.get('phone')
                    msg=request.form.get('message')
                    date = str(datetime.now() )
                    entry= Contact(name=name, phoneno=phoneno, email=email, msg=msg, date=date)
                    db.session.add(entry)
                    db.session.commit()
                    
                    mail.send_message('New Mail from blog',
                                      sender= email,
                                      recipients=[params['gmail-user']],
                                      body= msg + '\n'+'by- '+name+ '\n'+ 'phone number-'+ phoneno+'\n'+ 'email- '+ email+'\n'+ date)

          return render_template('contact.html',params=params)



@app.route('/subscribe', methods=['GET', 'POST'])
def subscribe():
    if (request.method=='POST'):
        email=request.form.get('email')
        date = str(datetime.now() )
        entry= Subscribe(email=email,date=date)
        db.session.add(entry)
        db.session.commit()
    return render_template('subscribe.html',params=params)



@app.route('/about')
def about():
          return render_template('about.html',params=params)

@app.route('/delete/<string:srno>', methods=['GET', 'POST'])
def delete(srno):
    if 'user' in session and session ['user']==params['admin_user']:
        post=Posts.query.filter_by(srno=srno).first()
        db.session.delete(post)
        db.session.commit()
        return redirect('/admin')


# @app.route('/upload', methods=['GET', 'POST'])
# def upload():
#      if 'user' in session and session ['user']==params['admin_user']:
#         if request.method=="POST":
#             f=request.files["file1"]
#             f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
#             return "uploaded"



@app.route('/edit/<string:srno>', methods=['GET', 'POST'])
def edit(srno):
    if 'user' in session and session ['user']==params['admin_user']:
        if request.method=="POST":
            titel=request.form.get('titel') 
            subtitel=request.form.get('subtitel')
            content=request.form.get('content')
            slug=request.form.get('slug')
            img_file=request.form.get('img_file')
            date = str(datetime.now() )
            f=request.files["file1"]
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))
            if srno=='0':
                post=Posts(titel=titel, subtitel=subtitel, slug=slug, content=content, img_file=img_file,date=date, author=params['admin_user'])
                db.session.add(post)
                db.session.commit()
                mydb=mysql.connector.connect(host='localhost', user='root' , password='password', db='site', auth_plugin='mysql_native_password')
                mycur=mydb.cursor()
                cmd="select * from subscribe"
                mycur.execute(cmd)
                records=mycur.fetchall()
                for row in records:
                    srno=row[0]
                    email = row[1]
                    date=row[2]
                    mail.send_message('New post is uploaded onn learner blog',
                                      sender=params['gmail-user'],
                                      recipients=[email],
                                      body= 'hey... \n New blog post is uploaded \n visit http://127.0.0.1:5000/post/'+slug)
            else:
                post=Posts.query.filter_by(srno=srno).first()
                post.titel=titel
                post.subtitel=subtitel
                post.content=content
                post.slug=slug
                post.img_file=img_file
                db.session.commit()
                return redirect('/edit/'+srno)
        
        post=Posts.query.filter_by(srno=srno).first()
        return render_template('edit.html',params=params, post=post, srno=srno)



@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect('/admin')


@app.route('/admin', methods=['GET', 'POST'])
def login():
    if 'user' in session and session ['user']==params['admin_user']:
        posts=Posts.query.all()
        return render_template('dashboard.html',params=params,posts=posts)
        
    if request.method=='POST':
        username=request.form.get('uname')
        password=request.form.get('pass')
        if (username==params['admin_user'] and password==params['admin_pass']):
            session['user']=username
            posts=Posts.query.all()

            # rows=Posts.query.filter(Posts.titel).count()
            return render_template('dashboard.html',params=params,posts=posts)

    
    return render_template('login.html',params=params)

@app.route('/post/<string:post_slug>', methods=['GET'])
def post(post_slug):

    post=Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,post=post)
app.run(debug=True)
