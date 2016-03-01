% rebase('layout.tpl',page='add') 
% import bibdb
% from util import *
% cr = current_review()
% cd = Document.select().where(Document.md5 == doc).get() 
% bib = bibtexparser.loads(cd.bib).entries[0]
<div>
    <h4>
        Citations From: <i>{{bib.get('title','(no title)')}}</i> 
    </h4>
    <p>{{bib.get('author', '(no author(s) provided)')}}, {{bib.get('year', '(no year provided)')}}</p>
    <p>{{bib.get('keyword','')}}</p>
    <p>
        <a href="/paper/{{cd.md5}}" title="">Paper</a>
    </p>
  
  	<form style="width:40%;" action="/handle_citation" method="post" enctype="multipart/form-data">
	    <div class="form-group">
	        <label for="cite">Add BibTeX Citation</label>
	        <textarea style="min-height:400px;" class="form-control" name="cite"></textarea>
	    </div>
	    <div class="form-group">
	        <label for="data">PDF</label>
	        <input class="form-control" type="file" name="data" />
	    </div>
	    <input name="md5" type="text" value="{{cd.md5}}" hidden></input>
	    <button type="submit" class="btn btn-default">Submit</button>
	    <p id="msg" class="help-block">{{msg}}</p>
	</form>

	<div class='citation-list'>
	<h3>References:</h3>
	<hr>
% for d in cd.references:
		% doc = d.document_
		% include('paper.tpl', doc=doc, bib=bibtexparser.loads(doc.bib).entries[0])
% end
	</div>
</div>


<script>
$(function(){
	$("#msg").fadeOut({duration: 4000, easing: 'easeInCirc'});
});
</script>
