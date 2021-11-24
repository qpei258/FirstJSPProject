<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.Product"%>
<%@ page import="dao.ProductRepository" %>
<%@ include file="dbconn.jsp" %>

<%
	request.setCharacterEncoding("utf-8");
	
	String filename = "";
	String realFolder = "C:\\Users\\user\\Documents\\수강계획\\ITBank\\JSP\\WorkSpace\\WebMarket\\src\\main\\webapp\\images";
	int maxSize = 5 * 1024 * 1024;
	String encType = "utf-8";
	
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
	if (unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(unitPrice);
	
	long stock;
	if (unitsInStock.isEmpty()) 
		stock = 0;
	else
		stock = Long.valueOf(unitsInStock);
	
	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	PreparedStatement ps = null;
	
	String sql = "insert into product value(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	ps = conn.prepareStatement(sql);
	ps.setString(1, productId);
	ps.setString(2, name);
	ps.setInt(3, price);
	ps.setString(4, description);
	ps.setString(5, category);
	ps.setString(6, manufacturer);
	ps.setLong(7, stock);
	ps.setString(8, condition);
	ps.setString(9, filename);
	ps.executeUpdate();
	
	if(ps != null)
		ps.close();
	if(conn != null)
		conn.close();
	
	response.sendRedirect("products.jsp");
 %>
