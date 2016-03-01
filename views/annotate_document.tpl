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
            <input style="min-height:400px;" data-role="tagsinput" name="tags" class="form-control tags" value="{{!','.join([t.value for t in cd.tags])}}"></input>
        </div>
        <div class="form-group">
            <label for="notes">Notes</label>
	        <textarea style="min-height:400px;" class="form-control" name="notes">{{cd.notes}}</textarea>
	    </div>
	    <input name="md5" type="text" value="{{cd.md5}}" hidden></input>
	    <textarea class='bib-input' name="bib" hidden></textarea>
	    <button type="submit" class="btn btn-default">Save</button>
	    <p id="msg" class="help-block">{{msg}}</p>
	</form>
</div>

<script>
$(function() {

	tags = new Bloodhound({
		datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
		queryTokenizer: Bloodhound.tokenizers.whitespace,
		local: {{!json.dumps([t.value for t in Tag.select(fn.Distinct(Tag.value))])}}
	});
	tags.initialize();

    $('.show-bib').click(function() {
        $(this).parent().parent().find('.bib-display').slideToggle();
    });
    $(".bib-display").focusout(function(){
    	$(".bib-input").text($(this).text());
    });

    $(".tags").tagsinput({
        typeaheadjs: {
        	name: 'tags',
            displayKey: 'value',
    		valueKey: 'value',
    		source: tags.ttAdapter()
        },
        tagClass: 'big',
        freeInput: true
    });
    $("#msg").fadeOut({duration: 4000, easing: 'easeInCirc'});
});
</script>
