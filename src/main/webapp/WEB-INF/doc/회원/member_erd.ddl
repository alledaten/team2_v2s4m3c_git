/**********************************/
/* Table Name: ���� */
/**********************************/
CREATE TABLE auth(
		auth_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		auth_content                  		VARCHAR2(10)		 NULL 
);

CREATE SEQUENCE auth_auth_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER auth_auth_no_TRG
BEFORE INSERT ON auth
FOR EACH ROW
BEGIN
IF :NEW.auth_no IS NOT NULL THEN
  SELECT auth_auth_no_SEQ.NEXTVAL INTO :NEW.auth_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE auth is '����';
COMMENT ON COLUMN auth.auth_no is '���ѹ�ȣ';
COMMENT ON COLUMN auth.auth_content is '���ѳ���';


/**********************************/
/* Table Name: SNS�α��� */
/**********************************/
CREATE TABLE snslogin(
		snslogin_no                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		snslogin_name                 		VARCHAR2(50)		 NOT NULL
);

COMMENT ON TABLE snslogin is 'SNS�α���';
COMMENT ON COLUMN snslogin.snslogin_no is 'SNS���й�ȣ';
COMMENT ON COLUMN snslogin.snslogin_name is 'SNS��';


/**********************************/
/* Table Name: ȸ�� */
/**********************************/
CREATE TABLE member(
		member_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		member_id                     		VARCHAR2(50)		 NOT NULL,
		member_passwd                 		VARCHAR2(50)		 NOT NULL,
		member_nickname               		VARCHAR2(50)		 NOT NULL,
		member_name                   		VARCHAR2(50)		 NULL ,
		member_isAdult                		NUMBER(20)		 NOT NULL,
		member_tel                    		INTEGER(20)		 NOT NULL,
		member_email                  		VARCHAR2(100)		 NULL ,
		member_rdate                  		DATE		 NOT NULL,
		member_address                		VARCHAR2(200)		 NOT NULL,
		auth_no                       		NUMBER(10)		 NULL ,
		snslogin_no                   		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (auth_no) REFERENCES auth (auth_no),
  FOREIGN KEY (snslogin_no) REFERENCES snslogin (snslogin_no)
);

CREATE SEQUENCE member_member_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER member_member_no_TRG
BEFORE INSERT ON member
FOR EACH ROW
BEGIN
IF :NEW.member_no IS NOT NULL THEN
  SELECT member_member_no_SEQ.NEXTVAL INTO :NEW.member_no FROM DUAL;
END IF;
END;

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
COMMENT ON COLUMN member.member_address is '������';
COMMENT ON COLUMN member.auth_no is '���';
COMMENT ON COLUMN member.snslogin_no is 'SNS�α���';


/**********************************/
/* Table Name: ��ǰ ���ã�� */
/**********************************/
CREATE TABLE myfavorite(
		fav_no                        		INTEGER(10)		 NOT NULL		 PRIMARY KEY,
		member_no                     		INTEGER(10)		 NOT NULL,
		product_no                    		INTEGER(30)		 NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

CREATE SEQUENCE myfavorite_fav_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER myfavorite_fav_no_TRG
BEFORE INSERT ON myfavorite
FOR EACH ROW
BEGIN
IF :NEW.fav_no IS NOT NULL THEN
  SELECT myfavorite_fav_no_SEQ.NEXTVAL INTO :NEW.fav_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE myfavorite is '��ǰ ���ã��';
COMMENT ON COLUMN myfavorite.fav_no is '���ã���ȣ';
COMMENT ON COLUMN myfavorite.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN myfavorite.product_no is '��ǰ��ȣ';


/**********************************/
/* Table Name: �� ��õ�׸�_��ǰ */
/**********************************/
CREATE TABLE myrecomend_product(
		myrecomend_no                 		INTEGER(10)		 NOT NULL		 PRIMARY KEY,
		member_no                     		INTEGER(10)		 NOT NULL,
		product_no                    		INTEGER(30)		 NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

CREATE SEQUENCE myrecomend_product_myrecomend_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER myrecomend_product_myrecomend_no_TRG
BEFORE INSERT ON myrecomend_product
FOR EACH ROW
BEGIN
IF :NEW.myrecomend_no IS NOT NULL THEN
  SELECT myrecomend_product_myrecomend_no_SEQ.NEXTVAL INTO :NEW.myrecomend_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE myrecomend_product is '�� ��õ�׸�_��ǰ';
COMMENT ON COLUMN myrecomend_product.myrecomend_no is '���� ��õ�� ��ǰ ������ȣ';
COMMENT ON COLUMN myrecomend_product.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN myrecomend_product.product_no is '��ǰ��ȣ';


/**********************************/
/* Table Name: �α��α�� */
/**********************************/
CREATE TABLE login_log(
		login_log_no                  		NUMBER(100)		 NULL ,
		member_no                     		NUMBER(10)		 NULL ,
		login_log_date                		DATE		 NULL ,
		login_log_ip                  		VARCHAR2(50)		 NULL ,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE login_log is '�α��α��';
COMMENT ON COLUMN login_log.login_log_no is '�α��ι�ȣ';
COMMENT ON COLUMN login_log.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN login_log.login_log_date is '�α����Ͻ�';
COMMENT ON COLUMN login_log.login_log_ip is '�α������';


