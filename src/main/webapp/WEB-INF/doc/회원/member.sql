-- 테이블 구조
-- member 삭제전에 FK가 선언된 테이블 먼저 삭제합니다.
DROP TABLE auth;
DROP TABLE memberlevel;
DROP TABLE snslogin;
DROP TABLE member;

/**********************************/
/* Table Name: 회원 */
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
COMMENT ON COLUMN member.member_profilepic is '프로필섬네일';
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
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test1', 1234, '의적', '홍길동',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate,
        '01234', '서울특별시', '중랑구', '01.jpg',
        1, 1, 1);

INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test2', 1234, '세종', '이도',
        '9001011234567', '01012345678', 'korea@gmail.com', sysdate,
        '01234', '서울특별시', '경복궁', '02.jpg',
        1, 1, 1);

INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'test3', 1234, '슈퍼맨', '클락 켄트',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate,
        '01234', '서울특별시', '중랑구', '03.jpg',
        1, 1, 1);

INSERT INTO member(member_no, member_id, member_passwd, member_nickname, member_name, 
                   member_isAdult, member_tel, member_email, member_rdate,
                   member_zipcode, member_address1, member_address2, member_profilepic, 
                   memberlevel_no, auth_no, snslogin_no)
VALUES (member_no_seq.nextval, 'user1', 1234, '배트맨', '브루스 웨인',
        '9001011234567', '01012345678', 'test@gmail.com', sysdate,
        '01234', '서울특별시', '중랑구', '03.jpg',
        1, 1, 1);
        
commit;

-- 목록
SELECT member_no, member_id, member_nickname, member_isAdult, member_rdate, auth_no, member_profilepic
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


-- 패스워드 변경
1) 패스워드 검사
SELECT COUNT(memberno) as cnt
FROM member
WHERE memberno=3 AND passwd='1234';
 
2) 패스워드 수정
UPDATE member
SET passwd='0000'
WHERE memberno=1;

COMMIT;

-- 삭제
1) 모두 삭제
DELETE FROM member;
 
2) 특정 회원 삭제
DELETE FROM member
WHERE memberno=10;

COMMIT;
 
-- 로그인
SELECT COUNT(member_no) as cnt
FROM member
WHERE member_id='user1' AND member_passwd='1234';

 cnt
 ---
   1


-- id를 이용한 회원 정보 조회
SELECT member_no, member_id, member_passwd, member_name, member_tel, member_zipcode, member_address1, member_address2
FROM member
WHERE member_id = 'user1';

 MEMBER_NO MEMBER_ID                                          MEMBER_PASSWD                                      MEMBER_NAME                                        MEMBER_TEL                                         MEMBER_ZIPCODE                                                                                                                                                                                           MEMBER_ADDRESS1                                                                                                                                                                                          MEMBER_ADDRESS2                                                                                                                                                                                         
---------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
         4 user1                                              1234                                               브루스 웨인                                        01012345678                                        01234                                                                                                                                                                                                    서울특별시                                                                                                                                                                                               중랑구                                                                                                                                                                                                  

