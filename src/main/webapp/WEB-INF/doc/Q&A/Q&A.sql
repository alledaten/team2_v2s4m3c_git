
/**********************************/
/* Table Name: 커뮤니티 */
/**********************************/
DROP TABLE community;
CREATE TABLE community(
		community_no NUMERIC(3) NOT NULL PRIMARY KEY,
		community_name VARCHAR(50) NOT NULL,
		community_seqno NUMERIC(10) NOT NULL,
		community_visible CHAR(1) DEFAULT 'Y' NOT NULL,
		community_rdate DATE NOT NULL
);

COMMENT ON TABLE community is '커뮤니티';
COMMENT ON COLUMN community.community_no is '커뮤니티 번호';
COMMENT ON COLUMN community.community_name is '이름';
COMMENT ON COLUMN community.community_seqno is '출력순서';
COMMENT ON COLUMN community.community_visible is '출력모드';
COMMENT ON COLUMN community.community_rdate is '그룹 생성일';

DROP SEQUENCE community_seq;
CREATE SEQUENCE community_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- insert
INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, '자유 게시판', 1, 'Y', sysdate);

INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, '술 게시판', 2, 'Y', sysdate);

INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, '기타 게시판', 3, 'Y', sysdate);

INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, 'Q&A', 4, 'Y', sysdate);

SELECT * FROM community ORDER BY community_no ASC;
  
commit;  

/**********************************/
/* Table Name: 회원 */
/**********************************/
DROP TABLE member;
CREATE TABLE member(
		member_no NUMERIC(10) NOT NULL PRIMARY KEY,
        member_id  VARCHAR(50) NOT NULL
);

DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 등록
INSERT INTO member(member_no, member_id)
VALUES(member_seq.nextval, 'user1');

INSERT INTO member(member_no, member_id)
VALUES(member_seq.nextval, 'user2');

-- 삭제
DELETE member
WHERE member_no =1;

SELECT * FROM member;

commit;

/**********************************/
/* Table Name: Q&A */
/**********************************/
DROP TABLE qna;
CREATE TABLE qna(
		qna_no NUMERIC(10) NOT NULL PRIMARY KEY,
		community_no NUMERIC(3),
		member_no NUMERIC(10),
		qna_title VARCHAR(50),
		qna_content VARCHAR(500) NOT NULL,
		qna_passwd VARCHAR(20) NOT NULL,
		qna_rdate DATE NOT NULL,
		qna_count NUMERIC(3) NOT NULL,
		qna_check CHAR(1) DEFAULT 'N' NULL,
        qna_visible CHAR(1) DEFAULT 'N' NULL,
        file1         VARCHAR(100)          NULL,
        thumb1    VARCHAR(100)          NULL,
        size1        NUMBER(10)      DEFAULT 0 NULL,  
        qna_word  VARCHAR2(300)  NULL,
        grpno    NUMBER(8)         DEFAULT 0         NOT NULL,
        indent   NUMBER(2)         DEFAULT 0         NOT NULL,
        ansnum NUMBER(3)         DEFAULT 0         NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (community_no) REFERENCES community (community_no)
);

COMMENT ON TABLE qna is 'Q&A';
COMMENT ON COLUMN qna.qna_no is 'Q&A 번호';
COMMENT ON COLUMN qna.community_no is '커뮤니티 번호';
COMMENT ON COLUMN qna.member_no is '회원 번호';
COMMENT ON COLUMN qna.qna_title is '질문 제목';
COMMENT ON COLUMN qna.qna_content is '질문 내용';
COMMENT ON COLUMN qna.qna_passwd is '비밀번호';
COMMENT ON COLUMN qna.qna_rdate is '질문 등록일';
COMMENT ON COLUMN qna.qna_count is '조회수';
COMMENT ON COLUMN qna.qna_check is '비밀글 모드';
COMMENT ON COLUMN qna.qna_visible is '첨부파일 확인';
COMMENT ON COLUMN qna.file1 is '메인 이미지';
COMMENT ON COLUMN qna.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN qna.size1 is ' 메인 이미지 크기';
COMMENT ON COLUMN qna.qna_word is '검색어';
COMMENT ON COLUMN qna.grpno is '그룹번호';
COMMENT ON COLUMN qna.indent is '들여쓰기/답변차수';
COMMENT ON COLUMN qna.ansnum is '답변순서';

DROP SEQUENCE qna_seq;
CREATE SEQUENCE qna_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 등록
INSERT INTO qna(qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word)
VALUES(qna_seq.nextval, 4, 1, 'test 질문', '질문 내용', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '테스트');

INSERT INTO qna(qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word)
VALUES(qna_seq.nextval, 4, 2, 'test 질문', '질문 내용', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '테스트');

-- 목록
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word
FROM qna 
ORDER BY qna_no ASC;

-- 조회
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word
FROM qna
WHERE qna_no = 1;

-- 비밀번호 검사
SELECT COUNT(*) as passwd_cnt
FROM qna
WHERE qna_no=1 AND qna_passwd='1234';

-- 수정
UPDATE qna
SET community_no=4, qna_title='질문 test1123', qna_content='답변 수정중 test1', qna_passwd='1234'
WHERE qna_no = 1;

-- 삭제
DELETE FROM qna
WHERE qna_no =1;

-- 출력 모드의 변경
UPDATE qna
SET qna_visible='Y'
WHERE qna_no= 1;

UPDATE qna
SET qna_visible='N'
WHERE qna_no=2;

--  조회(카운트)
UPDATE qna
SET cnt = cnt +1
WHERE qna_no = 1;

SELECT * FROM qna;

commit;

-- 첨부 파일 변경(등록, 변경, 수정, 삭제)
UPDATE qna
SET file1='file name', thumb1='thumb file name', size1=5000
WHERE qna_no=1;

-- qna + member join 목록

SELECT m.member_id,
          q.qna_no, q.community_no, q.member_no, q.qna_title, q.qna_content, q.qna_passwd, q.qna_rdate, q.qna_count, q.qna_visible, q.qna_check, q.qna_word
FROM member m,  qna q
WHERE m.member_no = q.member_no
ORDER BY q.qna_no DESC;

-- 검색 + 페이징
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word, r
FROM (
           SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word, rownum as r
           FROM (
                     SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word
                     FROM qna
                     WHERE community_no=4 AND qna_word LIKE '%테스트%'
                     ORDER BY qna_no DESC
           )          
)
WHERE r >= 1 AND r <= 10;

----------------------------------------------------------------------------------------------
답변 관련 시작
----------------------------------------------------------------------------------------------
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM community_no;


DROP TABLE qna  CASCADE CONSTRAINTS;

1) 등록 변경
- grpno: 새롭게 글을 등록하면 하나의 신규 그룹이 생성됨, (SELECT NVL(MAX(grpno), 0) + 1 FROM contents), 0, 0)
- indent: 들여 쓰기, n차 답변에 대한 효과
- ansnum: 답변 순서 지정
INSERT INTO qna(qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                              grpno, indent, ansnum)
VALUES(qna_seq.nextval, 4, 1, 'test 질문', '질문 내용', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '테스트',
           (SELECT NVL(MAX(grpno), 0) + 1 FROM qna), 0, 0);
            
2) 1건 조회 변경
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
           grpno, indent, ansnum
FROM qna
WHERE qna_no = 1;

3) 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;
 
 
4) 답변 등록
- community_no: FK, member_no: FK
 
INSERT INTO qna(qna_no,
                          community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                          grpno, indent, ansnum)  
VALUES((SELECT NVL(MAX(qna_no), 0) + 1 as qna_no FROM qna),
            4, 1, 'test 답변', '답변 내용', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '',
            1, 1, 1);
 
 
5) 답변에 따른 정렬 순서 변경    
-- ORDER BY grpno DESC, ansnum ASC
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
          grpno, indent, ansnum, r
FROM (
           SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                     grpno, indent, ansnum, rownum as r
           FROM (
                     SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                               grpno, indent, ansnum
                     FROM qna
                     WHERE community_no=4 AND (qna_title LIKE '테스트' OR qna_content LIKE '테스트' OR qna_word LIKE '테스트')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;     
   
----------------------------------------------------------------------------------------------
답변 관련 종료
----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
답변 + member join start
----------------------------------------------------------------------------------------------
SELECT m.member_id,
           q.qna_no, q.member_no, q.community_no
FROM qna q, member m
WHERE q.member_no = m.member_no;

CONTENTSNO   MEMBERNO     CATENO ID                  
---------- ---------- ---------- --------------------
        35          3                  27        user1               
        40          3                  27        user1               
        41          3                  27        user1               
        42          3                  27        user1       

-- 2개의 컬럼에 중복되는경우는 as를 사용하여 컬럼명을 변경, id를 mid로 변경
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
            grpno, indent, ansnum, mid, r
FROM (
           SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                       grpno, indent, ansnum, mid, rownum as r
           FROM (
                     SELECT q.qna_no, q.community_no, q.member_no, q.qna_title, q.qna_content, q.qna_passwd, q.qna_rdate, q.qna_count, q.qna_check, q.qna_visible, q.file1, q.thumb1, q.size1, q.qna_word,
                                 q.grpno, q.indent, q.ansnum,
                                 m.member_id as mid
                     FROM qna q, member m
                     WHERE community_no=4 
                               AND q.member_no = m.member_no 
                               AND (qna_title LIKE '%테스트%' OR qna_content LIKE '%테스트%' OR qna_word LIKE '%테스트%')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;        
   
----------------------------------------------------------------------------------------------
답변 + member join end
----------------------------------------------------------------------------------------------

commit;

/**********************************/
/* Table Name: 답변(댓글) */
/**********************************/
DROP TABLE answer;
CREATE TABLE answer(
		answer_no NUMERIC(10) NOT NULL PRIMARY KEY,
		member_no NUMERIC(10),
		qna_no NUMERIC(10),
		answer_content VARCHAR(4000) NOT NULL,
        answer_rdate DATE NOT NULL,
        answer_passwd   VARCHAR2(15)         NOT NULL,
        file1        VARCHAR(100)          NULL,
        thumb1   VARCHAR(100)          NULL,
        size1       NUMBER(10)      DEFAULT 0 NULL,
        grpno    NUMBER(8)         DEFAULT 0         NOT NULL,
        indent   NUMBER(2)         DEFAULT 0         NOT NULL,
        ansnum NUMBER(3)         DEFAULT 0         NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (qna_no) REFERENCES qna (qna_no)
);

COMMENT ON TABLE answer is '답변';
COMMENT ON COLUMN answer.answer_no is '답변 번호';
COMMENT ON COLUMN answer.member_no is '회원 번호';
COMMENT ON COLUMN answer.qna_no is '질문 번호';
COMMENT ON COLUMN answer.answer_content is '답변 내용';
COMMENT ON COLUMN answer.answer_rdate is '답변 등록일';
COMMENT ON COLUMN answer.answer_passwd is '비밀번호';
COMMENT ON COLUMN answer.file1 is '메인 이미지';
COMMENT ON COLUMN answer.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN answer.size1 is ' 메인 이미지 크기';
COMMENT ON COLUMN qna.grpno is '그룹번호';
COMMENT ON COLUMN qna.indent is '들여쓰기/답변차수';
COMMENT ON COLUMN qna.ansnum is '답변순서';

DROP SEQUENCE answer_seq;
CREATE SEQUENCE answer_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

--등록
INSERT INTO answer(answer_no, member_no, qna_no, answer_content, answer_rdate, answer_passwd, file1, thumb1, size1,
                               grpno, indent, ansnum)
VALUES(answer_seq.nextval, 1, 1, '답변 내용', sysdate, '1234', 'spring.jpg', 'spring_t.jpg', 23657,
           (SELECT NVL(MAX(grpno), 0) + 1 FROM qna), 0, 0);

-- 목록
SELECT answer_no, member_no, qna_no, answer_content, answer_rdate, answer_passwd, file1, thumb1, size1, grpno, indent, ansnum
FROM answer 
ORDER BY answer_no ASC;

-- 질문 목록
SELECT answer_no, member_no, qna_no, answer_content, answer_rdate, answer_passwd, file1, thumb1, size1, grpno, indent, ansnum
FROM answer
WHERE qna_no=1
ORDER BY answer_no DESC;

-- 조회
SELECT answer_no, member_no, qna_no, answer_content, answer_rdate, answer_passwd, file1, thumb1, size1, grpno, indent, ansnum
FROM answer
WHERE answer_no = 1;

-- 수정
UPDATE answer
SET qna_no= 1, answer_content='답변 test1중'
WHERE answer_no = 1;

-- 첨부 파일 변경(등록, 변경, 수정, 삭제)
UPDATE answer
SET file1='file name', thumb1='thumb file name', size1=5000
WHERE answer_no=1;

-- 삭제
DELETE answer
WHERE answer_no =3;

SELECT * FROM answer;

commit;
