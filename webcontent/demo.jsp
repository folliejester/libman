<%@page errorPage="error.jsp"%>
<%@page import="java.io.BufferedReader,java.io.BufferedWriter,java.io.FileReader,java.io.FileWriter"%>
<%@page import="java.sql.*,java.text.DateFormat,java.text.SimpleDateFormat,java.util.Date"%>
<%!
	public static String generateId(String fileName) throws Exception
	{
		BufferedReader br=new BufferedReader(new FileReader(fileName));
		String msid=br.readLine();
		String sub=msid.substring(3,msid.length());
		int sidn=Integer.parseInt(sub);
		sidn++;	
		br.close();
		BufferedWriter bw=new BufferedWriter(new FileWriter(fileName));		
		bw.write("SID0"+sidn);
		bw.flush();
		bw.close();
		return "SID0"+sidn;
	}
%>
<%
	String s1=application.getRealPath("/");
	out.println(s1+"studentid.txt");
	out.println(generateId(s1+"studentid.txt"));
%>