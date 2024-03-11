/*
	DDL (DATA DEFINITION LANGULAGE)
	객체를 만들고 (CREATE), 바꾸고 (ALTER.수정), 삭제(DROP)하는 데이터 정의 언어
	

	ALTER ( 바꾸다 , 수정하다 , 변조하다 )


	- (수정을 할건데) 테이블에서  수정할 수 있는 것
 
 	1) 제약조건 ( 추가 / 삭제 )
	2) 컬럼( 추가 / 수정 / 삭제 )
	3) 이름변경 ( 테이블명, 컬럼명.. )
	
*/

/* 1) 제약조건 (추가 / 삭제)

	[작성법]
	1 . 추가 : ALTER TABLE 테이블명 ADD [CONSTRAINT 제약조건명] 제약조건(지정할 컬럼명)
						[REFERENCES 테이블명(컬럼명)] ]; <-- FOREIGN KEY인 경우에만 추가


	2 . 삭제 : ALTER TABLE 테이블명	DROP [CONSTRAINT 제약조건명];

	* 제약조건 자체를 수정하는 구문은 별도 존재하지 않는다 ! ! ! ! 
		그래서 아예 삭제 후 추가를 해야한다..
	
*/

-- DEPARTMENT 테이블 복사 ( 복사를 하면 컬럼명 ,데이터타입, NOT NULL 제약조건만 복사된다)
CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;

SELECT * FROM DEPT_COPY;


-- DEPT_COPY 의 DEPT_TITLE 컬럼에 UNIQUE 추가
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DEPT_COPY_TITLE_U UNIQUE(DEPT_TITLE);

-- DEPT_COPY의 DEPT_TITLE 컬럼에 UNIQUE 삭제
ALTER TABLE DEPT_COPY
DROP CONSTRAINT DEPT_COPY_TITLE_U;

SELECT DEPT_TITLE FROM DEPT_COPY;



-- NOT NULL 해볼건데, NOT NULL은 다르다!
/* 
 ** DEPT_COPY 의 DEPT_TITLE 컬럼에 NOT NOLL 제약조건 추가 / 삭제 연습 **
*/
ALTER TABLE DEPT_COPY
ADD CONSTRAINT DEPT_COPY_TITLE_NN NOT NULL(DEPT_TITLE);
--ORA-00904: : 부적합한 식별자. 요런 식으로는 NOT NULL 조건을 쓸 수 없음.
--> NOT NULL : 새로운 조건을 추가하는게 아니고,
--						 컬럼 자체에 NULL을 허용 / 비허용을 제어하는 성질 변경의 형태로 인식된다.


-- MODIFY ( 수정하다) : 구문을 사용하여 위의 다른 KEY값 변경과는 다르게 제어 해줘야함


ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE NOT NULL; -- DEPT_TITLE 컬럼을 NOT NULL로 수정


-- NOT NULL 조건 해제
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE NULL; -- DEPT_TITLE 컬럼을 다시 NULL 로 수정



--──────────────────────────────────────────────────────────────────────────────────────────────────
--──────────────────────────────────────────────────────────────────────────────────────────────────

/*
	 2 . 컬럼 추가 / 수정 / 삭제
	

	· 컬럼 추가하는 구문
		ALTER TABLE 테이블명
		ADD( 추가할컬럼명 데이터타입 [DEFAULT '값'] );


	· 컬럼 수정하는 구문
	 ALTER TABLE 테이블명 
	 MODITY 컬럼명 데이터 타입; --> 데이터 타입 변경

 	 ALTER TABLE 테이블명
   MODIFY 컬럼명 DEFAULT '값'; --> 디폴트 값 변경하는 방법


	· 컬럼 삭제하는 구문
		ALTER TABLE 테이블명 DROP (삭제할 컬럼명);
		ALTER TABLE 테이블명 DROP COLUMN 삭제할 컬럼명;
*/		


SELECT * FROM DEPT_COPY;

-- CNAME 이라는 컬럼 DEPT_COPY 테이블에 추가하기
ALTER TABLE DEPT_COPY
ADD( CNAME VARCHAR2(30) );


-- LNAME 컬럼 추가 (로컬네임. 기본값으로 ' 한국')
ALTER TABLE DEPT_COPY
ADD ( LNAME VARCHAR2(30) DEFAULT '한국' );
SELECT * FROM DEPT_COPY;
--> 컬럼이 생성되며 DEFAULT 값 자동 생성된다.


-- D10 개발1팀 추가하기
INSERT INTO DEPT_COPY
VALUES ( 'D10', '개발1팀', 'L1', DEFAULT, DEFAULT);
-- ORA-12899: "KH_KSK"."DEPT_COPY"."DEPT_ID" 열에 대한 값이 너무 큼(실제: 3, 최대값: 2)


-- DEPT_ID 컬럼 데이터 타입 수정 ( 현재 CHAR (2) ) 
ALTER TABLE DEPT_COPY
MODIFY DEPT_ID VARCHAR2(3);

SELECT * FROM DEPT_COPY;



-- LNAME의 기본값인 ' 한국' 을 KOREA 로 수정
ALTER TABLE DEPT_COPY MODIFY LNAME DEFAULT 'KOREA';
SELECT * FROM DEPT_COPY;
--> 기본값을 변경했다고 해수 기존의 데이터가 변하지 않음.


-- LNAME 한국 -> 'KOREA'로 변경
UPDATE DEPT_COPY
SET LNAME = DEFAULT
WHERE LNAME = '한국';

SELECT * FROM DEPT_COPY;
COMMIT;

-- 모든 컬럼 삭제 ?
ALTER TABLE DEPT_COPY DROP(LNAME);
ALTER TABLE DEPT_COPY DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY DROP(LOCATION_ID);
ALTER TABLE DEPT_COPY DROP(DEPT_TITLE);
ALTER TABLE DEPT_COPY DROP(DEPT_ID);
-- ORA-12983: 테이블에 모든 열들을 삭제할 수 없습니다

--** 컬럼 삭제 시 유의사항 **
-- 테이블이란 : 행과 열로 이루어진 DB의 가장 기본적인 객체이다
--							테이블에 데이터가 저장됨
-- 테이블은 최소 1개 이상의 컬럼이 존재해야 하기 따문에
-- 모든 컬럼을 다 삭제할 순 없다.

-- 테이블 삭제

DROP TABLE DEPT_COPY;
SELECT * FROM DEPT_COPY;
-- ORA-00942 : 테이블 또는 뷰가 존재하지 않습니다.


-- DEPARTMENT 테이블 복사해서 DEPT_COPY 생성

CREATE TABLE DEPT_COPY
AS SELECT * FROM DEPARTMENT;
--> 컬럼명 , 데이터타입 ,NOT NULL 여부 복사



-- DEPT_COPY 테이블에 PK 추가하고( 컬럼 : DEPT_ID, 계약조건명 : D_COPY_PK)
ALTER TABLE DEPT_COPY ADD CONSTRAINT D_COPY_PK PRIMARY KEY(DEPT_ID);



/*
	3 . 이름 변경 ( 컬럼, 테이블 ,제약조건명 )
*/

--	1) 컬럼명 변경하기 ( DEPT_TITLE -> DEPT_NAME ) 
ALTER TABLE DEPT_COPY
RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY;


--  2) 제약조건명 변경 ( D_COPY_PK -> DEPT_COPY_PK )
ALTER TABLE DEPT_COPY
RENAME CONSTRAINT D_COPY_PK TO DEPT_COPY_PK;

SELECT * FROM DEPT_COPY;


-- 3) 테이블명 변경(DEPT_COPY -> DCOPY)
ALTER TABLE DEPT_COPY RENAME TO DCOPY;

SELECT * FROM DEPT_COPY; --> 오류남
--> ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
SELECT * FROM DCOPY;


/*────────────────────────────────────────────────────────────────────────────────────────────────────
──────────────────────────────────────────────────────────────────────────────────────────────────────

  4 . 테이블 삭제 

	DROP TABLE 테이블명 [CASCADE CONSTRAINTS];
	

	1) 관계가 형성되지 않은 테이블(DCOPY) 삭제하기 */

DROP TABLE DCOPY;
SELECT * FROM DCOPY;

	
--2) 관계가 형성된 테이블 삭제 (TEST할 테이블 2개 생성했다 지울거임)
CREATE TABLE TB1(
	TB1_PK NUMBER PRIMARY KEY,
	TB1_COL NUMBER
);

CREATE TABLE TB2(
	TB2_PK NUMBER PRIMARY KEY,
	TB2_COL NUMBER REFERENCES TB1 -- TB1의 PRIMARY KEY를 자동 참조
);																							


-- TB1 ADD TO SAMPLE DATA
INSERT INTO TB1 VALUES (1, 100);
INSERT INTO TB1 VALUES (2, 200);
INSERT INTO TB1 VALUES (3, 300);

COMMIT;

-- TB2 ADD TO SAMPLE DATA
INSERT INTO TB2 VALUES (11, 1);
INSERT INTO TB2 VALUES (13, 3);
INSERT INTO TB2 VALUES (12, 2);


-- TB1 삭제
DROP TABLE TB1;
/* ORA-02449: 외래 키에 의해 참조되는 고유/기본 키가 테이블에 있습니다 .
	
		해결방법 : 
		1) 자식테이블 삭제, 부모테이블 삭제 를 순서대로 해줌
		
		2) ALTER 를 이용해서 FK(FOREIGN KEY) 제약조건 삭제 후 TB1 삭제
		
		3) DROP TABLE 삭제옵션 CASCADE CONSTRAINTS 사용
													 CASCADE CONSTRAINTS : 삭제하려는 테이블과 연결된 
													 											 FK 제약조건을 모두 삭제하는 구문	
*/

DROP TABLE TB1 CASCADE CONSTRAINTS;
-- > 삭제 성공
SELECT * FROM TB1; --> 삭제 확인 

SELECT * FROM TB2;



/*────────────────────────────────────────────────────────────────────────────────────────────────────
──────────────────────────────────────────────────────────────────────────────────────────────────────

  DDL 주의사항 
 
	
	1) DDL 은 COMMIT / ROLLBACK 이 되지 않는다.
			>> ALTER, DROP 을 신중하게 진행해야 한다.
	
	2) DDL 구문과 DML 구문 섞어서 수행하면 안됩니다! 
			>> DDL은 수행 시 존재하고 있는 트랜잭션을 모두 DB에 강제 COMMIT 시킵니당
			>> DDL 이 종료된 후 DML 구문을 수항훌 수 있도록 권장..

*/

SELECT * FROM TB2;

COMMIT;

-- DML
INSERT INTO TB2 VALUES (14, 4);
INSERT INTO TB2 VALUES (15, 5);
SELECT * FROM TB2;

-- 컬럼명 변경하는 DDL
ALTER TABLE TB2 RENAME COLUMN TB2_COL TO TB2_COLCOL;


ROLLBACK;
SELECT * FROM TB2;





--───────────────────────────────────────────────────────────────────────────────────────────────────────────────
--───────────────────────────────────────────────────────────────────────────────────────────────────────────────






