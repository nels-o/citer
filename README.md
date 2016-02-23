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
## Goofing off

Frequency diagrams are fun, and this seems to work reasonably well.
![Rough cut keyword frequency view](https://cloud.githubusercontent.com/assets/2745310/13128829/9cf74b4e-d58d-11e5-84ef-76d7c6b40b4e.png)
