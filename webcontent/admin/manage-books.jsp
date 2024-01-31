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
	String id=request.getParameter("del");
	if(id!=null)
	{
		String sql = "delete from tblbooks  WHERE id=?";
		ps=conn.prepareStatement(sql);		
		ps.setInt(1,Integer.parseInt(id));
		ps.executeUpdate();
		session.setAttribute("delmsg","Category deleted scuccessfully ");
		response.sendRedirect("manage-books.jsp");
}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>ABC Library | Manage Books</title>
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
                <h4 class="header-line">Manage Books</h4>
    </div>
     <div class="row">
    <% if(session.getAttribute("error")!=null)
    {
     %>
<div class="col-md-6">
<div class="alert alert-danger" >
 <strong>Error :</strong> 
 <% out.println(session.getAttribute("error")); %>
<% session.setAttribute("error",null);%>
</div>
</div>
<% } %>
<% if(session.getAttribute("msg")!=null)
{%>
<div class="col-md-6">
<div class="alert alert-success" >
 <strong>Success :</strong> 
 <% out.println(session.getAttribute("msg")); %>
<% session.setAttribute("msg",null);%>
</div>
</div>
<% } %>
<% if(session.getAttribute("updatemsg")!=null)
{%>
<div class="col-md-6">
<div class="alert alert-success" >
 <strong>Success :</strong> 
 <% out.println(session.getAttribute("updatemsg")); %>
<% session.setAttribute("updatemsg",null);%>
</div>
</div>
<% } %>


   <% if(session.getAttribute("delmsg")!=null)
    {%>
<div class="col-md-6">
<div class="alert alert-success" >
 <strong>Success :</strong> 
 <% out.println(session.getAttribute("delmsg")); %>
<% session.setAttribute("delmsg",null);%>
</div>
</div>
<% } %>

</div>


        </div>
            <div class="row">
                <div class="col-md-12">
                    <!-- Advanced Tables -->
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Books Listing
                        </div>
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Book Name</th>
                                            <th>Category</th>
                                            <th>Author</th>
                                            <th>ISBN</th>
                                            <th>Price</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
<% String sql = "SELECT tblbooks.BookName,tblcategory.CategoryName,tblauthors.AuthorName,tblbooks.ISBNNumber,tblbooks.BookPrice,tblbooks.id as bookid from  tblbooks join tblcategory on tblcategory.id=tblbooks.CatId join tblauthors on tblauthors.id=tblbooks.AuthorId";
ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
rs=ps.executeQuery();

int cnt=1;
while(rs.next())
{
%>                                      
                                        <tr class="odd gradeX">
                                            <td class="center"><%=cnt%></td>
                                            <td class="center"><%=rs.getString("BookName")%></td>
                                            <td class="center"><%=rs.getString("CategoryName")%></td>
                                            <td class="center"><%=rs.getString("AuthorName")%></td>
                                            <td class="center"><%=rs.getString("ISBNNumber")%></td>
                                            <td class="center"><%=rs.getString("BookPrice")%></td>
                                            <td class="center">

                                            <a href="edit-book.jsp?bookid=<%=rs.getString("bookid")%>"><button class="btn btn-primary"><i class="fa fa-edit "></i> Edit</button> </a>
                                          <a href="manage-books.jsp?del=<%=rs.getString("bookid")%>" onclick="return confirm('Are you sure you want to delete?');" >  <button class="btn btn-danger"><i class="fa fa-pencil"></i> Delete</button></a>
                                            </td>
                                        </tr>
 <% cnt=cnt+1;
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
<% 
} 
%>
