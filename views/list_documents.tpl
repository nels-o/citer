% rebase('layout.tpl', page='annotate')
% from bibdb import *
% from util import *
% import bibtexparser, json

% cr = current_review()

<h2>{{cr.name}}</h2>
<p>{{cr.description}}</p>
<ol>
		
% for d in cr.documents:
%	doc = bibtexparser.loads(d.bib).entries[0]
	<li>
	    <div id='{{d.md5}}'>
	    	<h4>
	    		{{doc.get('title','(no title provided)')}} 
	    		<a href="/paper/{{d.md5}}" title="">Paper</a> 
	    		<a href="/annotate/{{d.md5}}" title="">Annotate</a> 
				<a href="/citations/{{d.md5}}" title="">Add Citations</a> 
				<a href="javascript:;" class="show-bib" title="">BibTeX</a>
				<a href="javascript:;" class="lookup-bib" title="">Lookup</a>
	    	</h4>
	    	<p>{{doc.get('author', '(no author(s) provided)')}}, {{doc.get('year', '(no year provided)')}} <a href="http://www.doi2bib.org/#/doi/{{doc.get('doi','')}}">{{doc.get('doi','')}}</a></p>
	    	<div class='bib' hidden>
	    		<pre>{{!d.bib}}</pre>
	    	</div>
	    </div>
	</li>
% end
</ol>

<script>
	$(function(){
		$('.show-bib').click(function(){
			$(this).parent().parent().find('.bib').slideToggle();
		});

		$('.show-bib').click(function(){
			var md5 = $(this).parent().parent().attr('id');
			$.ajax('./lookup/'+md5)
		});
	});
</script>	