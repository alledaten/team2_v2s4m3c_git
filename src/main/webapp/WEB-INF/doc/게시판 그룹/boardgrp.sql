/**********************************/
/* Table Name: 게시판 그룹 */
/**********************************/
DROP TABLE boardgrp;
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
  MAXVALUE 9999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- insert
INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '자유게시판', 1, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '술TALK', 2, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '기타게시판', 3, 'Y', sysdate);

COMMIT;

-- list
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
ORDER BY boardgrp_no ASC;

BOARDGRP_NO BOARDGRP_NAME                                      BOARDGRP_SEQNO B BOARDGRP
----------- -------------------------------------------------- -------------- - --------
          1 자유게시판                                                      1 Y 20/11/03
          2 술TALK                                                          2 Y 20/11/03
          3 기타게시판                                                      3 Y 20/11/03

-- 조회 + 수정폼
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
ORDER BY boardgrp_no ASC;
 
 CATEGRPNO NAME  SEQNO VISIBLE RDATE
 --------- ----- ----- ------- ---------------------
         1 국내 여행     1 Y       2019-05-13 13:07:50.0
         
-- 수정
UPDATE boardgrp
SET boardgrp_name='기타게시판', boardgrp_seqno = 3, boardgrp_visible='N'
WHERE boardgrp_no = 3;

commit;

-- 조회 + 수정폼 + 삭제폼
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
WHERE boardgrp_no = 3;
 
BOARDGRP_NO BOARDGRP_NAME                                      BOARDGRP_SEQNO B BOARDGRP
----------- -------------------------------------------------- -------------- - --------
          3 기타게시판                                                      3 N 20/11/03

-- 삭제         
DELETE FROM boardgrp
WHERE boardgrp_no = 10;

commit;
 
-- 출력 순서에따른 전체 목록
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
ORDER BY boardgrp_seqno ASC;
 
-- 출력 순서 상향, 10 ▷ 1
UPDATE boardgrp
SET boardgrp_seqno = boardgrp_seqno - 1
WHERE boardgrp_no=1;
 
-- 출력순서 하향, 1 ▷ 10
UPDATE boardgrp
SET boardgrp_seqno = boardgrp_seqno + 1
WHERE boardgrp_no=1;

-- 출력 모드의 변경
UPDATE boardgrp
SET visible='Y'
WHERE boardgrp_no=1;

UPDATE boardgrp
SET visible='N'
WHERE boardgrp_no=1;

commit;
         
         
         
         