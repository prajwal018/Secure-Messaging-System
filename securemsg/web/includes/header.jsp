<%
    
%>
<header>
            <center><h1>Secure Messaging Platform</h1></center>
        </header>
        <nav class="navbar navbar-default">
            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                </div>
                
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav">
                        <li><a href="my-friends.jsp">My Friends (<span id="countunreadmsg"></span>)</a></li>
                        <li><a href="user-profile.jsp">My Profile</a></li>
                        <li><a href="view-request.jsp">Request (<span id="count"></span>)</a></li>
                        <li><a href="change-password.jsp">Change Password</a></li>
                    </ul>
                    
                    <ul class="nav navbar-nav navbar-right">
                        <li class="dropdown">
                            <a href="logout.jsp" role="button" >Logout </a></li>
                    </ul>
                    <form action="search-friends.jsp" method="get" class="navbar-form navbar-right">
                        <div class="form-group">
                            <input type="text" class="form-control" required="true" name="keyw" placeholder="Search by friend name">
                        </div>
                        <button type="submit" class="btn btn-default">Find New Friend</button>
                    </form>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
<script>
$(document).ready(function(){
    $.ajax({
        url:"WebService.jsp",
        method:"POST",
        data:{"action":"countnewrequestrows"},
        success:function(res){
           // alert(res);
            $("#count").html(res);
        }
    });
});
function countunreadmsg(){
        $.ajax({
        url:"WebService.jsp",
        method:"POST",
        data:{"action":"countunreadmsg"},
        success:function(res){
         //alert(res);
         $("#countunreadmsg").html(res);
        }
    });
    }
    $(document).ready(function(){
       setInterval('countunreadmsg()', 1000);
    });
</script>