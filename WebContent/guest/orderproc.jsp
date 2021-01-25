<%@page import="kr.shop.order.OrderBean"%>
<%@page import="kr.shop.order.OrderDto"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="kr.shop.order.CartMgr" scope="session" />
<jsp:useBean id="orderMgr" class="kr.shop.order.OrderMgr" />
<jsp:useBean id="productMgr" class="kr.shop.product.ProductMgr" />

<%
Hashtable hCart = cartMgr.getCartList(); //카트의 내용 읽기.

Enumeration enu = hCart.keys();

if(hCart.size() == 0){
%>
	<script>
	alert("주문 내역이 없습니다.");
	location.href="orderlist.jsp";
	</script>
<% 	
}else{
	while(enu.hasMoreElements()){
		OrderBean order = (OrderBean)hCart.get(enu.nextElement());
		orderMgr.insertOrder(order); //주문 자료를 shop_order에 저장하기
		productMgr.reduceProduct(order); //주문수량 만큼 상품의 재고량에서 빼기
		cartMgr.deleteCart(order); //주문 완료 후 카트 비우기
	}
%>
	<script>
		alert("주문 처리 성공!");
		location.href="orderlist.jsp";
	</script>


<%
}
%>




