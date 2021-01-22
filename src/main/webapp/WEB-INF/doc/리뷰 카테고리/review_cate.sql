DROP TABLE review_cate;
DROP SEQUENCE review_cate_seq;

/**********************************/
/* Table Name: 리뷰 카테고리 */
/**********************************/
CREATE TABLE review_cate(
		review_cate_no                 NUMBER(10)     NOT NULL          PRIMARY KEY,
		review_categrp_no             NUMBER(10),
		review_cate_name              VARCHAR2(100) NOT NULL,
		review_cate_seqno             NUMBER(10) NOT NULL,
		review_cate_date               DATE NOT NULL,
		review_cate_cnt                NUMBER(10) DEFAULT 0 NOT NULL,
  FOREIGN KEY (review_categrp_no) REFERENCES review_categrp (review_categrp_no)
);

CREATE SEQUENCE review_cate_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 1) 등록
INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, '탁주', 1, sysdate, 0);

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, '맥주 및 청주', 2, sysdate, 0);

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, '과실주', 3, sysdate, 0); 

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, '증류주', 4, sysdate, 0); 

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 2, '면류', 5, sysdate, 0); 

-- 2) 목록
SELECT review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt
FROM review_cate
ORDER BY review_cate_no ASC;

-- 3) 조회(카테고리 번호(PK)기준 조회)
SELECT review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt
FROM review_cate
WHERE review_cate_no=3;

-- 4) 수정(카테고리 번호(PK)기준 수정)
UPDATE review_cate
SET review_categrp_no=3, review_cate_name='과실주 카테고리 수정(이름,순서,댓글수)', review_cate_seqno=4, review_cate_cnt=10
WHERE review_cate_no = 3;

-- 5) 삭제(카테고리 번호(PK)기준 삭제)
DELETE review_cate
WHERE review_cate_no = 6;

-- 6 - 1) 출력순서 상향
UPDATE review_cate
SET review_cate_seqno = review_cate_seqno - 1
WHERE review_cate_no=4;

-- 6 - 2) 출력순서 하향
UPDATE review_cate
SET review_cate_seqno = review_cate_seqno + 1
WHERE review_cate_no=4;

---------------------------------------------         
-- FK를 갖는 테이블 추가 구현
---------------------------------------------
-- 리뷰 카테고리 그룹에 따른 리뷰 카테고리 목록
SELECT review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt
FROM review_cate
WHERE review_categrp_no = 1
ORDER BY review_cate_seqno ASC;


-- 통합 VO
SELECT g.review_categrp_no as g_review_categrp_no, g.review_categrp_name as g_review_categrp_name, 
          c.review_cate_no, c.review_categrp_no, c.review_cate_name, c.review_cate_seqno, c.review_cate_date, c.review_cate_cnt
FROM review_categrp g, review_cate c
WHERE g.review_categrp_no = c.review_categrp_no
ORDER BY g.review_categrp_no ASC, c.review_cate_seqno ASC;

-- 통합 VO, categrpno 별 cate 목록
SELECT g.review_categrp_no as g_review_categrp_no, g.review_categrp_name as g_review_categrp_name,
          c.review_cate_no, c.review_categrp_no, c.review_cate_name, c.review_cate_seqno, c.review_cate_date, c.review_cate_cnt
FROM  review_categrp g, review_cate c
WHERE (g.review_categrp_no = c.review_categrp_no) AND g.review_categrp_no=1
ORDER BY g.review_categrp_no ASC, c.review_cate_seqno ASC;

-- contents 추가에 따른 등록된 글수의 증가
UPDATE review_cate 
SET review_cate_cnt = review_cate_cnt + 1 
WHERE review_cate_no=1;
 
-- contents 추가에 따른 등록된 글수의 감소
UPDATE review_cate 
SET review_cate_cnt = review_cate_cnt - 1 
WHERE review_cate_no=1;

-- 글수 초기화
UPDATE review_cate
SET review_cate_cnt = 0;


commit;

