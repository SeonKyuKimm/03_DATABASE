
-- 1 . ────────────────────────────────────────────────────────────────────────────────────────

-- 사번, 사원명, 전화번호, 고용일, 부서명 (MAIN)
-- '전지연 사원'이 속해있는 '부서'원들을 조회하시오 (단, 전지연은 제외)
SELECT EMP_ID, EMP_NAME, PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON( DEPT_ID = DEPT_CODE )
WHERE DEPT_CODE = ( SELECT DEPT_CODE
										FROM EMPLOYEE
									 	WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연';

/* DEPT_CODE를 통해서 전지연 사원 조회 */

-- 2 . ────────────────────────────────────────────────────────────────────────────────────────


-- 사번, 사원명, 전화번호, 급여, 직급명을 조회.	
SELECT EMP_ID, EMP_NAME, PHONE, SALARY, JOB_NAME
FROM EMPLOYEE
JOIN JOB USING(JOB_CODE)
WHERE SALARY = (SELECT MAX(SALARY)
								FROM EMPLOYEE
								WHERE EXTRACT(YEAR FROM HIRE_DATE) >= 2000);
								-- EXTRACT(YEAR FROM ) 날짜 형식인 컬럼에서 년도만 뽑아 추출 >= 2000 해서 2000과 크기비교 
--'고용일이 2000년도 이후'인 사원들 중 '급여가 가장 높은' 사원의( SUB QUERY)
							

-- 3 . ────────────────────────────────────────────────────────────────────────────────────────

-- (MAIN) 사번, 이름, 부서코드, 직급코드, 부서명, 직급명
							
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, DEPT_TITLE, JOB_NAME
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

< 단 노옹철 제외 >
AND EMP_NAME != '노옹철'; 
*/

-- 4 . ─────────────────────────────────────────────────────────────────────────────────────────────

-- 사번, 이름, 부서코드, 직급코드, 고용일(MAIN)
SELECT EMP_NO, EMP_NAME, DEPT_CODE, JOB_CODE, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE
WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE
															 FROM EMPLOYEE
															 WHERE EXTRACT(YEAR FROM HIRE_DATE) = '2000');

-- 다중열



-- '2000년도에 입사한 사원'과 '부서'와 '직급'이 같은 사원을 조회하시오 SUB
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2000;

-- 5 . ─────────────────────────────────────────────────────────────────────────────────────────────

-- 메인쿼리 (사번, 이름, 부서코드, 사수번호, 주민번호, 고용일)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE (DEPT_TITLE, MANAGER_ID) IN (SELECT DEPT_TITLE ,MANAGER_ID 
															     FROM EMPLOYEE
																	 NATURAL JOIN DEPARTMENT
																	 WHERE SUBSTR(EMP_NO, 8, 1 ) = '2'
																	 AND SUBSTR(EMP_NO, 1, 2) = '77')
ORDER BY EMP_ID;
										

SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE
WHERE (DEPT_CODE, MANAGER_ID) = (SELECT DEPT_CODE, MANAGER_ID
																 FROM EMPLOYEE	
																 WHERE SUBSTR(EMP_NO, 8, 1 ) = '2'
																 AND SUBSTR(EMP_NO, 1, 2) = '77');	
	/*			이건 왜 틀렸을까 ?												
SELECT EMP_ID, EMP_NAME, DEPT_CODE, MANAGER_ID, EMP_NO, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON DEPT_ID = DEPT_CODE
WHERE (DEPT_TITLE, MANAGER_ID) IN (SELECT DEPT_TITLE, MANAGER_ID
   																 FROM EMPLOYEE E
																   JOIN DEPARTMENT D ON E.DEPT_ID = D.DEPT_CODE 
																   WHERE SUBSTR(EMP_NO, 8, 1) = '2'
																   AND SUBSTR(EMP_NO, 1, 2) = '77'
																	 );*/

--''77년생 여자 사원''과 '동일한 부서''이면서 ''동일한 사수''를 가지고 있는 사원을 조회하시오
SELECT DEPT_TITLE ,MANAGER_ID 
FROM EMPLOYEE
NATURAL JOIN DEPARTMENT
WHERE SUBSTR(EMP_NO, 8, 1 ) = '2'
AND SUBSTR(EMP_NO, 1,2)= '77';
--AND EXTRACT(YEAR FROM EMP_NO)= '77____-';
--DECODE( SUBSTR(EMP_NO, 8, 1), '1', '남성', '2', '여성')



-- 6 . ─────────────────────────────────────────────────────────────────────────────────────────────

-- 사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고 (입사일 빠른 순, MAIN)

-- NVL (컬럼 , INPUT시킬 값) : 컬럼이 비어있다면 오른쪽에 넣을 정보

SELECT EMP_ID, EMP_NAME, NVL(DEPT_TITLE,'소속없음'), JOB_NAME, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE MAIN
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)

WHERE HIRE_DATE IN (SELECT MIN(HIRE_DATE)
										FROM EMPLOYEE SUB
										WHERE ENT_YN = 'N'-- 단, 퇴사한 직원은 제외하고 조회..
										AND MAIN.DEPT_CODE = SUB.DEPT_CODE
										OR (MAIN.DEPT_CODE IS NULL AND SUB.DEPT_CODE IS NULL)
									 )
ORDER BY HIRE_DATE;

SELECT EMP_ID, EMP_NAME, NVL(DEPT_TITLE,'소속없음'), JOB_NAME, TO_CHAR(HIRE_DATE, 'YY/MM/DD')
FROM EMPLOYEE MAIN
LEFT JOIN DEPARTMENT ON (DEPT_ID = DEPT_CODE)
JOIN JOB USING(JOB_CODE);

-- '부서별 입사일이 가장 빠른' 사원


SELECT MIN(HIRE_DATE)
FROM EMPLOYEE
WHERE DEPT_CODE;

SELECT MIN(HIRE_DATE)
FROM EMPLOYEE
WHERE ENT_YN  != 'Y'
GROUP BY DEPT_CODE;
-- 퇴사자를 여기서 거르는 이유는
-- D8 그룹의 가장 빠른 퇴사자 '이태림'
/*
 부서별로 그룹을 묶을 때 퇴사한 직원을 서브쿼리에서 제외해야 한다.
 ? 왜?  부서별로 가장 빠른 입사자 구했을 때 D8 부서는 이태림(이태림은 하필 퇴사자다)

  문제점 : 부서별로 가장 빠른 입사자 구해놓고 메인쿼리에서 퇴사자를제외하면
 D8 부서는 퇴사자인 이태림이 가장 빠른 입사자이기 때문에
 전체 부서 중 D8 부서가 아예 제외되어 버림.
  
  >> 부서 별 가장 빠른 입사자 구할 때 (서브쿼리) 퇴사한 직원을 뺀 상태로 그룹을 묶으면
   D8 부서의 가장 빠른 입사자는 이태림 제외 후 전형돈이 된다.
   
   즉, 메인쿼리에 WHERE ENT_YN  != 'Y' 퇴사자를 넣게 되면
   조건 자체에서 '퇴사자 (ENT_YN != 'Y')'를 가진 그룹 자체가 제외된다
   그래서 답이 안나온다
*/

-- 7 . ─────────────────────────────────────────────────────────────────────────────────────────────

-- '직급별' '나이가 가장 어린 직원'의
-- 사번, 이름, 직급명, 나이, 보너스 포함 연봉을 조회하고
-- 나이순으로 내림차순 정렬하세요 
-- 단 연봉은 ￦124,800,000 으로 출력되게 하세요. (￦ : 원 단위 기호)

-- 인라인 뷰로 해봤다


SELECT EMP_ID, EMP_NAME, JOB_NAME, 나이, 보너스포함연봉
FROM (SELECT EMP_ID, EMP_NAME, JOB_NAME,
						 TRUNC( MONTHS_BETWEEN (TRUNC( SYSDATE ) , (19 || SUBSTR( EMP_NO, 1, 6 ) ) ) /12) 나이,
			   		
				     '￦' || ( SALARY * ( NVL( BONUS,0 ) + 1 ) ) * 12 보너스포함연봉
			FROM EMPLOYEE
			NATURAL JOIN JOB)
			WHERE 나이 IN ( SELECT MIN( TRUNC( MONTHS_BETWEEN( TRUNC(SYSDATE), 
									    (19 || SUBSTR(EMP_NO, 1, 6) ) ) /12) )
                      FROM EMPLOYEE
             	        GROUP BY JOB_CODE)
ORDER BY 나이 DESC;


SELECT TRUNC( ( MONTHS_BETWEEN(SYSDATE , ( 19 || SUBSTR(EMP_NO,1 ,6) ) ) /12 ) ) 나이
FROM EMPLOYEE;


-- ******************풀이 ***************

--서브쿼리, 다중행 서브쿼리용
SELECT MAX(EMP_NO) FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 메인
SELECT EMP_ID, EMP_NAME, JOB_NAME,
			 FLOOR ( MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD' ) ) / 12 ) "나이",
			 TO_CHAR(SALARY * (1 + NVL(BONUS, 0 )) * 12, 'L999,999,999') "보너스 포함 연봉"
FROM EMPLOYEE
NATURAL JOIN JOB;


-- 합
SELECT EMP_ID, EMP_NAME, JOB_NAME,
			 FLOOR ( MONTHS_BETWEEN(SYSDATE, TO_DATE(SUBSTR(EMP_NO, 1, 6), 'RRMMDD' ) ) / 12 ) "나이",
			 TO_CHAR(SALARY * (1 + NVL(BONUS, 0 )) * 12, 'L999,999,999') "보너스 포함 연봉"
FROM EMPLOYEE
NATURAL JOIN JOB
WHERE EMP_NO IN (SELECT MAX(EMP_NO) FROM EMPLOYEE
								 GROUP BY JOB_CODE)
ORDER BY "나이" DESC;










