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
else
{
	
	
	String sql = "SELECT * from tblstudents";
	ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs=ps.executeQuery();
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>ABC Library | Fines</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- DATATABLE STYLE  -->
    <link href="assets/js/dataTables/dataTables.bootstrap.css" rel="stylesheet" />
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
                <h4 class="header-line">Total Fine paid by the Student</h4>
    </div>



        </div>
        <div class="row">
<div class="col-md-12">
<div class="panel panel-info">
<div class="panel-heading">
	Select Student and Duration
</div>
<div class="panel-body">
<form role="form" method="post">

<div class="form-group">
<label>Select Student<span style="color:red;">*</span></label>
<select class="form-control" name="stdname"  required>
<%
if(rs!=null)
{
while(rs.next())
{
String sname = rs.getString("FullName");
String sid = rs.getString("StudentId"); 
%>
<option value="<%=sid %>"><%=sname %></option>
<%
}

}
%>
</select>
</div>


<div class="form-group">
<label>From<span style="color:red;">*</span></label>
<input class="form-control" type="date" id="from" name="from" min="1900-01-01" max="2200-01-01" required>
</div>

<div class="form-group">
<label>To<span style="color:red;">*</span></label>
<input class="form-control" type="date" id="to" name="to" min="1900-01-01" max="2200-01-01" required>
</div>

<button type="submit" name="genReport" value="genReport" id="submit" class="btn btn-info">Generate Report </button>

                                    </form>
                            </div>
                        </div>
                            </div>

        </div>
        
    <%
        String sid=request.getParameter("stdname");
    	String from=request.getParameter("from");
    	String to=request.getParameter("to");
    	


    	if(from != null && to != null){
    		String sql2 = "SELECT sum(tblissuedbookdetails.fine) as fine,tblissuedbookdetails.StudentID,tblstudents.FullName,tblstudents.EmailId,tblstudents.MobileNumber from  tblissuedbookdetails join tblstudents on tblstudents.StudentId=tblissuedbookdetails.StudentId where tblstudents.StudentId=?  and (tblissuedbookdetails.IssuesDate between ? and ?) group by tblissuedbookdetails.StudentID,tblstudents.FullName,tblstudents.EmailId,tblstudents.MobileNumber";
    		ps=conn.prepareStatement(sql2,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
    		ps.setString(1,sid);
    		ps.setDate(2,java.sql.Date.valueOf(from));
    		ps.setDate(3,java.sql.Date.valueOf(to));
    		rs=ps.executeQuery();
    	
        
        
     %>
            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          Total Fine
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Student ID</th>
                                            <th>Student Name </th>
                                            <th>Email</th>
                                            <th>Mobile Number</th>
                                            <th>Total Fine(LKR)</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
	
		
		
		
		
	

if(rs.next())
{

 %>                                      
                                        <tr class="odd gradeX">
                                            
                                            <td class="center"><%=rs.getString("StudentId")%></td>
                                            <td class="center"><%=rs.getString("FullName")%></td>
                                            <td class="center"><%=rs.getString("EmailId")%></td>
                                            <td class="center"><%=rs.getString("MobileNumber")%></td>
                                            <td class="center"><%=rs.getString("fine")%></td>
                                           
                                        </tr>
												 <% }  %>                                      
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
                </div>
            </div>
<%  } ps.close(); %>

            
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
    <!-- DATATABLE SCRIPTS  -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
<% } %>
