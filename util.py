from bottle import request
from bibdb import *
import os, hashlib

PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static').replace('\\', '/')
DOCS_ROOT = os.path.join(PROJECT_ROOT, 'docs').replace('\\', '/')

def session():
    return  request.environ.get('beaker.session')

def current_review():
    return Review.select().where(Review.name==session().get('curr_review','Default')).get()

def get_binary_file(filepath):
	with open(filepath, 'rb') as f:
		contents = f.read()
	md5 = hashlib.md5()
	md5.update(contents)
	return (contents, md5)
