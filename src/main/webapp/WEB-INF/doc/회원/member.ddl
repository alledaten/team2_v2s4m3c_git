
/**********************************/
/* Table Name: 권한 */
/**********************************/
drop table auth;

CREATE TABLE auth(
    auth_no            NUMBER(10)		 NOT NULL,
    auth_content       VARCHAR2(50)		 NULL,
    PRIMARY KEY(auth_no)
);

COMMENT ON TABLE auth is '권한';
COMMENT ON COLUMN auth.auth_no is '권한번호';
COMMENT ON COLUMN auth.auth_content is '권한내용';

-- 등록
INSERT INTO auth(auth_no, auth_content)
VALUES(1, '최고관리자');
INSERT INTO auth(auth_no, auth_content)
VALUES(2, '관리자');
INSERT INTO auth(auth_no, auth_content)
VALUES(3, '게시판 관리자');
INSERT INTO auth(auth_no, auth_content)
VALUES(4, '우수회원');
INSERT INTO auth(auth_no, auth_content)
VALUES(5, '일반회원');

-- 목록
SELECT * FROM auth ORDER BY auth_no ASC;

   AUTH_NO AUTH_CONTENT                                      
---------- -----------------------------------
         1 최고관리자                                        
         2 관리자                                            
         3 게시판 관리자                                     
         4 우수회원                                          
         5 일반회원          

-- 조회
SELECT auth_no, auth_content
FROM auth
WHERE auth_no = 3;

-- 수정
UPDATE auth
SET auth_content = '기업회원'
WHERE auth_no = 4;

-- 삭제
DELETE auth
WHERE auth_no = 5;

/**********************************/
/* Table Name: SNS로그인 */
/**********************************/
drop table snslogin;

CREATE TABLE snslogin(
    snslogin_no                   NUMBER(10)		 NOT NULL		 PRIMARY KEY,
    snslogin_name                 VARCHAR2(50)		 NOT NULL
);

COMMENT ON TABLE snslogin is 'SNS로그인';
COMMENT ON COLUMN snslogin.snslogin_no is 'SNS구분번호';
COMMENT ON COLUMN snslogin.snslogin_name is 'SNS명';

-- 등록
INSERT INTO snslogin(snslogin_no, snslogin_name)
VALUES(1, '일반');
INSERT INTO snslogin(snslogin_no, snslogin_name)
VALUES(2, '네이버');
INSERT INTO snslogin(snslogin_no, snslogin_name)
VALUES(3, '카카오');

-- 목록
SELECT * FROM snslogin ORDER BY snslogin_no ASC;

SNSLOGIN_NO SNSLOGIN_NAME                                     
----------- --------------------------------------------------
          1 홈페이지 회원                                     
          2 구글 연동                                         
          3 카카오 연동                                       
          4 네이버 연동       
          
-- 조회
SELECT snslogin_no, snslogin_name
FROM snslogin
WHERE snslogin_no = 3;

-- 수정
UPDATE snslogin
SET snslogin_name = '기업회원'
WHERE auth_no = 4;

-- 삭제
DELETE auth
WHERE auth_no = 5;



/**********************************/
/* Table Name: 회원 */
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
COMMENT ON COLUMN member.member_zipcode is '우편번호';
COMMENT ON COLUMN member.member_address1 is '주소1';
COMMENT ON COLUMN member.member_address2 is '주소2';
COMMENT ON COLUMN member.member_profilepic is '프로필사진';
COMMENT ON COLUMN member.memberlevel_no is '등급';
COMMENT ON COLUMN member.auth_no is '권한';
COMMENT ON COLUMN member.snslogin_no is 'SNS로그인';

DROP SEQUENCE member_no_seq;
CREATE SEQUENCE member_no_SEQ
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999 -- 최대값: 99999999 --> NUMBER(10) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되?? 것을 방지

-- 등록
INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test', 1234, '의적', '홍길동',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate, '서울특별시', '중랑구', '01.jpg',
        5, 1, 1);

-- 목록
SELECT member_no, member_id, member_nickname, member_isAdult, member_rdate, auth_no
FROM member
ORDER BY member_no ASC;

SELECT *
FROM member
ORDER BY member_no ASC;

-- 조인
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

-- 페이징
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


-- 조회
SELECT member_no, member_id, member_passwd, member_nickname, member_name, 
       member_isAdult, member_tel, member_email, member_rdate, member_address, auth_no, snslogin_no
FROM member
WHERE member_no = 1;

-- ID체크
SELECT COUNT(member_id) as cnt
FROM member
WHERE member_id = 'test3';

-- 수정
UPDATE member
SET member_nickname = '허균'
WHERE member_no = 1;

UPDATE member
SET member_passwd = '1234',
    member_nickname = '의적',
    member_name = '다길동',
    member_isAdult = '1234561234567',
    member_tel = '01022225555',
    member_email = 'email@email.com', 
    member_zipcode = '01234',
    member_address1 = '서울특별시',
    member_address2 = '용산구',
    member_profilepic = '01.jpg',
    memberlevel_no = 1,
    auth_no = 1
WHERE member_no=1;

-- 삭제
DELETE member
WHERE member_no = 3;

/**********************************/
/* Table Name: 로그인기록 */
/**********************************/
drop table login_log;
CREATE TABLE login_log(
    login_log_no                  		NUMBER(30)		 NOT NULL       PRIMARY KEY,
    member_no                     		NUMBER(10)		 NOT NULL ,
    login_log_date                		DATE		     NOT NULL ,
    login_log_ip                  		VARCHAR2(50)	 NOT NULL ,
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE login_log is '로그인기록';
COMMENT ON COLUMN login_log.login_log_no is '로그인번호';
COMMENT ON COLUMN login_log.member_no is '회원번호';
COMMENT ON COLUMN login_log.login_log_date is '로그인일시';
COMMENT ON COLUMN login_log.login_log_ip is '로그인장소';


/**********************************/
/* Table Name: 등급 */
/**********************************/
CREATE TABLE "TEAM2"."MEMBERLEVEL" (
    "MEMBERLEVEL_NO"    NUMBER(10)      NOT NULL, 
	"MEMBERLEVEL_NAME"  VARCHAR2(50)    NOT NULL, 
    PRIMARY KEY ("MEMBERLEVEL_NO")
)

   COMMENT ON TABLE MEMBERLEVEL IS '등급';
   COMMENT ON COLUMN MEMBERLEVEL.MEMBERLEVEL_NO IS '등급 번호';
   COMMENT ON COLUMN MEMBERLEVEL.MEMBERLEVEL_NAME IS '등급 이름';



/**********************************/
/* Table Name: 관리자 */
/**********************************/

CREATE TABLE ADMIN (
    "ADMIN_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"ADMIN_ID" NUMBER(10,0) NOT NULL ENABLE, 
	"ADMIN_PASSWD" VARCHAR2(30 BYTE) NOT NULL ENABLE, 
	"AUTH_NO" NUMBER(10,0) NOT NULL ENABLE, 
    PRIMARY KEY ("ADMIN_NO")
)

   COMMENT ON COLUMN "TEAM2"."ADMIN"."ADMIN_NO" IS '관리자번호';
   COMMENT ON COLUMN "TEAM2"."ADMIN"."ADMIN_ID" IS '관리자ID';
   COMMENT ON COLUMN "TEAM2"."ADMIN"."ADMIN_PASSWD" IS '관리자 비밀번호';
   COMMENT ON COLUMN "TEAM2"."ADMIN"."AUTH_NO" IS '권한번호';
   COMMENT ON TABLE "TEAM2"."ADMIN"  IS '관리자';


/**********************************/
/* Table Name: 관리자 로그인 기록 */
/**********************************/

CREATE TABLE ADMIN_LOG (
    "ADMIN_LOG_NO" NUMBER(30,0) NOT NULL ENABLE, 
	"ADMIN_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"ADMIN_LOG_DATE" DATE NOT NULL ENABLE, 
	"ADMIN_LOG_IP" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
	 PRIMARY KEY ("ADMIN_LOG_NO")
)

   COMMENT ON TABLE ADMIN_LOG IS '관리자 로그인기록';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_NO IS '관리자 로그인 번호';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_NO" IS '관리자 번호';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_DATE" IS '관리자 로그인 날짜';
   COMMENT ON COLUMN ADMIN_LOG.ADMIN_LOG_IP" IS '관리자 로그인 IP';

/**********************************/
/* Table Name: 권한별 접근 URL */
/**********************************/

CREATE TABLE AUTHURL (
    "AURHURL_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"AUTH_NO" NUMBER(10,0) NOT NULL ENABLE, 
	"URL_NO" NUMBER(10,0), 
	 PRIMARY KEY ("AURHURL_NO")
)

   COMMENT ON COLUMN "TEAM2"."AUTHURL"."AURHURL_NO" IS '권한별 접근 URL 번호';
   COMMENT ON COLUMN "TEAM2"."AUTHURL"."AUTH_NO" IS '권한 번호';
   COMMENT ON COLUMN "TEAM2"."AUTHURL"."URL_NO" IS '접근 주소 번호';
   COMMENT ON TABLE "TEAM2"."AUTHURL"  IS '권한별 접근 URL';




