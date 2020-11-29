<%@page import="java.util.Random"%>
<%@page import="java.sql.*"%>
<%@page import="java.security.MessageDigest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

	<%
	
	// 한글 처리
	request.setCharacterEncoding("UTF-8");
	
	// ajax에서 가져온 값
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	
	// 초기화
	StringBuffer salt = new StringBuffer(); // salt
	StringBuffer rePW = new StringBuffer(); // 새로운 비밀번호
	Random rnd = new Random(); // 랜덤 값
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
				
				
				for (int i = 0; i < 6; i++) {
				    int rIndex = rnd.nextInt(3);
				    int xIndex = rnd.nextInt(3);
					// salt값 랜덤
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
				    // rePW값 랜덤
				    switch (xIndex) {
				    case 0:
				        // a-z
				        rePW.append((char) ((int) (rnd.nextInt(26)) + 97));
				        break;
				    case 1:
				        // A-Z
				        rePW.append((char) ((int) (rnd.nextInt(26)) + 65));
				        break;
				    case 2:
				        // 0-9
				        rePW.append((rnd.nextInt(10)));
				        break;
				    }
				}
				// 값들 String타입변환
				String SrePW = rePW.toString();
				String Ssalt = salt.toString();
				String pwSalt = SrePW+Ssalt; // pw + Salt난수
				
				// 비밀번호에 hash 적용
				MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
				sha256.update(pwSalt.getBytes());
				byte[] digest01 = sha256.digest();
				StringBuffer sb = new StringBuffer();
		           for (int i = 0; i < digest01.length; i++) {
		               sb.append(Integer.toString((digest01[i] & 0xFF) + 256, 16).substring(1));
		           }
		           // 만들어진 hashpw
		           hashpw = sb.toString();
		        
		        // query
				stmt.executeUpdate("UPDATE member SET pw='"+hashpw+"', salt='"+salt+"', count='0' WHERE id='"+DBid+"'");
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
