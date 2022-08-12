<%-- 
    Document   : WebService
    Created on : Jan 26, 2018, 10:30:10 AM
    Author     : Brothers
--%>
<%@page import="java.io.File"%>
<%@page import="org.apache.tomcat.util.codec.binary.Base64"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.InputStream"%>
<%@page import="database.Database"%>
<%
    Database db=new Database();
    String action=request.getParameter("action");
    System.out.println(action);
    switch(action){
        case "user_reg":
            String name=request.getParameter("name");
            String email=request.getParameter("email");
            String contactno=request.getParameter("mobileno");
            String cpwd=request.getParameter("pwd2");
            
                boolean resuserreg=db.userRegister(name,email,contactno,cpwd);
                if(resuserreg){
                 response.sendRedirect("index.jsp?status=1");
                }else{
                 response.sendRedirect("index.jsp?status=0");
                }
            
            break;
        case "user_login":
            String username1=request.getParameter("mobileno");
            String password=request.getParameter("password");
            String res=db.checkUserLogin(username1, password);
            if(res=="0"){
                response.sendRedirect("index.jsp?login=0");
            }else{
                ResultSet rs5=db.getUserDetailsById(res);
                if(rs5.next()){
                    int status=rs5.getInt("status");
                    if(status==1){
                        session.setAttribute("user_acc",res);
                        response.sendRedirect("my-friends.jsp");
                    }else{
                        response.sendRedirect("index.jsp?login=2");
                    }
                }
                
            }
            break;
        case "admin_login":
            String username2=request.getParameter("username");
            String password2=request.getParameter("password");
            boolean res2=db.checkAdminLogin(username2, password2);
            if(res2){
                response.sendRedirect("admin/users.jsp");
            }else{
                response.sendRedirect("admin/login.jsp?status=0");
            }
            break;
        case "updateuserstatus":
            int id=Integer.parseInt(request.getParameter("id"));
            int status=Integer.parseInt(request.getParameter("status"));
            boolean uus=db.updateUsersStatus(id,status);
            if(uus){
                out.print(1);
            }else{
                out.print(0);
            }
            break;
        case "removedata":
            int id1=Integer.parseInt(request.getParameter("id"));
            String tab=request.getParameter("tab");
            boolean rem=db.removeData(id1,tab);
            if(rem){
                out.print(1);
            }else{
                out.print(0);
            }
            break;
        case "sendinvitation":
            String userid=request.getParameter("userid");
            String reqid=request.getParameter("reqid");
            boolean sendinv=db.sendInvitation(userid,reqid);
            if(sendinv){
                out.println(1);
            }else{
                out.println(0);
            }
            break;
        case "cancelrequest":
            String inv4id=request.getParameter("invid");
            boolean reqfri=db.cancelRequest(inv4id);
            if(reqfri){
                out.println(1);
            }else{
                out.println(0);
            }
            break;
        case "acceptrejectreq":
            String invid=request.getParameter("invid");
            String act=request.getParameter("act");
            boolean invres=false;
            if(act.equals("accept")){
                invres=db.acceptRequest(invid);
                if(invres){
                    out.println(1);
                }else{
                    out.println(0);
                }
            }else{
                invres=db.rejectRequest(invid);
                if(invres){
                    out.println(2);
                }else{
                    out.println(0);
                }
            }
            break;
        case "addanno":
            String content1=request.getParameter("content");
            boolean anno=db.addAnno(content1);
            if(anno){
                response.sendRedirect("adminpanel/announcements.jsp");
            }else{
                response.sendRedirect("adminpanel/announcements.jsp");
            }
            break;
        case "sendmsg":
            String user3id=request.getParameter("userid");
            String recid=request.getParameter("recid");
            String message=request.getParameter("msg");
            String messagetype=request.getParameter("msgtype");
            String encryty=request.getParameter("encrytype");
            if(encryty.equals("cipher")){
                byte[] encodedBytes = Base64.encodeBase64(message.getBytes());
                message=new String(encodedBytes);
            }
            session.removeAttribute("recid");
            session.removeAttribute("msgtype");
            boolean resmsg=db.sendmsg(user3id,recid,message,messagetype,encryty);
            if(resmsg){
                out.println(1);
            }else{
                out.println(0);
            }
            break;
        case "updateprofdetails":
            int id11=Integer.parseInt(request.getParameter("id"));
            String username11=request.getParameter("user_name");
            String email11=request.getParameter("email");
            String contactno11=request.getParameter("contactno");
            String address11=request.getParameter("address");
            String aadhaarno11=request.getParameter("aadhaarno");
            boolean ress=db.userProfileUpdate(id11,username11,email11,contactno11,address11,aadhaarno11);
                if(ress){
                 response.sendRedirect("my-profile.jsp?status=1");
                }else{
                 response.sendRedirect("my-profile.jsp?status=0");
                }
            break;
        case "updateadminpassword":
            String pwd1=request.getParameter("pwd");
            String npwd1=request.getParameter("npwd");
            String cpwd1=request.getParameter("cpwd");
            
            boolean ress1=db.userPasswordAdminUpdate(cpwd1,pwd1);
                if(ress1){
                 response.sendRedirect("admin/change-pwd.jsp?status=1");
                }else{
                 response.sendRedirect("admin/change-pwd.jsp?status=0");
                }
            break;
        case "updateuserpassword":
            String pwd1u=request.getParameter("pwd");
            String cpwd1u=request.getParameter("cpwd");
            String userid4u=(String)session.getAttribute("user_acc");
            boolean ress1u=db.userPasswordUserUpdate(cpwd1u,pwd1u,userid4u);
                if(ress1u){
                 response.sendRedirect("change-password.jsp?status=1");
                }else{
                 response.sendRedirect("change-password.jsp?status=0");
                }
            break;
        case "addproducts":
            int id5=Integer.parseInt(request.getParameter("id"));
            String pname=request.getParameter("pname");
            String descr=request.getParameter("descr");
            String bidstart=request.getParameter("bidstart");
            String bidend=request.getParameter("bidend");
            String bidamt=request.getParameter("bidamt");
            
            boolean ress4=db.userNewProduct(id5,pname,descr,bidstart,bidend,bidamt);
                if(ress4){
                 response.sendRedirect("my-products.jsp?status1=1");
                }else{
                 response.sendRedirect("my-products.jsp?status1=0");
                }
            break;
        case "clearchat":
            int recidid=Integer.parseInt(request.getParameter("recid"));
            int useridid=Integer.parseInt(request.getParameter("userid"));
            boolean res6=db.clearChat(recidid,useridid);
            if(res6){
                out.println(1);
            }else{
                out.println(0);
            }
            break;
        case "setMsgTypeSession":
            int recid65=Integer.parseInt(request.getParameter("recid"));
            String msgtype6=request.getParameter("msgtype");
            session.setAttribute("recid", recid65);
            session.setAttribute("msgtype",msgtype6);
            out.println(1);
            break;
         case "updateproductdetails":
            int id6=Integer.parseInt(request.getParameter("id"));
            String pname3=request.getParameter("pname");
            String descr3=request.getParameter("descr");
            String bidstart3=request.getParameter("bidstart");
            String bidend3=request.getParameter("bidend");
            String bidamt3=request.getParameter("bidamt");
            
            boolean ress6=db.userUpdateProductDetails(id6,pname3,descr3,bidstart3,bidend3,bidamt3);
                if(ress6){
                 response.sendRedirect("my-products.jsp?status=1");
                }else{
                 response.sendRedirect("my-products.jsp?status=0");
                }
            break;
         case "countnewrequestrows":
            String userid4=(String)session.getAttribute("user_acc");
            int res8=db.countTotalNewRequest(userid4);
            if(res8>0){
                out.println(res8);
            }else{
                out.println(0);
            }
             break;
         case "countunreadmsg":
            String userid45=(String)session.getAttribute("user_acc");
            int res58=db.countTotalUnreadMsg(userid45);
            if(res58>0){
                out.println(res58);
            }else{
                out.println(0);
            }
             break;
        case "getMessagesBySenderReceiverId":
            String sendid=request.getParameter("sendid");
            String recid4=request.getParameter("recid");
            ResultSet res84=db.getMessagesBySenderReceiverId(sendid,recid4);
            String output="";
            if(res84!=null){
                while(res84.next()){
                    int senderid=res84.getInt("sender_id");
                    int receiverid=res84.getInt("receiver_id");
                    String msgtype=res84.getString("msg_type");
                    String encyty=res84.getString("ency_type");
                    String msgid=res84.getString("id");
                    String sta=res84.getString("status");
                    
                    if(receiverid==Integer.parseInt(recid4) && senderid==Integer.parseInt(sendid)){
                        %>
                        <div class='media'>
                            <div class='media-body text-right'>
                                <%
                                String msg=res84.getString("message");
                                
                                if(msgtype.equals("file")){
                                    String msgg = msg.replace(".","/");
                                    String[] parts = msgg.split("/", 2);
                                    String ext=parts[1];
                                    //out.println(ext);
                                    if(ext.equals("pdf") || ext.equals("doc") || ext.equals("docx")){
                                        out.println("<a style='color:#fff;' target='_blank' href='uploads/"+msg+"'>"+msg+"</a>");
                                    }else{
                                        out.println("<a target='_blank' href='uploads/"+msg+"'><img src='uploads/"+msg+"' width='200px' ></a>");
                                    }  
                                }else{
                                %>
                                <span style='color:#fff;' id="msg<%=msgid%>"><%=res84.getString("message")%></span>
                                <%
                                    if(encyty.equals("cipher")){
                                        %>
                                        <a href="javascript:plain(<%=msgid%>);"><i class="fa fa-map"></i></a>
                                        <%
                                    }
                                }
                                %>
                            </div>
                            <div class='media-right'> 
                                <i class="fa fa-user fa-lg" style="font-size: 35px; color:#fff;"></i>
                            </div>
                        </div>
                        <%
                    }
                    if(receiverid==Integer.parseInt(sendid) && Integer.parseInt(recid4)==senderid){
                        if(sta.equals("0")){
                        db.readReceivedMsg(msgid);
                        }
               %>
                        <div class="media">
                            <div class="media-left"> 
                                <a href="#">
                                    <i class="fa fa-user fa-lg" style="font-size: 35px;color:#fff;"></i>
                                </a>
                            </div>
                            <div class="media-body">
                                <%
                                String msg=res84.getString("message");
                                
                                if(msgtype.equals("file")){
                                    String msgg = msg.replace(".","/");
                                    String[] parts = msgg.split("/", 2);
                                    String ext=parts[1];
                                    if(ext.equals("pdf") || ext.equals("doc") || ext.equals("docx")){
                                        out.println("<a style='color:#fff;' target='_blank' href='uploads/"+msg+"'>"+msg+"</a>");
                                    }else{
                                        out.println("<a target='_blank' href='uploads/"+msg+"'><img src='uploads/"+msg+"' width='200px' ></a>");
                                    }  
                                }else{
                                %>
                                <span style='color:#fff;' id="msg<%=msgid%>"><%=res84.getString("message")%></span>
                                <%
                                    if(encyty.equals("cipher")){
                                        %>
                                        <a href="javascript:plain(<%=msgid%>);"><i class="fa fa-map"></i></a>
                                        <%
                                    }
                                }
                                %>
                            </div>
                        </div>
                <%
                    }
                        }
            }else{
                out.println(0);
            }
             break;
        case "convertIntoPlainText":
            String msgcipher=request.getParameter("msgcipher");
            byte[] decodedBytes = Base64.decodeBase64(msgcipher);
            out.println(new String(decodedBytes));
            break;
    }
    %>
