% rebase('layout.tpl',page='add') 
% import bibdb
% from util import *
% cr = current_review()
<h2>{{cr.name}}</h2>
<p>{{cr.description}}</p>



<form style="width:40%;" action="/handle_document" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="cite">BibTeX Citation</label>
        <textarea style="min-height:400px;" class="form-control" name="cite"></textarea>
    </div>
    <div class="form-group">
        <label for="data">PDF</label>
        <input class="form-control" type="file" name="data" />
    </div>
    <button type="submit" class="btn btn-default">Submit</button>
    <p id="msg" class="help-block">{{msg}}</p>
</form>

<script>
    $(function(){
        $("#msg").fadeOut({duration: 4000, easing: 'easeInCirc'});
    });
</script>

