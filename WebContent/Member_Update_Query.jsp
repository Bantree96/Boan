<!--  
	���� : ������ 
	�й� : 201545047
 -->
 
<%@page import="java.util.Random"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="java.sql.*" %>

<%
	// �ѱ� ó��
	request.setCharacterEncoding("EUC-KR");
	
	// form���� ������ ��
	String id = request.getParameter("_id");
	String pw = request.getParameter("_pw");
	String pw2 = request.getParameter("_pw2");
	String name = request.getParameter("_name");
	
	// �ؽð� ���� ����
	String hashpw="";
	
	// salt�� ����
	StringBuffer salt = new StringBuffer();
	Random rnd = new Random();
	for (int i = 0; i < 6; i++) {
	    int rIndex = rnd.nextInt(3);
	    switch (rIndex) {
	    case 0:
	        // a-z
	        salt.append((char) ((int) (rnd.nextInt(26)) + 97));
	        break;
	    case 1:
	        // A-Z
	        salt.append((char) ((int) (rnd.nextInt(26)) + 65));
	        break;
	    case 2:
	        // 0-9
	        salt.append((rnd.nextInt(10)));
	        break;
	    }
	}
	// pw + Salt����
	String pwSalt = pw+salt;
	
	try{
		// ��й�ȣ�� hash ����
		MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
		sha256.update(pwSalt.getBytes());
		byte[] digest01 = sha256.digest();
		StringBuffer sb = new StringBuffer();
        for (int i = 0; i < digest01.length; i++) {
            sb.append(Integer.toString((digest01[i] & 0xFF) + 256, 16).substring(1));
        }
        
        hashpw = sb.toString(); // ��ȣȭ�� ��й�ȣ
	
		// 1.driver �ε�
		Class.forName("com.mysql.jdbc.Driver");
		// 2. DB����   getConnection(url, id, pw)
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_b","root","1234");
		// 3. Statement ��ü ���� : DB������ ����� ������ ��ü ����
		Statement stmt = conn.createStatement();
		// 4. stmt��ü�� query ����  
		if(pw.equals("")){ // ��й�ȣ�� ������� �ʾ����� ������ pw ����
			stmt.executeUpdate("UPDATE member SET pw='"+pw2+"', name='"+name+"' WHERE id='"+id+"'");
			session.setAttribute("__NAME", name);
		} else { // ��й�ȣ�� ����Ǿ����� ����� pw ����
			stmt.executeUpdate("UPDATE member SET pw='"+hashpw+"', name='"+name+"', salt='"+salt+"' WHERE id='"+id+"'");
			session.setAttribute("__PW", pw);
			session.setAttribute("__NAME", name);
		}
		// 5. close
		stmt.close();
		conn.close();
		
		out.println("<script>alert('������ �����Ǿ����ϴ�.');location.href='main.jsp';</script>");
		
	} catch(Exception e){
		e.printStackTrace(); // ���� �߻��� �޼����� ����Ʈ
	}
		
	%>