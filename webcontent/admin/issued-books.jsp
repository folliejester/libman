<%@page import="java.sql.*" import="com.library.db.dbConnect" import="java.util.*"%>
<%
	PreparedStatement ps;
        ResultSet rs= null;
        Connection conn = dbConnect.getConnection();
        
%>


<%
if(session.getAttribute("alogin")==null)
{ 
	response.sendRedirect("../index.jsp");
}
else
{ 
	

%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>ABC Library | Return Books</title>
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
                <h4 class="header-line">Return Issued Books</h4>
    </div>
    

            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                          Issued Books 
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Book Name</th>
                                            <th>ISBN </th>
                                            <th>Issued Date</th>
                                            <th>Due Date</th>
                                            <th>Status</th>
                                            <th>Fine in(INR)</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<%
	String sid=(String)request.getParameter("stdid");
	String sql="SELECT tblbooks.BookName,tblbooks.ISBNNumber,tblissuedbookdetails.DueDate, tblissuedbookdetails.IssuesDate,tblissuedbookdetails.ReturnDate,tblissuedbookdetails.id as rid,tblissuedbookdetails.fine from  tblissuedbookdetails join tblstudents on tblstudents.StudentId=tblissuedbookdetails.StudentId join tblbooks on tblbooks.id=tblissuedbookdetails.BookId where tblstudents.StudentId=? order by tblissuedbookdetails.id desc";
	ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ps.setString(1,sid);
	rs=ps.executeQuery();
	
	int cnt=1;
	while(rs.next())
	{
		
%>             
		                         
		<tr class="odd gradeX">
		<td class="center"><%=cnt%></td>
		<td class="center"><%=rs.getString("BookName")%></td>
		<td class="center"><%=rs.getString("ISBNNumber")%></td>
		<td class="center"><%=rs.getDate("IssuesDate")%></td>
		<td class="center"><%=rs.getDate("DueDate")%></td>
		<td class="center"><%	if(rs.getDate("ReturnDate")==null)
					{
				   %>
                                            <span style="color:red">
                                             <%="Not Return Yet"%>
                                                </span>
                                    <%  } 
					else
				    	{ 
				    %>

                                            <span style="color:green">
                                             <%="Returned"%>
                                                </span>

                                    <%  } 
				
                                    %></td>
		<td class="center"><%if(rs.getString("fine")==null){
			%>
			<span style="color:blue">
                                             <%="Not Calculated"%>
            </span>
        <%
		}else{
			out.println(rs.getString("Fine"));
		}
		%></td>
		 <td class="center">

          <a href="returnBooks.jsp?rid=<%=rs.getInt("rid")%>"><button class="btn btn-primary"><i class="fa fa-edit "></i> Edit</button> 
                                         
        </td>
                                         
		</tr>
<% 	cnt=cnt+1;
	} 
	
	ps.close();
%>                                      
                                    </tbody>
                                </table>
                            </div>
                            
                        </div>
                    </div>
                    <!--End Advanced Tables -->
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
    <!-- DATATABLE SCRIPTS  -->
    <script src="assets/js/dataTables/jquery.dataTables.js"></script>
    <script src="assets/js/dataTables/dataTables.bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>

</body>
</html>
<% } %>
