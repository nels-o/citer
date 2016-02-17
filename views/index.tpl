% rebase('layout.tpl', page='index')
% from bibdb import *

% for r in Review.select():
	<div>
		<h3>{{r.name}} <a href="/curr_review/{{r.name}}" title="">&raquo;</a></h3>
		<dir>{{r.description}} <span>({{r.documents.count()}} documents)<span></dir>
	</div>
% end

