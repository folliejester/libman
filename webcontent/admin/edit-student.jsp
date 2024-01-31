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
	String update=request.getParameter("update");
	if(update!=null)
	{
		String stdid=request.getParameter("stdid");
		String Student=request.getParameter("Student");
		String email=request.getParameter("Email");
		String pwd=request.getParameter("Password");

		String sql="update  tblstudents set FullName=?,UpdationDate=?,emailid = ?,password = ? where studentid=?";
		ps=conn.prepareStatement(sql);
		ps.setString(1,Student);
		ps.setString(2,getDate());
		ps.setString(3,email);
		ps.setString(4,pwd);
		ps.setString(5,stdid);
		int i=ps.executeUpdate();

		session.setAttribute("updatemsg","Student info updated successfully");
		response.sendRedirect("manage-students.jsp");
}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="Student" content="" />
    <title>ABC Library | Add Student</title>
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
                <h4 class="header-line">Add Student</h4>
                
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
<% 
String stdid=request.getParameter("stdid");
String sql = "SELECT * from  tblstudents where studentid=?";
ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ps.setString(1,stdid);
	rs=ps.executeQuery();

int cnt=1;
while(rs.next())
{
       %>  
<label>Student Name</label>
<input class="form-control" type="text" name="Student" value="<%=rs.getString("FullName")%>" required />
<br>
<label>Email</label>
<input class="form-control" type="text" name="Email" value="<%=rs.getString("emailid")%>" required />
<br>
<label>Password</label>
<input class="form-control" type="password" name="Password" value="<%=rs.getString("password")%>" required />

<% }
ps.close();

%>
</div>

<button type="submit" name="update" class="btn btn-info">Update </button>

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