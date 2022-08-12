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
        <%
            String userid=(String)session.getAttribute("user_acc");
            Database db=new Database();
            ResultSet res=db.getFriendList();
        %>
        <%@ include file="includes/header.jsp" %> 
       
        <section class="col-md-12">
            <h3>New Friend Request</h3><br>
            
            <%
            try{
            while(res.next()){
                int usid=res.getInt("userid");
                int reqid=res.getInt("reqid");
                int invid=res.getInt("id");
                int nocount=res.getInt("nocount");
                int nos=reqid+usid;
                if(nos==nocount){
                ResultSet resuser=null;
                    if(usid==Integer.parseInt(userid)){
                        resuser=db.getUserDetailsById(reqid+"");
                    }else if(reqid==Integer.parseInt(userid)){
                        resuser=db.getUserDetailsById(usid+"");
                    }
                    if(resuser!=null){
                resuser.next();
            %>
            <div class="col-md-4">
                <div class="media table-bordered">
                    <div class="media-left">
                        <a href="#">
                            <i class="fa fa-user fa-lg" style="font-size: 35px;"></i>
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading"><%=resuser.getString("name")%></h4>
                        Friend
                        <%
                        if(usid==Integer.parseInt(userid)){
                        %>
                        <a href="javascript:cancel(<%=invid%>);" class="btn btn-warning pull-right btn-xs">Cancel</a>
                        <%
                        }else if(reqid==Integer.parseInt(userid)){
                        %>
                        <a href="javascript:updatestatus('accept',<%=invid%>);" class="btn btn-success pull-right btn-xs">Accept</a> 
                        <a href="javascript:updatestatus('reject',<%=invid%>);" class="btn btn-danger pull-right btn-xs">Reject</a>
                        <%    
                        }
                        %>
                    </div>
                </div>
            </div>
           <% }
           }
            }
}
catch(Exception e){

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
    function updatestatus(action,id){
        if(confirm("Are you sure?")){
            $.ajax({
                    url:"WebService.jsp",
                    data:{"act":action,"invid":id,"action":"acceptrejectreq"},
                    method:"POST",
                    success:function(res){
                    //alert(res);
                        if(res==1){
                            alert("You accepted a friend request.");
                            window.location.reload();
                        }else if(res==2){
                            alert("You rejected a friend request.");
                            window.location.reload();
                        }else{
                            alert("Something Problem");
                            window.location.reload();
                        }
                    }
                });
        }
    }
</script>
