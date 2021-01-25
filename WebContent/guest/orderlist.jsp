<%@page import="kr.shop.product.ProductDto"%>
<%@page import="kr.shop.order.OrderDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="orderMgr" class="kr.shop.order.OrderMgr" />
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문정보</title>
<link type="text/css" rel="stylesheet" href="../css/style.css">
<script type="text/javascript" src="../js/script.js"></script>
</head>
<body style="margin-top: 20px;">
** 주문된 상품 목록 확인하기 **<p/>

<%@ include file="guest_top.jsp" %>
<table style="width: 90%">
	<tr><th>주문번호</th><th>상품명</th><th>주문수량</th><th>주문일자</th><th>주문상태</th></tr>
	<%
	String id = (String)session.getAttribute("idKey"); //주문한 회원 아이디 읽기, db에는 모든 회원의 주문내역이 있어서
	//본인것만 읽을 수 있도록 session으로 잡아서 읽어준다.
	ArrayList<OrderDto> list = orderMgr.getOrder(id);
	if(list.size() == 0){
	%>
	<tr>
		<td colspan="5">주문한 상품이 없습니다.</td>
	</tr>	
	<%}else{
		for(OrderDto ord:list){
			ProductDto product = productMgr.getProduct(ord.getProduct_no());		
	%>
	<tr style="text-align:center;">
		<td><%=ord.getNo() %></td>
		<td><%=product.getName() %></td>		
		<td><%=ord.getQuantity() %></td>
		<td><%=ord.getSdate() %></td>
		<td><%
		switch(ord.getState()){
    	case "1":out.println("접수"); break;
    	case "2":out.println("입금확인"); break;
    	case "3":out.println("배송준비"); break;
    	case "4":out.println("배송중"); break;
    	case "5":out.println("처리완료"); break;
    	default:out.println("접수중");
    	}
		%></td>		
	</tr>
	<%			
		}
		
	}
	%>
</table>
	<a href="../index.jsp" style="text-align:center;"><h5>[메인으로]</h5></a>
<%@ include file="guest_bottom.jsp" %>

</body>
</html>