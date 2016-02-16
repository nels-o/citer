from bottle import route, view, request, response
from datetime import datetime

from bibdb import *

import json, os, bibtexparser, hashlib

PROJECT_ROOT = os.path.abspath(os.path.dirname(__file__))
STATIC_ROOT = os.path.join(PROJECT_ROOT, 'static').replace('\\', '/')
DOCS_ROOT = os.path.join(PROJECT_ROOT, 'docs').replace('\\', '/')

__temp_review = Review.select().where(Review.name=='Visualization Design Frameworks').get()

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
        # Parse bib
        try:
            bib = bibtexparser.loads(cite)
        except:
            return {"msg": "bogus bib"}

        # encode the bib
        json_bib = json.dumps(bib.entries[0])
        hashed_name = hashlib.md5(json_bib).hexdigest()
        hashed_filename = hashed_name + '.pdf'

        # write the pdf to file.
        with open(DOCS_ROOT+'/'+hashed_filename,'wb') as open_file:
            open_file.write(data.file.read())

        # Redirect the user to the add page
        response.status = 303
        response.set_header('Location', '/add)

        # Write the db entry for the document.
        doc = Document(md5=hashed_name, name=bib.entries[0]['title'], bib=json_bib, notes="", review=__temp_review)
        doc.save()
        return {"msg": "Success"}
    return {"msg": "You missed a field."}

@route('/annotate')
@view('list_documents')
def prototype():
    return {}

@route('/annotate/<md5>')
@view('annotate_document')
def prototype(md5=None):
    return {"doc": md5}