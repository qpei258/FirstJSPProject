<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="dbconn.jsp"%>
<%
	String productId = request.getParameter("id");
	PreparedStatement ps = null;
	ResultSet rs = null;

	String sql = "select * from product";
	ps = conn.prepareStatement(sql);
	rs = ps.executeQuery();
	
	if(rs.next()) {
		sql = "delect from product where p_id = ?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, productId);
		ps.executeUpdate();		
	}else {
		out.println("일치하는 상품이 없습니다.");
	}
	
	if(rs != null)
		rs.close();
	if(ps != null)
		ps.close();
	if(conn != null)
		conn.close();
	
	response.sendRedirect("editProduct.jsp?edit=delete");
%>