DROP TABLE AUTH;

CREATE TABLE AUTH (
    AUTH_NO           NUMBER(10,0)  PRIMARY KEY,
	AUTH_CONTENT      VARCHAR2(50 BYTE)
);

COMMENT ON TABLE AUTH  IS '����';
COMMENT ON COLUMN AUTH.AUTH_NO IS '���� ��ȣ';
COMMENT ON COLUMN AUTH.AUTH_CONTENT IS '���� �̸�';

-- ���
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (1,'�ְ����');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (2,'�Խ��� ����');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (3,'�Ǹ���');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (4,'����');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (5,'�� ���');
Insert into AUTH (AUTH_NO,AUTH_CONTENT) values (6,'�� ����');

-- ���
SELECT *
FROM auth
ORDER BY auth_no ASC;

   AUTH_NO AUTH_CONTENT                                      
---------- --------------------
         1 �ְ����                                          
         2 �Խ��� ����                                       
         3 �Ǹ���
         4 ����                                              
         5 �� ���                                           
         6 �� ����      

-- ��ȸ
SELECT auth_no, auth_content
FROM auth
WHERE auth_no = 3;

-- ����
UPDATE auth
SET auth_content = '�Ǹ�'
WHERE auth_no = 3;

-- ����
DELETE FROM auth
WHERE auth_no=6;
