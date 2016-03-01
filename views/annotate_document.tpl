% rebase('layout.tpl', page='annotate') 
% from bibdb import * 
% from util import * 
% import bibtexparser, json
% cd = Document.select().where(Document.md5 == doc).get() 
% bib = bibtexparser.loads(cd.bib).entries[0]

<div>
    <h4>
        {{bib.get('title','(no title)')}} 
    </h4>
    <p>{{bib.get('author', '(no author(s) provided)')}}, {{bib.get('year', '(no year provided)')}}</p>
    <p>{{bib.get('keyword','')}}</p>
    <p>
        <a href="/paper/{{cd.md5}}" title="">Paper</a>
        <a href="/citations/{{cd.md5}}" title="">Add Citations</a>
        <a href="javascript:;" class="show-bib" title="">BibTeX</a>
    </p>
  
  	<div class='bib-display' hidden>
		<pre contenteditable="true">{{!cd.bib}}</pre>
	</div>


    <form style="width:100%;" action="/handle_annotations" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="tags">Tags</label>
            <input style="min-height:400px;" data-role="tagsinput" name="tags" class="form-control tags"></input>
        </div>
        <div class="form-group">
            <label for="notes">Notes</label>
	        <textarea style="min-height:400px;" class="form-control" name="notes">{{cd.notes}}</textarea>
	    </div>
	    <input name="md5" type="text" value="{{cd.md5}}" hidden></input>
	    <textarea class='bib-input' name="bib" hidden></textarea>
        <input class='deltags' name="deltags" type="text" hidden></input>
	    <button type="submit" class="btn btn-default">Save</button>
	    <p id="msg" class="help-block">{{msg}}</p>
	</form>
</div>

<script>
$(function() {

    $('.show-bib').click(function() {
        $(this).parent().parent().find('.bib-display').slideToggle();
    });
    $(".bib-display").focusout(function(){
    	$(".bib-input").text($(this).text());
    });

    $(".tags").tagsinput({
        typeahead: {
            source: ['Amsterdam', 'Washington', 'Sydney', 'Beijing', 'Cairo']
        },
        freeInput: true
    });
% for tag in cd.tags:
    $(".tags").tagsinput('add', {{!"'"+tag.value+"'"}});
% end
    $("#msg").fadeOut({duration: 4000, easing: 'easeInCirc'});

    $('.tags').on('itemRemoved', function(event) {
        var d = $(".deltags");
        if(d.val() == '') d.val(event.item);
        else d.val(d.val() +','+ event.item);
    });
});
</script>
