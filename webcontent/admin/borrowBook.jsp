<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date,java.time.LocalDate" import="com.library.db.dbConnect" %>
<%!
	
%>
<%
		PreparedStatement ps;
		Connection conn = dbConnect.getConnection();
        ResultSet rs= null,rs2=null;
        
       
        
%>

<%

String stdid=(String)request.getParameter("stdid");
out.println(stdid);


if(session.getAttribute("alogin")==null)
{ 
	response.sendRedirect("../index.jsp");
}
else
{ 
	LocalDate date = LocalDate.now();
	String issue=request.getParameter("issue");
	if(issue!=null)
	{
		String bookName=request.getParameter("bookname");
		
		String sql1 ="SELECT id FROM tblbooks WHERE (BookName=?)";
		ps=conn.prepareStatement(sql1,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		ps.setString(1,bookName);
		ResultSet rs1=ps.executeQuery();
		String sql2 = "SELECT * from tblissuedbookdetails";
		ps=conn.prepareStatement(sql2,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs2=ps.executeQuery();
		
		if(rs1.next())
		{
			String sql="INSERT INTO  tblissuedbookdetails(StudentID,BookId,IssuesDate) VALUES(?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setString(1,stdid);
			ps.setInt(2,rs1.getInt("id"));
			ps.setDate(3,java.sql.Date.valueOf(date));
			int i=ps.executeUpdate();
		
		
			if(i>0)
			{
				session.setAttribute("msg","Book issued successfully");
			}
			else 
			{
				session.setAttribute("error","Something went wrong. Please try again");
				response.sendRedirect("issued-books.jsp");
			}
		}	
		
		ps.close();
	}
else{
	String sql = "SELECT * from tblbooks";
	ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs=ps.executeQuery();
}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>TIU LIBRARY | Borrow a new Book</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />

<style type="text/css">
  .others{
    color:red;
}

</style>


</head>
<body>
      <!------MENU SECTION START-->
<jsp:include page="includes/header.jsp" />
<!-- MENU SECTION END-->
    
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">Borrow a New Book</h4>
                
                            </div>

</div>
<div class="row">
<div class="col-md-10 col-sm-6 col-xs-12 col-md-offset-1">
<div class="panel panel-info">
<div class="panel-heading">
Borrow a New Book
</div>
<div class="panel-body">
<form role="form" method="post">

<div class="form-group">
<label>Select a Book<span style="color:red;">*</span></label>
<select class="form-control" name="bookname"  required>
<%
if(rs!=null)
{
while(rs.next())
{
String bname = rs.getString("BookName"); 
%>
<option value="<%=bname %>"><%=bname %></option>
<%
}
}
%>
</select>
</div>

<a href = "issued-books.jsp?stdid=<%=rs2.getString("studentid")%>"><button type="submit" name="issue" value="issue" id="submit" class="btn btn-info">Borrow Book</button></a>

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
<%
 } 
%>
