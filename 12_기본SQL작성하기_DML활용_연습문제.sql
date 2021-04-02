DROP TABLE lecture;
DROP TABLE enroll;
DROP TABLE course;
DROP TABLE student;
DROP TABLE professor;



CREATE TABLE professor
(
    professor_no NUMBER,
    professor_name VARCHAR2(10),
    professor_major VARCHAR2(30)
);

CREATE TABLE student
(
    student_no NUMBER,
    student_name VARCHAR2(10),
    student_address VARCHAR2(100),
    student_lv NUMBER,
    professor_no NUMBER
);

CREATE TABLE course
(
    course_no NUMBER,
    course_name VARCHAR2(20),
    course_credit NUMBER
);

CREATE TABLE enroll
(
    enroll_no NUMBER,
    student_no NUMBER,
    course_no NUMBER,
    app_date DATE
);

CREATE TABLE lecture
(
    lecture_no NUMBER,
    professor_no NUMBER,
    enroll_no NUMBER,
    lecture_name VARCHAR2(20),
    lecture_room CHAR(1)
);

ALTER TABLE professor ADD CONSTRAINT professor_pk PRIMARY KEY(professor_no);
ALTER TABLE student ADD CONSTRAINT student_pk PRIMARY KEY(student_no);
ALTER TABLE student ADD CONSTRAINT student_professor_fk FOREIGN KEY (professor_no) REFERENCES professor(professor_no);
ALTER TABLE course ADD CONSTRAINT course_pk PRIMARY KEY(course_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_pk PRIMARY KEY(enroll_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_student_fk FOREIGN KEY (student_no) REFERENCES student(student_no);
ALTER TABLE enroll ADD CONSTRAINT enroll_course_fk FOREIGN KEY (course_no) REFERENCES course(course_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_pk PRIMARY KEY(lecture_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_professor_fk FOREIGN KEY (professor_no) REFERENCES professor(professor_no);
ALTER TABLE lecture ADD CONSTRAINT lecture_enroll_fk FOREIGN KEY (enroll_no) REFERENCES enroll(enroll_no);


INSERT INTO professor VALUES (111, '교수1', '수학');
INSERT INTO professor VALUES (222, '교수2', '국어');
INSERT INTO professor VALUES (333, '교수3', '영어');

INSERT INTO student VALUES (11111, '학생1', '서울', 1, 111);
INSERT INTO student VALUES (22222, '학생2', '인천', 2, 222);
INSERT INTO student VALUES (33333, '학생3', '경기도', 3, 333);

INSERT INTO course VALUES (11, '수학1', 3);
INSERT INTO course VALUES (22, '국어1', 3);
INSERT INTO course VALUES (33, '영어1', 3);

INSERT INTO enroll VALUES (1111, 11111, 11, sysdate);
INSERT INTO enroll VALUES (2222, 22222, 22, sysdate);
INSERT INTO enroll VALUES (3333, 33333, 33, sysdate);

INSERT INTO lecture VALUES (1, 111, 1111, '수학의정석', 'A');
INSERT INTO lecture VALUES (2, 222, 2222, '국어의정석', 'B');
INSERT INTO lecture VALUES (3, 333, 3333, '영어의정석', 'C');








