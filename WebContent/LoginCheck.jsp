<%@page import="java.security.MessageDigest"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	//�ѱ� ó��
	request.setCharacterEncoding("EUC-KR");

	// form���� ������ ��
	String id = request.getParameter("_id");
	String pw = request.getParameter("_pw");
				
	
          
	//1.driver �ε�
	Class.forName("com.mysql.jdbc.Driver");
	// 2. DB����   getConnection(url, id, pw)
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_b","root","1234");
	// 3. Statement ��ü ���� : DB������ ����� ������ ��ü ����
	Statement stmt = conn.createStatement();
	// 4. stmt��ü�� query ����
	
	// select���� rs�� return
	ResultSet rs = stmt.executeQuery("SELECT * FROM member WHERE id='"+id+"'");
	
	
	
	if(rs.next()){
		String DBpw = rs.getString("pw");
		String DBname = rs.getString("name");
		String DBsalt = rs.getString("salt");
		int DBcount = rs.getInt("count");
		
		String hashpw="";
		// pw + Salt����
		pw = pw+DBsalt;
		// ��й�ȣ�� hash ����
		MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
		sha256.update(pw.getBytes());
		byte[] digest01 = sha256.digest();
		StringBuffer sb = new StringBuffer();
        for (int i = 0; i < digest01.length; i++) {
            sb.append(Integer.toString((digest01[i] & 0xFF) + 256, 16).substring(1));
        }
        
        hashpw = sb.toString();
        
	    // count 3ȸ �̻� �õ���
	    if(DBcount >= 3){
	    	out.println("<script>alert('��й�ȣ 3ȸ�̻� �õ������Ǿ� ������ �����ġ �Ǿ����ϴ�. ��й�ȣ ã�⸦ ������ּ���');history.back();</script>");
		} else {  
        
	        // ��й�ȣ ��ġ��
			if(DBpw.equals(hashpw)){
				stmt.executeUpdate("UPDATE member SET count='0' WHERE id='"+id+"'"); // �α��� �õ� Ƚ�� �ʱ�ȭ
				// ���ǿ� �� ���� 
				session.setAttribute("__ID", id);
				session.setAttribute("__PW", DBpw);
				session.setAttribute("__NAME", DBname);
				response.sendRedirect("main.jsp");
				
			// ��й�ȣ ����ġ��
			} else {
				DBcount++;
				stmt.executeUpdate("UPDATE member SET count='"+DBcount+"' WHERE id='"+id+"'"); // �α��� �õ� Ƚ�� �ʱ�ȭ
				out.println("<script>alert('��й�ȣ�� ��ġ���� �ʽ��ϴ�.');history.back();</script>");
			}
		}
   	// ���̵� ������
	} else {
		
		out.println("<script>alert('�������� �ʴ� ���̵��Դϴ�.');history.back();</script>");

	}
	// 5. close
	stmt.close();
	conn.close();

%>
