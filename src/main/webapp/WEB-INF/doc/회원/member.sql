-- ���̺� ����
-- member �������� FK�� ����� ���̺� ���� �����մϴ�.
DROP TABLE auth;
DROP TABLE memberlevel;
DROP TABLE snslogin;
DROP TABLE member;

/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
    member_no                     NUMBER(10)		NOT NULL    PRIMARY KEY,
    member_id                     VARCHAR2(50)		NOT NULL,
    member_passwd                 VARCHAR2(50)		NOT NULL,
    member_nickname               VARCHAR2(50)		NOT NULL,
    member_name                   VARCHAR2(50)		NOT NULL,
    member_isAdult                VARCHAR2(50)		NOT NULL,
    member_tel                    VARCHAR2(50)		NOT NULL,
    member_email                  VARCHAR2(100)		NULL,
    member_rdate                  DATE		        NOT NULL,
    member_zipcode                VARCHAR2(200)		NOT NULL,
    member_address1               VARCHAR2(200)     NOT NULL,
    member_address2               VARCHAR2(200)     NOT NULL,
    member_profilepic             VARCHAR2(200)     NULL,
    member_profilethumb           VARCHAR2(200)     NULL,
    memberlevel_no                NUMBER(10)		NOT NULL,
    auth_no                       NUMBER(10)        NOT NULL,
    snslogin_no                   NUMBER(10)		NOT NULL,
    FOREIGN KEY (auth_no) REFERENCES auth (auth_no),
    FOREIGN KEY (memberlevel_no) REFERENCES memberlevel (memberlevel_no),
    FOREIGN KEY (snslogin_no) REFERENCES snslogin (snslogin_no)
);

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN member.member_id is 'ID';
COMMENT ON COLUMN member.member_passwd is '��й�ȣ';
COMMENT ON COLUMN member.member_nickname is '�г���';
COMMENT ON COLUMN member.member_name is '�̸�';
COMMENT ON COLUMN member.member_isAdult is '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN member.member_tel is '��ȭ��ȣ';
COMMENT ON COLUMN member.member_email is '�̸���';
COMMENT ON COLUMN member.member_rdate is '������';
COMMENT ON COLUMN member.member_zipcode is '�����ȣ';
COMMENT ON COLUMN member.member_address1 is '�ּ�1';
COMMENT ON COLUMN member.member_address2 is '�ּ�2';
COMMENT ON COLUMN member.member_profilepic is '�����ʻ���';
COMMENT ON COLUMN member.member_profilepic is '�����ʼ�����';
COMMENT ON COLUMN member.memberlevel_no is '���';
COMMENT ON COLUMN member.auth_no is '����';
COMMENT ON COLUMN member.snslogin_no is 'SNS�α���';

DROP SEQUENCE member_no_seq;
CREATE SEQUENCE member_no_SEQ
  START WITH 1           -- ���� ��ȣ
  INCREMENT BY 1       -- ������
  MAXVALUE 9999999999 -- �ִ밪: 99999999 --> NUMBER(10) ����
  CACHE 2                  -- 2���� �޸𸮿����� ���
  NOCYCLE;                -- �ٽ� 1���� ������?? ���� ����

-- ���
INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test1', 1234, '����', 'ȫ�浿',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate,
        '01234', '����Ư����', '�߶���', '01.jpg',
        1, 1, 1);

INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test2', 1234, '����', '�̵�',
        '9001011234567', '01012345678', 'korea@gmail.com', sysdate,
        '01234', '����Ư����', '�溹��', '02.jpg',
        1, 1, 1);

INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test3', 1234, '���۸�', 'Ŭ�� ��Ʈ',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate,
        '01234', '����Ư����', '�߶���', '03.jpg',
        1, 1, 1);

INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'user1', 1234, '��Ʈ��', '��罺 ����',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate,
        '01234', '����Ư����', '�߶���', '03.jpg',
        1, 1, 1);
        
commit;

-- ���
SELECT member_no, member_id, member_nickname, member_isAdult, member_rdate, auth_no, member_profilepic
FROM member
ORDER BY member_no ASC;

SELECT *
FROM member
ORDER BY member_no ASC;

-- ����
SELECT l.memberlevel_no as level_no, l.memberlevel_name as level_name,
       m.member_no, m.member_id, m.member_name, m.member_nickname, m.member_profilethumb, m.memberlevel_no
FROM memberlevel l, member m
WHERE m.memberlevel_no = l.memberlevel_no
ORDER BY l.memberlevel_no ASC, m.member_no ASC;

SELECT l.memberlevel_no as level_no, l.memberlevel_name as level_name,
        m.member_no, m.member_name
FROM memberlevel l, member m
WHERE m.memberlevel_no = l.memberlevel_no
ORDER BY l.memberlevel_no ASC, m.member_no ASC;

-- ����¡
SELECT member_id, member_name, r
FROM(
         SELECT member_no, member_id, member_name, rownum as r
         FROM (
                   SELECT *
                   FROM member
                   ORDER BY member_no ASC
         )
)
WHERE r>=1 AND r <=3;


-- ��ȸ
SELECT member_no, member_id, member_passwd, member_nickname, member_name, 
       member_isAdult, member_tel, member_email, member_rdate, member_address, auth_no, snslogin_no
FROM member
WHERE member_no = 1;

-- IDüũ
SELECT COUNT(member_id) as cnt
FROM member
WHERE member_id = 'test3';

-- ����
UPDATE member
SET member_nickname = '���'
WHERE member_no = 1;

UPDATE member
SET member_passwd = '1234',
    member_nickname = '����',
    member_name = '�ٱ浿',
    member_isAdult = '1234561234567',
    member_tel = '01022225555',
    member_email = 'email@email.com', 
    member_zipcode = '01234',
    member_address1 = '����Ư����',
    member_address2 = '��걸',
    member_profilepic = '01.jpg',
    memberlevel_no = 1,
    auth_no = 1
WHERE member_no=1;


-- �н����� ����
1) �н����� �˻�
SELECT COUNT(memberno) as cnt
FROM member
WHERE memberno=3 AND passwd='1234';
 
2) �н����� ����
UPDATE member
SET passwd='0000'
WHERE memberno=1;

COMMIT;

-- ����
1) ��� ����
DELETE FROM member;
 
2) Ư�� ȸ�� ����
DELETE FROM member
WHERE memberno=10;

COMMIT;
 
-- �α���
SELECT COUNT(member_no) as cnt
FROM member
WHERE member_id='user1' AND member_passwd='1234';

 cnt
 ---
   1


-- id�� �̿��� ȸ�� ���� ��ȸ
SELECT member_no, member_id, member_passwd, member_name, member_tel, member_zipcode, member_address1, member_address2
FROM member
WHERE member_id = 'user1';

 MEMBER_NO MEMBER_ID                                          MEMBER_PASSWD                                      MEMBER_NAME                                        MEMBER_TEL                                         MEMBER_ZIPCODE                                                                                                                                                                                           MEMBER_ADDRESS1                                                                                                                                                                                          MEMBER_ADDRESS2                                                                                                                                                                                         
---------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         4 user1                                              1234                                               ��罺 ����                                        01012345678                                        01234                                                                                                                                                                                                    ����Ư����                                                                                                                                                                                               �߶���                                                                                                                                                                                                  

