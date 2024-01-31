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
	String add=request.getParameter("add");
if(add!=null)
{
	String bookname=request.getParameter("bookname");
	String category=request.getParameter("category");
	String author=request.getParameter("author");
	String isbn=request.getParameter("isbn");
	String price=request.getParameter("price");
	String sql="INSERT INTO  tblbooks(BookName,CatId,AuthorId,ISBNNumber,BookPrice) VALUES(?,?,?,?,?)";
	ps=conn.prepareStatement(sql);
	ps.setString(1,bookname);
	ps.setInt(2,Integer.parseInt(category));
	ps.setInt(3,Integer.parseInt(author));
	ps.setInt(4,Integer.parseInt(isbn));
	ps.setInt(5,Integer.parseInt(price));
	int i=ps.executeUpdate();


	if(i>0)
	{
		session.setAttribute("msg","Book Listed successfully");
		response.sendRedirect("manage-books.jsp");	
	}
	else 
	{	
		session.setAttribute("error","Something went wrong. Please try again");
		response.sendRedirect("manage-books.jsp");
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
    <title>ABC Library | Add Book</title>
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
                <h4 class="header-line">Add Book</h4>
                
                            </div>

</div>
<div class="row">
<div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
<div class="panel panel-info">
<div class="panel-heading">
Book Info
</div>
<div class="panel-body">
<form role="form" method="post">
<div class="form-group">
<label>Book Name<span style="color:red;">*</span></label>
<input class="form-control" type="text" name="bookname" autocomplete="off"  required />
</div>

<div class="form-group">
<label> Category<span style="color:red;">*</span></label>
<select class="form-control" name="category" required="required">
<option value=""> Select Category</option>
<% 
int status=1;
String sql = "SELECT * from  tblcategory where Status=?";
ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
ps.setInt(1,status);
rs=ps.executeQuery();

int cnt=1;
while(rs.next())
{

%>  
<option value="<%=rs.getInt("id")%>"><%=rs.getString("CategoryName")%></option>
<% 
} 
%> 
</select>
</div>


<div class="form-group">
<label> Author<span style="color:red;">*</span></label>
<select class="form-control" name="author" required="required">
<option value=""> Select Author</option>
<% 

sql = "SELECT * from  tblauthors ";
ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);

rs=ps.executeQuery();

cnt=1;
while(rs.next())
{
%>  
<option value="<%=rs.getInt("id")%>"><%=rs.getString("AuthorName")%></option>
 <%
 } 

%> 
</select>
</div>

<div class="form-group">
<label>ISBN Number<span style="color:red;">*</span></label>
<input class="form-control" type="number" name="isbn"  required="required" autocomplete="off"  />
<p class="help-block">An ISBN is an International Standard Book Number.ISBN Must be unique</p>
</div>

 <div class="form-group">
 <label>Price<span style="color:red;">*</span></label>
 <input class="form-control" type="text" name="price" autocomplete="off"   required="required" />
 </div>
<button type="submit" name="add" value="add" class="btn btn-info">Add </button>

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
