package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dto.EmployeesDto;

/*
 *  부서번호(10~110)를 입력받아서,
 *  해당 부서에 근무하는 사원들의 정보를 조회하시오
 *  (이름, 부서명, 연봉, 입사일)
 */  





public class EmployeesDao {
	
	private Connection con;
	private PreparedStatement ps;
	private ResultSet rs;
	private String sql;
	
	private EmployeesDao() {}
	private static EmployeesDao dao = new EmployeesDao();
	public static EmployeesDao getInstance() {
		return dao;
	}
	
	private Connection getConnection() throws Exception{
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
		String user = "hr";
		String password = "1111";
		
		return DriverManager.getConnection(url, user, password);
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

	
	public List<EmployeesDto> selectEmployeesList (int departmentId) {
		List<EmployeesDto> list = new ArrayList<EmployeesDto>();
		try {
			con = getConnection();
			sql = "SELECT E.FIRST_NAME, "
					+    "E.LAST_NAME, "
					+    "D.DEPARTMENT_NAME, "
					+    "E.SALARY, "
					+    "E.HIRE_DATE "
				+   "FROM DEPARTMENTS D INNER JOIN EMPLOYEES E "
				+     "ON D.DEPARTMENT_ID = E.DEPARTMENT_ID "
				+  "WHERE E.DEPARTMENT_ID = ?";
			ps = con.prepareStatement(sql);
			ps.setInt(1, departmentId);
			rs = ps.executeQuery();
			while(rs.next()) {
				EmployeesDto dto = new EmployeesDto();
				dto.setFirstName(rs.getString(1));
				dto.setLastName(rs.getString(2));
				dto.setDepartmentName(rs.getString(3));
				dto.setSalary(rs.getDouble(4));
				dto.setHireDate(rs.getDate(5));
				list.add(dto);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(con, ps, rs);
		}
		return list;
	}
	
	
	
	
	
	
	
	
}
