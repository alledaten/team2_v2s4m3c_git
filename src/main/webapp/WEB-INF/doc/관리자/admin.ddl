DROP TABLE admin_log CASCADE CONSTRAINTS;
DROP TABLE admin CASCADE CONSTRAINTS;
DROP TABLE authurl CASCADE CONSTRAINTS;
DROP TABLE url CASCADE CONSTRAINTS;
DROP TABLE login_log CASCADE CONSTRAINTS;
DROP TABLE myrecomend_product CASCADE CONSTRAINTS;
DROP TABLE myfavorite CASCADE CONSTRAINTS;
DROP TABLE member CASCADE CONSTRAINTS;
DROP TABLE memberlevel CASCADE CONSTRAINTS;
DROP TABLE snslogin CASCADE CONSTRAINTS;
DROP TABLE auth CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 권한 */
/**********************************/
CREATE TABLE auth(
		auth_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		auth_content                  		VARCHAR2(10)		 NULL 
);

COMMENT ON TABLE auth is '권한';
COMMENT ON COLUMN auth.auth_no is '권한번호';
COMMENT ON COLUMN auth.auth_content is '권한내용';


/**********************************/
/* Table Name: SNS로그인 */
/**********************************/
CREATE TABLE snslogin(
		snslogin_no                   		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		snslogin_name                 		VARCHAR2(50)		 NOT NULL
);

DROP SEQUENCE snslogin_snslogin_no_SEQ;

CREATE SEQUENCE snslogin_snslogin_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER snslogin_snslogin_no_TRG
BEFORE INSERT ON snslogin
FOR EACH ROW
BEGIN
IF :NEW.snslogin_no IS NOT NULL THEN
  SELECT snslogin_snslogin_no_SEQ.NEXTVAL INTO :NEW.snslogin_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE snslogin is 'SNS로그인';
COMMENT ON COLUMN snslogin.snslogin_no is 'SNS구분번호';
COMMENT ON COLUMN snslogin.snslogin_name is 'SNS명';


/**********************************/
/* Table Name: 등급 */
/**********************************/
CREATE TABLE memberlevel(
		memberlevel_no                		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		member_name                   		VARCHAR2(50)		 NOT NULL
);

COMMENT ON TABLE memberlevel is '등급';
COMMENT ON COLUMN memberlevel.memberlevel_no is '등급 번호';
COMMENT ON COLUMN memberlevel.member_name is '등급 이름';

-- 조회
SELECT * FROM MEMBERLEVEL;

/**********************************/
/* Table Name: 회원 */
/**********************************/
CREATE TABLE member(
		member_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		member_id                     		VARCHAR2(50)		 NOT NULL,
		member_passwd                 		VARCHAR2(50)		 NOT NULL,
		member_nickname               		VARCHAR2(50)		 NOT NULL,
		member_name                   		VARCHAR2(50)		 NULL ,
		member_isAdult                		NUMBER(20)		 NOT NULL,
		member_tel                    		NUMBER(20)		 NOT NULL,
		member_email                  		VARCHAR2(100)		 NULL ,
		member_rdate                  		DATE		 NOT NULL,
		member_address1               		VARCHAR2(200)		 NOT NULL,
		member_address2               		VARCHAR2(200)		 NULL ,
		member_profilepic             		VARCHAR2(50)		 NULL ,
		member_profilethumb           		VARCHAR2(50)		 NULL ,
		memberlevel_no                		INTEGER(10)		 NULL ,
		auth_no                       		NUMBER(10)		 NULL ,
		snslogin_no                   		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (auth_no) REFERENCES auth (auth_no),
  FOREIGN KEY (snslogin_no) REFERENCES snslogin (snslogin_no),
  FOREIGN KEY (memberlevel_no) REFERENCES memberlevel (memberlevel_no)
);

DROP SEQUENCE member_member_no_SEQ;

CREATE SEQUENCE member_member_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER member_member_no_TRG
BEFORE INSERT ON member
FOR EACH ROW
BEGIN
IF :NEW.member_no IS NOT NULL THEN
  SELECT member_member_no_SEQ.NEXTVAL INTO :NEW.member_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.member_no is '회원번호';
COMMENT ON COLUMN member.member_id is 'ID';
COMMENT ON COLUMN member.member_passwd is '비밀번호';
COMMENT ON COLUMN member.member_nickname is '닉네임';
COMMENT ON COLUMN member.member_name is '이름';
COMMENT ON COLUMN member.member_isAdult is '주민등록번호';
COMMENT ON COLUMN member.member_tel is '전화번호';
COMMENT ON COLUMN member.member_email is '이메일';
COMMENT ON COLUMN member.member_rdate is '가입일';
COMMENT ON COLUMN member.member_address1 is '주소1';
COMMENT ON COLUMN member.member_address2 is '주소2';
COMMENT ON COLUMN member.member_profilepic is '프로필사진';
COMMENT ON COLUMN member.member_profilethumb is '프로필 섬네일';
COMMENT ON COLUMN member.memberlevel_no is '등급';
COMMENT ON COLUMN member.auth_no is '권한';
COMMENT ON COLUMN member.snslogin_no is 'SNS로그인';


/**********************************/
/* Table Name: 상품 즐겨찾기 */
/**********************************/
CREATE TABLE myfavorite(
		fav_no                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		member_no                     		NUMBER(10)		 NOT NULL,
		product_no                    		NUMBER(30)		 NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

DROP SEQUENCE myfavorite_fav_no_SEQ;

CREATE SEQUENCE myfavorite_fav_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER myfavorite_fav_no_TRG
BEFORE INSERT ON myfavorite
FOR EACH ROW
BEGIN
IF :NEW.fav_no IS NOT NULL THEN
  SELECT myfavorite_fav_no_SEQ.NEXTVAL INTO :NEW.fav_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE myfavorite is '상품 즐겨찾기';
COMMENT ON COLUMN myfavorite.fav_no is '즐겨찾기번호';
COMMENT ON COLUMN myfavorite.member_no is '회원번호';
COMMENT ON COLUMN myfavorite.product_no is '상품번호';


/**********************************/
/* Table Name: 내 추천항목_제품 */
/**********************************/
CREATE TABLE myrecomend_product(
		myrecomend_no                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		member_no                     		NUMBER(10)		 NOT NULL,
		product_no                    		NUMBER(30)		 NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

DROP SEQUENCE myrecomend_product_myrecomend_no_SEQ;

CREATE SEQUENCE myrecomend_product_myrecomend_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER myrecomend_product_myrecomend_no_TRG
BEFORE INSERT ON myrecomend_product
FOR EACH ROW
BEGIN
IF :NEW.myrecomend_no IS NOT NULL THEN
  SELECT myrecomend_product_myrecomend_no_SEQ.NEXTVAL INTO :NEW.myrecomend_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE myrecomend_product is '내 추천항목_제품';
COMMENT ON COLUMN myrecomend_product.myrecomend_no is '내가 추천한 제품 고유번호';
COMMENT ON COLUMN myrecomend_product.member_no is '회원번호';
COMMENT ON COLUMN myrecomend_product.product_no is '상품번호';


/**********************************/
/* Table Name: 로그인기록 */
/**********************************/
CREATE TABLE login_log(
		login_log_no                  		NUMBER(30)		 NOT NULL		 PRIMARY KEY,
		member_no                     		NUMBER(10)		 NOT NULL,
		login_log_date                		DATE		 NOT NULL,
		login_log_ip                  		VARCHAR2(50)		 NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

DROP SEQUENCE login_log_login_log_no_SEQ;

CREATE SEQUENCE login_log_login_log_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER login_log_login_log_no_TRG
BEFORE INSERT ON login_log
FOR EACH ROW
BEGIN
IF :NEW.login_log_no IS NOT NULL THEN
  SELECT login_log_login_log_no_SEQ.NEXTVAL INTO :NEW.login_log_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE login_log is '로그인기록';
COMMENT ON COLUMN login_log.login_log_no is '로그인번호';
COMMENT ON COLUMN login_log.member_no is '회원번호';
COMMENT ON COLUMN login_log.login_log_date is '로그인일시';
COMMENT ON COLUMN login_log.login_log_ip is '로그인장소';


/**********************************/
/* Table Name: 접속 주소 */
/**********************************/
CREATE TABLE url(
		url_no                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		authurl_no                    		NUMBER(10)		 NOT NULL
);

DROP SEQUENCE url_url_no_SEQ;

CREATE SEQUENCE url_url_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER url_url_no_TRG
BEFORE INSERT ON url
FOR EACH ROW
BEGIN
IF :NEW.url_no IS NOT NULL THEN
  SELECT url_url_no_SEQ.NEXTVAL INTO :NEW.url_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE url is '접속 주소';
COMMENT ON COLUMN url.url_no is '접속 주소 번호';
COMMENT ON COLUMN url.authurl_no is '권한별 접근 URL 번호';


/**********************************/
/* Table Name: 권한별 접근 URL */
/**********************************/
CREATE TABLE authurl(
		authurl_no                    		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		auth_no                       		NUMBER(10)		 NOT NULL,
		url_no                        		NUMBER(10)		 NULL ,
  FOREIGN KEY (auth_no) REFERENCES auth (auth_no),
  FOREIGN KEY (url_no) REFERENCES url (url_no)
);

COMMENT ON TABLE authurl is '권한별 접근 URL';
COMMENT ON COLUMN authurl.authurl_no is '권한별 접근 URL 번호';
COMMENT ON COLUMN authurl.auth_no is '권한 번호';
COMMENT ON COLUMN authurl.url_no is '접근 주소 번호';


/**********************************/
/* Table Name: 관리자 */
/**********************************/
CREATE TABLE admin(
		admin_no                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		admin_id                      		VARCHAR2(30)		 NOT NULL,
		admin_passwd                  		VARCHAR2(50)		 NOT NULL,
		admin_name                    		VARCHAR2(50)		 NOT NULL
);

DROP SEQUENCE admin_admin_no_SEQ;

CREATE SEQUENCE admin_admin_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER admin_admin_no_TRG
BEFORE INSERT ON admin
FOR EACH ROW
BEGIN
IF :NEW.admin_no IS NOT NULL THEN
  SELECT admin_admin_no_SEQ.NEXTVAL INTO :NEW.admin_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE admin is '관리자';
COMMENT ON COLUMN admin.admin_no is '관리자번호';
COMMENT ON COLUMN admin.admin_id is '관리자ID';
COMMENT ON COLUMN admin.admin_passwd is '관리자PW';
COMMENT ON COLUMN admin.admin_name is '관리자이름';


/**********************************/
/* Table Name: 관리자 로그인기록 */
/**********************************/
CREATE TABLE admin_log(
		admin_log_no                  		NUMBER(30)		 NOT NULL		 PRIMARY KEY,
		admin_no                      		NUMBER(10)		 NOT NULL,
		admin_log_date                		DATE		 NOT NULL,
		admin_log_ip                  		VARCHAR2(50)		 NOT NULL,
  FOREIGN KEY (admin_no) REFERENCES admin (admin_no)
);

DROP SEQUENCE admin_log_admin_log_no_SEQ;

CREATE SEQUENCE admin_log_admin_log_no_SEQ NOMAXVALUE NOCACHE NOORDER NOCYCLE;

CREATE TRIGGER admin_log_admin_log_no_TRG
BEFORE INSERT ON admin_log
FOR EACH ROW
BEGIN
IF :NEW.admin_log_no IS NOT NULL THEN
  SELECT admin_log_admin_log_no_SEQ.NEXTVAL INTO :NEW.admin_log_no FROM DUAL;
END IF;
END;

COMMENT ON TABLE admin_log is '관리자 로그인기록';
COMMENT ON COLUMN admin_log.admin_log_no is '관리자 로그인 번호';
COMMENT ON COLUMN admin_log.admin_no is '관리자 번호';
COMMENT ON COLUMN admin_log.admin_log_date is '관리자 로그인 날짜';
COMMENT ON COLUMN admin_log.admin_log_ip is '관리자 로그인 IP';


