<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />

<%
request.setCharacterEncoding("utf-8");

String spage = request.getParameter("page");
String num = request.getParameter("num");
String pass = request.getParameter("pass");

boolean b = boardMgr.checkPass(Integer.parseInt(num), pass);

if(b){
	boardMgr.delData(num); 
	response.sendRedirect("boardlist.jsp?page=" + spage);  //글 삭제 후 목록보기 
}else{
%>
	<script>
	alert("비밀번호 불일치!!!");
	history.back();
	</script>
<%
}
%>