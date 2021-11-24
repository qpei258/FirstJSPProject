<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Connection conn = null;
	
	try{
		String url = "jdbc:mysql://localhost:3306/WebMarketDB";
		String user = "root";
		String password = "1234";
		
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url, user, password);
	
	}catch (SQLException ex){
		out.println("데이터베이스 연결이 실패했습니다.");
		out.println("SQLException : " + ex.getMessage());
	}

%>