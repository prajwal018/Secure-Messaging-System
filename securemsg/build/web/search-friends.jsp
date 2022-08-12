<%-- 
    Document   : home
    Created on : Jan 11, 2018, 7:32:58 AM
    Author     : Brothers
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
        <section class="col-md-8 friends-list-search">
            
            <section>
                <h5>List of searched friends</h5>
                <%
                String userid=(String)session.getAttribute("user_acc");
                String keyw=request.getParameter("keyw");
                
                Database db=new Database();
                ResultSet rs=db.getSearchedFriends(keyw,userid);
                if(rs!=null){
                    while(rs.next()){
                        int reqid=rs.getInt("id");
                        ResultSet resu=db.checkFriendRequestSend();
                        int i=0;
                        int invid=0;
                        try{
                            while(resu.next()){
                                int usid=resu.getInt("userid");
                                int rqid=resu.getInt("reqid");
                                int sts=resu.getInt("status");

                                if(usid==Integer.parseInt(userid) && rqid==reqid){
                                    i=1;    
                                    invid=resu.getInt("id");
                                }
                                if(usid==reqid && usid==reqid){
                                    i=1;    
                                    invid=resu.getInt("id");
                                }
                            }
                        }catch(Exception e){
                            
                        } 
                %>
                    <div class="media table-bordered">
                       <div class="media-left">
                            <a href="#">
                                <i class="fa fa-user fa-lg" style="font-size: 35px;"></i>
                            </a>
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading"><%=rs.getString("name")%></h4>
                            Friend
                            <%
                            if(i==0){
                            %>
                            <a href="javascript:send(<%=rs.getString("id")%>);" class="btn btn-primary pull-right btn-xs">Send Request</a>
                              <%
                            }else if(i==1){
                                %>
                                <a href="javascript:cancel(<%=invid%>);" class="btn btn-warning pull-right btn-xs">Cancel</a>
                                <%
                            }
                            %>
                        </div>
                    </div>
                    <%
                    }
                }else{
                    %>
                    <div class="media table-bordered">
                        No friends found.
                    </div>
                    <%
                }
                %>
                
            </section>
        </section>
    </body>
</html>
<script>
    function send(id){
        if(confirm("Are you sure?")){
            $.ajax({
                    url:"WebService.jsp",
                    data:{"reqid":id,"userid":<%=userid%>,"action":"sendinvitation"},
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
</script>
