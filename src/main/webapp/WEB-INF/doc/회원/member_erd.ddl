/**********************************/
/* Table Name: 권한 */
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

COMMENT ON TABLE snslogin is 'SNS로그인';
COMMENT ON COLUMN snslogin.snslogin_no is 'SNS구분번호';
COMMENT ON COLUMN snslogin.snslogin_name is 'SNS명';


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
COMMENT ON COLUMN member.member_address is '거주지';
COMMENT ON COLUMN member.auth_no is '등급';
COMMENT ON COLUMN member.snslogin_no is 'SNS로그인';


/**********************************/
/* Table Name: 상품 즐겨찾기 */
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

COMMENT ON TABLE myfavorite is '상품 즐겨찾기';
COMMENT ON COLUMN myfavorite.fav_no is '즐겨찾기번호';
COMMENT ON COLUMN myfavorite.member_no is '회원번호';
COMMENT ON COLUMN myfavorite.product_no is '상품번호';


/**********************************/
/* Table Name: 내 추천항목_제품 */
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

COMMENT ON TABLE myrecomend_product is '내 추천항목_제품';
COMMENT ON COLUMN myrecomend_product.myrecomend_no is '내가 추천한 제품 고유번호';
COMMENT ON COLUMN myrecomend_product.member_no is '회원번호';
COMMENT ON COLUMN myrecomend_product.product_no is '상품번호';


/**********************************/
/* Table Name: 로그인기록 */
/**********************************/
CREATE TABLE login_log(
		login_log_no                  		NUMBER(100)		 NULL ,
		member_no                     		NUMBER(10)		 NULL ,
		login_log_date                		DATE		 NULL ,
		login_log_ip                  		VARCHAR2(50)		 NULL ,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE login_log is '로그인기록';
COMMENT ON COLUMN login_log.login_log_no is '로그인번호';
COMMENT ON COLUMN login_log.member_no is '회원번호';
COMMENT ON COLUMN login_log.login_log_date is '로그인일시';
COMMENT ON COLUMN login_log.login_log_ip is '로그인장소';


