-- TCL ( Transaction Control Language) : 트랜젝션 제어 언어
/*
  

* * COMMIT(트랜젝션 종류 후 저장) 

* * ROLLBACK(트랜젝션 취소) 

* * SAVEPOINT(임시저장)



 - DML : 데이터 조작 언어로 데이터의 삽입, 수정, 삭제
 	-> 트랜젝션은 DML 과 관련되어 있다.
*/

/* TRANSACTION이란 ?
 *   
 *    - [데이터베이스의 논리적 연산 단위]
 * 		- 데이터 변경사항을 묶어서 하나의 트랜젝션에 담아 처리함.
 * 		- 트랜젝션의 대상이 되는 데이터 변경 사항 : INSERT, UPDATE, DELETE, MERGE
 * 
 * INSERT 수행 ────────────────────────────────────────────────────────────────> DB에 반영(x)
 * 
 * INSERT 수행 ─────────────────────> 트랜젝션에 추가 ────────> COMMIT ────────> DB에 반영됨(o)
 * 
 * INSERT 10번 수행 ──────> 1개 트랜젝션에 10개 추가 ─────────> ROLLBACK ──────> DB반영 안됨(X)
 * 
 * 
 * 1 ) COMMIT : 메모리 버퍼(트랜젝션)에 임시 저장된 데이터 변경 사항을 DB에 반영
 * 
 * 2 ) ROLLBACK : 메모리버퍼 ( 트랜젝션)에 임시 저장된 데이터 변경 사항을 삭제하고
 * 								마지막 COMMIT 상태로 되돌아감( DB에 변경 내용 반영 X)
 * 
 * 3) SAVEPOINT : 메모리버퍼 (트랜젝션)에 저장 지점을 정의하여
 * 								ROLLBACK 수행 시 전체 작업을 삭제하는 것이 아닌
 * 								저장 지점까지만 일부 ROLLBACK
 * 
 * [ SAVEPOINT ] 사용법
 * 
 * 
 * ....(대충 구문을 작성했다는 닷닷닷)
 * SAVVEPOINT "포인트명1";
 * 
 * 
 *  ....(대충 구문을 작성했다는 닷닷닷)
 * SAVVEPOINT "포인트명2";
 * 
 * 
 *  ....(대충 구문을 작성했다는 닷닷닷)
 * ROLLBACK TO "포인트명1"; -- 포인트 1 지점 이후의 데이터 변경사항 삭제
 */


-- 새로운 데이터 INSERT in DEPARTMENT2
SELECT * FROM DEPARTMENT2;


INSERT INTO DEPARTMENT2 VALUES('T1', '개발1팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T2', '개발2팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T3', '개발3팀', 'L2');



-- INSERT 확인
SELECT * FROM DEPARTMENT2;


--> DB에 반영된것처럼 보이긴 하지만, 실제로 아직 DB에 반영된것은 아니다
--> SQL 수행 시 트랜젝션 내용도 포함해서 수행됨. 

-- ROLLBACK 후 확인
ROLLBACK;
SELECT * FROM DEPARTMENT2;

-- COMMIT 후 롤백이 되는지 확인
INSERT INTO DEPARTMENT2 VALUES('T1', '개발1팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T2', '개발2팀', 'L2');
INSERT INTO DEPARTMENT2 VALUES('T3', '개발3팀', 'L2');

SELECT * FROM DEPARTMENT2;

COMMIT;

ROLLBACK;

SELECT * FROM DEPARTMENT2; -- ROLLBACK 안된다. DB에 이미 반영되었음


--------------------------------------------------------------------------------------------------------------------------------------

-- SAVEPOINT 확인

INSERT INTO DEPARTMENT2 VALUES('T4', '개발4팀', 'L2');
SAVEPOINT "SP1"; -- SAVEPOINT 지정

INSERT INTO DEPARTMENT2 VALUES('T5', '개발5팀', 'L2');
SAVEPOINT "SP2"; -- SAVEPOINT 지정

INSERT INTO DEPARTMENT2 VALUES('T6', '개발6팀', 'L2');
SAVEPOINT "SP3"; -- SAVEPOINT 지정

ROLLBACK TO "SP1";

SELECT * FROM DEPARTMENT2; 


-- ROLLBACK TO "SP1" 구문 수행 시 SP2, SP3도 삭제됨.


INSERT INTO DEPARTMENT2 VALUES('T5', '개발5팀', 'L2');
SAVEPOINT "SP2"; -- SAVEPOINT 지정

INSERT INTO DEPARTMENT2 VALUES('T6', '개발6팀', 'L2');
SAVEPOINT "SP3"; -- SAVEPOINT 지정

SELECT * FROM DEPARTMENT2;


-- 개발팀 전체 삭제해보기

DELETE FROM DEPARTMENT2
WHERE DEPT_ID LIKE 'T%';


-- SP2 지점까지 롤백
ROLLBACK TO "SP2";
SELECT * FROM DEPARTMENT2; -- 개발 6팀만 롤백

-- SP1 지점까지 롤백
ROLLBACK TO "SP1";
SELECT * FROM DEPARTMENT2;-- 개발 5팀만 롤백

-- 롤백 수행
ROLLBACK;
SELECT * FROM DEPARTMENT2;
-- 개발 1 2 3 팀만 남음

