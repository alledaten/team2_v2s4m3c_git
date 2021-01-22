
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

/**********************************/
/* Table Name: SNS�α��� */
/**********************************/
drop table snslogin;

CREATE TABLE snslogin(
    snslogin_no                   NUMBER(10)		 NOT NULL		 PRIMARY KEY,
    snslogin_name                 VARCHAR2(50)		 NOT NULL
);

COMMENT ON TABLE snslogin is 'SNS�α���';
COMMENT ON COLUMN snslogin.snslogin_no is 'SNS���й�ȣ';
COMMENT ON COLUMN snslogin.snslogin_name is 'SNS��';

-- ���
INSERT INTO snslogin(snslogin_no, snslogin_name)
VALUES(1, '�Ϲ�');
INSERT INTO snslogin(snslogin_no, snslogin_name)
VALUES(2, '���̹�');
INSERT INTO snslogin(snslogin_no, snslogin_name)
VALUES(3, 'īī��');

-- ���
SELECT * FROM snslogin ORDER BY snslogin_no ASC;

SNSLOGIN_NO SNSLOGIN_NAME                                     
----------- --------------------------------------------------
          1 Ȩ������ ȸ��                                     
          2 ���� ����                                         
          3 īī�� ����                                       
          4 ���̹� ����       
          
-- ��ȸ
SELECT snslogin_no, snslogin_name
FROM snslogin
WHERE snslogin_no = 3;

-- ����
UPDATE snslogin
SET snslogin_name = '���ȸ��'
WHERE auth_no = 4;

-- ����
DELETE auth
WHERE auth_no = 5;



/**********************************/
/* Table Name: ȸ�� */
/**********************************/
drop table member;

CREATE TABLE member(
    member_no                     NUMBER(10)		 NOT NULL,
    member_id                     VARCHAR2(50)		 NOT NULL,
    member_passwd                 VARCHAR2(50)		 NOT NULL,
    member_nickname               VARCHAR2(50)		 NOT NULL,
    member_name                   VARCHAR2(50)		 NULL ,
    member_isAdult                VARCHAR2(50)		 NOT NULL,
    member_tel                    VARCHAR2(50)		 NOT NULL,
    member_email                  VARCHAR2(100)		 NULL ,
    member_rdate                  DATE		         NOT NULL,
    member_zipcode                VARCHAR2(200)		 NOT NULL,
    member_address1                VARCHAR2(200)		 NOT NULL,
    member_address2                VARCHAR2(200)		 NOT NULL,
    member_profilepic                VARCHAR2(200)		 NULL,
    memberlevel_no                NUMBER(10)		 NOT NULL,
    auth_no                       NUMBER(10)         NOT NULL,
    snslogin_no                   NUMBER(10)		 NOT NULL,
    PRIMARY KEY(member_no),
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
                   member_isAdult, member_tel, member_email, member_rdate, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test', 1234, '����', 'ȫ�浿',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate, '����Ư����', '�߶���', '01.jpg',
        5, 1, 1);

-- ���
SELECT member_no, member_id, member_nickname, member_isAdult, member_rdate, auth_no
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

-- ����
DELETE member
WHERE member_no = 3;

/**********************************/
/* Table Name: �α��α�� */
/**********************************/
drop table login_log;
CREATE TABLE login_log(
    login_log_no                  		NUMBER(30)		 NOT NULL       PRIMARY KEY,
    member_no                     		NUMBER(10)		 NOT NULL ,
    login_log_date                		DATE		     NOT NULL ,
    login_log_ip                  		VARCHAR2(50)	 NOT NULL ,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE login_log is '�α��α��';
COMMENT ON COLUMN login_log.login_log_no is '�α��ι�ȣ';
COMMENT ON COLUMN login_log.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN login_log.login_log_date is '�α����Ͻ�';
COMMENT ON COLUMN login_log.login_log_ip is '�α������';


/**********************************/
/* Table Name: ��� */
/**********************************/
CREATE TABLE "TEAM2"."MEMBERLEVEL" (
    "MEMBERLEVEL_NO"    NUMBER(10)      NOT NULL, 
	"MEMBERLEVEL_NAME"  VARCHAR2(50)    NOT NULL, 
    PRIMARY KEY ("MEMBERLEVEL_NO")
)

   COMMENT ON TABLE MEMBERLEVEL IS '���';
   COMMENT ON COLUMN MEMBERLEVEL.MEMBERLEVEL_NO IS '��� ��ȣ';
   COMMENT ON COLUMN MEMBERLEVEL.MEMBERLEVEL_NAME IS '��� �̸�';



/**********************************/
/* Table Name: ������ */
/**********************************/

CREATE TABLE ADMIN (
    "ADMIN_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"ADMIN_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"ADMIN_PASSWD" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"AUTH_NO" NUMBER(10,0) NOT NULL ENABLE, 
    PRIMARY KEY ("ADMIN_NO")
)

   COMMENT ON COLUMN "TEAM2"."ADMIN"."ADMIN_NO" IS '�����ڹ�ȣ';
   COMMENT ON COLUMN "TEAM2"."ADMIN"."ADMIN_ID" IS '������ID';
   COMMENT ON COLUMN "TEAM2"."ADMIN"."ADMIN_PASSWD" IS '������ ��й�ȣ';
   COMMENT ON COLUMN "TEAM2"."ADMIN"."AUTH_NO" IS '���ѹ�ȣ';
   COMMENT ON TABLE "TEAM2"."ADMIN"  IS '������';


/**********************************/
/* Table Name: ������ �α��� ��� */
/**********************************/

CREATE TABLE ADMIN_LOG (
    "ADMIN_LOG_NO" NUMBER(30,0) NOT NULL ENABLE, 
	"ADMIN_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"ADMIN_LOG_DATE" DATE NOT NULL ENABLE, 
	"ADMIN_LOG_IP" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	 PRIMARY KEY ("ADMIN_LOG_NO")
)

   COMMENT ON TABLE ADMIN_LOG IS '������ �α��α��';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_NO IS '������ �α��� ��ȣ';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_NO" IS '������ ��ȣ';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_DATE" IS '������ �α��� ��¥';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_IP" IS '������ �α��� IP';

/**********************************/
/* Table Name: ���Ѻ� ���� URL */
/**********************************/

CREATE TABLE AUTHURL (
    "AURHURL_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"AUTH_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"URL_NO" NUMBER(10,0), 
	 PRIMARY KEY ("AURHURL_NO")
)

   COMMENT ON COLUMN "TEAM2"."AUTHURL"."AURHURL_NO" IS '���Ѻ� ���� URL ��ȣ';
   COMMENT ON COLUMN "TEAM2"."AUTHURL"."AUTH_NO" IS '���� ��ȣ';
   COMMENT ON COLUMN "TEAM2"."AUTHURL"."URL_NO" IS '���� �ּ� ��ȣ';
   COMMENT ON TABLE "TEAM2"."AUTHURL"  IS '���Ѻ� ���� URL';




