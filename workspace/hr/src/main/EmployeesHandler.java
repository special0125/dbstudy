package main;

import java.util.List;
import java.util.Scanner;

import dao.EmployeesDao;
import dto.EmployeesDto;

public class EmployeesHandler {

	private EmployeesDao dao = EmployeesDao.getInstance();
	Scanner sc = new Scanner(System.in);
	
	// method
		public void menu() {
			System.out.println("=====회원조회=====");
			System.out.println("0. 프로그램 종료");
			System.out.println("1. 부서 조회");
			System.out.println("==================");
		}
		public void execute() {
			while (true) {
				menu();
				System.out.print("선택 >>> ");
				switch (sc.nextInt()) {
				case 0 : System.out.println("회원조회 서비스를 종료합니다."); sc.close(); return;
				case 1 : inquiryByDepartmentId(); break;
				}
			}
		}
	
	
	public void inquiryByDepartmentId() {
		System.out.print("조회할 부서 번호 입력 (10~110) >>> ");
		int departmentId = sc.nextInt();
		
		List<EmployeesDto> list = dao.selectEmployeesList(departmentId);
		
		System.out.println("총 사원 수: " + list.size());
		for(EmployeesDto dto : list) {
			System.out.println(dto);
		}

	}
	
	
	
}

