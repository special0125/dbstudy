-- 시퀀스
-- 1. 일렬번호 생성 객체이다.
-- 2. 주로 기본키(인공키)에서 사용한다.
-- 3. currval : 시퀀스가 생성해서 사용한 현재 번호
-- 4. nextval : 시퀀스가 생성해야 할 다음 번호

-- 시퀀스 생성
CREATE SEQUENCE employee_seq
INCREMENT BY 1  -- 번호가 1씩 증가한다.
START WITH 1000  -- 번호 시작이 1000이다.
NOMAXVALUE  -- 최대값 없음, 최대값 지정 : (MAXVALUE 999999)
NOMINVALUE -- 최소값 없음
NOCYCLE  -- 번호 순환이 없다.
NOCACHE;  -- 메모리에 캐시하지 않는다. 항상 유지.

-- employee3 테이블에 행 삽입
-- emp_no는 시퀀스로 입력

INSERT INTO employee3 
    (emp_no, name, depart, position, gender, hire_date, salary)
VALUES 
    (employee_seq.nextval, '구창민', 1, '과장', 'M', '95-05-01', 5000000);
    
    
-- 시퀀스 확인
SELECT employee_seq.currval
  FROM dual;
  
-- 시퀀스 목록 확인
SELECT *
  FROM user_sequences;
  

-- ROWNUM : 가상 행 번호
-- ROWID : 데이터가 저장된 물리적 위치 정보

SELECT ROWNUM,
       ROWID,
       emp_no,
       name
  FROM employee;

-- 최고 빠른 검색 : rowid를 이용한 검색 (오라클의 검색 방식)
SELECT emp_no,
       name
  FROM employee
 WHERE ROWID = 'AAAFCIAABAAALCxAAC'; 

-- 그 다음 빠른 검색 : INDEX를 이용한 검색 (휴먼의 검색)

SELECT emp_no,
       name
  FROM employee
 WHERE emp_no = 1003;

-- ROWNUM의 WHERE절 사용
-- 주의. 
-- 1. 1을 포함하는 검색만 가능하다.
-- 2. 순서대로 몇 건을 추출하기 위한 목적이다.
-- 3. 특정 위치를 지정한 검색은 불가능하다.
SELECT emp_no,
       name
  FROM employee
 WHERE ROWNUM = 1; 
 
SELECT emp_no,
       name
  FROM employee
 WHERE ROWNUM = 2;  -- 불가능하다.
 
SELECT emp_no,
       name
  FROM employee
 WHERE ROWNUM BETWEEN 1 AND 3;  -- 가능하다.
 
SELECT emp_no,
       name
  FROM employee
 WHERE ROWNUM BETWEEN 3 AND 5;  -- 불가능하다.
 
-- 1 이외의 번호로 시작하는 모든 ROWNUM을 사용하기 위해서는
-- ROWNUM에 별명을 주고 별명을 사용한다.

-- 실행 순서 때문에 처리 안 되는 쿼리문
SELECT ROWNUM AS rn,  -- 실행순서 3
       emp_no,
       name
  FROM employee  -- 실행순서 1
 WHERE rn = 2;  -- 실행순서 2
 
SELECT 
       e.emp_no,
       e.name
  FROM (SELECT ROWNUM AS rn,
               emp_no,
               name
          FROM employee) e
 WHERE e.rn = 2;


-- 연습문제
-- 1. 다음 테이블을 생성한다.
-- 게시판(글번호, 글제목, 글내용, 글작성자, 작성일자)
-- 회원(회원번호, 아이디, 이름, 가입일자)
DROP TABLE BOARD;
DROP TABLE MEMBERS;

CREATE TABLE BOARD
(
    BOARD_NO NUMBER,
    BOARD_TITLE VARCHAR2(1000),
    BOARD_CONTENT VARCHAR2(4000),
    MEMBER_ID VARCHAR2(30),
    BOARD_DATE DATE
);

CREATE TABLE MEMBERS
(
    MEMBER_NO NUMBER,
    MEMBER_ID VARCHAR2(30) NOT NULL UNIQUE,
    MEMBER_NAME VARCHAR2(30),
    MEMBER_DATE DATE
);


-- 2. 각 테이블에서 사용할 시퀀스를 생성한다.
-- 게시판시퀀스(1~무제한)
-- 회원시퀀스(100000~999999)
DROP SEQUENCE BOARD_SEQ;
DROP SEQUENCE MEMBER_SEQ;
CREATE SEQUENCE BOARD_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE;
CREATE SEQUENCE MEMBER_SEQ INCREMENT BY 1 START WITH 100000 MAXVALUE 999999 NOCYCLE NOCACHE;

-- 3. 각 테이블에 적절한 기본키, 외래키, 데이터(5개)를 추가한다.
ALTER TABLE MEMBER ADD CONSTRAINT MEMBERS_PK PRIMARY KEY(MEMBER_NO);
ALTER TABLE BOARD ADD CONSTRAINT BOARD_PK PRIMARY KEY(BOARD_NO);
ALTER TABLE BOARD ADD CONSTRAINT BOARD_MEMBER_FK FOREIGN KEY(MEMBER_ID) REFERENCES MEMBERS(MEMBER_ID);

INSERT INTO MEMBERS(MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_DATE) VALUES
    (MEMBER_SEQ.NEXTVAL, 'admin', '관리자', '21/04/01');
INSERT INTO MEMBERS(MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_DATE) VALUES
    (MEMBER_SEQ.NEXTVAL, 'tokyo', '도쿄', '21/04/02');
INSERT INTO MEMBERS(MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_DATE) VALUES
    (MEMBER_SEQ.NEXTVAL, 'toronto', '토론토', '21/04/03');
INSERT INTO MEMBERS(MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_DATE) VALUES
    (MEMBER_SEQ.NEXTVAL, 'tomato', '토마토', '21/04/04');
INSERT INTO MEMBERS(MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_DATE) VALUES
    (MEMBER_SEQ.NEXTVAL, 'racer', '레이서', '21/04/05');
INSERT INTO MEMBERS(MEMBER_NO, MEMBER_ID, MEMBER_NAME, MEMBER_DATE) VALUES
    (MEMBER_SEQ.NEXTVAL, 'bayaba', '바야바', '21/04/06');

INSERT INTO BOARD(BOARD_NO, BOARD_TITLE, BOARD_CONTENT, MEMBER_ID, BOARD_DATE) VALUES
    (BOARD_SEQ.NEXTVAL, '공지사항', '공지입니다.', 'admin', SYSDATE);
INSERT INTO BOARD(BOARD_NO, BOARD_TITLE, BOARD_CONTENT, MEMBER_ID, BOARD_DATE) VALUES
    (BOARD_SEQ.NEXTVAL, '출석', '출석입니다.', 'bayaba', '21/04/05');
INSERT INTO BOARD(BOARD_NO, BOARD_TITLE, BOARD_CONTENT, MEMBER_ID, BOARD_DATE) VALUES
    (BOARD_SEQ.NEXTVAL, '질문입니다', '여기가 차붐의 나라입니까?', 'tomato', '21/04/06');
INSERT INTO BOARD(BOARD_NO, BOARD_TITLE, BOARD_CONTENT, MEMBER_ID, BOARD_DATE) VALUES
    (BOARD_SEQ.NEXTVAL, '협조', '재활용은 화목일입니다.', 'admin', SYSDATE);
INSERT INTO BOARD(BOARD_NO, BOARD_TITLE, BOARD_CONTENT, MEMBER_ID, BOARD_DATE) VALUES
    (BOARD_SEQ.NEXTVAL, '[필독]건의', '매일 아침마다 차가 너무 밀립니다.', 'racer', '21/04/07');

COMMIT;

SELECT * FROM BOARD;
SELECT * FROM MEMBERS;

-- 4. 게시판을 글제목의 가나다순으로 정렬하고 첫 번째 글을 조회한다.
SELECT b.board_no
     , b.board_title
     , b.board_content
     , b.member_id
     , b.board_date
  FROM (SELECT board_no
             , board_title
             , board_content
             , member_id
             , board_date
          FROM board
         ORDER BY board_title) b
 WHERE ROWNUM = 1;

-- 5. 게시판을 글번호의 가나다순으로 정렬하고 1 ~ 3번째 글을 조회한다.
SELECT b.board_no
     , b.board_title
     , b.board_content
     , b.member_id
     , b.board_date
  FROM (SELECT board_no
             , board_title
             , board_content
             , member_id
             , board_date
          FROM board
         ORDER BY board_no) b
 WHERE ROWNUM <= 3;

-- 6. 게시판을 최근 작성일자순으로 정렬하고 3 ~ 5번째 글을 조회한다.
SELECT a.*
  FROM (SELECT b.board_no
             , b.board_title
             , b.board_content
             , b.member_id
             , b.board_date
             , ROWNUM AS rn
          FROM (SELECT board_no
                     , board_title
                     , board_content
                     , member_id
                     , board_date
                  FROM board
                 ORDER BY board_date DESC) b) a
 WHERE a.rn BETWEEN 3 AND 5;


-- 7. 가장 먼저 가입한 회원을 조회한다.
-- 가입일을 기준으로 오름차순 정렬하고 첫 번째 항목을 조회한다.
SELECT m.member_no,
       m.member_id,
       m.member_name,
       m.member_date
  FROM (SELECT member_no,
               member_id,
               member_name,
               member_date
          FROM members
         ORDER BY member_date) m
 WHERE ROWNUM = 1;


-- 8. 3번째로 가입한 회원을 조회한다.
SELECT
       m2.member_no,
       m2.member_id,
       m2.member_name,
       m2.member_date
  FROM (SELECT m1.member_no,
               m1.member_id,
               m1.member_name,
               m1.member_date,
               ROWNUM AS rn
          FROM (SELECT member_no,
                       member_id,
                       member_name,
                       member_date
                  FROM members
                 ORDER BY member_date) m1) m2
 WHERE m2.rn = 3;


-- 9. 가장 나중에 가입한 회원을 조회한다.
SELECT m.member_no,
       m.member_id,
       m.member_name,
       m.member_date
  FROM (SELECT member_no,
               member_id,
               member_name,
               member_date
          FROM members
         ORDER BY member_date DESC) m
 WHERE ROWNUM = 1;