package com.library.db;

import java.sql.*;

public class dbConnect {
	
	 static Connection conn = null;
	 
	   public static Connection getConnection() {
	      if (conn != null) {
	    	  return conn;
	      }
	      else {
	      String database = "jdbc:oracle:thin:@localhost:1521:xe";
	      String Username = "system";
	      String password = "ASKDC";
	      return getConnection(database, Username, password);
	      }
	   }
	   
		   
	   private static Connection getConnection(String databaseName, String UserName, String password) {
		  
		   try {
			   	DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		        conn = DriverManager.getConnection( databaseName , UserName,  password);
		  }catch (Exception e) {
		         e.printStackTrace();
		  }
		  return conn;
		  }
		
	   
}


