
-- 1 . ────────────────────────────────────────────────────────────────────────────────────────
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON( DEPT_ID = DEPT_CODE )
WHERE DEPT_CODE = ( SELECT DEPT_CODE
										FROM EMPLOYEE
									 	WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연';


-- 2 . ────────────────────────────────────────────────────────────────────────────────────────

SELECT EMP_NO, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MAX(SALARY)
								FROM EMPLOYEE
								WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000);
-- 사번, 사원명, 전화번호, 급여, 직급명을 조회.						
--'고용일이 2000년도 이후'인 사원들 중 '급여가 가장 높은' 사원의( SUB QUERY)

-- 3 . ────────────────────────────────────────────────────────────────────────────────────────

-- (MAIN) 사번, 이름, 부서코드, 직급코드, 부서명, 직급명
							
SELECT EMP_ID, EMP_NAME, DEPT_ID, JOB_CODE, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
WHERE (DEPT_CODE, JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
																FROM EMPLOYEE
																WHERE EMP_NAME = '노옹철')
AND EMP_NAME != '노옹철';


-- '노옹철 사원'과 '같은 부서', '같은 직급'인 사원을 조회하시오. (단, 노옹철 사원은 제외 EMP_NAME!= '노옹철')
/*
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';
*/

-- 4 . ─────────────────────────────────────────────────────────────────────────────────────────────

-- 사번, 이름, 부서코드, 직급코드, 고용일(MAIN)
SELECT EMP_NO, EMP_NAME, DEPT_CODE, JOB_CODE, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
															 FROM EMPLOYEE
															 WHERE EXTRACT(YEAR FROM HIRE_DATE) = '2000');





-- '2000년도에 입사한 사원'과 '부서'와 '직급'이 같은 사원을 조회하시오 SUB
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2000;


-- 6 . ─────────────────────────────────────────────────────────────────────────────────────────────

-- 사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고 (입사일 빠른 순, MAIN)

-- '부서별 입사일이 가장 빠른' 사원



SELECT EMP_ID, EMP_NAME, NVL(DEPT_TITLE,'소속없음'), JOB_NAME, HIRE_DATE
FROM EMPLOYEE
NATURAL JOIN JOB
LEFT JOIN DEPARTMENT ON (DEPT_ID, DEPT_CODE);




