<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

	<%
	
	// �ѱ� ó��
	request.setCharacterEncoding("EUC-KR");
	
	// ajax���� ������ ��
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	
	
	StringBuffer temp = new StringBuffer();
	Random rnd = new Random();
	for (int i = 0; i < 6; i++) {
	    int rIndex = rnd.nextInt(3);
	    switch (rIndex) {
	    case 0:
	        // a-z
	        temp.append((char) ((int) (rnd.nextInt(26)) + 97));
	        break;
	    case 1:
	        // A-Z
	        temp.append((char) ((int) (rnd.nextInt(26)) + 65));
	        break;
	    case 2:
	        // 0-9
	        temp.append((rnd.nextInt(10)));
	        break;
	    }
	}

	long rePW = 0; // ���ο� ��й�ȣ
	long salt = 0; // salt
	String hashpw = ""; // ��ȣȭ�� ��й�ȣ
	
	try{
		// 1.driver �ε�
		Class.forName("com.mysql.jdbc.Driver");
		// 2. DB����   getConnection(url, id, pw)
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_b","root","1234");
		// 3. Statement ��ü ���� : DB������ ����� ������ ��ü ����
		Statement stmt = conn.createStatement();
		// 4. stmt��ü�� query ����  
		// select���� rs�� return
		ResultSet rs = stmt.executeQuery("SELECT * FROM member WHERE id='"+id+"'");
		
		// id�� �ִٸ�
		if(rs.next()){
			String DBid = rs.getString("id");
			String DBname = rs.getString("name");
			
			// name�� DBname�� ���ٸ� ��й�ȣ �ʱ�ȭ
			if(DBname.equals(name)){
				salt = Math.round( Math.random()*999999 ); // ����
				rePW = Math.round( Math.random()*999999 ); // ���ο� ��й�ȣ
				//String pwSalt = rePW+Long.toString(salt); // pw + Salt����
				String pwSalt = Long.toString(rePW)+temp; // pw + Salt����
				
				// ��й�ȣ�� hash ����
				MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
				sha256.update(pwSalt.getBytes());
				byte[] digest01 = sha256.digest();
				StringBuffer sb = new StringBuffer();
		           for (int i = 0; i < digest01.length; i++) {
		               sb.append(Integer.toString((digest01[i] & 0xFF) + 256, 16).substring(1));
		           }
		           
		           hashpw = sb.toString();
		           
				stmt.executeUpdate("UPDATE member SET pw='"+hashpw+"', salt='"+temp+"', count='0' WHERE id='"+DBid+"'");
			}
		}
		// 5. close
		stmt.close();
		conn.close();
		
		
	} catch(Exception e){
		e.printStackTrace(); // ���� �߻��� �޼����� ����Ʈ
	}
		
	%>
	<%=rePW%>
