# citer
Lit review and citation manager.

citer is currently at a low level of polish

## todo

* Document how to get started with the application
* Separate settings from the server logic
* Automate first run setup (populating the database)

## Data Model

The citer data model is based around collections (the Review model) of Documents, and Citation relationships between documents.
  ```                 
                     _____________
                    /             \
                    V             |
   Review -> Document -> Citation-|
                      |
                      V
                      Tags
  ```                 
