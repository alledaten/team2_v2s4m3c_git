DROP TABLE admin;

CREATE TABLE admin (
    admin_no  NUMBER(10,0)      NOT NULL    PRIMARY KEY, 
    admin_id    VARCHAR2(100)   NOT NULL,
    admin_passwd    VARCHAR2(100)   NOT NULL,
	admin_name   VARCHAR2(100)  NOT NULL
);

COMMENT ON TABLE admin is '������';
COMMENT ON COLUMN admin.admin_no is '�����ڹ�ȣ';
COMMENT ON COLUMN admin.admin_id is '������ID';
COMMENT ON COLUMN admin.admin_passwd is '������PW';
COMMENT ON COLUMN admin.admin_name is '�������̸�';

DROP SEQUENCE admin_no_seq;
CREATE SEQUENCE admin_no_SEQ
  START WITH 1           -- ���� ��ȣ
  INCREMENT BY 1       -- ������
  MAXVALUE 9999999999 -- �ִ밪: 99999999 --> NUMBER(10) ����
  CACHE 2                  -- 2���� �޸𸮿����� ���
  NOCYCLE;                -- �ٽ� 1���� ������?? ���� ����

--���
INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin1', '1234', '������1');

INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin2', '1234', '������2');

INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin3', '1234', '������3');

INSERT INTO admin (admin_no, admin_id, admin_passwd, admin_name)
VALUES (admin_no_seq.nextval, 'admin4', '1234', '������4');

commit;

-- ���
SELECT *
FROM admin
ORDER BY admin_no ASC;

  ADMIN_NO ADMIN_ID                                                                                             ADMIN_PASSWD                                                                                         ADMIN_NAME                                                                                          
---------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------
         1 admin1                                                                                              1234                                                                                                 ������1                                                                                             
         2 admin2                                                                                              1234                                                                                                 ������2                                                                                             
         3 admin3                                                                                              1234                                                                                                 ������3                                                                                             
         4 admin4                                                                                              1234                                                                                                 ������4                                                                                             

-- ��ȸ
SELECT admin_no, admin_id, admin_passwd, admin_name
FROM admin
WHERE admin_no = 3;

-- ���̵�� ��ȸ
SELECT admin_no, admin_id, admin_passwd, admin_name
FROM admin
WHERE admin_id = 'admin1';

-- ����
UPDATE admin
SET admin_name = '�ְ������'
WHERE admin_no = 1;

-- �н����� üũ
SELECT COUNT(*) as passwd_cnt
FROM admin
WHERE admin_no=1 AND admin_passwd='1234'

-- ����
DELETE FROM admin
WHERE admin_no=4;

-- ��ü����
DELETE FROM admin;

-- �ߺ�üũ
SELECT COUNT(admin_id) as cnt
FROM admin
WHERE admin_id = 'admin1';

