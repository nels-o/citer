from bottle import route, view, request, response, redirect
from datetime import datetime

from bibdb import *

import json, os, bibtexparser, hashlib

from util import *

@route('/')
@view('index')
def prototype():
    return {}

@route('/add_review')
@view('add_review')
def prototype():
    return {"msg": session().get('msg','')}

@route('/handle_review', method='POST')
def prototype():
    title = request.forms.title
    description = request.forms.description
    if title and description:
        r = Review(name=title, description=description)
        r.save(force_insert=True)
        session()['msg'] = "Success"
        return redirect('/add_review')
    session()['msg'] = "Failed, missing argument."
    return redirect('/add_review')

@route('/curr_review/<name>')
@view('add_review')
def prototype(name="Default"):
    r = Review.select().where(Review.name==name).count()
    if r > 0:
        session()['curr_review'] = name
        return redirect('/add')
    session()['msg'] = 'Invalid review'
    return redirect('/')


@route('/add')
@view('add')
def prototype():
    return {"msg": session().get('msg','')}

@route('/handle_document', method="POST")
def prototype():
    cite = request.forms.cite
    data = request.files.data
    
    cr = current_review()

    if cite and data and data.file:
        # Parse bib
        try:
            bib = bibtexparser.loads(cite)
        except:
            session()['msg'] = "bogus bib"
            return redirect('/add')

        # encode the bib
        json_bib = json.dumps(bib.entries[0])
        contents = data.file.read() # hazard.

        # hash the bib with the review; save separate copies of each file per review.
        hashed_name = hashlib.md5()
        hashed_name.update(contents)
        hashed_name.update(cr.name.encode('utf-8'))
        hashed_name = hashed_name.hexdigest()
        hashed_filename = hashed_name + '.pdf'

        # write the pdf to file.
        with open(DOCS_ROOT+'/'+hashed_filename,'wb') as open_file:
            open_file.write(contents)

        # Redirect the user to the add page
        response.status = 303
        response.set_header('Location', '/add')

        # Write the db entry for the document.
        doc = Document(md5=hashed_name, name=bib.entries[0]['title'], bib=cite.strip(' \t\n\r'), notes="", review=cr)
        doc.save(force_insert=True)
        session()['msg'] = "Success"
        return redirect('/add')

    session()['msg'] = "You missed a field."
    return redirect('/add')

@route('/annotate')
@view('list_documents')
def prototype():
    return {}

@route('/lookup/<md5>')
def prototype(md5):
    import crossref as cr
    from bibtexparser import loads as b_in, dumps as b_out

    d = Document.select().where(Document.md5 == md5).get()
    if d:
        ob = b_in(d.bib).entries[0]
        search = ob.get('title','') 
        # At some point, consider adding more information...
        # Also, should detect existing DOI's
        bibs = cr.title2bib(search)
        response['Content-Type'] = 'appliction/x-bibtex'
        return bib
    response.status = 404;
    return None

@route('/handle_annotations', method="POST")
def prototype():
    md5   = request.forms.md5
    bib   = request.forms.bib
    notes = request.forms.notes
    
    if md5:
        doc = Document.select().where(Document.md5 == md5).get()
        if doc:
            if notes:
                doc.notes = notes
            if bib:
                try:
                    bibtexparser.loads(bib)
                    doc.bib = bib.strip()
                except:
                    session()['msg'] = "Invalid bibtex."
                    return redirect('/annotate/'+md5)
            doc.save()
            session()['msg'] = " Success"
            return redirect('/annotate/'+md5)
    else:
        session()['msg'] = "Invalid request. No document specified."
        return redirect('/annotate/'+md5)

    session()['msg'] = "You missed a field, or something went wrong."
    return redirect('/annotate/'+md5)

@route('/annotate/<md5>')
@view('annotate_document')
def prototype(md5=None):
    return {"doc": md5, "msg": session().get('msg','')}

@route('/paper/<md5>')
@view('annotate_document')
def prototype(md5=None):
    from bottle import static_file
    return static_file(md5+'.pdf', root=DOCS_ROOT)