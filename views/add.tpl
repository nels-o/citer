% rebase('layout.tpl') 
% import bibdb

<form style="width:40%;" action="/upload" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="cite">BibTeX Citation</label>
        <textarea class="form-control" name="cite"></textarea>
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

