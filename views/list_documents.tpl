% rebase('layout.tpl')
% from bibdb import *
% review = Review.select().where(Review.name=="Test").get()
% for d in review.documents:
    {{!d.bib}}<br>
% end