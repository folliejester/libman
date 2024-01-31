<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date,java.time.LocalDate" import="com.library.db.dbConnect"%>
<%!
	public static String getDate()
    
	{
        
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        
		String exam_date=df.format(new Date());
         
		return exam_date;
    
	}
public static int getDateDiff(java.util.Date firstdate, java.util.Date seconddate){
	long difference = Math.abs(seconddate.getTime() - firstdate.getTime());
	return (int)(difference/(1000 * 60 * 60 * 24))% 365;
}
%>
<%
	PreparedStatement ps;
		Connection conn = dbConnect.getConnection();
        ResultSet rs= null;
        int diff = 0;
       
%>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>ABC Library | Issued Book Details</title>
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
                <h4 class="header-line">Issued Book Details</h4>
                
                            </div>

</div>
<div class="row">
<div class="col-md-10 col-sm-6 col-xs-12 col-md-offset-1">
<div class="panel panel-info">
<div class="panel-heading">
Issued Book Details
</div>
<div class="panel-body">
<form role="form" method="post">
<%
	int rid=Integer.parseInt(request.getParameter("rid"));
	String sql = "SELECT tblstudents.FullName,tblbooks.BookName,tblbooks.ISBNNumber,tblissuedbookdetails.finestatus, tblissuedbookdetails.IssuesDate,tblissuedbookdetails.ReturnDate,tblissuedbookdetails.DueDate,tblissuedbookdetails.id as rid,tblissuedbookdetails.fine,tblissuedbookdetails.RetrunStatus from  tblissuedbookdetails join tblstudents on tblstudents.StudentId=tblissuedbookdetails.StudentId join tblbooks on tblbooks.id=tblissuedbookdetails.BookId where tblissuedbookdetails.id=?";
	ps=conn.prepareStatement(sql,ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	ps.setInt(1,rid);
	rs=ps.executeQuery();

	int cnt=1;
	while(rs.next())
	{
%>                                      
                   



<div class="form-group">
<label>Student Name :</label>
<%=rs.getString("FullName")%>
</div>

<div class="form-group">
<label>Book Name :</label>
<%=rs.getString("BookName")%>
</div>


<div class="form-group">
<label>ISBN :</label>
<%=rs.getString("ISBNNumber")%>
</div>

<div class="form-group">
<label>Book Issued Date :</label>
<%=rs.getDate("IssuesDate")%>
</div>


<div class="form-group">
<label>Book Returned Date :</label>
<% if(rs.getDate("ReturnDate")==null)
                                            {
                                                out.println("Not Return Yet");
                                            } else {
                                            out.println(rs.getDate("ReturnDate"));
											}
                                            %>
</div>

<div class="form-group">
<label>Fine (in INR) :</label>
<% 
if(rs.getString("fine")==null)
{
	LocalDate date1 = LocalDate.now();
	Date date2 = java.sql.Date.valueOf(date1);;
	if(date2.getTime() > rs.getDate("DueDate").getTime() && rs.getDate("ReturnDate")==null){
		diff = getDateDiff(date2,rs.getDate("DueDate"));
		
		}
	else{
	diff = 0;
	}
	out.println(diff);
}
else{
out.println(rs.getString("Fine"));
}%>
</div>
<div class="form-group">
<label>Fine Status :</label>
<%if(rs.getInt("FineStatus")==0){
out.println("Not paid");}
else{
out.println("Paid");}%>
</div>
 <% if(rs.getInt("RetrunStatus")==0){%>

<button type="submit" name="return" id="submit" class="btn btn-info">Return Book </button>
<%}
 if(rs.getInt("FineStatus")==0){%>
<button type="submit" name="pay" id="submit" class="btn btn-warning">Pay </button>
</form>

<% }
	}
	ps.close();
	
%>
<%

if(session.getAttribute("login")==null)
{ 
	response.sendRedirect("index.jsp");
}
else
{ 
	LocalDate date = LocalDate.now();
	String ret=request.getParameter("return");
	if(ret!=null)
	{
		rid=Integer.parseInt(request.getParameter("rid"));
		int rstatus=1;
		sql="update tblissuedbookdetails set ReturnDate=?,RetrunStatus=?,fine = ?,finestatus = ? where id=?";
		ps=conn.prepareStatement(sql);
		ps.setDate(1,java.sql.Date.valueOf(date));
		ps.setInt(2,rstatus);
		ps.setInt(3,diff);
		if(diff == 0){
			ps.setInt(4,1);
		}else{ps.setInt(4,0);
}
		ps.setInt(5,rid);
		int i=ps.executeUpdate();
		
		session.setAttribute("msg","Book Returned successfully");
		response.sendRedirect("issued-books.jsp");
		ps.close();

	}
	String pay=request.getParameter("pay");
	if(pay!=null)
	{
		rid=Integer.parseInt(request.getParameter("rid"));
		sql="update tblissuedbookdetails set FineStatus=? where id=?";
		ps=conn.prepareStatement(sql);
		ps.setInt(1,1);
		ps.setInt(2,rid);
		int i=ps.executeUpdate();
		
		session.setAttribute("msg","Fine paid successfully");
		response.sendRedirect("issued-books.jsp");
		ps.close();

	}
%>
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
