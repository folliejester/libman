<%@page import="java.sql.*" import="com.library.db.dbConnect"%>
<%
	PreparedStatement ps;
    ResultSet rs= null;
    Connection conn = dbConnect.getConnection();
%>
<%

//if(((String)session.getAttribute("login")).length==0)
if(session.getAttribute("login")==null)
  { 
	response.sendRedirect("index.jsp");
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
    <title>TIU LIBRARY | Student Dash Board</title>
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
                <h4 class="header-line">STUDENT DASHBOARD</h4>
                
                            </div>

        </div>
             
             <div class="row">



            
                 <div class="col-md-3 col-sm-3 col-xs-6">
                      <div class="alert alert-info back-widget-set text-center">
                            <i class="fa fa-bars fa-5x"></i>
<%
String sid=(String)session.getAttribute("stdid");
String sql1 ="SELECT id from tblissuedbookdetails where StudentID=?";
ps=conn.prepareStatement(sql1,ResultSet.TYPE_SCROLL_SENSITIVE,  
                     ResultSet.CONCUR_UPDATABLE);
ps.setString(1,sid);
rs=ps.executeQuery();

rs.last();
int issuedbooks=rs.getRow();

ps.close();
%>

                            <h3> <%=issuedbooks%></h3>
                            Books Borrowed
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
<%}%>