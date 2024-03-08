/*
  Data Dictionary 데이터 딕셔너리란 ?
  
  데이터베이스에 저장된 데이터 구조, 메타데이터 정보를 포함하는
  데이터베이스 객체이다.
  
  일반적으로 데이터베이스 시스템은 데이터 딕셔너리를 사용하여
  데이터베이스의 테이블, 뷰 , 인덱스, 제약조건 등과 관련된 정보를 저장하고 관리한다.
  
  *** USER_TABLES : 계정이 소유한 객체 등에 관한 정보를 RESULT SET을 통해 조회할 수 있는 딕셔너리 뷰
  
 */


SELECT * FROM USER_TABLES; -- kh_ksk 계정에서 만들었던 tables, 자료로 제공받았던 scrpits

/* 
      * DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어 *
	
	객체(OBJECT)를 만들고(CREATE), 수정(ALTER)하고, 삭제 (DROP)등
	데이터의 전체 구조를 정의하는 언어로, 주로 DB의 관리자나 설계자가 사용한다.
		 
		
	- 객체 : 테이블 ( TABLE) , 뷰 (VIEW), 시퀀스 (SEQUENCE),
					 인덱스 ( INDEX) , 사용자 (USER),
					 패키지 (PACKAGE), 트리거 (TRIGGER)
					 프로시져 (PROCEDUAL) , 함수 (FUNCTION)
					 동의어 (SYNONYM)
					 
*/

--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

--CREATE(생성)

-- 테이블이나 인덱스, 뷰 등 다양한 데이터베이스 객체를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 이라는 구문을 통해 제거할 수 있다!!

--DROP TABLE MEMBER;
/* [표현식]					    
	
	CREATE TABLE 테이블명 (
		컬럼명 자료형(크기),
		컬럼명 자료형(크기),
		컬럼명 자료형(크기),
		.....
	);
*/


/*

	[자료형]

	NUMBER: 숫자형 ( 정수 , 실수 )

	─ CHAR (크기) : 고정 길이 문자형 데이터 (최대 2000 BYTE)
			--> CHAR(10) - 10바이트 중 일부만 사용해도 10 바이트로 인식해서 저장
			--> 컬럼에 'ABC' 3BYTE 문자열만 저장해도 10BYTE 저장공간 모두 사용.
	
	
	
	
	 ─ VARCHAR2 (크기) : 가변 길이 문자형 데이터 ( 최대 4000 BYTE) 
			--> VARCHAR(10) - 10바이트 중 일부만 사용하면 나머지 용량은 반환해줌
			--> --> 컬럼에 'ABC' 3BYTE 문자열만 저장하면 7BYTE 저장공간 반환.
			
	 DATE : 날짜타입		
	 BLOB : 대용량 이진 데이터.  사진 등  ( 4GB )		
	 CLOB : 대용량 문자 데이터. 웹소설 등 (	4GB )

*/	 	
			
			
			
			

-- MEMBER 테이블 생성

CREATE TABLE "MEMBER"( -- 쌍따옴표를 감싸준 이유는 SQL에서 MEMBER라는 명령어가 있어서 그랬음ㅎ (쌍따옴표 안써더 무관함)
	MEMBER_ID VARCHAR2(20),
	MEMBER_PWD VARCHAR2(20),
	MEMBER_NAME VARCHAR2(30),
	MEMBER_SSN CHAR(14), --데이터 메모리 낭비를 하지 않기 위해 확실한 길이를 지정해주는게 좋다 (생년월일 - 고유7자리) = 14자 
	ENROLL_DATE DATE DEFAULT SYSDATE -- 데이터가 들어가지 않으면 자동으로 오늘날짜가 들어가게 설정해둔것
);
-- SQL 작성법 : 대문자 작성 권장, 연결된 단어 사이에는 "_" (언더바 ) 사용
-- 문자 인코딩 UTF - 8 : 영어, 숫자는 1BYTE, 한글, 특수문자 등은 3BYTE (자바에선 2BYTE 취급)

-- 만든 테이블 확인
SELECT * FROM MEMBER;




-- 2 . 컬럼에 주석 달기



/*
  
  [표현식]
   
  COMMENT ON COLUMN 테이블명.어떤?컬럼명 IS '주석내용';

*/

COMMENT ON COLUMN "MEMBER".MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN "MEMBER".MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN "MEMBER".MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN "MEMBER".MEMBER_SSN IS '회원 주민 등록 번호';
COMMENT ON COLUMN "MEMBER".ENROLL_DATE IS '회원 가입일';



-- MEMBER테이블에 샘플 데이터 삽입
-- INSERT DATE 테이블명 VALUES (값1, 값2, .....)
INSERT INTO "MEMBER" VALUES 
('MEM01', '123ABC', '김선규', '991213-1234567', DEFAULT);

		/*
  	INSERT / UPDATE 시 컬럼값으로 DEFAULT 를 작성하면
		테이블 생성 시 해당 컬럼에 지정된 DEFAUL 값으로 삽입이 된다.!
		*/


-- 데이터 삽입 확인
SELECT * FROM MEMBER;
COMMIT; -- 중요함 ㅇㅇ


-- 추가 샘플 데이터 삽입
-- 가입일 -> SYSDATE 활용해서 넣어보기
INSERT INTO "MEMBER" VALUES 
('MEM02', 'QWER1234', '김영희', '970506-2233567', SYSDATE);
SELECT *FROM MEMBER;

-- 가입일 -> INSERT시 미작성하는 경우 -> DEFAULT 값이 반영됨
-- INSERT INTO 테이블명(컬럼명1, 컬럼명2)
-- VALUES(값1, 값2)

INSERT INTO "MEMBER"(MEMBER_ID, MEMBER_PWD, MEMBER_NAME)
VALUES('MEM03','102WER', '이지연');

/*
 ** JDBC에서 날짜를 입력 받았을 때 삽입하는 방법

		'2022-09-13 17:33:27' 이런식으로 문자열이 넘어온 경우..
*/    
INSERT INTO "MEMBER" VALUES
( 'MEM04', 'PASS04', '김길동', '930101-1234567', 
	TO_DATE('2022-09-13 17:33:27', 'YYYY-MM-DD HH24:MI:SS' )
);


SELECT * FROM MEMBER;
COMMIT;

/*
		** NUMBER 타입의 문제점 **
		MEMBER2 테이블 ( 아이디, 비밀번호 ,이름, 전화번호 )
		
*/

CREATE TABLE MEMBER2(
		MEMBER_ID VARCHAR2(20),
		MEMBER_PWD VARCHAR2(20),
		MEMBER_NAME VARCHAR2(30),
		MEMBER_TEL NUMBER
);

INSERT INTO MEMBER2 VALUES('MEM01', 'PASS01' ,'고길동' , 7712341234);
INSERT INTO MEMBER2 VALUES('MEM02', 'PASS02' ,'고길순' , 01012344321);

/*
 NUMBER 타입 컬럼에 데이터 삽입 시, 제일 앞에 0이 있으면 이를 자동으로 제거한다
		 전화번호나, 주민등록번호처럼 숫자로만 되어있는 데이터지만
		 0 으로 시작할 가능성이 있다면 CHAR, VARCHAR2 같은 문자형을 사용하셔야 한다 
*/

SELECT * FROM MEMBER2;



--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

/*
		[ 제약 조건 ( CONSTRAINTS) ]
		
		┌──────────────────────────────────────────────────────────────────────────────────┐
		├──────────────────────────────────────────────────────────────────────────────────┤
		├──────────────────────────────────────────────────────────────────────────────────┤
		│
		│		사용자가 원하는 조건의 데이터만 유지하기 위해서 특정 컬럼에 설정하는 제약
		│		데이터 무결성 보장을 목적으로 한다
		│		-데이터가정확하고일견된상태라는것. 중복데이터 없게 해준다고.
		│		
		│		
		│		+ 입력 데이터에 문제가 없는지 자동으로 검사하는 목적
		│		+ 데이터의 수정 / 삭제 가능 여부 검사등을 목적으로 한다.
		│		 -->제약조건을 위배하는 DML구문은 수행이 불가하다.
		│
		──────────────────────────────────────────────────────────────────────────────────		
		──────────────────────────────────────────────────────────────────────────────────		
		──────────────────────────────────────────────────────────────────────────────────		
		
		
		[ 제약조건의 종류 ]
		
		
		
		PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY.
		
		
*/

-- 제약조건 확인
-- USER_CONSTRAINTS : 사용자가 작성한 제약조건을 확인하는 딕셔너리 뷰.
DESC USER_CNSTRAINTS; -- SQUPLUS 에서만 된다 (CMD창)
SELECT * FROM USER_CONSTRAINTS;

/*
CONSTRAINT_NAME : 제약조건명 SYS_COO7300 
CONSTRAINT_TYPE : 계약 타입
ETC...
*/

-- USER_CONS_COLUMNS : 제약조건이 걸려있는 컬럼을 확인하는 딕셔너리 뷰
DESC USER_CONS_COLUMNS; -- SQLPLUS용 
SELECT * FROM USER_CONS_COLUMNS;



/* 1 . NOT NULL 제약조건

		──────────────────────────────────────────────────────────────────────────────────
		
			해당 컬럼에 반드시 값이 기록되어야 하는 경우 사용
			삽입 / 수정 시 NULL 값을 허용하지 않도록 컬럼 레벨에서 제한.

			* 컬럼레벨 : 테이블 생성 시 컬럼을 정의하는 부분에 작성하는 것


*/

CREATE TABLE USER_USED_NN(
		USER_NO NUMBER NOT NULL, -- 사용자 번호 설정(모든 사용자는 사용자 번호가 있어야 한다)
									 --> 컬럼 레벨 제약조건을 설정한 구문	
		USER_ID VARCHAR2(20),
		USER_PWD VARCHAR2(30),
		USER_NAME VARCHAR(30),
		GENDER VARCHAR2(10),
		PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50)
);

INSERT INTO USER_USED_NN
VALUES( 1, 'USER01', 'PASS01', '홍길동', '남자', '010-8888-1123', 'hong123@kh.or.kr');

INSERT INTO USER_USED_NN
VALUES( NULL, 'USER01', 'PASS01', '홍길동', '남자', '010-8888-1123', 'hong123@kh.or.kr');

-- SQL Error [1400] [23000]: ORA-01400: NULL을 ("KH_KSK"."USER_USED_NN"."USER_NO") 안에 삽입할 수 없습니다

-- NULL을 ("KH_KSK"."USER_USER_NN"."USER_NO")안에 삽입할 수 없습니다
--> NOT NULL 제약조건의 위배되어 오류 발생


--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


/*
 
 		2 . UNIQUE 제약조건 
		
		컬럼의 입력값에 대해서 중복을 제한하는 제약조건
		컬럼 레벨에서 설정가능, 테이블 레벨에서 설정 가능

		- 단 UNIQUE 제약조건이 설정된 컬럼에 NULL 값은 중복 삽입 가능.


		* 테이블 레벨 : 테이블 생성 시 컬럼 정의가 끝난 후 마지막에 작성 하는것

		CREATE TABLE USER_USED_NN(
		USER_NO NUMBER NOT NULL, 
									 --> 컬럼 레벨 제약조건을 설정한 구문	
		USER_ID VARCHAR2(20),
		USER_PWD VARCHAR2(30),
		USER_NAME VARCHAR(30),
		GENDER VARCHAR2(10),
		PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50)
									 -- > 테이블 레벨 제약조건 설정하는 부분
    );


		* 제약조건 지정 방법
	
		1) 컬럼레벨    : [CONSTRAINT 제약조건명] 제약조건
		2) 테이블 레벨 : [CONSTRAINT 제약조건명] 제약조건(컬럼명)

		
--─────────────────────────────────────────────────────────────────

	*/

CREATE TABLE USER_USED_UK(
	USER_NO NUMBER,
	--USER_ID VARCHAR2(20) UNIQUE, -- 컬럼레벨에서 유니크 제약조건 건거고, (제약조건을 미지정 하는 방식)
	--USER_PWD VARCHAR2(30) CONSTRAINT USER_PWD_U , UNIQUE, -- 컬럼레벨에서 ( 제약조건명 지정 )
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(20),
	EMAIL VARCHAR2(50),
	/*테이블 레벨*/
	--UNIQUE(USER_ID) -- 테이블 레벨에서 (제약조건명 미지정)해서 하는방법
	CONSTRAINT USER_ID_U UNIQUE(USER_ID) -- 테이블 레벨에서 (제약조건명 지정)해서
);


INSERT INTO USER_USED_UK
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');

--INSERT INTO USER_USED_UK
--VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');
-- ORA - 00001 : 무결성 제약 조건 (KH_KSK.USER_ID_U)에 위배됩니다

INSERT INTO USER_USED_UK
VALUES(1, NULL, 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');
-- 아이디에 NULL 값 삽입 가능 !

INSERT INTO USER_USED_UK
VALUES(1, NULL, 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');
-- 아이디에 NULL 값 중복 삽입 가능 -!


SELECT * FROM USER_USED_UK;


--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────


/*
	UNIQUE 복합키
	두 개 이상의 컬럼을 묶어서 하나의 UNIQUE 제약조건을 설정함
	
		* 복합키 지정은 테이블 레벨만 가능하다! *
		* 복합키는 지정된 모든 컬럼의 값이 같을 때 위배된다 *	
*/

CREATE TABLE USER_USED_UK2(
	USER_NO NUMBER,
	USER_ID VARCHAR2(20),
	USER_PWD VARCHAR2(30),
	USER_NAME VARCHAR(30),
	GENDER VARCHAR2(10),
	PHONE VARCHAR2(20),
	EMAIL VARCHAR2(50),
	-- 테이블 레벨 UNIQUE 복합키 지정해보기
	CONSTRAINT USER_ID_NAME_U UNIQUE(USER_ID, USER_NAME)
);

INSERT INTO USER_USED_UK2
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(2, 'USER02', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(3, 'USER01', 'PASS01', '고길동', '남', '010-1234-4321', 'hong123@kh.or.kr');

INSERT INTO USER_USED_UK2
VALUES(4, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');

--ORA-00001: 무결성 제약 조건(KH_KSK.USER_ID_NAME_U)에 위배됩니다 (USER_ID , USER_NAME - USER_ID_NAME_U - 제약조건명에 의해 위배.)


--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

/*

	3 . PRIMARY KEY(기본키) 제약조건
	
	테이블에서 한 행의 정보를 찾기 위해 사용할 컬럼을 의미한다.
	테이블에 대한 식별자(사용자 번호, 학번..) 역할을 한다.
	
	-NOT NULL + UNIQUE 제약조건의 의미 -> 중복되지 않는 값이 필수로 존재해야한다
	

  	-	한 테이블당 한 개만 설정할 수 있다 
 		-	컬럼 레벨 , 테이블 레벨 둘 다 설정 가능
		-	한 개 컬럼에 설정할 수 있고, 여러개의 컬럼을 묶어서 설정할 수 있다. (테이블 레벨 설정하고 , 거기서 괄호열어서 가능하다는 말ㅎ)

*/

CREATE TABLE USER_USED_PK( -- 프라이머리키는 보통 NUMBER타입으로 식별자 지정하는 편
		USER_NO NUMBER CONSTRAINT USER_NO_PK PRIMARY KEY, -- 컬럼레벨에서 지정, 제약조건명 지정함
		USER_ID VARCHAR2(20),
		USER_PWD VARCHAR2(30),
		USER_NAME VARCHAR(30),
		  GENDER VARCHAR2(10),
		 PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50)
		-- 테이블 레벨
		-- , CONSTRAINT USER_NO_PK PRIMARY KEY(USER._NO)
	);



INSERT INTO USER_USED_PK
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');


INSERT INTO USER_USED_PK
VALUES(1, 'USER02', 'PASS02', '이순신', '남', '010-4321-1234', 'lee123@kh.or.kr');
-- 기본키 중복 오류
--  ORA-00001: 무결성 제약 조건(KH_KSK.USER_ID_U)에 위배됩니다.

INSERT INTO USER_USED_PK
VALUES(NULL, 'USER03', 'PASS03', '유관순', '여', '010-4111-1111', 'yooe123@kh.or.kr');
-- 기본키가 NULL 이므로 오류
-- ORA-01400: NULL을 ("KH_KSK"."USER_USED_PK"."USER_NO") 안에 삽입할 수 없습니다



SELECT * FROM USER_USED_PK; 



--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

/*
 
PRIMARY KEY 복합키 (테이블레벨에서만 설정 가능하다)
*/

CREATE TABLE USER_USED_PK2( -- 프라이머리키는 보통 NUMBER타입으로 식별자 지정하는 편
		USER_NO NUMBER , -- 컬럼레벨에서 지정, 제약조건명 지정함
		USER_ID VARCHAR2(20),
		USER_PWD VARCHAR2(30),
		USER_NAME VARCHAR(30),
		GENDER VARCHAR2(10),
		PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50),
		-- 테이블 레벨
	 CONSTRAINT PK_USERNO_USERID PRIMARY KEY(USER_NO, USER_ID)
	);



INSERT INTO USER_USED_PK2
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'USER02', 'PASS02', '이순신', '남', '010-1234-4321', 'hong123@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(2, 'USER01', 'PASS02', '유관순', '여', '010-1234-4321', 'hong123@kh.or.kr');

INSERT INTO USER_USED_PK2
VALUES(1, 'USER01', 'PASS02', '신사임당', '남', '010-1234-4321', 'hong123@kh.or.kr');
--ORA-00001: 무결성 제약 조건(KH_KSK.PK_USERNO_USERID)에 위배됩니다
-- '회원번호'와 '아이디' 둘 다 중복되었을때만 제약조건 위배 에러 발생

INSERT INTO USER_USED_PK2
VALUES(NULL, 'USER01', 'PASS02', '신사임당', '남', '010-1234-4321', 'hong123@kh.or.kr');
--ORA-01400: NULL을 ("KH_KSK"."USER_USED_PK2"."USER_NO") 안에 삽입할 수 없습니다
-- PRIMARY KEY 는 NULL이 들어갈 수 없음 !

SELECT * FROM USER_USED_PK2;



--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
--────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

/* 
  FOREIGN KEY(외래키/외부키) 제약조건
 			
  참조 (REFERENCES)된 다른 테이블의 컬럼이 제공하는 값만 사용할 수 있다.

	FOREIGN KEY 제약조건에 의해서 테이블간의 관계가 형성됨.

  제공되는 값 외에는 NULL값을 사용할 수 있음.


 *** 컬럼레벨일 경우
	   컬럼명 자료형(크기) [CONSTRAINT 이름] REFERENCES 참조할테이블명 [(참조할 컬럼)][삭제룰]
	
	
 *** 테이블 레벨일 경우
		 [CONSTRAINT 이름] FOREIGN KEY (적용할컬럼명) REFERENCES 참조할테이블명 [(참조할 컬럼)][삭제룰] 	


☆★☆★ 참조될 수 있는 컬럼은 PRIMARY KEY 컬럼과, UNIQUE 지정된 컬럼만 외래키로 사용할 수 있다
		 참조할 테이블의 참조할 컬럼명이 생략되면 , PRIMARY KEY 로 설정된 컬럼이 자동 참조할 컬럼이 됨☆★☆★


*/

-- 부모테이블 / 참조할 테이블 (대상이 되는 테이블)

CREATE TABLE USER_GRADE( 
	GRADE_CODE NUMBER PRIMARY KEY, -- 등급 번호
	GRADE_NAME VARCHAR2(30) NOT NULL -- 등급명
);


INSERT INTO USER_GRADE VALUES(10, '일반회원');

INSERT INTO USER_GRADE VALUES(20, '우수회원');

INSERT INTO USER_GRADE VALUES(30, '특별회원');

SELECT * FROM USER_GRADE;


-- 자식 테이블 (USER_GRADE를 사용할 테이블)
CREATE TABLE USER_USED_FK(
		USER_NO NUMBER PRIMARY KEY, 
		USER_ID VARCHAR2(20)UNIQUE,
		USER_PWD VARCHAR2(30) NOT NULL,
		USER_NAME VARCHAR(30),
		GENDER VARCHAR2(10),
		PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50),
		GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK REFERENCES USER_GRADE /*(GRADE_CODE)*/ -- 컬럼레벨임다.
 																	    -- 컬럼명 미작성 시 USER_GRADE 테이블의 PRIMARY KEY를 자동 참조한다
/*테이블레벨*/
		-- , CONSTRAINT GRADE_CODE_FK FOREIGN KEY (GRADE_CODE) REFERENCES USER_GRADE
													--> FOREIGN KEY 라는 단어는 테이블 레벨에서만 사용 !
				
);


COMMIT;

INSERT INTO USER_USED_FK
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(2, 'USER02', 'PASS02', '이순신', '남', '010-4242-4242', ',lee123@kh.or.kr', 10);

INSERT INTO USER_USED_FK
VALUES(3, 'USER03', 'PASS03', '유관순', '여', '010-9999-3131', ',yoo123@kh.or.kr', 30);

INSERT INTO USER_USED_FK
VALUES(4, 'USER04', 'PASS04', '안중근', '남', '010-3232-1232', ',ahn123@kh.or.kr', NULL);
-- > NULL 사용 가능한 제약조건이 있어서 가능

INSERT INTO USER_USED_FK
VALUES(5, 'USER05', 'PASS05', '윤봉길', '남', '010-2211-3232', ',yoon123@kh.or.kr', 50);
-- ORA-02291: 무결성 제약조건(KH_KSK.GRADE_CODE_FK)이 위배되었습니다- 부모 키가 없습니다
--> 50이라는 값은 USER_GRADE 테이블 GRADE_CODE 컬럼에서 제공하는 값이 아니므로
-- 외래키 제약조건에 위배되어 오류 발생.

SELECT * FROM USER_USED_FK;

COMMIT;


--───────────────────────────────────────────────────────┬
/*																											 │		
	FOREIGN KEY 삭제 옵션																	 │
																												 │
	부모 테이블의 데이터 삭제 시, 자식 테이블의 데이터를   │
	어떤 식으로 처리할지에 대한 내용을 설정할 수 있다.		 │
																												 │	
─────────────────────────────────────────────────────────┘

 1) ON DELETE RESTRICTED (삭제 제한 )로 기본 지정되어 있다
 		FOREIGN KEY 로 지정된 컬럼에서 사용되고 있는 값일 경우
		제공하는 컬럼의 값은 삭제하지 못함.
		
*/

DELETE FROM USER_GRADE WHERE GRADE_CODE = 30; -- 자식테이블 ( 유관순)에서 사용되고 있는 값
--ORA-02292: 무결성 제약조건(KH_KSK.GRADE_CODE_FK)이 위배되었습니다- '자식 레코드가 발견되었습니다'

-- GRADD_CODE 중 20은 외래키로 참조되고 있지 않으므로 삭제 가능.
DELETE FROM USER_GRADE WHERE GRADE_CODE = 20;
SELECT * FROM USER_GRADE; -- 20 삭제됨
ROLLBACK;-- 20 살리려고 롤백, 커밋안해서 됨 ㅎ


/* 
  
 2) ON DELETE SET NULL : 부모 키 삭제 시 자식키를 NULL 로 변경하는 옵션 */
  
 CREATE TABLE USER_GRADE2( 
	GRADE_CODE NUMBER PRIMARY KEY, -- 등급 번호
	GRADE_NAME VARCHAR2(30) NOT NULL -- 등급명
);


INSERT INTO USER_GRADE2 VALUES(10, '일반회원');

INSERT INTO USER_GRADE2 VALUES(20, '우수회원');

INSERT INTO USER_GRADE2 VALUES(30, '특별회원');

SELECT * FROM USER_GRADE;


-- ON DELETE SET NULL 삭제옵션이 적용된 테이블 생성
-- 자식 테이블
CREATE TABLE USER_USED_FK2(
		USER_NO NUMBER PRIMARY KEY, 
		USER_ID VARCHAR2(20)UNIQUE,
		USER_PWD VARCHAR2(30) NOT NULL,
		USER_NAME VARCHAR(30),
		GENDER VARCHAR2(10),
		PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50),
		GRADE_CODE NUMBER CONSTRAINT GRADE_CODE_FK2 REFERENCES USER_GRADE2 ON DELETE SET NULL
																																				/* 삭제옵션 */
);


COMMIT;

INSERT INTO USER_USED_FK2
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr', 10);

INSERT INTO USER_USED_FK2
VALUES(2, 'USER02', 'PASS02', '이순신', '남', '010-4242-4242', ',lee123@kh.or.kr', 10);

INSERT INTO USER_USED_FK2
VALUES(3, 'USER03', 'PASS03', '유관순', '여', '010-9999-3131', ',yoo123@kh.or.kr', 30);

INSERT INTO USER_USED_FK2
VALUES(4, 'USER04', 'PASS04', '안중근', '남', '010-3232-1232', ',ahn123@kh.or.kr', NULL);
-- > NULL 사용 가능한 제약조건이 있어서 가능

COMMIT;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_USED_FK2;

-- 부모테이블인 USER GRADE2 에서 GRADE_CODE = 10; 삭제
--> ON DELETE SET NULL 옵션이 설정되어 있어서 오류 없이 삭제됨
DELETE FROM USER_GRADE2
WHERE GRADE_CODE = 10;

SELECT * FROM USER_GRADE2;
SELECT * FROM USER_USED_FK2; -- 10 을 가지고 있던 자식테이블 값이 NULL이 됨을 확인;



/*
	3 ) ON DELETE CASCADE : 같이죽자. 부모키가 삭제되면 자식키도 삭제된다.
			부모 키 삭제 시, 값을 사용하는 자식 테이블의 컬럼에 해당하는 행이 삭제된다.
*/


CREATE TABLE USER_GRADE3( 
	GRADE_CODE NUMBER PRIMARY KEY, -- 등급 번호
	GRADE_NAME VARCHAR2(30) NOT NULL -- 등급명
);


INSERT INTO USER_GRADE3 VALUES(10, '일반회원');

INSERT INTO USER_GRADE3 VALUES(20, '우수회원');

INSERT INTO USER_GRADE3 VALUES(30, '특별회원');

SELECT * FROM USER_GRADE3;


-- ON DELETE CASCADE 삭제옵션이 적용된 테이블 생성
-- 자식 테이블
CREATE TABLE USER_USED_FK3(
		USER_NO NUMBER PRIMARY KEY, 
		USER_ID VARCHAR2(20)UNIQUE,
		USER_PWD VARCHAR2(30) NOT NULL,
		USER_NAME VARCHAR(30),
		GENDER VARCHAR2(10),
		PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50),
		GRADE_CODE NUMBER,
		/*테이블레벨*/
		CONSTRAINT GRADE_CODE_FK3 FOREIGN KEY(GRADE_CODE) 
		REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
);



-- USER_USED_FK3에 샘플 데이터 삽입
INSERT INTO USER_USED_FK3
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr', 10);

INSERT INTO USER_USED_FK3
VALUES(2, 'USER02', 'PASS02', '이순신', '남', '010-4242-4242', ',lee123@kh.or.kr', 10);

INSERT INTO USER_USED_FK3
VALUES(3, 'USER03', 'PASS03', '유관순', '여', '010-9999-3131', ',yoo123@kh.or.kr', 30);

INSERT INTO USER_USED_FK3
VALUES(4, 'USER04', 'PASS04', '안중근', '남', '010-3232-1232', ',ahn123@kh.or.kr', NULL);

COMMIT;

SELECT * FROM USER_GRADE3;
SELECT * FROM USER_USED_FK3;

-- 부모 테이블인 USER-GRADE3 에서 GRADE_CODE = 10; 삭제
-- ON DELETE CASCADE 옵션이 설정되어 있어서 오류 없이 삭제됨
DELETE 
FROM USER_GRADE3
WHERE GRADE_CODE = 10;

-- ON DELETE CASCADE 옵션으로 인해서 참조키를 사용한 행이 삭제됨을 확인 ~
SELECT * FROM USER_GRADE3;
SELECT * FROM USER_USED_FK3;




--───────────────────────────────────────────────────────┐
/*										                   								 │		
	  5 . CHECK 제약조건                   								 │
																												 │
	컬럼에 기록되는 값에 조건 설정을 할 수 있다            │
	CHECK ( 컬럼명 비교연산자 비교값)                 		 │
																												 │	
─────────────────────────────────────────────────────────┘
*/  
CREATE TABLE USER_USED_CHECK(
		USER_NO NUMBER PRIMARY KEY, 
		USER_ID VARCHAR2(20)UNIQUE,
		USER_PWD VARCHAR2(30) NOT NULL,
		USER_NAME VARCHAR(30),
		GENDER VARCHAR2(10) CONSTRAINT GENDER_CHECK CHECK( GENDER IN('남', '여') ),
		PHONE VARCHAR2(20),
		EMAIL VARCHAR2(50)
);



INSERT INTO USER_USED_CHECK
VALUES(1, 'USER01', 'PASS01', '홍길동', '남', '010-1234-4321', 'hong123@kh.or.kr');

INSERT INTO USER_USED_CHECK
VALUES(2, 'USER02', 'PASS02', '홍길동', '남성', '010-1234-4321', 'hong123@kh.or.kr');
/* GENDER 컬럼에 CHECK 제약조건으로 '남' 또는 '여' 만 기록 가능한데
 '남성'이라고 조건 이외의 값이 들어와 에러 발생. */
-- ORA-02290: 체크 제약조건(KH_KSK.GENDER_CHECK)이 위배되었습니다



--───────────────────────────────────────────────────────────────────────────────────────────────────────────────
--───────────────────────────────────────────────────────────────────────────────────────────────────────────────
--───────────────────────────────────────────────────────────────────────────────────────────────────────────────









