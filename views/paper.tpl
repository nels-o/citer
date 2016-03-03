<div>
	<h4>{{bib.get('title', '(no title)')}}</h4>
	<p>{{bib.get('author', '(no author(s) provided)')}}, {{bib.get('year', '(no year provided)')}}</p>
    <p>{{bib.get('keyword','(no keywords)')}}</p>
    <p>
        <a href="/paper/{{doc.md5}}" title="">Paper</a>
        <a href="/citations/{{doc.md5}}" title="">Add Citations</a>
        <a href="/annotate/{{doc.md5}}" title="">Annotate</a>
        <a href="javascript:;" class="show-bib" title="">BibTeX</a>
    </p>
    <div class='bib-display' hidden>
		<pre contenteditable="true">{{!doc.bib}}</pre>
	</div>
</div>