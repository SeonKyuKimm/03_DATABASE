
-- 한 줄 주석

/*범위 주석
 * 
 * */ 

-- 11G 버전 이전의 문법을 사용 가능하도록 함
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- CTRL + ENTER : 선택한 SQL 수행
-- CTRL + S : 자바와 같이 현재 수행 저장

-- 사용자 계정 생성
CREATE USER board_project IDENTIFIED BY board1234;


-- 사용자 계정에 권한 부여
GRANT RESOURCE, CONNECT TO board_project;


--객체가 생성될 수 있는 공간 할당량 지정
ALTER USER board_project DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;