<%@page import="java.security.MessageDigest"%>
<%@page import="java.sql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//한글 처리
	request.setCharacterEncoding("UTF-8");

	// form에서 가져온 값
	String id = request.getParameter("_id");
	String pw = request.getParameter("_pw");
				
	
          
	//1.driver 로딩
	Class.forName("com.mysql.jdbc.Driver");
	// 2. DB연결   getConnection(url, id, pw)
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/testdb_b","root","1234");
	// 3. Statement 객체 생성 : DB서버에 명령을 내리는 객체 생성
	Statement stmt = conn.createStatement();
	// 4. stmt객체로 query 실행
	
	// select쿼리 rs로 return
	ResultSet rs = stmt.executeQuery("SELECT * FROM member WHERE id='"+id+"'");
	
	
	
	if(rs.next()){
		String DBpw = rs.getString("pw");
		String DBname = rs.getString("name");
		String DBsalt = rs.getString("salt");
		int DBcount = rs.getInt("count");
		
		String hashpw="";
		// pw + Salt난수
		pw = pw+DBsalt;
		// 비밀번호에 hash 적용
		MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
		sha256.update(pw.getBytes());
		byte[] digest01 = sha256.digest();
		StringBuffer sb = new StringBuffer();
        for (int i = 0; i < digest01.length; i++) {
            sb.append(Integer.toString((digest01[i] & 0xFF) + 256, 16).substring(1));
        }
        
        hashpw = sb.toString();
        
	    // count 3회 이상 시도시
	    if(DBcount >= 3){
	    	out.println("<script>alert('비밀번호 3회이상 시도감지되어 계정이 잠금조치 되었습니다. 비밀번호 찾기를 사용해주세요');history.back();</script>");
		} else {  
        
	        // 비밀번호 일치시
			if(DBpw.equals(hashpw)){
				stmt.executeUpdate("UPDATE member SET count='0' WHERE id='"+id+"'"); // 로그인 시도 횟수 초기화
				// 세션에 값 저장 
				session.setAttribute("__ID", id);
				session.setAttribute("__PW", DBpw);
				session.setAttribute("__NAME", DBname);
				response.sendRedirect("main.jsp");
				
			// 비밀번호 불일치시
			} else {
				DBcount++;
				stmt.executeUpdate("UPDATE member SET count='"+DBcount+"' WHERE id='"+id+"'"); // 로그인 시도 횟수 초기화
				out.println("<script>alert('비밀번호가 일치하지 않습니다.');history.back();</script>");
			}
		}
   	// 아이디가 없을시
	} else {
		
		out.println("<script>alert('존재하지 않는 아이디입니다.');history.back();</script>");

	}
	// 5. close
	stmt.close();
	conn.close();

%>
