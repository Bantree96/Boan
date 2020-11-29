<!--  
	성명 : 남지원 
	학번 : 201545047
 -->
 
<%@page import="java.util.Random"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>

<%
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// form에서 가져온 값
	String id = request.getParameter("_id");
	String pw = request.getParameter("_pw");
	String pw2 = request.getParameter("_pw2");
	String name = request.getParameter("_name");
	
	// 해시값 저장 변수
	String hashpw="";
	
	// salt값 생성
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
	// pw + Salt난수
	String pwSalt = pw+salt;
	
	try{
		// 비밀번호에 hash 적용
		MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
		sha256.update(pwSalt.getBytes());
		byte[] digest01 = sha256.digest();
		StringBuffer sb = new StringBuffer();
        for (int i = 0; i < digest01.length; i++) {
            sb.append(Integer.toString((digest01[i] & 0xFF) + 256, 16).substring(1));
        }
        
        hashpw = sb.toString(); // 암호화된 비밀번호
	
		// 1.driver 로딩
		Class.forName("com.mysql.jdbc.Driver");
		// 2. DB연결   getConnection(url, id, pw)
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_b","root","1234");
		// 3. Statement 객체 생성 : DB서버에 명령을 내리는 객체 생성
		Statement stmt = conn.createStatement();
		// 4. stmt객체로 query 실행  
		if(pw.equals("")){ // 비밀번호가 변경되지 않았을때 기존의 pw 적용
			stmt.executeUpdate("UPDATE member SET pw='"+pw2+"', name='"+name+"' WHERE id='"+id+"'");
			session.setAttribute("__NAME", name);
		} else { // 비밀번호가 변경되었을때 변경된 pw 적용
			stmt.executeUpdate("UPDATE member SET pw='"+hashpw+"', name='"+name+"', salt='"+salt+"' WHERE id='"+id+"'");
			session.setAttribute("__PW", pw);
			session.setAttribute("__NAME", name);
		}
		// 5. close
		stmt.close();
		conn.close();
		
		out.println("<script>alert('정보가 수정되었습니다.');location.href='main.jsp';</script>");
		
	} catch(Exception e){
		e.printStackTrace(); // 오류 발생한 메세지를 프린트
	}
		
	%>