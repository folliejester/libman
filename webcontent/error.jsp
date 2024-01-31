<%@page isErrorPage="true" import="java.io.PrintWriter"%>

<%=exception%>
</br></br></br></br>
<%=exception.getMessage()%>
<% exception.printStackTrace(new PrintWriter(out));%>

<script type='text/javascript'> alert("exception")</script>