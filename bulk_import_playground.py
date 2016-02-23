from util import *
from bibdb import *
import bibtexparser

review = Review.select().where(Review.name == 'General Visualization Reading').get()

path = 'C:/Users/Nels/SkyDrive/Reading/Vis/'

bib = path + 'bibliography.bib'

with open(bib) as f:
    parsed_bib = bibtexparser.loads(f.read())

with_files = [e for e in parsed_bib.entries if e.has_key('file')]

for e in with_files:
    e['file'] = e['file'].replace('OneDrive','C:/Users/Nels/SkyDrive')
    e['file'] = e['file'].replace('\\', '/')

for e in with_files:
    try:
        contents, md5 = get_binary_file(e['file'])
        md5.update(review.name.encode('utf-8'))
        file_digest = md5.hexdigest()
        file_name = file_digest+'.pdf'
        with open(DOCS_ROOT+'/'+file_name,'wb') as f:
                f.write(contents)
        b = bibtexparser.bibdatabase.BibDatabase()
        b.entries = [e]
        cite = bibtexparser.dumps(b) 
        d = Document(md5=file_digest, name=e['title'], bib=cite.strip(' \t\n\r'), notes="", review=review)
        d.save(force_insert=True)
    except:
        print('Missing file, or something')

@db.atomic()
def normalize_keyword_delimitter():
    for d in review.documents:
        bib = bibtexparser.loads(d.bib)
        if bib.entries[0].has_key('keyword'):
            bib.entries[0]['keyword'] = bib.entries[0]['keyword'].replace(';',',')
            d.bib = bibtexparser.dumps(bib)
            d.save()
@db.atomic()
def normalize_keyword_case():
    for d in review.documents:
        bib = bibtexparser.loads(d.bib)
        if bib.entries[0].has_key('keyword'):
            bib.entries[0]['keyword'] = bib.entries[0]['keyword'].lower()
            d.bib = bibtexparser.dumps(bib)
            d.save()

@db.atomic()
def normalize_keyword_visualization():
    for d in review.documents:
        bib = bibtexparser.loads(d.bib)
        if bib.entries[0].has_key('keyword'):
            bib.entries[0]['keyword'] = bib.entries[0]['keyword'].replace('visualis','visualiz')
            d.bib = bibtexparser.dumps(bib)
            d.save()