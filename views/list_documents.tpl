% rebase('layout.tpl', page='annotate')
% from bibdb import *
% from util import *
% import bibtexparser, json

% cr = current_review()

<h2>{{cr.name}}</h2>
<p>{{cr.description}}</p>
<ol>
		
% for d in cr.documents:
%	try:
%		doc = bibtexparser.loads(d.bib).entries[0]
		<li>
		    <div id='{{d.md5}}'>
		    	<h4>
		    		{{doc['title']}}
		    		<a href="/paper/{{d.md5}}" title="">Paper</a> 
		    		<a href="/annotate/{{d.md5}}" title="">Annotate</a> 
					<a href="/citations/{{d.md5}}" title="">Add Citations</a> 
					<a href="javascript:;" class="show-bib" title="">BibTeX</a>
					<a href="javascript:;" class="lookup-bib" title="">Lookup</a>
		    	</h4>
		    	<p>{{doc['author']}}, {{doc['year']}} <a href="http://doi.org/{{doc.get('doi','')}}">{{doc.get('doi','')}}</a></p>
		    	<div class='bib' hidden>
		    		<pre>{{!d.bib}}</pre>
		    	</div>
		    </div>
		</li>
%	except:

%	end
% end
</ol>

<script>
	$(function(){
		$('.show-bib').click(function(){
			$(this).parent().parent().find('.bib').slideToggle();
		});

		$('.lookup-bib').click(function(){
			var doc = $(this).parent().parent();
			var md5 = doc.attr('id');
			$.ajax('./lookup/'+md5).done(function(data){
				var bibs = doc.find('.bib'); 
				for(var i in data){
					var bib = $('<pre></pre>');
					bib.text(data[i]['bib'])
					bibs.append(bib);
				}
				bibs.slideDown();
			})
		});
	});
</script>	