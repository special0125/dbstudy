-- 테이블 생성 순서 : 부모(PK) -> 자식(FK)

--CREATE TABLE SCHOOL
--(   SCHOOL_CODE NUMBER(3) PRIMARY KEY,
--    SCHOOL_NAME VARCHAR2(10)
--);
--    
--CREATE TABLE STUDENT
--(
--    SCHOOL_CODE NUMBER(3) REFERENCES SCHOOL(SCHOOL_CODE),
--    STUDENT_NAME VARCHAR(15)
--);
 


-- 학생 테이블
CREATE TABLE student
(
    student_no VARCHAR2(5) PRIMARY KEY,
    student_name VARCHAR2(15),
    student_age NUMBER(5)
);
-- 과목 테이블
CREATE TABLE subject
(
    subject_code VARCHAR2(1) PRIMARY KEY,
    subject_name VARCHAR2(30),
    professor VARCHAR2(10)
);
-- 수강신청 테이블
CREATE TABLE APPLICATION
(
    application_no NUMBER PRIMARY KEY,
    student_no VARCHAR2(5) REFERENCES student(student_no),
    subject_code VARCHAR2(1) REFERENCES subject(subject_code)
);

-- 테이블 삭제 순서 : 자식(FK) -> 부모(PK)
--DROP TABLE STUDENT;
--DROP TABLE SCHOOL;



-- 제약조건추가(PK,FK)
-- 테이블 생성순서 조정
-- 칼럼 수정(칼럼명, 타입)
-- 테이블 삭제 순서


-- 회원 테이블
CREATE TABLE member
(
    member_no NUMBER, -- 회원번호(기본키)
    member_id VARCHAR2(30),-- 아이디
    member_pw VARCHAR2(30),  -- 비밀번호
    member_name VARCHAR2(15),  -- 이름
    member_email VARCHAR2(50),  -- 이메일
    member_phone VARCHAR2(15),  -- 전화
    member_date DATE,  -- 가입일
    PRIMARY KEY(member_no)
);

-- 게시판 테이블
CREATE TABLE board
(
    board_no NUMBER PRIMARY KEY,  -- 게시글번호(기본키)
    board_title VARCHAR2(1000),  -- 제목
    board_content VARCHAR2(4000),  -- 내용 (VARCHAR2 의 최대 사이즈는 4000이다.)
    board_hit NUMBER,  -- 조회수
    member_no NUMBER,  -- 작성자(member테이블 member_no참조하는 외래키)
    board_date DATE, -- 작성일자
    FOREIGN KEY(member_no) REFERENCES member(member_no)
);

-- 제조사 테이블
CREATE TABLE manufacturer
(
    manufacturer_no VARCHAR2(12) PRIMARY KEY, -- 사업자번호(기본키)
    manufacturer_name VARCHAR2(100), -- 제조사명
    manufacturer_phone VARCHAR2(15)  -- 연락처
);

-- 창고 테이블
CREATE TABLE warehouse
(
    warehouse_no NUMBER PRIMARY KEY,  -- 창고번호(기본키)
    warehouse_name VARCHAR2(5),  -- 창고이름
    warehouse_location VARCHAR2(100),  -- 창고위치
    warehous_used VARCHAR2(1) -- 사용여부
);

-- 택배업체 테이블
CREATE TABLE delivery_service
(
    delivery_service_no VARCHAR2(12) PRIMARY KEY,  -- 택배업체사업자번호(기본키)
    delivery_service_name VARCHAR2(20),  -- 택배업체명
    delivery_service_phone VARCHAR2(15),  -- 택배업체연락처
    delivery_service_address VARCHAR2(100)  -- 택배업체주소
);

-- 배송 테이블
CREATE TABLE delivery
(
    delivery_no NUMBER PRIMARY KEY,  -- 배송번호(기본키)
    delivery_service_no VARCHAR2(12) REFERENCES delivery_service(delivery_service_no),  -- 배송업체(택배업체) (delivery_service테이블 delivery_service_no참조하는 외래키)
    delivery_price NUMBER,  -- 배송가격
    delivery_date DATE  -- 배송날짜
);



-- 주문 테이블
CREATE TABLE orders
(
    orders_no NUMBER PRIMARY KEY,  -- 주문번호(기본키)
    member_no NUMBER REFERENCES member(member_no),  -- 주문회원 (member테이블 member_no참조하는 외래키)
    delivery_no NUMBER REFERENCES delivery(delivery_no), -- 배송번호 (delivery테이블 delivery_no참조하는 외래키)
    orders_pay VARCHAR2(10),  -- 결제방법
    orders_date DATE  -- 주문일자
);

-- 제품 테이블
CREATE TABLE product
(
    product_code VARCHAR2(10) PRIMARY KEY,  -- 제품코드(기본키)
    product_name VARCHAR2(50),  -- 제품명
    product_price NUMBER,  -- 가격
    product_category VARCHAR(15), -- 카테고리
    orders_no NUMBER REFERENCES orders(orders_no),  -- 주문번호 (orders테이블 orders_no참조하는 외래키)
    manufacturer_no VARCHAR2(12) REFERENCES manufacturer(manufacturer_no),  -- 제조사 (manufacturer테이블 manufacturer_no참조하는 외래키)
    warehouse_no NUMBER REFERENCES warehouse(warehouse_no)  -- 창고번호 (warehouse테이블 warehouse_no참조하는 외래키)
);




























