package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Secure Messaging Platform</title>\n");
      out.write("        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css\">\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/bootstrap.min.css\" />\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\" />\n");
      out.write("        \n");
      out.write("        <script src=\"css/jquery.min.js\"></script>\n");
      out.write("        <script src=\"css/bootstrap.min.js\"></script>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("        <header>\n");
      out.write("            <center><h1>Secure Messaging Platform</h1></center>\n");
      out.write("        </header>\n");
      out.write("        <nav class=\"navbar navbar-default\">\n");
      out.write("            <div class=\"container-fluid\">\n");
      out.write("                <!-- Brand and toggle get grouped for better mobile display -->\n");
      out.write("                <div class=\"navbar-header\">\n");
      out.write("                    <button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\"#bs-example-navbar-collapse-1\" aria-expanded=\"false\">\n");
      out.write("                        <span class=\"sr-only\">Toggle navigation</span>\n");
      out.write("                        <span class=\"icon-bar\"></span>\n");
      out.write("                        <span class=\"icon-bar\"></span>\n");
      out.write("                        <span class=\"icon-bar\"></span>\n");
      out.write("                    </button>\n");
      out.write("                </div>\n");
      out.write("                \n");
      out.write("                <!-- Collect the nav links, forms, and other content for toggling -->\n");
      out.write("                <div class=\"collapse navbar-collapse\" id=\"bs-example-navbar-collapse-1\">\n");
      out.write("                    ");

                            if(request.getParameter("login")!= null){
                                String login=request.getParameter("login");
                                if(login.equals("2")){
                                    
      out.write("\n");
      out.write("                                    <div class=\"alert alert-success\">\n");
      out.write("                                        User not verified yet by admin!\n");
      out.write("                                    </div>\n");
      out.write("                                    ");

                                }else{
                                    
      out.write("\n");
      out.write("                                    <div class=\"alert alert-danger\">\n");
      out.write("                                        Username/Password Invalid.\n");
      out.write("                                    </div>\n");
      out.write("                                    ");

                                }
                            }
                        
      out.write("\n");
      out.write("                    <form action=\"WebService.jsp\" method=\"POST\" class=\"navbar-form navbar-right\">\n");
      out.write("                        <div class=\"form-group\">\n");
      out.write("                            <input type=\"text\" class=\"form-control\" name=\"mobileno\" maxlength=\"10\" required=\"true\" placeholder=\"Mobile no\">\n");
      out.write("                            <input type=\"password\" class=\"form-control\"name=\"password\" required=\"true\" placeholder=\"********\">\n");
      out.write("                        </div>\n");
      out.write("                        <input type=\"hidden\" value=\"user_login\" name=\"action\"/>\n");
      out.write("                        <button type=\"submit\" class=\"btn btn-default\">Login</button>\n");
      out.write("                    </form>\n");
      out.write("                </div><!-- /.navbar-collapse -->\n");
      out.write("            </div><!-- /.container-fluid -->\n");
      out.write("        </nav>\n");
      out.write("        <section class=\"col-md-7 left-side\" style=\"width: 63.5%;\">\n");
      out.write("            \n");
      out.write("        </section>\n");
      out.write("        <section class=\"col-md-4 right-side\"><br>\n");
      out.write("            ");

                            if(request.getParameter("status")!= null){
                                String login=request.getParameter("status");
                                if(login.equals("1")){
                                    
      out.write("\n");
      out.write("                                    <div class=\"alert alert-success\">\n");
      out.write("                                        User registered successfully!\n");
      out.write("                                    </div>\n");
      out.write("                                    ");

                                }else{
                                    
      out.write("\n");
      out.write("                                    <div class=\"alert alert-danger\">\n");
      out.write("                                        User not registered.\n");
      out.write("                                    </div>\n");
      out.write("                                    ");

                                }
                            }
                        
      out.write("\n");
      out.write("            <h3 class=\"text-center\">Create an account</h3>\n");
      out.write("            <h5 class=\"red\">*All fields are compulsory.</h5><br>\n");
      out.write("            <form action=\"WebService.jsp\" name=\"userreg\" method=\"POST\">\n");
      out.write("                <div class=\"col-md-12\">\n");
      out.write("                    <label>Full name</label>\n");
      out.write("                    <input type=\"text\" class=\"form-control\" name=\"name\" id=\"name\" required=\"true\" placeholder=\"Full name\"><br>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-6\">\n");
      out.write("                    <label>Email Address</label>\n");
      out.write("                    <input type=\"email\" class=\"form-control\" name=\"email\" id=\"email\" required=\"true\" placeholder=\"Email Address\"><br>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-6\">\n");
      out.write("                    <label>Mobile No</label>\n");
      out.write("                    <input type=\"text\" maxlength=\"10\" class=\"form-control\" name=\"mobileno\" id=\"mobileno\" required=\"true\" placeholder=\"Mobile No.\"><br>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-6\">\n");
      out.write("                    <label>Password</label>\n");
      out.write("                    <input type=\"password\" class=\"form-control\" name=\"pwd1\" id=\"pwd1\" required=\"true\" placeholder=\"********\"><br>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-6\">\n");
      out.write("                    <label>Confirm Password</label>\n");
      out.write("                    <input type=\"password\" class=\"form-control\" name=\"pwd2\" id=\"pwd2\" required=\"true\" placeholder=\"********\"><br>\n");
      out.write("                </div>\n");
      out.write("                <div class=\"col-md-12\">\n");
      out.write("                    <button type=\"button\" onclick=\"submituser();\" class=\"btn btn-default\">Register</button><br><br><br><br>\n");
      out.write("                </div>\n");
      out.write("                <input type=\"hidden\" value=\"user_reg\" name=\"action\"/>\n");
      out.write("            </form>\n");
      out.write("        </section>\n");
      out.write("        <section class=\"col-md-12\"><br>\n");
      out.write("            <h5 class=\"text-center\">Copyright 2021. All rights reserved.</h5>\n");
      out.write("        </section>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
      out.write("<script>\n");
      out.write("    function submituser(){\n");
      out.write("        var name=document.getElementById(\"name\").value;\n");
      out.write("        var email=document.getElementById(\"email\").value;\n");
      out.write("        var mobileno=document.getElementById(\"mobileno\").value;\n");
      out.write("        var pwd1=document.getElementById(\"pwd1\").value;\n");
      out.write("        var pwd2=document.getElementById(\"pwd2\").value;\n");
      out.write("        if(name==''){\n");
      out.write("            alert(\"Please enter name.\");\n");
      out.write("        }else if(email==''){\n");
      out.write("            alert(\"Please enter email.\");\n");
      out.write("        }else if(mobileno==''){\n");
      out.write("            alert(\"Please enter mobile no\");\n");
      out.write("        }else if(!$.isNumeric(mobileno)){\n");
      out.write("            alert(\"Please enter valid mobile no\");\n");
      out.write("        }else if(mobileno.length!=10){\n");
      out.write("            alert(\"Please enter valid mobiloe no.\");\n");
      out.write("        }else if(pwd1=='' || pwd2 ==''){\n");
      out.write("            alert(\"Please enter password.\");\n");
      out.write("        }else if(pwd1!=pwd2){\n");
      out.write("            alert(\"Password does not matched.\");\n");
      out.write("        }else{\n");
      out.write("            document.userreg.submit();\n");
      out.write("        }\n");
      out.write("    }\n");
      out.write("</script>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
