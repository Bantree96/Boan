<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%	
	// ���ǻ���, �α׾ƿ�
	session.invalidate();
	out.println("<script>alert('�α׾ƿ� �Ǿ����ϴ�.');location.href='index.jsp';</script>");
%>
