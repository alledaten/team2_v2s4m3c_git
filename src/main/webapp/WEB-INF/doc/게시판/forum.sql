-- 1. 테이블 삭제
DROP TABLE boardgrp;
-- DROP TABLE forum CASCADE CONSTRAINTS; 
DROP TABLE forum;

-- 2. 테이블 생성
boardgrp
forum

-- 3. CASCADE option을 이용한 자식 테이블을 무시한 테이블 삭제, 관련된 제약조건이 삭제됨.
DROP TABLE forum CASCADE CONSTRAINTS;



/**********************************/
/* Table Name: 게시판 그룹 */
/**********************************/
CREATE TABLE boardgrp(
		boardgrp_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		boardgrp_name                          		VARCHAR2(50)		 NOT NULL,
		boardgrp_seqno                         		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		boardgrp_visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		boardgrp_rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE boardgrp is '게시판 그룹';
COMMENT ON COLUMN boardgrp.boardgrp_no is '게시판 그룹 번호';
COMMENT ON COLUMN boardgrp.boardgrp_name is '게시판이름';
COMMENT ON COLUMN boardgrp.boardgrp_seqno is '게시판 출력 순서';
COMMENT ON COLUMN boardgrp.boardgrp_visible is '게시판 출력 모드';
COMMENT ON COLUMN boardgrp.boardgrp_rdate is '게시판 생성일';

DROP SEQUENCE boardgrp_seq;
CREATE SEQUENCE boardgrp_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
  
/**********************************/
/* Table Name: 게시판 */
/**********************************/
DROP TABLE forum;
CREATE TABLE forum(
		forum_no                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		boardgrp_no                     		NUMBER(10)		 NULL ,
		forum_name                          		VARCHAR2(100)		 NOT NULL,
		forum_seqno                         		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		forum_visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		forum_rdate                         		DATE		 NOT NULL,
		forum_cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (boardgrp_no) REFERENCES boardgrp (boardgrp_no)
);

COMMENT ON TABLE forum is '자유게시판';
COMMENT ON COLUMN forum.forum_no is '글 번호';
COMMENT ON COLUMN forum.boardgrp_no is '게시판 번호';
COMMENT ON COLUMN forum.forum_name is '글제목';
COMMENT ON COLUMN forum.forum_seqno is '글 출력 순서';
COMMENT ON COLUMN forum.forum_visible is '출력 모드';
COMMENT ON COLUMN forum.forum_rdate is '등록일';
COMMENT ON COLUMN forum.forum_cnt is '자게 등록된 글 수';

DROP SEQUENCE forum_seq;
CREATE SEQUENCE forum_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 1, '스키장추천', 1, 'Y', sysdate, 0);
오류 보고 -
ORA-02291: integrity constraint (AI7.SYS_C008048) violated - parent key not found
-- FK 컬럼의 값 1000은 categrp 테이블에 없어서 에러 발생함.

-- 부모 테이블에 먼저 추가
INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '자유게시판', 1, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '술TALK', 2, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '기타게시판', 3, 'Y', sysdate);

COMMIT;

SELECT * FROM boardgrp ORDER BY boardgrp_no ASC;

BOARDGRP_NO BOARDGRP_NAME                                      BOARDGRP_SEQNO B BOARDGRP
----------- -------------------------------------------------- -------------- - --------
          1 자유게시판                                                      0 Y 20/11/03
          2 술TALK                                                          2 Y 20/11/03
          3 기타게시판                                                      3 N 20/11/03

-- 등록: 1, 2, 3 번 게시판
INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 1, '자유게시판', 1, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval,2, '술TALK', 2, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 3, '기타게시판', 3, 'Y', sysdate, 0);


-- 2번 게시판
INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 2, '2번 게시판1', 1, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 2, '2번 게시판2', 2, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 2, '2번 게시판3', 3, 'Y', sysdate, 0);

--3번 게시판
INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 3, '3번 게시판1', 1, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 3, '3번 게시판2', 2, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 3, '3번 게시판3', 3, 'Y', sysdate, 0);

COMMIT;

-- 목록
SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
ORDER BY forum_no ASC;
        
        PK           FK 
  FORUM_NO BOARDGRP_NO FORUM_NAME                                                                                           FORUM_SEQNO F FORUM_RDATE          FORUM_CNT
---------- ----------- ---------------------------------------------------------------------------------------------------- ----------- - ------------------- ----------
         1           1 자유게시판                                                                                                     1 Y 2021-02-02 11:30:33          0
         2           2 술TALK                                                                                                         2 Y 2021-02-02 11:30:33          0
         3           3 기타게시판                                                                                                     3 Y 2021-02-02 11:30:33          0
         
-- 조회
SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
WHERE forum_no=3;

-- 수정
UPDATE forum
SET boardgrp_no=1, forum_name='HakubaGoryu', forum_seqno = 10, forum_visible='N', forum_cnt=0
WHERE forum_no = 3;

  FORUM_NO BOARDGRP_NO FORUM_NAME                                                                                           FORUM_SEQNO F FORUM_RD  FORUM_CNT
---------- ----------- ---------------------------------------------------------------------------------------------------- ----------- - -------- ----------
         3           1 HakubaGoryu                                                                                                   10 N 20/11/03          0

commit;

-- 삭제
DELETE forum
WHERE forum_no = 3;

SELECT * FROM forum;

-- 출력 순서 상향, 10 ▷ 1
UPDATE forum
SET forum_seqno = forum_seqno - 1
WHERE forum_no=2;

SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
ORDER BY forum_seqno ASC;

-- 출력순서 하향, 1 ▷ 10
UPDATE forum
SET forum_seqno = forum_seqno + 1
WHERE forum_no=2;

-- 출력 모드의 변경
UPDATE forum
SET forum_visible='Y'
WHERE forum_no=2;

UPDATE forum
SET forum_visible='N'
WHERE forum_no=2;

commit;

---------------------------------------         
-- FK를 갖는 테이블 추가 구현
---------------------------------------
-- 카테고리 그룹에 따른 카테고리 목록
SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
WHERE boardgrp_no=1
ORDER BY forum_seqno ASC;


-- 부모 테이블 레코드 삭제
DELETE FROM boardgrp
WHERE boardgrp_no = 1;
오류 보고 -
ORA-02292: integrity constraint (AI7.SYS_C008048) violated - child record found

-- 삭제하려면 레코드의 categrpno가 어디에서 쓰이는지 알려주어야함.
SELECT COUNT(*) as cnt
FROM forum
WHERE boardgrp_no=1;

       CNT
----------
         2
         
-- 자식 테이블에서 FK가 1인 레코드 모두 삭제
DELETE FROM forum
WHERE boardgrp_no=1;

-- 부모 테이블 레코드 삭제
DELETE FROM boardgrp
WHERE boardgrp_no=1;

commit;

-- 부모 테이블 레코드 삭제 확인
SELECT * FROM boardgrp ORDER BY boardgrp_no ASC;

--SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt

-- 통합 VO
SELECT r.boardgrp_no as r_boardgrp_no, r.boardgrp_name as r_boardgrp_name,
           c.forum_no, c.boardgrp_no, c.forum_name, c.forum_seqno, c.forum_visible, c.forum_rdate, c.forum_cnt
FROM boardgrp r, forum c
WHERE r.boardgrp_no = c.boardgrp_no
ORDER BY r.boardgrp_no ASC, c.forum_seqno ASC;


SELECT r.boardgrp_no as r_boardgrp_no, r.boardgrp_name as r_boardgrp_name,
           c.forum_no, c.boardgrp_no, c.forum_name, c.forum_seqno, c.forum_visible, c.forum_rdate, c.forum_cnt
FROM boardgrp r, forum c
WHERE (r.boardgrp_no = c.boardgrp_no) AND r.boardgrp_no=1
ORDER BY r.boardgrp_no ASC, c.forum_seqno ASC;



-- 통합 VO, categrpno 별 cate 목록
SELECT r.boardgrp_no as r_boardgrp_no, r.boardgrp_name as r_boardgrp_name,
           c.forum_no, c.boardgrp_no, c.forum_name, c.forum_seqno, c.forum_visible, c.forum_rdate, c.forum_cnt
FROM boardgrp r, forum c
WHERE (r.boardgrp_no = c.boardgrp_no) AND r.boardgrp_no=1
ORDER BY r.boardgrp_no ASC, c.forum_seqno ASC;

R_CATEGRPNO R_NAME  CATENO  CATEGRPNO  NAME      SEQNO VISIBLE RDATE            CNT
----------- --------------- ---------- ----------- --------------------- ---------- - ------------------- ----------
          1 영화                  1           1 SF                              1 Y 2020-05-12 04:04:28          0
          1 영화                  2           1 드라마                         2 Y 2020-05-12 04:04:28          0
          1 영화                  3           1 스릴러                         3 Y 2020-05-12 04:04:28          0

-- contents 추가에따른 등록된 글수의 증가
UPDATE forum 
SET cnt = cnt + 1 
WHERE forum_no=1;
 
-- contents 추가에따른 등록된 글수의 감소
UPDATE forum 
SET cnt = cnt - 1 
WHERE forum_no=1; 

-- 글수 초기화
UPDATE forum
SET forum_cnt = 0;

COMMIT;



