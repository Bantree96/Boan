<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%	
	// 세션삭제, 로그아웃
	session.invalidate();
	response.sendRedirect("index.jsp");
%>
