<%-- 
    Document   : home
    Created on : Jan 11, 2018, 7:32:58 AM
    Author     : Brothers
--%>

<%@page import="database.Database"%>
<%@page import="java.sql.ResultSet"%>
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
        <section class="col-md-3 friends-list-search">
            <section>
                <h5>List of friends</h5>
                <%
            String uid=(String)session.getAttribute("user_acc");
            Database db=new Database();
                        
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
                    resuser.next();
                    
                    int cot=db.countTotalSenderUnreadMsg(linkuserid);
            %>
            <div class="media table-bordered">
                    <div class="media-left">
                        <a href="#" class="text-center" style="padding:5px; margin-top: 3px; display: inline-block;">
                            <i class="fa fa-user fa-lg" style="font-size: 35px;"></i>
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading"><%=resuser.getString("name")%></h4>
                        Friend (<%=cot%>)
                        <a href="my-friends.jsp?uid=<%=linkuserid%>" target="_blank" class="btn btn-primary pull-right btn-xs">Chat</a>
                    </div>
                </div>
            <% }
            }
                        }
                        %>
            </section>
        </section>
        <section class="col-md-8 friends-list-search">
        <%
        if(request.getParameter("uid")!=null){
            String uuid=request.getParameter("uid");
            ResultSet res34=db.getUserDetailsById(uuid);
            res34.next();
        %>
        <input type="hidden" id="recid" value="<%=uuid%>"/>
        <input type="hidden" id="sendid" value="<%=uid%>"/>
            <h4>Chat with <%=res34.getString("name")%>.<a href="javascript:clear(<%=uuid%>,<%=uid%>);" class="pull-right">Clear Chat</a></h4>
            
            <article class="chatbody" id="chatbody" style='background: url("images/ws_WhatsApp_Background_1366x768.jpg") no-repeat 50% 100%;'>
                
            </article>
            <section class="inputmsg">
                <form action="uploadFile.jsp" method="POST" enctype="multipart/form-data" name="form2Submit" id ="form2Submit">
                    <select class="col-md-2" name="type" id="type" required style="padding: 13px;">
                            <option value="text">Text</option>
                            <option value="file">File</option>
                    </select>
                    <div class="col-md-7" id="changetype" style="padding:0px;">
                        <textarea rows="2" style="width: 100%;" required name="message" id="message" placeholder="Write your message"></textarea>
                    </div>
                    <select class="col-md-2" name="ttype" id="ttype" required style="padding: 13px;">
                            <option value="plain">Plain Text</option>
                            <option value="cipher">Cipher Text</option>
                    </select>
                    <button type="button" onclick="sendmsg(<%=uuid%>);" class="btn btn-primary col-md-1" style="padding: 12px;">Send</button>
                </form>
            </section>
        <%
        
        }else{
            out.println("Select any one friend to chat.");
        }
        %>
        </section>
    </body>
</html>
<script>
    function clear(recid,userid){
        if(confirm("Are you sure?")){
            $.ajax({
                    url:"WebService.jsp",
                    data:{"recid":recid,"userid":userid,"action":"clearchat"},
                    method:"POST",
                    success:function(res){
                     //alert(res);
                     reload();
                     if(res==1){
                         reload();
                     }else{
                        //alert("Chat messages not found."); 
                     }
                    }
                });
        }
    }
    
    function sendmsg(recid){
        
        var type=document.getElementById("type").value;
        var ttype=document.getElementById("ttype").value;
        if(type=="text" && document.getElementById("message").value==""){
            alert("Please enter message");
        }else if(type=="file" && $("#file").val()==""){
            alert("Please select file");
        }else{
            if(type=="text"){
                var msg=document.getElementById("message").value;
                   $.ajax({
                    url:"WebService.jsp",
                    data:{"recid":recid,"userid":<%=uid%>,"action":"sendmsg","msg":msg,"msgtype":type,"encrytype":ttype},
                    method:"POST",
                    success:function(res){
                     //alert(res);
                     if(res==1){
                         //alert("msg send");
                         reload();
                         document.getElementById("message").value="";
                     }else{
                         
                     }  
                    }
                });
            }else{
                document.form2Submit.submit();
            }
        }
    }
    
    $(document).on("change","#type",function(){
        var recid=document.getElementById("recid").value;
        if(type.value=="text"){
            $("#changetype").html('<textarea rows="2" style="width: 100%;" required name="message" id="message" placeholder="Write your message"></textarea>');
            $("#ttype").removeAttr("disabled");
        }else{
            $("#changetype").html('<input type="file" required name="file" style="height: 46px;" class="form-control file" id="file">'); 
            $("#ttype").attr("disabled","disabled");
            updateSessionMsgType(recid,type.value);
        }
    });
    function updateSessionMsgType(recid,msgtype){
        $.ajax({
            url:"WebService.jsp",
            method:"POST",
            data:{"action":"setMsgTypeSession","recid":recid,"msgtype":msgtype},
            success:function(res){
              //  alert(res);
            }
        });
    }
    function reload(){
        var recid=document.getElementById("recid").value;
        var sendid=document.getElementById("sendid").value;
        
        $.ajax({
            url:"WebService.jsp",
            method:"POST",
            data:{"action":"getMessagesBySenderReceiverId","recid":recid,"sendid":sendid},
            success:function(res){
               // alert(res);
                $(".chatbody").html(res);
            }
        });
        //alert(1);
        $('#chatbody').animate({scrollTop: document.getElementById("chatbody").scrollHeight},"fast");
    }
    function plain(msgid){
        var msgcipher=document.getElementById("msg"+msgid).innerHTML;
        $.ajax({
            url:"WebService.jsp",
            method:"POST",
            data:{"action":"convertIntoPlainText","msgid":msgid,"msgcipher":msgcipher},
            success:function(res){
                        //alert(res);
                document.getElementById("msg"+msgid).innerHTML=res;
            }
        });
    }
    $(document).ready(function(){
        reload();
        $('#chatbody').animate({scrollTop: document.getElementById("chatbody").scrollHeight},"fast");
        //setInterval('reload()', 1000);
    });
</script>

