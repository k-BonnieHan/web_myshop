<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="bean" class="kr.shop.board.BoardBean" />
<jsp:setProperty property="*" name="bean" />
<jsp:useBean id="boardMgr" class="kr.shop.board.BoardMgr" />

<%
//out.println(bean.getName());
String spage = request.getParameter("page");

boolean b = boardMgr.checkPass(bean.getNum(), bean.getPass());
if(b){
	boardMgr.saveEdit(bean); 
	response.sendRedirect("boardlist.jsp?page=" + spage);  //글 주정 후 목록보기 
}else{
%>
	<script>
	alert("비밀번호 불일치!!!");
	history.back();
	</script>
<%
}
%>
