
/**********************************/
/* Table Name: ���� */
/**********************************/
drop table auth;

CREATE TABLE auth(
    auth_no            NUMBER(10)		 NOT NULL,
    auth_content       VARCHAR2(50)		 NULL,
    PRIMARY KEY(auth_no)
);

COMMENT ON TABLE auth is '����';
COMMENT ON COLUMN auth.auth_no is '���ѹ�ȣ';
COMMENT ON COLUMN auth.auth_content is '���ѳ���';

-- ���
INSERT INTO auth(auth_no, auth_content)
VALUES(1, '�ְ������');
INSERT INTO auth(auth_no, auth_content)
VALUES(2, '������');
INSERT INTO auth(auth_no, auth_content)
VALUES(3, '�Խ��� ������');
INSERT INTO auth(auth_no, auth_content)
VALUES(4, '���ȸ��');
INSERT INTO auth(auth_no, auth_content)
VALUES(5, '�Ϲ�ȸ��');

-- ���
SELECT * FROM auth ORDER BY auth_no ASC;

   AUTH_NO AUTH_CONTENT                                      
---------- -----------------------------------
         1 �ְ������                                        
         2 ������                                            
         3 �Խ��� ������                                     
         4 ���ȸ��                                          
         5 �Ϲ�ȸ��          

-- ��ȸ
SELECT auth_no, auth_content
FROM auth
WHERE auth_no = 3;

-- ����
UPDATE auth
SET auth_content = '���ȸ��'
WHERE auth_no = 4;

-- ����
DELETE auth
WHERE auth_no = 5;