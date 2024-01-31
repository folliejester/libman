<%@page import="java.sql.*" import="com.library.db.dbConnect"%>

<%
	PreparedStatement ps;
        ResultSet rs= null;
        Connection conn = dbConnect.getConnection();
	String msg=null;
	String error=null;
%>

<%

String email=(String)session.getAttribute("login");
if(email==null)
{   
	response.sendRedirect("index.jsp");
}
else
{ 
	String changeValue=request.getParameter("change");
	if(changeValue!=null && changeValue.equals("change"))
  	{
		String password=request.getParameter("password");
		String newpassword=request.getParameter("newpassword");
		String sql ="SELECT Password FROM tblstudents WHERE EmailId=? and Password=?";
		ps=conn.prepareStatement(sql);
		ps.setString(1,email);
		ps.setString(2,password);

		rs=ps.executeQuery();

		if(rs.next())
		{
			String sql1="update tblstudents set Password=? where EmailId=?";
			ps=conn.prepareStatement(sql1);
			ps.setString(1,newpassword);
			ps.setString(2,email);
			ps.executeUpdate();

			msg="Your Password succesfully changed";
			error=null;
		}
		else 
		{
			error="Your current password is wrong";  
			msg=null;
		}
		
		ps.close();
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
  <style>
    .errorWrap {
    padding: 10px;
    margin: 0 0 20px 0;
    background: #fff;
    border-left: 4px solid #dd3d36;
    -webkit-box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
}
.succWrap{
    padding: 10px;
    margin: 0 0 20px 0;
    background: #fff;
    border-left: 4px solid #5cb85c;
    -webkit-box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
    box-shadow: 0 1px 1px 0 rgba(0,0,0,.1);
}
    </style>
</head>
<script type="text/javascript">
function valid()
{
if(document.chngpwd.newpassword.value!= document.chngpwd.confirmpassword.value)
{
alert("New Password and Confirm Password Field do not match  !!");
document.chngpwd.confirmpassword.focus();
return false;
}
return true;
}
</script>

<body>
    <!------MENU SECTION START-->
<jsp:include page="includes/header.jsp" />
<!-- MENU SECTION END-->
<div class="content-wrapper">
<div class="container">
<div class="row pad-botm">
<div class="col-md-12">
<h4 class="header-line">User Change Password</h4>
</div>
</div>
 <% if(error!=null){%><div class="errorWrap"><strong>ERROR</strong>:<%=error%> </div><% } 
        else if(msg!=null){%><div class="succWrap"><strong>SUCCESS</strong>:<%=msg%> </div><% }%>            
<!--LOGIN PANEL START-->           
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3" >
<div class="panel panel-info">
<div class="panel-heading">
Change Password
</div>
<div class="panel-body">
<form role="form" method="get" onSubmit="return valid();" name="chngpwd">

<div class="form-group">
<label>Current Password</label>
<input class="form-control" type="password" name="password" autocomplete="off" required  />
</div>

<div class="form-group">
<label>Enter Password</label>
<input class="form-control" type="password" name="newpassword" autocomplete="off" required  />
</div>

<div class="form-group">
<label>Confirm Password </label>
<input class="form-control"  type="password" name="confirmpassword" autocomplete="off" required  />
</div>

 <button type="submit" name="change" value="change" class="btn btn-info">Change </button> 
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
<% } %>
