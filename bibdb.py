from peewee import *
import bibtexparser

db = SqliteDatabase('citer.db')

class BaseModel(Model):
    class Meta:
        database = db

class Review(BaseModel):
    """
    The Review model records details about the 
    literature review currently underway.

    This is used to partition literature reviews that 
    reside in the same DB. 

    The Document model maintains a foreign key for the 
    Review model, so each review instance can refer 
    directly to its child documents.  
    """
    
    name = TextField(primary_key=True)
    description = TextField()

class Document(BaseModel):
    """
    The Document model represents a single paper 
    entry in the lit review. 

    It stores the relevant citation, any notes, and 
    a reference to the review to which is belongs.
    """
    
    md5 = FixedCharField(max_length=16, unique=True, primary_key=True)

    review = ForeignKeyField(Review, related_name='documents')

    notes = TextField()
    bib = TextField()

class Citation(BaseModel):
    """
    The Citation model acts as an intermediary for storing
    references from one Document instance to all Documents 
    cited by the first Document... Isn't that a lovely sentence.

    The foreign key related name mechanism allows the Document model
    to refer directly to its set of citations  
    """
    parent_ = ForeignKeyField(Document, related_name='references')
    document_ = ForeignKeyField(Document, related_name='cited_by')

class Tag(BaseModel):
    """
    The Tag model represents the tags assigned 
    to any given Document.

    This is simply a text value at present, though I think there
    are other values that could be useful. This may require some 
    refactoring.
    """

    document = ForeignKeyField(Document, related_name='tags')
    value = TextField()

    class Meta:
        primary_key = CompositeKey('document', 'value')

def init_tables():
    """
    For use in a clean database, this initializes all the models. 
    """
    Review.create_table()
    Document.create_table()
    Citation.create_table()
    Tag.create_table()

def init_defaults():
    """
    citer expects there to always be a Default review, so we must create it.

    Note the goofiness of the force_insert parameter to the save() call.
    The peewee developer frowns on non-integer primary keys, so this is 
    required to insert a new row in the Review table.
    """
    default_review = Review(name='Default', description='Default review')
    default_review.save(force_insert=True)