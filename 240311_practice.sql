-- [연습 문제]
-- 회원가입용 테이블 생성(USER_TEST)
-- 컬럼명 : USER_NO(회원번호) - 기본키(PK_USER_TEST), 
--          USER_ID(회원아이디) - 중복금지(UK_USER_ID),
--          USER_PWD(회원비밀번호) - NULL값 허용안함(NN_USER_PWD),
--          PNO(주민등록번호) - 중복금지(UK_PNO), NULL 허용안함(NN_PNO),
--          GENDER(성별) - '남' 혹은 '여'로 입력(CK_GENDER),
--          PHONE(연락처),
--          ADDRESS(주소),
--          STATUS(탈퇴여부) - NOT NULL(NN_STATUS), 'Y' 혹은 'N'으로 입력(CK_STATUS)
-- 각 컬럼의 제약조건에 이름 부여할 것
-- 각 컬럼에 주석 달기
-- 5명 이상 INSERT할 것

CREATE TABLE USER_TEST(
	USER_NO	CHAR(10) PRIMARY KEY,
	USER_ID VARCHAR2(20) UNIQUE,
	USER_PWD VARCHAR2(20) NOT NULL,
	PNO CHAR(14) NOT NULL,
	GENDER CHAR(10) CHECK(GENDER IN('남', '여')),
	PHONE VARCHAR2(20),
	ADDRESS VARCHAR2(100),
	STATUS CHAR(3) DEFAULT 'N' NOT NULL,
	CONSTRAINT UK_PNO UNIQUE(PNO),
  CONSTRAINT CK_STATUS CHECK( STATUS IN ('Y','N') )
 );

ROLLBACK;

COMMENT ON COLUMN USER_TEST.USER_NO IS '회원번호';
COMMENT ON COLUMN USER_TEST.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_TEST.USER_PWD IS '회원비밀번호';
COMMENT ON COLUMN USER_TEST.PNO IS '주민등록번호';
COMMENT ON COLUMN USER_TEST.GENDER IS '성별';
COMMENT ON COLUMN USER_TEST.PHONE IS '연락처';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '주소';
COMMENT ON COLUMN USER_TEST.STATUS IS '탈퇴여부';


INSERT INTO USER_TEST
VALUES(1 ,'user01', 'pass02', '881010-1001010', '남', '010-3122-3313', ' 서울시 종로구 부암동', 'N');

INSERT INTO USER_TEST
VALUES(2 ,'user02', 'pass02', '891110-1001010', '여', '010-3122-3313', ' 서울시 은평구 녹번동', 'N');

INSERT INTO USER_TEST
VALUES(3 ,'user03', 'pass03', '911010-1011010', '남', '010-3122-3313', ' 서울시 서대문구 부암동', 'N');

INSERT INTO USER_TEST
VALUES(4 ,'user04', 'pass04', '751010-1001010', '남', '010-3122-3313', ' 서울시 종로구 부암동', 'N');

INSERT INTO USER_TEST
VALUES(5 ,'user05', 'pass05', '641010-1001010', '남', '010-3122-3313', ' 서울시 종로구 부암동', 'N');


--테이블 확인
SELECT * FROM USER_TEST;

--테이블 주석 확인
SELECT * FROM USER_COL_COMMENTS
WHERE TABLE_NAME = 'USER_TEST';

--─────────────────────────────────────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────────────────────────
--─────────────────────────────────────────────────────────────────────────────────────────────────

/* 8 . SUBQUERY 를 이용한 테이블 생성하기
 
	컬럼명, 데이터 타입, 값이 복사되고, 제약조건은 UNIQUE, PRIMARY 키 등 다 안되고 NOT NULL만 복사됨
  
*/  
  -- 1) 테이블 전체 복사
 	
CREATE TABLE EMPLOYEE_COPY
AS SELECT * FROM EMPLOYEE;
--> 서브쿼리의 조회 결과 (RESULT SET)의 모양대로 테이블이 생성됨


SELECT * FROM EMPLOYEE_COPY;


	-- 2) JOIN 후 원하는 컬럼만 테이블로 복사
CREATE TABLE EMPLOYEE_COPY2
AS
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING(JOB_CODE);

SELECT * 
FROM EMPLOYEE_COPY2
ORDER BY EMP_ID;

/*
 	────────────────────────────────────────────────────────────────────
	서브쿼리로 테이블 생성 시
	테이블의 형태 ( 컬럼명, 데이터 타입) + NOT NULL 제약조건만 복사 된다
	제약조건, 코멘트는 복사 되지 않기 때문에 별도 추가 작업이 필요하다.
	────────────────────────────────────────────────────────────────────
																																		  */

--──────────────────────────────────────────────────────────────────────────────────────────────────────────

-- 9. 제약조건 추가하기 !
	/*
		┌───────┐
		│ALTER	│
		└───────┘
		각 키마다 표현 방법이 다르다는점
		
	- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] PRIMARY KEY( 컬럼명 )
	- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] UNIQUE KEY( 컬럼명 )
	- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] CHECK( 컬럼명 비교안산자 비교값 )
	- ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] FOREIGN KEY ( 컬럼명 )REFERENCES 참조 테이블명( 참조컬럼명)
	-- > 참조 테이블에 PRIMARY KEY를 PK(기본키) 를 FOREIGN KEY 로 사용하는 경우
			 참조컬럼명 생략이 가능하다
	
	ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL; 
		- ( MODIFY : 체크된 / 언체크된 것의 상태를 바꾸는거라 수정하는 의미.. )
	
*/

-- NOT NULL 제악조건만 복사된 EMPLOYEE_COPY 테이블에
-- EMP_ID 컬럼에 PRIMARY KEY 제약조건 추가
ALTER TABLE EMPLOYEE_COPY ADD CONSTRAINT PK_EMP_COPY PRIMARY KEY(EMP_ID);

-- 테이블 제약조건 확인방법 
SELECT * 
FROM USER_CONSTRAINTS "C1"
JOIN USER_CONS_COLUMNS "C2" USING (CONSTRAINT_NAME)
WHERE C1.TABLE_NAME = 'EMPLOYEE';


-- 수업시간에 활용하던 EMPLOYEE 테이블에는 FOREIGN KEY 제약조건이 없는 상태이므로, 추가해보기
-- EX ) DEPT_CODE , JOB_CODE 등

-- EMPLOYEE 테이블의 DEPT_CODE 에 외래키 제약조건 추가
-- 참조테이블은 DEPARTMENT, 참조컬럼은 DEPARTMENT 의 기본키.

ALTER TABLE EMPLOYEE 
ADD CONSTRAINT EMP_DEPT_CODE
FOREIGN KEY(DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID) ON DELETE SET NULL;
																	/* PK 알아서 참조 (DEPT_ID) */


-- EMPLOYEE 테이블의 JOB_CODE 외래키 제약조건 추가
-- 참조 테이블은 JOB, 참조 컬럼은 JOB테이블의 의 기본키
ALTER TABLE EMPLOYEE 
ADD CONSTRAINT EMP_JOB_CODE
FOREIGN KEY(JOB_CODE) REFERENCES JOB ON DELETE SET NULL;
																/* PK 컬럼을 자동 참조 (JOB_CODE) */	

-- EMPLOYEE 테이블의 SAL_LEVEL 외래키 제약조건 추가
-- 참조 테이블은 SAL_GRADE, 참조컬럼은 SAL_GRADE 의 기본키
ALTER TABLE EMPLOYEE 
ADD CONSTRAINT EMP_SAL_LEVEL
FOREIGN KEY(SAL_LEVEL) REFERENCES SAL_GRADE ON DELETE SET NULL;
																	/* PK 컬럼을 자동 참조 (SAL_LEVEL) */	

-- DEPARTMENT 테이블의 LOCATION_ID 에 외래키 제약조건 추가하기
-- 참조 테이블은 LOCATION , 참조 컬럼은 LOCATION 의 기본키
ALTER TABLE DEPARTMENT 
ADD CONSTRAINT EMP_LOCATION_ID
FOREIGN KEY(LOCATION_ID) REFERENCES LOCATION ON DELETE SET NULL;
																		/* PK 컬럼을 참조 (LOCAL_CODE) */

-- LOCATION 테이블의 NATIONAL_CODE에 외래키 제약조건 추가
-- 참조 테이블은 NATIONAL, 참조 컬럼은 NATIONAL의 기본키
ALTER TABLE LOCATION 
ADD CONSTRAINT LOC_NATIONAL_CODE
FOREIGN KEY(NATIONAL_CODE) REFERENCES NATIONAL ON DELETE SET NULL;
																			/* PK 컬럼 참조 (NATIONAL_CODE)*/









































