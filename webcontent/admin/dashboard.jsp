<%@page import="java.sql.*" import="com.library.db.dbConnect"%>
<%
	PreparedStatement ps;
		Connection conn = dbConnect.getConnection();
        ResultSet rs= null;
        
%>

<%

if(session.getAttribute("alogin")==null)
{ 
	response.sendRedirect("../index.jsp");
}
else{
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>ABC Library | Admin Dash Board</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

</head>
<body>
      <!------MENU SECTION START-->
<jsp:include page="includes/header.jsp" />
<!-- MENU SECTION END-->
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">ADMIN DASHBOARD</h4>
                
                            </div>

        </div>
             
             <div class="row">

 <div class="col-md-3 col-sm-3 col-xs-6">
                      <div class="alert alert-success back-widget-set text-center">
                            <i class="fa fa-book fa-5x"></i>
<%
String sql ="SELECT id from tblbooks ";
ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=ps.executeQuery();


rs.last();
int listdbooks=rs.getRow();
%>


                            <h3><%=listdbooks%></h3>
                      Books Listed
                        </div>
                    </div>

            
                 <div class="col-md-3 col-sm-3 col-xs-6">
                      <div class="alert alert-info back-widget-set text-center">
                            <i class="fa fa-bars fa-5x"></i>
<% 
String sql1 ="SELECT id from tblissuedbookdetails ";
ps=conn.prepareStatement(sql1,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=ps.executeQuery();

rs.last();
int issuedbooks=rs.getRow();
%>

                            <h3><%=issuedbooks%> </h3>
                           Books Issued
                        </div>
                    </div>
             
               <div class="col-md-3 col-sm-3 col-xs-6">
                      <div class="alert alert-warning back-widget-set text-center">
                            <i class="fa fa-recycle fa-5x"></i>
<%
int status=1;
String sql2 ="SELECT id from tblissuedbookdetails where RetrunStatus=?";
ps=conn.prepareStatement(sql2,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
ps.setInt(1,status);
rs=ps.executeQuery();

rs.last();
int returnedbooks=rs.getRow();
%>

                            <h3><%=returnedbooks%></h3>
                          Books Returned
                        </div>
                    </div>
               <div class="col-md-3 col-sm-3 col-xs-6">
                      <div class="alert alert-danger back-widget-set text-center">
                            <i class="fa fa-users fa-5x"></i>
<% 
String sql3 ="SELECT id from tblstudents ";
ps=conn.prepareStatement(sql3,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=ps.executeQuery();

rs.last();
int regstds=rs.getRow();
%>
                            <h3><%=regstds%></h3>
                           Registered Students
                        </div>
                    </div>

        </div>



 <div class="row">

 <div class="col-md-3 col-sm-3 col-xs-6">
                      <div class="alert alert-success back-widget-set text-center">
                            <i class="fa fa-user fa-5x"></i>
<% 
String sql4 ="SELECT id from tblauthors ";
ps=conn.prepareStatement(sql4,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=ps.executeQuery();

rs.last();
int listdathrs=rs.getRow();
%>


                            <h3><%=listdathrs%></h3>
                      Listed Authors
                        </div>
                    </div>

            
                 <div class="col-md-3 col-sm-3 rscol-xs-6">
                      <div class="alert alert-info back-widget-set text-center">
                            <i class="fa fa-file-archive-o fa-5x"></i>
<% 
String sql5 ="SELECT id from tblcategory ";
ps=conn.prepareStatement(sql5,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=ps.executeQuery();

rs.last();
int listdcats=rs.getRow();

ps.close();

%>

                            <h3><%=listdcats%> </h3>
                           Listed Categories
                        </div>
                    </div>
             

        </div>             

            
    </div>
    </div>
     <!-- CONTENT-WRAPPER SECTION END-->
<jsp:include page="includes/footer.jsp" />
      <!-- FOOTER SECTION END-->
    <!-- JAVASCRIPT FILES PLACED AT THE BOTTOM TO REDUCE THE LOADING TIME  -->
    <!-- CORE JQUERY  -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<% } %>
