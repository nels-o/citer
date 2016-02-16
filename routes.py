from bottle import route, view, request, response
from datetime import datetime

from bibdb import *

import json, os, bibtexparser

PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static').replace('\\', '/')
DOCS_ROOT = os.path.join(PROJECT_ROOT, 'docs').replace('\\', '/')

__temp_review = Review.select().where(Review.name=='Test').get()

@route('/')
@view('index')
def prototype():
    return {}

@route('/add')
@view('add')
def prototype():
    return {"msg": ""}

@route('/upload', method="POST")
def prototype():
    cite = request.forms.cite
    data = request.files.data
    
    if cite and data and data.file:
        # Write file to disk. 
        filename = data.filename
        response.status = 303
        response.set_header('Location', '/add')
        try:
            print("Parsing citation...")
            print(cite)
            bib = bibtexparser.loads(cite)
            print(bib.entries[0])
        except:
            print('-'*64)
            print("Oopsie.")
            print('-'*64)
            return {"msg": "bogus bib"}
        print(PROJECT_ROOT)
        with open(DOCS_ROOT+'/'+filename,'wb') as open_file:
            open_file.write(data.file.read())
        doc = Document(name=bib.entries[0]['title'], bib=json.dumps(bib.entries[0]), notes="", file=filename, review=__temp_review)
        doc.save()
        print('-'*64)
        print(bib.entries)
        print('-'*64)
        return {"msg": "Success"}
    return {"msg": "You missed a field."}

@route('/annotate')
@view('list_documents')
def prototype():
    return {}

@route('/annotate/<label>')
@view('annotate_document')
def prototype(label=None):
    return {"doc": label}