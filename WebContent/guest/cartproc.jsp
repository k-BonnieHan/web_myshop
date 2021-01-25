<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="cartMgr" class="kr.shop.order.CartMgr" scope="session" />
<jsp:useBean id="order" class="kr.shop.order.OrderBean" />
<jsp:setProperty property="*" name="order"/>

<%
//컨트롤러 역할 : flag - 구매목록 보기, 수정, 삭제 판단
String flag = request.getParameter("flag");
String id = (String)session.getAttribute("idKey");
//out.println(order.getProduct_no() + " 주문수 : " + order.getQuantity());

if(id == null) {
	response.sendRedirect("../member/login.jsp");  // 로그인 안하고 온 경우
}else{
	if(flag == null){  //구매목록 보기 - 카트에 담기
		order.setId(id); 
		cartMgr.addCart(order);  //id, product_no, quantity를 들고  addCart 호출
%>
		<script>
		alert("장바구니에 상품 담기 성공!");
		location.href="cartlist.jsp";
		</script>
<%
	}else if(flag.equals("update")){
		order.setId(id); 
		cartMgr.updateCart(order);
%>
		<script>
		alert("장바구니의 내용 수정 성공!");
		location.href="cartlist.jsp";
		</script>
<%
	}else if(flag.equals("del")){ 
		cartMgr.deleteCart(order);
%>
		<script>
		alert("장바구니에 주문된 상품 삭제 성공!");
		location.href="cartlist.jsp";
		</script>
<%
	}
}
%>