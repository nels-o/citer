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
    """
    
    name = TextField()
    description = TextField()

class Document(BaseModel):
    """
    The Document model represents a single paper 
    entry in the lit review. 

    It stores the relevant citation, any notes, and 
    a reference to the review to which is belongs.
    """
    
    review = ForeignKeyField(Review, related_name='documents')

    notes = TextField()
    bib = TextField()
    file = TextField()

class Citation(BaseModel):

    parent_ = ForeignKeyField(Document, related_name='parent')
    document_ = ForeignKeyField(Document, related_name='citations')

class Tag(BaseModel):
    """
    The Tag model represents the tags assigned 
    to any given Document.

    This is simply a text value.
    """

    document = ForeignKeyField(Document, related_name='tags')
    value = TextField()

def init_tables():
    Review.create_table()
    Document.create_table()
    Citation.create_table()
    Tag.create_table()