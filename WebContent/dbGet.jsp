<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

	<%
	
	// 한글 처리
	request.setCharacterEncoding("EUC-KR");
	
	// ajax에서 가져온 값
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

	long rePW = 0; // 새로운 비밀번호
	long salt = 0; // salt
	String hashpw = ""; // 암호화된 비밀번호
	
	try{
		// 1.driver 로딩
		Class.forName("com.mysql.jdbc.Driver");
		// 2. DB연결   getConnection(url, id, pw)
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_b","root","1234");
		// 3. Statement 객체 생성 : DB서버에 명령을 내리는 객체 생성
		Statement stmt = conn.createStatement();
		// 4. stmt객체로 query 실행  
		// select쿼리 rs로 return
		ResultSet rs = stmt.executeQuery("SELECT * FROM member WHERE id='"+id+"'");
		
		// id가 있다면
		if(rs.next()){
			String DBid = rs.getString("id");
			String DBname = rs.getString("name");
			
			// name과 DBname이 같다면 비밀번호 초기화
			if(DBname.equals(name)){
				salt = Math.round( Math.random()*999999 ); // 난수
				rePW = Math.round( Math.random()*999999 ); // 새로운 비밀번호
				//String pwSalt = rePW+Long.toString(salt); // pw + Salt난수
				String pwSalt = Long.toString(rePW)+temp; // pw + Salt난수
				
				// 비밀번호에 hash 적용
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
		e.printStackTrace(); // 오류 발생한 메세지를 프린트
	}
		
	%>
	<%=rePW%>
