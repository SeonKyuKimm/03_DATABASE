ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER SEMI2ND IDENTIFIED BY SEMI2ND;

GRANT RESOURCE, CONNECT TO SEMI2ND;

ALTER USER SEMI2ND DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;