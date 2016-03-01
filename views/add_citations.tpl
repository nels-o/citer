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
        <a href="/citations/{{cd.md5}}" title="">Add Citations</a>
        <a href="javascript:;" class="show-bib" title="">BibTeX</a>
    </p>
  
  	<form style="width:40%;" action="/handle_document" method="post" enctype="multipart/form-data">
	    <div class="form-group">
	        <label for="cite">Add BibTeX Citation</label>
	        <textarea style="min-height:400px;" class="form-control" name="cite"></textarea>
	    </div>
	    <div class="form-group">
	        <label for="data">PDF</label>
	        <input class="form-control" type="file" name="data" />
	    </div>
	    <button type="submit" class="btn btn-default">Submit</button>
	    <p id="msg" class="help-block">{{msg}}</p>
	</form>
</div>


<script>
$(function(){
	$("#msg").fadeOut({duration: 4000, easing: 'easeInCirc'});
});
</script>
