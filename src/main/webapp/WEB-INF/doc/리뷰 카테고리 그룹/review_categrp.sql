DROP TABLE review_categrp;
DROP SEQUENCE review_categrp_seq;

/**********************************/
/* Table Name: 리뷰 카테고리 그룹 */
/**********************************/
CREATE TABLE review_categrp(
		review_categrp_no            NUMBER(10)      NOT NULL PRIMARY KEY,
		review_categrp_name        VARCHAR2(50)    NOT NULL,
		review_categrp_seqno       NUMBER(10)       DEFAULT 0 NOT NULL,
		review_categrp_date         DATE                 NOT NULL
);

COMMENT ON TABLE review_categrp is '리뷰 카테고리 그룹';
COMMENT ON COLUMN review_categrp.review_categrp_no is '리뷰 카테고리 그룹 번호';
COMMENT ON COLUMN review_categrp.review_categrp_name is  '리뷰 카테고리 그룹 이름';
COMMENT ON COLUMN review_categrp.review_categrp_seqno is '리뷰 카테고리 그룹 출력순서';
COMMENT ON COLUMN review_categrp.review_categrp_date is '리뷰 카테고리 그룹 생성일';

CREATE SEQUENCE review_categrp_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

1) 등록
INSERT INTO review_categrp(review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date)
VALUES(review_categrp_seq.nextval, '술', 1, sysdate);

INSERT INTO review_categrp(review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date)
VALUES(review_categrp_seq.nextval, '안주', 2, sysdate);

INSERT INTO review_categrp(review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date)
VALUES(review_categrp_seq.nextval, '기타', 3, sysdate); 


2) 목록
SELECT review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date
FROM review_categrp
ORDER BY review_categrp_no ASC;

3) 조회
SELECT review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date
FROM review_categrp
WHERE review_categrp_no = 1;

4) 수정
UPDATE review_categrp 
SET review_categrp_name='술(SQL 수정)', review_categrp_seqno='1'
WHERE review_categrp_no = 1;

5) 삭제
DELETE FROM review_categrp
WHERE review_categrp_no = 3;

 
6) 출력 순서에 따른 전체 목록
SELECT review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date
FROM review_categrp
ORDER BY review_categrp_seqno ASC;
 
-- 출력 순서 상향, 10 ▷ 1
UPDATE review_categrp
SET review_categrp_seqno = review_categrp_seqno - 1
WHERE review_categrp_no=1;
 
-- 출력순서 하향, 1 ▷ 10
UPDATE review_categrp
SET review_categrp_seqno = review_categrp_seqno + 1
WHERE review_categrp_no=1;
