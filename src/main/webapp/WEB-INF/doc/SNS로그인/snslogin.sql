DROP TABLE snslogin;

CREATE TABLE snslogin (
    snslogin_no           NUMBER(10,0)  PRIMARY KEY,
	snslogin_name      VARCHAR2(50 BYTE)
);

COMMENT ON TABLE snslogin IS 'SNS�α���';
COMMENT ON COLUMN snslogin.snslogin_no is 'SNS���й�ȣ';
COMMENT ON COLUMN snslogin.snslogin_name is 'SNS��';

-- ���
Insert into snslogin (snslogin_no, snslogin_name) values (1, '�̸���');
Insert into snslogin (snslogin_no, snslogin_name) values (2, '����īī��');
Insert into snslogin (snslogin_no, snslogin_name) values (3, '���̹�');
Insert into snslogin (snslogin_no, snslogin_name) values (4, '����');

-- ���
SELECT *
FROM snslogin
ORDER BY snslogin_no ASC;

SNSLOGIN_NO SNSLOGIN_NAME                                     
----------- --------------------------------------------------
          1 �̸���                                            
          2 ����īī��                                        
          3 ���̹�                                            
          4 ����                                              

-- ��ȸ
SELECT snslogin_no, snslogin_name
FROM snslogin
WHERE snslogin_no = 3;

-- ����
UPDATE snslogin
SET snslogin_name = '�Ǹ�'
WHERE snslogin_no = 3;

-- ����
DELETE FROM snslogin
WHERE snslogin_no=4;
