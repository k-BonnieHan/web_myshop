<%@page import="kr.shop.product.ProductDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />
<%
String no = request.getParameter("no");
ProductDto dto = productMgr.getProduct(no); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세보기</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="margin-top: 20px">
** 상품 상세보기 **<br>
<%@include file="admin_top.jsp" %>

<table style="width: 90%">
  <tr>
  	<td style="width: 20%">
  		<img src="../upload/<%=dto.getImage() %>" width="150">
  	</td>
  	<td style="width: 50%; vertical-align: top;">
  		<table style="width: 100%">
  		  <tr><td>번 호 : </td><td><%=dto.getNo() %></td></tr>
  		  <tr><td>상품명 : </td><td><%=dto.getName() %></td></tr>
  		  <tr><td>가 격 : </td><td><%=dto.getPrice() %></td></tr>
  		  <tr><td>등록일 : </td><td><%=dto.getSdate() %></td></tr>
  		  <tr><td>재고량 : </td><td><%=dto.getStock() %></td></tr>
  		</table>
  	</td>
  	<td style="width: 30%; vertical-align: top;">
  		<b>* 상품 설명 *</b><br>
  		<%= dto.getDetail() %>
  	</td>
  </tr>
  <tr>
  	<td colspan="3" style="text-align: center;">
  		<a href="javascript:productUpdate('<%=dto.getNo() %>')">수정하기</a>
  		<a href="javascript:productDelete('<%=dto.getNo() %>')">삭제하기</a>
  	</td>
  </tr>
</table>

<%@include file="admin_bottom.jsp" %>

<form action="productupdate.jsp" name="updateForm" method="post">
	<input type="hidden" name="no">
</form>
<form action="productproc.jsp?flag=delete" name="delForm" method="post">
	<input type="hidden" name="no">
</form>
</body>
</html>