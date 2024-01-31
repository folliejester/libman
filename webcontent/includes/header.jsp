<div class="navbar navbar-inverse set-radius-zero" >
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" >

                    <img src="assets/img/logo1.png" height=60 />
                </a>

            </div>
<% if(session.getAttribute("login")!=null)
{
%> 
            <div class="right-div">
                <a href="logout.jsp" class="btn btn-danger pull-right">LOG OUT</a>
            </div>
<% } %>
        </div>
    </div>
    <!-- LOGO HEADER END-->
<% if(session.getAttribute("login")!=null)
{
%>    
<section class="menu-section">
        <div class="container">
            <div class="row ">
                <div class="col-md-12">
                    <div class="navbar-collapse collapse ">
                        <ul id="menu-top" class="nav navbar-nav navbar-right">
                            <li><a href="dashboard.jsp" class="menu-top">DASHBOARD</a></li>
                           
                          
   <li>
                                <a href="#" class="dropdown-toggle" id="ddlmenuItem" data-toggle="dropdown"> Account <i class="fa fa-angle-down"></i></a>
                                <ul class="dropdown-menu" role="menu" aria-labelledby="ddlmenuItem">
                                    <li role="presentation"><a role="menuitem" tabindex="-1" href="my-profile.jsp">My Profile</a></li>
                                     <li role="presentation"><a role="menuitem" tabindex="-1" href="change-password.jsp">Change Password</a></li>
                                </ul>
                            </li>
                            <li><a href="issued-books.jsp">Books Info</a></li>
                          

                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </section>
    <%} else { %>
        <section class="menu-section">
        <div class="container">
            <div class="row ">
                <div class="col-md-12">
                    <div class="navbar-collapse collapse ">
                        <ul id="menu-top" class="nav navbar-nav navbar-right">                        
                          
  							 <li><a href="adminlogin.jsp">Teacher Login</a></li>
                             <li><a href="signup.jsp">Student Sign up</a></li>
                             <li><a href="index.jsp">Student Login</a></li>
                          

                        </ul>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <% } %>