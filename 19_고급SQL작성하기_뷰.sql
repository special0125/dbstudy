-- 뷰
-- 1. 기존 테이블을 이용해서 생성한 가상 테이블이다.
-- 2. 디스크 대신 데이터사전에만 등록한다.

-- 뷰 생성 연습
CREATE VIEW test_view 
    AS (SELECT emp_no, 
               name 
          FROM employee);
          
SELECT /** HINT */
       emp_no,
       name
  FROM test_view;
      
    
CREATE VIEW test_view2
    AS (SELECT *
          FROM employee
         WHERE position = '과장');

SELECT *
  FROM test_view2;
  
  
CREATE VIEW test_view3
    AS (SELECT /** HINT */
               e.emp_no,
               e.name,
               e.position,
               d.dept_name
          FROM department d RIGHT OUTER JOIN employee e
            ON d.dept_no = e.depart);
            
SELECT emp_no,
       name,
       dept_name,
       position
  FROM test_view3;  
