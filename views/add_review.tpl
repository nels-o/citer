% rebase('layout.tpl', page='add_review')

<form style="width:40%;" action="/handle_review" method="post" enctype="multipart/form-data">
    <div class="form-group">
    	<label for="title">Title</label>
        <input class="form-control" type="text" name="title" value="" placeholder="">
    </div>
    <div class="form-group">
        <label for="description">Description</label>
        <textarea class="form-control" name="description"></textarea>
    </div>
    <button type="submit" class="btn btn-default">Submit</button>
    <p id="msg" class="help-block">{{msg}}</p>
</form>

<script>
    $(function(){
        $("#msg").fadeOut({duration: 4000, easing: 'easeInCirc'});
    });
</script>
