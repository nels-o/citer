% rebase('layout.tpl', page='annotate') 
% from bibdb import * 
% from util import * 
% import bibtexparser, json
% cd = Document.select().where(Document.md5 == doc).get() 
% bib = bibtexparser.loads(cd.bib).entries[0]

<div>
    <h4>
        {{bib['title']}} 
    </h4>
    <p>{{bib['author']}}, {{bib['year']}}</p>
    <p>{{bib['keyword']}}</p>
    <p>
        <a href="/paper/{{cd.md5}}" title="">Paper</a>
        <a href="/citations/{{cd.md5}}" title="">Add Citations</a>
        <a href="javascript:;" class="show-bib" title="">BibTeX</a>
    </p>
    <div class='bib' hidden>
        <pre>{{!cd.bib}}</pre>
    </div>
    
</div>

<form style="width:100%;" action="/handle_annotations" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="notes">Notes</label>
        <textarea style="min-height:400px;" class="form-control" name="notes">{{cd.notes}}</textarea>
    </div>
    <input name="md5" type="text" value="{{cd.md5}}" hidden></input>
    <button type="submit" class="btn btn-default">Save</button>
    <p id="msg" class="help-block">{{msg}}</p>
</form>


<script>
$(function() {
    $('.show-bib').click(function() {
        $(this).parent().parent().find('.bib').slideToggle();
    });
    
    $("#msg").fadeOut({duration: 4000, easing: 'easeInCirc'});
});
</script>
