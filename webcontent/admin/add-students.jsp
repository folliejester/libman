<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date" import="com.library.db.dbConnect"%>
<%!
	public static String getDate()
    
	{
        
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        
		String exam_date=df.format(new Date());
         
		return exam_date;
    
	}
%>

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
else
{ 
	String create=request.getParameter("create");
try{
if(create!=null)
{
	String studentid=request.getParameter("studentid");
	String studentName=request.getParameter("studentName");
	String emailid=request.getParameter("emailid");
	String mobileno=request.getParameter("mobileno");
	String sql="INSERT INTO  tblstudents(studentid,FullName,emailid ,mobilenumber,RegDate) VALUES(?,?,?,?,?)";
	ps=conn.prepareStatement(sql);
	ps.setString(1,studentid);
	ps.setString(2,studentName);
	ps.setString(3,emailid);
	ps.setString(4,mobileno);
	ps.setString(5,getDate());
	int i=ps.executeUpdate();


	if(i>0)
	{
		session.setAttribute("msg","Student Listed successfully");
		response.sendRedirect("manage-students.jsp");
	}
	else 
	{
		session.setAttribute("error","Something went wrong. Please try again");
		response.sendRedirect("manage-students.jsp");
	}

	ps.close();
}
}
catch(SQLException e){%><script>alert("ID already exists.");</script><%} %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="student" content="" />
    <title>ABC Library | Add student</title>
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
                <h4 class="header-line">Add student</h4>
                
                            </div>

</div>
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
<div class="panel panel-info">
<div class="panel-heading">
Student Info
</div>
<div class="panel-body">
<form role="form" method="post">
<div class="form-group">
<label>Student ID</label>
<input class="form-control" type="text" name="studentid" autocomplete="off"  required />
<label>Student Name</label>
<input class="form-control" type="text" name="studentName" autocomplete="off"  required />
<label>Email ID</label>
<input class="form-control" type="text" name="emailid" autocomplete="off"  required />
<label>Mobile Number</label>
<input class="form-control" type="text" name="mobileno" autocomplete="off"  required />
</div>

<button type="submit" name="create" value="create" class="btn btn-info">Add </button>

                                    </form>
                            </div>
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
