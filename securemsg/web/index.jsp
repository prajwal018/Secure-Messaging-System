<%-- 
    Document   : index
    Created on : Jan 11, 2021, 7:32:30 AM
    Author     : Brothers
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Secure Messaging Platform</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="css/style.css" />
        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
    </head>
    <body>
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
                    <%
                            if(request.getParameter("login")!= null){
                                String login=request.getParameter("login");
                                if(login.equals("2")){
                                    %>
                                    <div class="alert alert-success">
                                        User not verified yet by admin!
                                    </div>
                                    <%
                                }else{
                                    %>
                                    <div class="alert alert-danger">
                                        Username/Password Invalid.
                                    </div>
                                    <%
                                }
                            }
                        %>
                    <form action="WebService.jsp" method="POST" class="navbar-form navbar-right">
                        <div class="form-group">
                            <input type="text" class="form-control" name="mobileno" maxlength="10" required="true" placeholder="Mobile no">
                            <input type="password" class="form-control"name="password" required="true" placeholder="********">
                        </div>
                        <input type="hidden" value="user_login" name="action"/>
                        <button type="submit" class="btn btn-default">Login</button>
                    </form>
                </div><!-- /.navbar-collapse -->
            </div><!-- /.container-fluid -->
        </nav>
        <section class="col-md-7 left-side" style="width: 63.5%;">
            
        </section>
        <section class="col-md-4 right-side"><br>
            <%
                            if(request.getParameter("status")!= null){
                                String login=request.getParameter("status");
                                if(login.equals("1")){
                                    %>
                                    <div class="alert alert-success">
                                        User registered successfully!
                                    </div>
                                    <%
                                }else{
                                    %>
                                    <div class="alert alert-danger">
                                        User not registered.
                                    </div>
                                    <%
                                }
                            }
                        %>
            <h3 class="text-center">Create an account</h3>
            <h5 class="red">*All fields are compulsory.</h5><br>
            <form action="WebService.jsp" name="userreg" method="POST">
                <div class="col-md-12">
                    <label>Full name</label>
                    <input type="text" class="form-control" name="name" id="name" required="true" placeholder="Full name"><br>
                </div>
                <div class="col-md-6">
                    <label>Email Address</label>
                    <input type="email" class="form-control" name="email" id="email" required="true" placeholder="Email Address"><br>
                </div>
                <div class="col-md-6">
                    <label>Mobile No</label>
                    <input type="text" maxlength="10" class="form-control" name="mobileno" id="mobileno" required="true" placeholder="Mobile No."><br>
                </div>
                <div class="col-md-6">
                    <label>Password</label>
                    <input type="password" class="form-control" name="pwd1" id="pwd1" required="true" placeholder="********"><br>
                </div>
                <div class="col-md-6">
                    <label>Confirm Password</label>
                    <input type="password" class="form-control" name="pwd2" id="pwd2" required="true" placeholder="********"><br>
                </div>
                <div class="col-md-12">
                    <button type="button" onclick="submituser();" class="btn btn-default">Register</button><br><br><br><br>
                </div>
                <input type="hidden" value="user_reg" name="action"/>
            </form>
        </section>
        <section class="col-md-12"><br>
            <h5 class="text-center">Copyright 2021. All rights reserved.</h5>
        </section>
    </body>
</html>
<script>
    function submituser(){
        var name=document.getElementById("name").value;
        var email=document.getElementById("email").value;
        var mobileno=document.getElementById("mobileno").value;
        var pwd1=document.getElementById("pwd1").value;
        var pwd2=document.getElementById("pwd2").value;
        if(name==''){
            alert("Please enter name.");
        }else if(email==''){
            alert("Please enter email.");
        }else if(mobileno==''){
            alert("Please enter mobile no");
        }else if(!$.isNumeric(mobileno)){
            alert("Please enter valid mobile no");
        }else if(mobileno.length!=10){
            alert("Please enter valid mobiloe no.");
        }else if(pwd1=='' || pwd2 ==''){
            alert("Please enter password.");
        }else if(pwd1!=pwd2){
            alert("Password does not matched.");
        }else{
            document.userreg.submit();
        }
    }
</script>