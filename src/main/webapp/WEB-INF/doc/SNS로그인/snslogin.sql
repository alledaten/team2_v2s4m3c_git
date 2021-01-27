DROP TABLE snslogin;

CREATE TABLE snslogin (
    snslogin_no           NUMBER(10,0)  PRIMARY KEY,
	snslogin_name      VARCHAR2(50 BYTE)
);

COMMENT ON TABLE snslogin IS 'SNS로그인';
COMMENT ON COLUMN snslogin.snslogin_no is 'SNS구분번호';
COMMENT ON COLUMN snslogin.snslogin_name is 'SNS명';

-- 등록
Insert into snslogin (snslogin_no, snslogin_name) values (1, '이메일');
Insert into snslogin (snslogin_no, snslogin_name) values (2, '다음카카오');
Insert into snslogin (snslogin_no, snslogin_name) values (3, '네이버');
Insert into snslogin (snslogin_no, snslogin_name) values (4, '구글');

-- 목록
SELECT *
FROM snslogin
ORDER BY snslogin_no ASC;

SNSLOGIN_NO SNSLOGIN_NAME                                     
----------- --------------------------------------------------
          1 이메일                                            
          2 다음카카오                                        
          3 네이버                                            
          4 구글                                              

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
