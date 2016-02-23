% rebase('layout.tpl', page='index')
% from bibdb import *
% from collections import Counter
% from math import *
<style>
	.keywords{
		width: 40%;
		font-size:8pt;
	}
	.keyword{
		display: inline-block;
		background: #428bca;
		color: white;
		border-radius: 10px;
		padding:5px;
		white-space: nowrap;
		margin:3px 3px;
	}
</style>
% for r in Review.select():
	<div>
		<h3>{{r.name}} <a href="/curr_review/{{r.name}}" title="">&raquo;</a></h3>
		<dir>{{r.description}} <span>({{r.documents.count()}})<span></dir>
%	ks = Counter([ k.strip() for d in r.documents for k in bibtexparser.loads(d.bib).entries[0].get('keyword','').split(',')])
	<div class="keywords">
	% for k,v in ks.most_common(15):
		% if not k is '':
			<div class="keyword" style="font-size: {{v*50}}%;"><span>{{k}}</span></div>
		% end
	% end
	</div>
	</div>
% end

