<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%	
	// 세션삭제, 로그아웃
	session.invalidate();
	out.println("<script>alert('로그아웃 되었습니다.');location.href='index.jsp';</script>");
%>
