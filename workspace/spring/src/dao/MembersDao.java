package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.MembersDto;

public class MembersDao {

	private Connection con;  // 접속
	private PreparedStatement ps;  // 쿼리 처리
	private ResultSet rs;  // select 결과
	private String sql;  
	private int result;  // insert, update, delete 결과
	
	// singleton
	// MembersDao 내부에서 1개의 객체를 미리 생성해 두고,
	// getInstance() 메소드를 통해서 외부에서 사용할 수 있도록 처리
	private MembersDao() {}  // private 생성자(내부에서만 생성이 가능하다_
	private static MembersDao dao = new MembersDao();
	public static MembersDao getInstance() {  // 클래스 필드(static 필드)를 사용은 클래스 메소드(static 메소드)만 가능하다.
		return dao;
	}
	// getInstamce() 메소드 호출방법
	// 클래스 메소드는 클래스로 호출한다.
	// MembersDao dao = MembersDao.getInstance();
	
	// method
	
	// 접속과 접속해제
	// MembersDao 내부에서만 사용하기 때문에 private 처리한다.
	
	private Connection getConnection() throws Exception {  // getConnection() 메소드를 호출하는 곳은, 
														   // PreparedStatement 클래스를 사용하는 곳으로 어차피 try - catch를 하는 곳이다. 
														   // getConnection() 메소드를 호출하는 곳으로 예외를 던져버리자.
		Class.forName("oracle.jdbc.driver.OracleDriver");  // ClassNotFoundException
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "spring";
		String password = "1111";
		return DriverManager.getConnection(url, user, password);  // SQLException
	}
	
	private void close(Connection con, PreparedStatement ps, ResultSet rs) {
		
		try {
			if(rs != null) { rs.close(); }
			if(ps != null) { ps.close(); }
			if(con != null) { con.close(); }
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 가입(Dao로 전단된 데이터를 DB에 INSERT)
	// (부가: 같은 아이디, 같은 이메일은 가입을 미리 방지)
	public int insertMembers(MembersDto dto) {  // dto(mId, mName, mEmail 저장)
		result = 0;
		try{
			con = getConnection();  // 커넥션은 무조건 메소드 마다 열고 닫는다.
			sql = "INSERT INTO MEMBERS(MNO, MID, MNAME, MEMAIL, MDATE ) " +
				  " VALUES (MEMBERS_SEQ.NEXTVAL, ?, ?, ?, SYSDATE)";  // ? 자리에는 변수가 들어간다.
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getmId());  // 1번째 ?에 dto.getmId()를 넣는다.
			ps.setString(2, dto.getmName());
			ps.setString(3, dto.getmEmail());
			result = ps.executeUpdate();  // 실행결과는 실제 삽입된 행(row)의 개수이다.
			
		}catch (Exception e) {
			e.printStackTrace();// TODO: handle exception
		}finally {
			close(con, ps, null);
		}
		return result;  // 실행결과 반환
	}
	public boolean check(String mId, String mEmail) {
		boolean check = false;
		try {
			con = getConnection();
			sql = "SELECT MID, MEMAIL FROM MEMBERS WHERE MID = ? OR MEMAIL = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mId);
			ps.setNString(2, mEmail);
			rs = ps.executeQuery();
			if(check = rs.next()) {
				if(rs.getString(1).equalsIgnoreCase(mId) ) {
					System.out.println(mId + " 으로 이미 가입된 Id가 있습니다.");
				}else if(rs.getString(2).equalsIgnoreCase(mEmail)) {
					System.out.println(mEmail + " 으로 이미 가입된 Email이 있습니다.");
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(con, ps, rs);
		}
		return check;
		
	}
	
	// 탈퇴(아이디에 의한 탈퇴)
	public int deleteMembers(String mId) {
		result = 0;
		try {
			con = getConnection();
			sql = "DELETE FROM MEMBERS WHERE MID = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mId);
			result = ps.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(con, ps, null);
		}
		return result;
	}
	// 회원정보수정(아이디에 의한 수정)
	// 수정 가능한 요소는 mName, mEmail
	public int updateMembers(MembersDto dto) {
		result = 0;
		try {
			con = getConnection();
			sql = "UPDATE MEMBERS SET MNAME = ?, MEMAIL = ? WHERE MID = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, dto.getmName());
			ps.setString(2, dto.getmEmail());
			ps.setString(3, dto.getmId());
			result = ps.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(con, ps, null);
		}
		return result;
	}
	
	// 아이디 찾기(mEmail을 통해서 mId찾기)
	public String findmIdBymEmail(String mEmail) {
		String findmId = null;
		try {
			con = getConnection();
			sql = "SELECT MID FROM MEMBERS WHERE MEMAIL = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mEmail);
			rs = ps.executeQuery();  // select문은 executeQuery() 메소드, 실행결과는 ResultSet
			// 일치하는 mEmail 있으면 rs.next()의 결과를 사용
			// 일치하는 mEmail 없으면 rs.next() 결과가 false
			if(rs.next()) {  // 일치하는 mEmail이 있으면,
				// rs에 저장된 칼럼(열)의 개수 : 1개(select절의 칼럼과 일치)
				// rs.getString(1) : 1번째 칼럼의 값
				// rs.getString("MID") : MID 칼럼의 값
				findmId = rs.getString(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(con, ps, rs);
		}
		return findmId;
	}
	
	// 아이디에 의한 검색
	public MembersDto selectMembersDtoBymId(String mId) {
		MembersDto dto = null;
		try {
			con = getConnection();
			sql = "SELECT MNO,MID,MNAME,MEMAIL,MDATE FROM MEMBERS WHERE MID = ?";
			ps = con.prepareStatement(sql);
			ps.setString(1, mId);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new MembersDto(rs.getLong(1), 
									 rs.getString(2), 
									 rs.getString(3), 
									 rs.getString(4), 
									 rs.getDate(5));
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(con, ps, rs);
		}
		return dto;
		
	}
	
	
	
	// 전체 검색
	public List<MembersDto> selectMembersList() {
		List<MembersDto> list = new ArrayList<MembersDto>();
		try {
			con = getConnection();
			sql = "SELECT MNO, MID, MNAME, MEMAIL,MDATE FROM MEMBERS";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while(rs.next()) {
				list.add(new MembersDto(rs.getLong("MNO"), 
									    rs.getString("MID"), 
									    rs.getString("MNAME"), 
									    rs.getString("MEMAIL"), 
									    rs.getDate("MDATE"))); 
				
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(con, ps, rs);
		}
		return list;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
