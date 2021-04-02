DROP TABLE employee;
DROP TABLE department;

CREATE TABLE department
(
    dept_no NUMBER,
    dept_name VARCHAR2(15) NOT NULL,
    location VARCHAR2(15) NOT NULL
);


CREATE TABLE employee
(
    emp_no NUMBER,
    NAME VARCHAR2(20) NOT NULL,
    depart NUMBER,
    POSITION VARCHAR2(20),
    gender CHAR(2),
    hire_date DATE,
    salary NUMBER
);


ALTER TABLE department ADD CONSTRAINT department_pk PRIMARY KEY(dept_no);
ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY(emp_no);
ALTER TABLE employee ADD CONSTRAINT employee_department_fk FOREIGN KEY (depart) REFERENCES department(dept_no);

-- 행(Row) 삽입
INSERT INTO department (dept_no, dept_name, location) VALUES (1, '영업부', '대구');
INSERT INTO department VALUES (2, '인사부', '서울');
INSERT INTO department VALUES (3, '총무부', '대구');
INSERT INTO department VALUES (4, '기획부', '서울');

-- 날짜 타입 작성 방법
-- 1. '2021-04-02'
-- 2. '21-04-02'
-- 3. '2021/04/02'
-- 4. '21/04/02' -- 오라클 기본값
INSERT INTO employee VALUES (1001, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
INSERT INTO employee VALUES (1002, '김민서', 1, '사원', 'M', '17-09-01', 2500000);
INSERT INTO employee VALUES (1003, '이은영', 2, '부장', 'F', '90-09-01', 5500000);
INSERT INTO employee VALUES (1004, '한성일', 2, '과장', 'M', '93-04-01', 5000000);


-- 행(Row) 수정
-- '영업부'의 위치(location)를 '인천'으로 수정하시오.
UPDATE department SET location = '인천' WHERE dept_name = '영업부';
UPDATE department SET location = '인천' WHERE dept_no = 1; -- WHERE절에서는 가능하면 PK를 사용하는 것이 좋다.

-- 2. '과장'과 '부장'의 월급(salary)을 10% 인상하시오.
UPDATE employee SET salary = salary * 1.1 WHERE POSITION = '과장' OR POSITION = '부장';
UPDATE employee SET salary = salary * 1.1 WHERE POSITION IN('과장', '부장');  -- 추천

-- 3. '총무부' -> '총괄팀', '대구' -> '광주'로 수정하시오.
UPDATE department SET location = '광주', dept_name = '총괄팀' WHERE dept_no = 3;

-- 행(Row) 삭제
-- 1. 모든 employee를 삭제한다.
DELETE FROM employee;  -- ROLLBACK으로 취소할 수 있다. (DML)
TRUNCATE TABLE employee;  -- 빠르게 삭제되지만 취소가 불가능하다. (DDL)

-- 2. '기획부'를 삭제한다.
DELETE FROM department WHERE dept_no = 4;





