<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="dbconn.jsp" %>
<%
	String filename = "";
	String realFolder = "./image";
	String encType = "utf-8";
	int maxSize = 5 * 1024 * 1024;
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	String productId = multi.getParameter("productId");
	String name = multi.getParameter("name");
	String unitPrice = multi.getParameter("unitPrice");
	String description = multi.getParameter("description");
	String manufacturer = multi.getParameter("manufacturer");
	String category = multi.getParameter("category");
	String unitsInStock = multi.getParameter("unitsInStock");
	String condition = multi.getParameter("condition");
	
	Integer price;
	
	if(unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(unitPrice);
	
	long stock;
	
	if(unitsInStock.isEmpty())
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);
	
	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	String sql = "select * from product where p_id = ?";
	ps = conn.prepareStatement(sql);
	ps.setString(1, productId);
	rs = ps.executeQuery();
	
	if(rs.next()) {
		if(fileName != null){
			sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, p_condition=?, p_fileName=? WHERE p_id=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2, price);
			ps.setString(3, description);
			ps.setString(4, manufacturer);
			ps.setString(5, category);
			ps.setLong(6, stock);
			ps.setString(7, condition);
			ps.setString(8, fileName);
			ps.setString(9, productId);
			ps.executeUpdate();
		} else {
			sql = "UPDATE product SET p_name=?, p_unitPrice=?, p_description=?, p_manufacturer=?, p_category=?, p_unitsInStock=?, p_condition=? WHERE p_id=?";
			ps = conn.prepareStatement(sql);
			ps = conn.prepareStatement(sql);
			ps.setString(1, name);
			ps.setInt(2, price);
			ps.setString(3, description);
			ps.setString(4, manufacturer);
			ps.setString(5, category);
			ps.setLong(6, stock);
			ps.setString(7, condition);
			ps.setString(9, productId);
			ps.executeUpdate();
		}
	}
	if(rs != null)
		rs.close();
	if(ps != null)
		ps.close();
	if(conn != null)
		conn.close();
	
	response.sendRedirect("editProduct.jsp?edit=update");
%>