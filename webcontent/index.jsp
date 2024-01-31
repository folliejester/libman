<%@page import="java.sql.*" import="com.library.db.dbConnect"%>
<%
	PreparedStatement ps;
    ResultSet rs= null;
    Connection conn = dbConnect.getConnection();

String login=request.getParameter("login");
if(session.getAttribute("login")==null)
{
	//session.setAttribute("login",null);
}
if(login!=null)
{
	
		String email=request.getParameter("emailid");
		String password=request.getParameter("password");
			String sql ="SELECT EmailId,Password,StudentId,Status FROM tblstudents WHERE EmailId=? and Password=?";
			ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			ps.setString(1,email);
			ps.setString(2,password);
		
			rs=ps.executeQuery();

			if(rs.next())
			{
				String stdid=rs.getString(3);
				int status=rs.getInt(4);
				session.setAttribute("stdid",stdid);
				if(status==1)
				{
					session.setAttribute("login",email);
					out.println("<script type='text/javascript'> document.location ='dashboard.jsp'; </script>");
				} 
				else 
				{
					out.println("<script>alert('Your Account Has been blocked .Please contact admin');</script>");
		
				}
			}
			else
			{	
				out.println("<script>alert('Invalid Details');</script>");
			}
			

			rs.close();
		
} 


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>ABC Library | </title>
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
<h4 class="header-line">STUDENT LOGIN FORM</h4>
</div>
</div>
             
<!--LOGIN PANEL START-->           
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" >
<div class="panel panel-info">
<div class="panel-heading">
 LOGIN FORM
</div>
<div class="panel-body">
<form role="form" method="post">

<div class="form-group">
<label>Enter Email id</label>
<input class="form-control" type="text" name="emailid" required autocomplete="off" />
</div>
<div class="form-group">
<label>Password</label>
<input class="form-control" type="password" name="password" required autocomplete="off"  />

</div>


 <button type="submit" name="login" value="login" class="btn btn-info">LOGIN </button> | <a href="signup.jsp">Not Registered Yet</a>
</form>
 </div>
</div>
</div>
</div>  
<!---LOGIN PABNEL END-->            
             
 
    </div>
    </div>
     <!-- CONTENT-WRAPPER SECTION END-->
<jsp:include page="includes/footer.jsp" />
      <!-- FOOTER SECTION END-->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>

</body>
</html>
