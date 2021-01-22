
/**********************************/
/* Table Name: 권한 */
/**********************************/
drop table auth;

CREATE TABLE auth(
    auth_no            NUMBER(10)		 NOT NULL,
    auth_content       VARCHAR2(50)		 NULL,
    PRIMARY KEY(auth_no)
);

COMMENT ON TABLE auth is '권한';
COMMENT ON COLUMN auth.auth_no is '권한번호';
COMMENT ON COLUMN auth.auth_content is '권한내용';

-- 등록
INSERT INTO auth(auth_no, auth_content)
VALUES(1, '최고관리자');
INSERT INTO auth(auth_no, auth_content)
VALUES(2, '관리자');
INSERT INTO auth(auth_no, auth_content)
VALUES(3, '게시판 관리자');
INSERT INTO auth(auth_no, auth_content)
VALUES(4, '우수회원');
INSERT INTO auth(auth_no, auth_content)
VALUES(5, '일반회원');

-- 목록
SELECT * FROM auth ORDER BY auth_no ASC;

   AUTH_NO AUTH_CONTENT                                      
---------- -----------------------------------
         1 최고관리자                                        
         2 관리자                                            
         3 게시판 관리자                                     
         4 우수회원                                          
         5 일반회원          

-- 조회
SELECT auth_no, auth_content
FROM auth
WHERE auth_no = 3;

-- 수정
UPDATE auth
SET auth_content = '기업회원'
WHERE auth_no = 4;

-- 삭제
DELETE auth
WHERE auth_no = 5;