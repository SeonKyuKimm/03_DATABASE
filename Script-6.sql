--- 1 . 

SELECT STUDENT_NO 학번, STUDENT_NAME 이름, TO_CHAR(ENTERANCE_DATE, 'YYYY-MM-DD') AS 입학년도
FROM TB_STUDENT
WHERE