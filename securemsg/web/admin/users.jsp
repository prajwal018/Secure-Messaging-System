<%-- 
    Document   : index
    Created on : Jan 10, 2018, 6:04:55 PM
    Author     : Brothers
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="database.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="http://localhost:8084/eauction2018/admin-panel/css/style.css" />        
        <script src="css/jquery.min.js"></script>
        <script src="css/bootstrap.min.js"></script>
    </head>
    <body>
        <%@ include file="parts/header.jsp" %>
        <section class="center-side col-md-12">
            <h2>Registered Users</h2><br>
            <table class="table table-bordered">
                <thead>
                    <tr><th>Sr.No.</th><th>Full Name</th><th>Email Address</th><th>Mobile No</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                <%
                    int i=1;
                Database db=new Database();
                ResultSet rs=db.getUsers();
                try
                {
                while(rs.next()){
                    int status=rs.getInt("status");
                    %>
                    <tr><td><%=i++%>.</td><td><%=rs.getString("name")%></td><td><%=rs.getString("email")%></td><td><%=rs.getString("mobno")%></td>
                        <td>
                            <%
                            if(status==1){
                                %>
                                <label class="label label-success">Active</label>
                                <%
                            }else{
                                %>
                                <label class="label label-warning">In-Active</label>
                                <%
                            }
                            %>
                            
                        </td>
                        <td>
                            <%
                            if(status==1){
                                %>
                                <a href="javascript:updatestatus(<%=rs.getString("id")%>,0);" class="btn btn-warning btn-sm">Decline</a>
                                <%
                            }else{
                                %>
                                <a href="javascript:updatestatus(<%=rs.getString("id")%>,1);" class="btn btn-success btn-sm">Active</a>
                                <%
                            }
                            %>
                             
                            <a href="javascript:removeuser(<%=rs.getString("id")%>);" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                    <%
                }
                }catch(Exception e){
                
                    }
                %>
                </tbody>
            </table>
        </section>
    </body>
</html> 
<script>
    function updatestatus(userid,status){
        if(confirm("Are you sure?")){
            $.ajax({
                    url:"../WebService.jsp",
                    data:{"id":userid,"status":status,"action":"updateuserstatus"},
                    method:"POST",
                    success:function(res){
                        //alert(res);
                        window.location.reload();
                    }
                });
        }
    }
    
    function removeuser(userid){
        if(confirm("Are you sure?")){
            $.ajax({
                    url:"../WebService.jsp",
                    data:{"id":userid,"tab":"users","action":"removedata"},
                    method:"POST",
                    success:function(res){
                        //alert(res);
                        if(res==1){
                            alert("User removed.");
                        }
                        window.location.reload();
                    }
                });
        }
    }
</script>
