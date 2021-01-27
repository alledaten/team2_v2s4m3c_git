DROP TABLE AUTH;

CREATE TABLE AUTH (
    AUTH_NO           NUMBER(10,0)  PRIMARY KEY,
	AUTH_CONTENT      VARCHAR2(50 BYTE)
);

COMMENT ON TABLE AUTH  IS '권한';
COMMENT ON COLUMN AUTH.AUTH_NO IS '권한 번호';
COMMENT ON COLUMN AUTH.AUTH_CONTENT IS '권한 이름';

-- 등록
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (1,'최고관리');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (2,'게시판 관리');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (3,'판매자');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (4,'구매');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (5,'글 등록');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (6,'글 열람');

-- 목록
SELECT *
FROM auth
ORDER BY auth_no ASC;

   AUTH_NO AUTH_CONTENT                                      
---------- --------------------
         1 최고관리                                          
         2 게시판 관리                                       
         3 판매자
         4 구매                                              
         5 글 등록                                           
         6 글 열람      

-- 조회
SELECT auth_no, auth_content
FROM auth
WHERE auth_no = 3;

-- 수정
UPDATE auth
SET auth_content = '판매'
WHERE auth_no = 3;

-- 삭제
DELETE FROM auth
WHERE auth_no=6;
