DROP TABLE admin;

CREATE TABLE admin (
    admin_no  NUMBER(10,0)      NOT NULL    PRIMARY KEY, 
    admin_id    VARCHAR2(100)   NOT NULL,
    admin_passwd    VARCHAR2(100)   NOT NULL,
	admin_name   VARCHAR2(100)  NOT NULL
);

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.admin_no is '관리자번호';
COMMENT ON COLUMN admin.admin_id is '관리자ID';
COMMENT ON COLUMN admin.admin_passwd is '관리자PW';
COMMENT ON COLUMN admin.admin_name is '관리자이름';

DROP SEQUENCE admin_no_seq;
CREATE SEQUENCE admin_no_SEQ
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999 -- 최대값: 99999999 --> NUMBER(10) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되?? 것을 방지

--등록
INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin1', '1234', '관리자1');

INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin2', '1234', '관리자2');

INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin3', '1234', '관리자3');

INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin4', '1234', '관리자4');

commit;

-- 목록
SELECT *
FROM admin
ORDER BY admin_no ASC;

  ADMIN_NO ADMIN_ID                                                                                             ADMIN_PASSWD                                                                                         ADMIN_NAME                                                                                          
---------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------
         1 admin1                                                                                              1234                                                                                                 관리자1                                                                                             
         2 admin2                                                                                              1234                                                                                                 관리자2                                                                                             
         3 admin3                                                                                              1234                                                                                                 관리자3                                                                                             
         4 admin4                                                                                              1234                                                                                                 관리자4                                                                                             

-- 조회
SELECT admin_no, admin_id, admin_passwd, admin_name
FROM admin
WHERE admin_no = 3;

-- 아이디로 조회
SELECT admin_no, admin_id, admin_passwd, admin_name
FROM admin
WHERE admin_id = 'admin1';

-- 수정
UPDATE admin
SET admin_name = '최고관리자'
WHERE admin_no = 1;

-- 패스워드 체크
SELECT COUNT(*) as passwd_cnt
FROM admin
WHERE admin_no=1 AND admin_passwd='1234'

-- 삭제
DELETE FROM admin
WHERE admin_no=4;

-- 전체삭제
DELETE FROM admin;

-- 중복체크
SELECT COUNT(admin_id) as cnt
FROM admin
WHERE admin_id = 'admin1';

