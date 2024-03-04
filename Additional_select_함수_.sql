

-- 춘 대학교 워크북 과제
--SELECT(function)
-- 1 . 영어영문학과 (학과코드 002) 학생들의 학번과 이름 입학년도를 입학년도가 빠른 순으로 표시하는 SQL문 작성
-- (헤더는 학번 이름 입학년도가 표시되도록 한다)
SELECT STUDENT_NO 학번, STUDENT_NAME 이름, ENTRANCE_DATE 입학년도
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY 3;

-- 2 . 춘 기술대학교의 교수 중 이름이 세 글자가 아닌교수가 한 명 있다고 한다
-- 그 교수의 이름과 주민번호를 화면에 출력하는 문장을 작성해보자

SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';

-- 3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL문장
-- 단 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 하세요

SELECT PROFESSOR_NAME AS 교수이름, TO_NUMBER( || PROFESSOR_SSN) AS 나이
FROM TB_PROFESSOR
WHERE MOD PROFESSOR_SSN ;

-- 4 . 교수들의 이름 중 성을 지외한 이름만 출력하는 SQL 문장을 작성하시오
-- 출력 헤더는 "이름" 이 찍히도록 한다 ( 성이 2자인 경우의 교수는 없다고 가정)

SELECT SUBSTR(PROFESSOR_NAME, 2) 이름   --EMP_NAME, SUBSTR(EMAIL , 1, INSTR(EMAIL, '@') -1 ) 아이디
FROM TB_PROFESSOR;

-- 5 . 춘 기술대학교의 재수생 입학자를 구하려고 한다. 어떻게 찾아낼것인가 ?
-- 이 때, 19살에 입학하면 재수를 하지 않은것으로 간주한다

SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT;
-- ENTRANCE_DATE - STUDENT_SSN?


-- 6 . 2020 년 크리스마스는 무슨 요일인가 ?

 