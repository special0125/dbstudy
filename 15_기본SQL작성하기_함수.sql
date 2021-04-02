-- 오라클 내장 함수

-- 1. 집계 함수

DROP TABLE score;

CREATE TABLE score
(   
    kor NUMBER(3),
    eng NUMBER(3),
    mat NUMBER(3)
);

INSERT INTO score (kor, eng, mat) VALUES (10, 10, 10);
INSERT INTO score (kor, eng, mat) VALUES (20, 20, 20);
INSERT INTO score (kor, eng, mat) VALUES (30, 30, 30);
INSERT INTO score (kor, eng, mat) VALUES (90, 90, 90);
INSERT INTO score (kor, eng, mat) VALUES (100, 100, 100);

-- 1) 국어(kor) 점수의 합계를 구한다.
SELECT SUM(kor) FROM score;  -- 칼럼이 1개인 테이블로 보여진다.
SELECT SUM(kor) 합계 FROM score;  -- 칼럼의 이름이 '합계'이다.
SELECT SUM(kor) AS 국어점수합계 FROM score;  -- 칼럼의 이름이 '국어점수합계'이다.

-- 2) 모든 점수의 합계를 구한다.
--select sum(kor,eng,mat) from score;  -- 칼럼을 1개만 지정할 수 있습니다.
SELECT SUM(kor + eng + mat) 전체점수합계 FROM score; 
SELECT SUM(kor) + SUM(eng) + SUM(mat) AS 전체점수합계 FROM score;

-- 3) 국어(kor) 점수의 평균을 구한다.
SELECT AVG(kor) 국어평균 FROM score;

-- 4) 영어(eng) 점수의 최댓값을 구한다.
SELECT MAX(eng) 영어최댓값 FROM score;

-- 5) 수학(mat) 점수의 최솟값을 구한다.
SELECT MIN(mat) 수학최솟값 FROM score;

-- 'NAME' 칼럼을 추가하고, 적당한 이름을 삽입하시오.
ALTER TABLE score ADD name VARCHAR2(20);
UPDATE score SET name = 'JADU   ' WHERE kor = 10;
UPDATE score SET name = 'jjanggu   ' WHERE kor = 20;
UPDATE score SET name = '   WILK' WHERE kor = 30;
UPDATE score SET name = '   ddoongi' WHERE kor = 90;
UPDATE score SET name = 'CHOCO   ' WHERE kor = 100;

-- 국어점수 중 임의로 2개를 null로 수정하시오.
UPDATE score SET kor = NULL WHERE name = 'WILK';
UPDATE score SET kor = NULL WHERE name = 'CHOCO';

-- 6) 이름의 개수를 구하시오.
SELECT COUNT(name) FROM score;

-- 7) 국어점수의 개수를 구하시오.
SELECT COUNT(kor) FROM score;

-- 8) 학생의 개수를 구하시오.
SELECT COUNT(*) FROM score;  -- *는 전체 칼럼을 의미한다. 어떤 칼럼이든 하나라도 데이터가 포함되어 있으면 개수를 구한다.

-- 2. 문자 함수
-- 1) 대소문자 관련 함수
SELECT INITCAP(name) FROM score;  -- 첫 글자만 대문자, 나머지 소문자
SELECT UPPER(name) FROM score;  -- 모두 대문자
SELECT LOWER(name) FROM score;  -- 모두 소문자


-- 2) 문자열의 길이 반환
SELECT LENGTH(name) FROM score;

-- 3) 문자열의 일부 반환 함수
SELECT SUBSTR(name, 2, 3) FROM score;  -- (시작이 1입니다.) 2번째 글자부터 3글자를 반환한다.

-- 4) 문자열에서 특정 문자의 포함된 위치 반환 함수
SELECT INSTR(name, 'J') FROM score;  -- 대문자 J의 위치가 반환한다. 없으면 0이 반환한다.
SELECT INSTR(UPPER(name), 'J') FROM score;  -- 모든 제이(J, j)의 위치를 반환한다.

-- 5) 왼쪽 패딩
SELECT LPAD(name, 10, '*') FROM score;

-- 6) 오른쪽 패딩
SELECT RPAD(name, 10, '*') FROM score;

-- 모든 name을 오른쪽 맞춤해서 출력
SELECT LPAD(name, 10, ' ') FROM score;

-- 모든 name을 다음과 같이 출력
-- JADU : JA**
-- jjangu : jj*****
-- WILK : WI**
SELECT RPAD(substr(name, 1, 2), LENGTH(name), '*') FROM score;

-- 7) 문자열 연결 함수
-- Oracle에서 연산자 || 는 OR이 아니라, 연결 연산자이다.

-- JADU 10 10 10
SELECT name || ' ' || kor || ' ' || eng || ' ' || mat FROM score;

SELECT CONCAT(name, ' ') FROM score;
SELECT CONCAT(CONCAT(name, ' '), kor) FROM score;

-- 8) 불필요한 문자열 제거 함수 (좌우만 가능하고, 중간에 포함된 건 불가능)
-- 공백 제거 위주로 본다.

SELECT LTRIM(name) FROM score;  -- 왼쪽 공백을 제거
SELECT LENGTH(LTRIM(name)) FROM score;  -- 왼쪽 공백을 제거 후 글자수 제거
SELECT RTRIM(name) FROM score;
SELECT LENGTH(RTRIM(name)) FROM score;
SELECT TRIM(name) FROM score;

-- 다음 데이터를 삽입한다.
-- 80, 80, 80 james bond
INSERT INTO score values(80, 80, 80, 'james bond');

-- 아래와 같이 출력한다.
-- first_name  last_name
-- james       bond

SELECT 
    SUBSTR(name, 1, instr(name, ' ') - 1) AS first_name,
    SUBSTR(name, instr(name, ' ') + 1) AS last_name 
FROM score 
WHERE name = 'james bond';




