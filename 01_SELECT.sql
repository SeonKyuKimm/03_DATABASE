SELECT * FROM EMPLOYEE; 

SELECT EMP_NAME
FROM EMPLOYEE;

-- SELECT는 '조회' * 모두(컬럼명을) FROM '어디서' EMPLOYEE 임플로이에서.

/* SELECT (DQU 데이터검색어 또는 DML 데이터 조작어) : 데이터 조회
 *
 * - 데이터를 조회(SELECT)하면 조건에 맞는 행들이 조회됨.
 * 	이 때, 조회된 행들의 집합을 "RESULT SET(조회 결과의 집합)"이라고 한다.
 * 
 * - RESULT SET은 0개 이상의 행을 포함할 수 있다
 * 왜 0개 ? 조건에 맞는 행이 없을 수도 있어서..
 * 
 * */

-- [작성법]
-- SELECT 컬럼명 FROM 테이블명;
--> 어떤 테이블의 특정 컬럼을 조회하겠다

SELECT * FROM EMPLOYEE;
-- '*' : ALL, 모든, 모두..


SELECT EMP_ID, EMP_NAME, PHONE FROM EMPLOYEE;


--------------------------------------------------------------------------

--< 컬럼값 산술 연산>
-- 컬럼 값 : 테이블 내 한 칸(== 한 셀)에 작성된 값(DATA)

-- EMPLOYEE 테이블에서 모든 사원의 사번, 이름, 급여, 연봉,  조회

SELECT EMP_ID, EMP_NAME, SALARY, SALARY * 12 FROM EMPLOYEE;


--SELECT EMP_NAME +10 FROM EMPLOYEE;
-- ORA-01722 : 수치가 부적합합니다.
-- 산술 연산은 숫자(NUMBER타입)만 가능합니다!


--------------------------------------------------------------------------

-- 날짜(DATE) 타입 조회

-- EMPLOYEE 테이블에서 이름, 입사일 ,오늘 날짜 조회

SELECT EMP_NAME, HIRE_DATE, SYSDATE 
FROM EMPLOYEE;

-- SYSDATE : 시스템 상의 현재 시간(날짜)을 나타내는 상수


-- 현재 시간만 조회하기

SELECT SYSDATE FROM DUAL;

-- DUAL(DUmmy tABle) : 테이블 : 가짜 테이블(임시 조회용 테이블);


-- 날짜 + 산술 연산(+ ,-)

SELECT SYSDATE -1, SYSDATE, SYSDATE +1 
FROM DUAL;

-- 날짜에 +, -  연산 시 일 단위로 계산이 진행된다

-------------------------------------------------------------------------

-- <컬럼 별칭 지정하기> -- 

-- SELECT 조회 결과 집합인 RESULT SET에 출력되는 컬럼명을 지정

/*
 * 컬럼명 AS 별칭 : 이방법은별칭의띄어쓰기 X, 특수문자 X, 문자만O
 * 
 * 컬럼명 AS "별칭" :  이 방법은 띄어 쓰기 O, 특수문자 O, 문자만O
 * 
 * AS는 생략 가능
 * */


SELECT SYSDATE - 1 "하루 전", SYSDATE AS 현재시간, SYSDATE + 1 내일
FROM DUAL;

-------------------------------------------------------------------------

-- JAVA 리터럴 : 값 자체를 의미

-- DB 리터럴 : 임의로 지정한 값을 기존 테이블에 존재하는 값처럼 사용하는 것
-- (필수로) DB의 리터럴은 ' 홑따옴표 '
SELECT EMP_NAME, SALARY, '원 입니다.' 
FROM EMPLOYEE;


-------------------------------------------------------------------------

--- DISTINCT : 조회 시 컬럼에 포함된 중복값을 딱 한번만 표기

-- 주의사항 1) DISTINCT 구문은 SELECT 마다 딱 한 번 씩만 작성 가능
-- 주의사항 2) DISTINCT 구문은 SELECT 제일 앞에 작성되어야 한다.

SELECT DISTINCT DEPT_CODE, JOB_CODE FROM EMPLOYEE; 


--------------------------------------------------------------------------

--SELECT 컬럼명 FROM 테이블명 WHERE 조건절;

-- 해석순서 1 FROM 2 WHERE 3 SELECT

-- 3. SELECT 절 : SELECT 컬럼명
-- 1. FROM 절 : FROM 테이블명
-- 2. WHERE 절 : WHERE 컬럼명 연산자 값; (WHERE를 조건절이라고 함)
-- SELECT * FROM EMPLOYEE WHERE EMP_ID 300;

-- EMPLOYEE 테이블에서 급여가 3백만원 초과인 사원의 
-- 사번, 이름, 급여, 부서코드를 조회

SELECT EMP_ID, EMP_NAME, SALARY, DEPT_CODE 
FROM EMPLOYEE
WHERE SALARY > 3000000;


-- EMPLOYEE 테이블에서 부서코드가 'D9'인 사원의
-- 사번, 이름, 부서코드, 직급코드 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9'; --비교연산자가 ( = ) / 대입연산자 ( := )

-- 비교연산자 : >, <, >=, <=, =(같다), ( !=, <> 같지 않다 )



---------------------------------------------------------------------------

-- 논리연산자 (AND, OR)

-- EMPLOYEE 테이블에서 급여가 300만원 미만 또는 500만 이상인 사원의
-- 사번 이름 급여 전화번호 조회

SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY < 3000000 OR SALARY >= 5000000;

-- EMPLOYEE 테이블에서 급여가 300만원 이상 또는 500만 미만인 사원의
-- 사번 이름 급여 전화번호 조회

SELECT EMP_ID, EMP_NAME, SALARY, PHONE
FROM EMPLOYEE
WHERE SALARY >= 3000000 AND SALARY < 5000000;


-----------------------------------------------------------------------------

-- BETWEEN A AND B : A 이상 B 이하

-- 300만 이상, 600만 이하

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY BETWEEN 3000000 AND 6000000 ;

-- NOT BETWEEN A AND B : A 이상 B 이하가 아닌 경우 -- > A 미만, B 초과

SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY NOT BETWEEN 3000000 AND 6000000 ;


-- 날짜 (DATE )에 BETWEEN 사용하기
-- [EMPLOYEE] 테이블에서 입사일이 1990-01-01 ~1999-12-31 사이인 직원의
-- 이름, 입사일 조회

SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '1990-01-01' AND '1999-12-31';
-- 오라클은 데이터 타입이 달라도 형태가 일치하면 자동으로 타입을 변환시킴(형변환)

-- EX) 1 = '1'
SELECT '같음'
FROM DUAL
WHERE 1 = '';

----------------------------------------------------------------------------------------------

-- LIKE
-- 비교하려는 값이 특정한 패턴을 만족시키면 조회하는 연산자

-- [작성법] -- 
-- WHERE 컬럼명 LIKE '패턴이 적용된 값';

-- LIKE의 패턴을 나타내는 문자
--> '%' : 포함
--> '_' : 글자 수

-- '%' 예시
-- 'A%' : A로 시작하는 문자열
-- '%A' : A로 끝나는 문자열
-- '%A%': A를 포함하는 문자열

-- '_' 예시
-- 'A_' : A로 시작하는 두 글자 문자열
-- '___A' : A로 끝나는 네 글자 문자열 (A도 포함임)
-- '__A__' : 세 번째 문자가 A인 다섯글자 문자열
-- '_____' : 다섯글자 문자열

-- EMPLOYEE 테이블에서 성이 '전'씨인 사원의 사번, 이름 조회

SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';
-- WHERE EMP_NAME LIKE '전__';

-- EMPLOYEE 테이블에서 전화번호가 010 으로 시작하는'%' 사원의
-- 사번 이름 전화번호 조회

SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '010%';
-- WHERE PHONE LINE '010_________';

 
-- EMPLOYEE 테이블에서 전화번호가 010 으로 시작하지 않는'%' 사원의
-- 사번 이름 전화번호 조회

SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

-- EMAIL 에서 _ 앞에 글자가 3글자인 사원 이름, 이메일 조회

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';
-- 문제점 : '_' 를 기준점으로 삼았으나, 패턴 중 '_'와 동일한 표기법으로 작성되어
--          구분이 되지 않음

-- 해결방법 : LIKE의 ESCAPE OPTION을 이용하여 _ 를 구분한다

-- LIKE의 ESCAPE OPTION : 일반 문자로 처리할 '_' / '%' 앞에
--												아무 특수기호나 첨부해서 구분하게한다

SELECT EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___+_%' ESCAPE '+';

SELECT SALARY
FROM EMPLOYEE
WHERE HIRE_DATE LIKE '1990-0%';

--> + 뒤에 작성된 _ 는 일반 문자로 탈출시킨다. (+ 가 아닌 다른 기호도 ㄱㅊ, 대신 ESCAPE '특수기호' 첨부)


-- 연습문제
-- EMPLOYEE 테이블에서
-- 이메일'_' 앞이 4글자이면서
-- 부서코드가 'D9' 또는 'D6'이고 -> AND가 OR 보다 우선순위가 높다, () 사용 가능
-- 입사일이 1990-01-01 ~2000-12-31 이고
-- 급여가 270만 이상인 사원의
-- 사번 이름 이메일 부서코드 입사일 급여 조회

SELECT EMP_NO, EMP_NAME, EMAIL, DEPT_CODE, HIRE_DATE, SALARY
FROM EMPLOYEE
WHERE EMAIL LIKE '____+_%' ESCAPE '+'
AND (DEPT_CODE = 'D9' OR DEPT_CODE = 'D6')
AND HIRE_DATE BETWEEN '1990-01-01' AND '2000-12-31'
AND SALARY >= 2700000;

-- 연산자 우선순위

/*
 * 0. ()
 * 1. 산술연산자 ( + - * / )
 * 2. 연결연산자 (||)
 * 3. 비교연산자 ( > < <= >= = != <> )
 * 4. IS NULL / IS NOT NULL, LIKE, IN / NOT IN
 * 5. BETWEEN AND / NOT BEETWEEN AND
 * 6. NOT (논리연산자)
 * 7. AND (논리연산자)
 * 8. OR (논리연산자)
 * 
 * */


-------------------------------------------------------------------------------------

/* IN 연산자
 * 
 * - 비교하려는 값과 목록에 작성된 값 중
 * 일치하는것이 있으면 조회하는 연산자다
 * 
 * [작성법]
 * 
 * WHERE 컬럼명 IN(값1, 값2, 값3 ...)
 * 
 * (위와 같은 구문)
 * WHERE 컬럼명 = 값1
 * OR    컬럼명 = 값2
 * OR    컬럼명 = 값3
 * ...
 * */


-- EMPLOYEE 테이블에서
-- 부서코드가 D1, D6 D9인 사원의 
-- 사번 이름 부서코드 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IN('D1', 'D6', 'D9');


/* 위와 같음
 * WHERE DEPT_CODE = 'D1'
 * OR DEPT_CODE = 'D6'
 * OR DEPT_CODE = 'D9';
 * 
 * */

-- NOT IN

-- EMPLOYEE 테이블에서
-- 부서코드가 D1, D6 D9이 아닌 사원의 
-- 사번 이름 부서코드 조회

SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN('D1','D6','D9') --12 명? NULL 인 2 명이 생략됐었다
OR DEPT_CODE IS NULL; -- DEPT_CODE 가 D1 D6 D9 가 아니고, NULL의 값도 ~ (NULL 처리 연산자)


------------------------------------------------------------------------------------------------

/*NULL 처리 연산자
 * 
 * JAVA 에서 NULL : 참조하는 객체가 없음을 의미하는 값
 * DB 에서   NULL : 컬럼에 값이 없음을 의미하는 값
 * 
 * 
 * 
 * 1) IS NULL : NULL 인 경우 조회
 * 2) IS NOT NULL : NULL이 아닌 경우 조회
 * 
 * 
 * 
 * */

-- EMPLOYEE TABLE에서 보너스가 있는 사원의 이름, 보너스를 조회
SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL; -- 9행

-- EMPLOYEE TABLE에서 보너스가 없는 사원의 이름, 보너스를 조회

SELECT EMP_NAME, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL; -- 14행


---------------------------------------------------------------


/* ORDER BY 절
 * 
 * - SELECT 문의 조회 결과 (RESULT SET)를 정렬할 때 사용하는 구문
 * 
 * ** SELECT문 해석 시 가장 마지막에 해석됩니다 !
 * 
 * 3 SELECT 절
 * 1 FROM 절
 * 2 WHERE 절
 * 4 ORDER BY 컬럼명 || 별칭 || 컬럼 순서 [ ASC  | DESC ]     [NULLS FIRST | LAST]
 * 															(오름차순: 기본값) (내림차순)
 * */

-- EMPLOYEE TABLE에서 급여 오름차순으로 
-- 사번 이름 급여 조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
ORDER BY SALARY ASC; -- ASC가 기본값이라 써도 되고 안써도되고


-- 급여 200만 이상인 사원의 
-- 사번 이름 급여 조회, 단 급여 '내림차순'으로 조회할것.

SELECT EMP_ID,EMP_NAME, SALARY
FROM EMPLOYEE
WHERE SALARY >= 2000000
ORDER BY 3 DESC; -- SELECT 절에 써둔 순서의 번호임.


-- 입사일 순서대로 이름 입사일 조회 ( 별칭사용하기 )

SELECT EMP_NAME 이름, HIRE_DATE 입사일
FROM EMPLOYEE
ORDER BY 입사일;

/* 정렬 중첩 : 대분류 정렬 후 소분류 정렬*/

-- 부서코드 오름차순 정렬 후 급여 내림차순 정렬

SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
ORDER BY DEPT_CODE, SALARY DESC;











