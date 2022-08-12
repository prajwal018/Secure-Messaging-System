<%-- 
    Document   : index
    Created on : Jan 10, 2018, 6:04:55 PM
    Author     : Prajwal Kuchewar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="database.Database"%>
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
        <%@ include file="includes/header.jsp" %> 
        
        <section class="col-md-3">
            <h3>Profile Details</h3><br>
            <table class="table table-bordered">
            <%
                Database db=new Database();
                String uid=(String)session.getAttribute("user_acc");
                ResultSet rs=db.getUserDetails(uid);
                if(rs.next()){
            %>
                <tr><th>Name</th><td><%=rs.getString("name")%></td></tr>
                <tr><th>Email Address</th><td><%=rs.getString("email")%></td></tr>
                <tr><th>Mobile No.</th><td><%=rs.getString("mobno")%></td></tr>
            <%
                }
            %>
            </table>
        </section>
        <section class="col-md-8">
            <h3>My Friends</h3><br>
            <%
            ResultSet res=db.getMyFriends(uid);
            if(res!=null){
            while(res.next()){
                int reqid=res.getInt("reqid");
                int userid=res.getInt("userid");
                int invid=res.getInt("id");
                ResultSet resuser=null;
                int linkuserid=0;
                    if(userid==Integer.parseInt(uid)){
                        resuser=db.getUserDetailsById(reqid+"");
                        linkuserid=reqid;
                    }else if(reqid==Integer.parseInt(uid)){
                        resuser=db.getUserDetailsById(userid+"");
                        linkuserid=userid;
                    }
                    if(resuser!=null){
                                        if(resuser.next()){
                                            
            %>
            <div class="col-md-5">
                <div class="media table-bordered">
                    <div class="media-left">
                        <a href="#">
                            <i class="fa fa-user fa-lg" style="font-size: 35px;"></i>
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading"><%=resuser.getString("name")%></h4>
                        Friend
                        <a href="javascript:cancel(<%=invid%>);" class="btn btn-warning pull-right btn-xs">Cancel</a> 
                        <a href="my-friends.jsp?uid=<%=linkuserid%>" class="btn btn-primary pull-right btn-xs">Chat</a>
                        
                    </div>
                </div>
            </div>
                        <% }
                    }
            }
                        }
                        %>
        </section>
    </body>
</html> 
<script>
    function cancel(invid){
        if(confirm("Are you sure?")){
            $.ajax({
                    url:"WebService.jsp",
                    data:{"invid":invid,"action":"cancelrequest"},
                    method:"POST",
                    success:function(res){
                     //alert(res);
                        if(res==1){
                            alert("Your friend request canceled.");
                            window.location.reload();
                        }
                    }
                });
        }
    }
    function send(id){
        if(confirm("Are you sure?")){
            $.ajax({
                    url:"WebService.jsp",
                    data:{"reqid":id,"userid":<%=uid%>,"action":"sendinvitation"},
                    method:"POST",
                    success:function(res){
                       // alert(res);
                        if(res==1){
                            alert("Your friend request sent.");
                            window.location.reload();
                        }
                    }
                });
        }
    }
</script>