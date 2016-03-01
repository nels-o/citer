<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Citer</title>

    <link rel="stylesheet" type="text/css" href="/static/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/static/css/bootstrap-tagsinput.css">
    <link rel="stylesheet" type="text/css" href="/static/css/dashboard.css">
    <script src="/static/js/jquery-2.2.0.min.js" type="text/javascript" charset="utf-8" ></script>
    <script src="/static/js/jquery.easing.1.3.js" type="text/javascript" charset="utf-8" ></script>
    <script src="/static/js/bootstrap.min.js" type="text/javascript" charset="utf-8" ></script>
    <script src="/static/js/bootstrap-tagsinput.min.js" type="text/javascript" charset="utf-8" ></script>
    <script src="/static/js/typeahead.js" type="text/javascript" charset="utf-8" ></script>
</head>

<body>
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#">citer</a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="#">Dashboard</a></li>
                    <li><a href="#">Settings</a></li>
                    <li><a href="#">Profile</a></li>
                    <li><a href="#">Help</a></li>
                </ul>
                <form class="navbar-form navbar-right">
                    <input type="text" class="form-control" placeholder="Search...">
                </form>
            </div>
        </div>
    </nav>
    <div class="container-fluid">
        <div class="row">
            <div class="col-sm-3 col-md-2 sidebar">
                <ul class="nav nav-sidebar">
% active = {'index': '', 'add_review': '', 'add': '', 'annotate':''}
% active[page] = 'active'
                    <li class="{{active['index']}}"><a href="/">Overview</a></li>
                    <li class="{{active['add_review']}}"><a href="/add_review">Add Review</a></li>
                    <li class="{{active['annotate']}}"><a href="/annotate">List Papers</a></li>
                    <li class="{{active['add']}}"><a href="/add">Add Papers</a></li>
                </ul>
                <!-- <ul class="nav nav-sidebar">
                    <li><a href="">Nav item</a></li>
                    <li><a href="">Nav item again</a></li>
                    <li><a href="">One more nav</a></li>
                    <li><a href="">Another nav item</a></li>
                    <li><a href="">More navigation</a></li>
                </ul>
                <ul class="nav nav-sidebar">
                    <li><a href="">Nav item again</a></li>
                    <li><a href="">One more nav</a></li>
                    <li><a href="">Another nav item</a></li>
                </ul> -->
            </div>
            <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            {{!base}}
            </div>
        </div>
</body>

</html>
