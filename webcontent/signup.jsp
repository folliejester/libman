<%@page errorPage="error.jsp"%>
<%@page import="java.io.BufferedReader,java.io.BufferedWriter,java.io.FileReader,java.io.FileWriter"%>
<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date" import="com.library.db.dbConnect"%>
<%!
	public static String getDate()
    
	{
        
		DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
        
		String exam_date=df.format(new Date());
         
		return exam_date;
    
	}
	public static String generateId(String filePath) throws Exception
	{
		BufferedReader br=new BufferedReader(new FileReader(filePath));
		String msid=br.readLine();
		String sub=msid.substring(3,msid.length());
		int sidn=Integer.parseInt(sub);
		sidn++;	
		br.close();
		BufferedWriter bw=new BufferedWriter(new FileWriter(filePath));		
		bw.write("SID0"+sidn);
		bw.flush();
		bw.close();
		return "SID0"+sidn;
	}
%>
<%
	PreparedStatement ps;
	Connection conn = dbConnect.getConnection();
%>
<%
String signup=request.getParameter("signup");

if(signup!=null)
{
	    
		//Code for student ID

		String filePath=application.getRealPath("/")+"studentid.txt";
		String studentId=generateId(filePath);   
		String fname=request.getParameter("fullanme");
		String mobileno=request.getParameter("mobileno");
		String email=request.getParameter("email"); 
		String password=request.getParameter("password"); 
		int status=1;
		String sql="INSERT INTO  tblstudents(StudentId,FullName,MobileNumber,EmailId,Password,Status,RegDate) VALUES(?,?,?,?,?,?,?)";
		ps=conn.prepareStatement(sql);
		ps.setString(1,studentId);
		ps.setString(2,fname);
		ps.setString(3,mobileno);
		ps.setString(4,email);
		ps.setString(5,password);
		ps.setInt(6,status);
		ps.setString(7,getDate());
		int i=ps.executeUpdate();		


		if(i>0)
		{
			out.println("<script>alert('Your Registration successfull and your student id is  "+studentId+"')</script>");
		}
		else 
		{
			out.println("<script>alert('Something went wrong. Please try again');</script>");
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
    <!--[if IE]>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <![endif]-->
    <title>ABC Library | Student Sign up</title>
    <!-- BOOTSTRAP CORE STYLE  -->
    <link href="assets/css/bootstrap.css" rel="stylesheet" />
    <!-- FONT AWESOME STYLE  -->
    <link href="assets/css/font-awesome.css" rel="stylesheet" />
    <!-- CUSTOM STYLE  -->
    <link href="assets/css/style.css" rel="stylesheet" />
    <!-- GOOGLE FONT -->
    <link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css' />
<script type="text/javascript">
function valid()
{
if(document.signup.password.value!= document.signup.confirmpassword.value)
{
alert("Password and Confirm Password Field do not match  !!");
document.signup.confirmpassword.focus();
return false;
}
return true;
}
</script>
<script>
function checkAvailability() {
$("#loaderIcon").show();
jQuery.ajax({
url: "check_availability.jsp",
data:'emailid='+$("#emailid").val(),
type: "POST",
success:function(data){
$("#user-availability-status").html(data);
$("#loaderIcon").hide();
},
error:function (){}
});
}
</script>    

</head>
<body>
    <!------MENU SECTION START-->
<jsp:include page="includes/header.jsp" />
<!-- MENU SECTION END-->
    <div class="content-wrapper">
         <div class="container">
        <div class="row pad-botm">
            <div class="col-md-12">
                <h4 class="header-line">Student Sign up</h4>
                
                            </div>

        </div>
             <div class="row">
           
<div class="col-md-9 col-md-offset-1">
               <div class="panel panel-danger">
                        <div class="panel-heading">
                           SINGUP FORM
                        </div>
                        <div class="panel-body">
                            <form name="signup" method="post" onSubmit="return valid();">
<div class="form-group">
<label>Enter Full Name</label>
<input class="form-control" type="text" name="fullanme" autocomplete="off" required />
</div>


<div class="form-group">
<label>Mobile Number :</label>
<input class="form-control" type="text" name="mobileno" maxlength="10" autocomplete="off" required />
</div>
                                        
<div class="form-group">
<label>Enter Email</label>
<input class="form-control" type="email" name="email" id="emailid" onBlur="checkAvailability()"  autocomplete="off" required  />
   <span id="user-availability-status" style="font-size:12px;"></span> 
</div>

<div class="form-group">
<label>Enter Password</label>
<input class="form-control" type="password" name="password" autocomplete="off" required  />
</div>

<div class="form-group">
<label>Confirm Password </label>
<input class="form-control"  type="password" name="confirmpassword" autocomplete="off" required  />
</div>
                              
<button type="submit" name="signup" value="signup" class="btn btn-danger" id="submit">Register Now </button>

                                    </form>
                            </div>
                        </div>
                            </div>
        </div>
    </div>
    </div>
     <!-- CONTENT-WRAPPER SECTION END-->
<jsp:include page="includes/footer.jsp" />
    <script src="assets/js/jquery-1.10.2.js"></script>
    <!-- BOOTSTRAP SCRIPTS  -->
    <script src="assets/js/bootstrap.js"></script>
      <!-- CUSTOM SCRIPTS  -->
    <script src="assets/js/custom.js"></script>
</body>
</html>
