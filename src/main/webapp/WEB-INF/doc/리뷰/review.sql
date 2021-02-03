DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE review_attachfile CASCADE CONSTRAINTS;

DROP SEQUENCE review_seq;
DROP SEQUENCE review_attachfile;

/**********************************/
/* Table Name: 리뷰 */
/**********************************/

CREATE TABLE review(
		review_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		member_no                     		NUMBER(10)		 NOT NULL,
        product_no                    		NUMBER(10)		 NOT NULL,
		review_title                  		VARCHAR2(100)     NOT NULL,
		review_content                		CLOB         	         NOT NULL,
		review_score                  		NUMBER(2)		     NOT NULL,
		review_good                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		review_view                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		review_reply_cnt              		NUMBER(10)		 DEFAULT 0      NOT NULL,
		review_passwd                 		VARCHAR2(20)		 NOT NULL,
		review_word                   		VARCHAR2(300)     NULL,
		review_date                   		DATE		             NOT NULL,
		review_file                   		    VARCHAR2(100)     NULL,
		review_thumb                  		VARCHAR2(100)	 NULL,
		review_size                   		NUMBER(10)		 DEFAULT 0      NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (product_no) REFERENCES product (product_no)
);

COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.review_no is '리뷰 번호';
COMMENT ON COLUMN review.member_no is '회원번호';
COMMENT ON COLUMN review.product_no is '상품번호';
COMMENT ON COLUMN review.review_title is '제목';
COMMENT ON COLUMN review.review_content is '내용';
COMMENT ON COLUMN review.review_score is '평점';
COMMENT ON COLUMN review.review_good is '추천수';
COMMENT ON COLUMN review.review_view is '조회수';
COMMENT ON COLUMN review.review_reply_cnt is '댓글수';
COMMENT ON COLUMN review.review_passwd is '패스워드';
COMMENT ON COLUMN review.review_word is '검색어';
COMMENT ON COLUMN review.review_date is '등록일';
COMMENT ON COLUMN review.review_file is '메인 이미지 파일';
COMMENT ON COLUMN review.review_thumb is '메인 이미지 섬네일';
COMMENT ON COLUMN review.review_size is '메인 이미지 크기';

CREATE SEQUENCE review_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 1. 등록
-- member_no: 1, review_cate_no: 1, product_no: 1이 사전에 등록이되어 있어야 INSERT 가능
INSERT INTO review(review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1,  1, 'asdf 리뷰', 'asdf 리뷰의 내용', 5, '1234', 'asdf', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 2, '이상재명가 리뷰', '이상재명가 리뷰의 내용', 4, '1234', '이상재명가', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 3, '처음처럼 리뷰', '처음처럼 리뷰의 내용', 3, '1234', '전통주3', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

commit;

2-1) 전체목록
SELECT p.product_no, p.product_name, p.product_cost, p.product_thumb1,
          r.review_no, r.review_title, r.review_score, r.review_date, r.review_thumb,
          m.member_no, m.member_nickname
FROM review r, member m, product p
WHERE r.member_no = m.member_no AND r.product_no = p.product_no
ORDER BY review_no DESC; 

commit;

2-2) product_no별 목록
SELECT p.product_no, p.product_name, p.product_cost, p.product_thumb1,
          r.review_no, r.review_title, r.review_score, r.review_date, r.review_thumb,
          m.member_no, m.member_nickname
FROM review r, member m, product p
WHERE r.member_no = m.member_no AND p.product_no = 1 AND r.product_no = p.product_no
ORDER BY review_no DESC;

2-3) product_no별 검색 목록
1) 검색
① product_no별 검색 목록
SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE product_no = 1 AND review_word LIKE '%asdf%'
ORDER BY review_no DESC;

SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE product_no = 1 AND (review_title LIKE '%asdf%' OR review_content LIKE '%asdf%' OR review_word LIKE 'aasdf%')
ORDER BY review_no DESC;

2-4) 전체 레코드 검색 갯수
SELECT COUNT(*) as review_cnt
FROM review

2-5) product_no 별 검색된 레코드 갯수
SELECT COUNT(*) as review_cnt
FROM review
WHERE product_no = 1 AND review_word LIKE '%asdf%';

SELECT COUNT(*) as review_cnt
FROM review
WHERE product_no = 1 AND (review_title LIKE '%수정%' OR review_content LIKE '%리뷰%' OR review_word LIKE '%리뷰%')

3) 1건 조회
SELECT r.review_no, r.review_title, r.review_content, r.review_score, r.review_passwd, r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size,
          m.member_no, m.member_nickname,
          p.product_no, p.product_name, p.product_cost, p.product_thumb1
FROM review r, member m, product p
WHERE r.review_no = 1
                                AND r.member_no = m.member_no
                                AND r.product_no = p.product_no

4) 수정
UPDATE review 
SET review_title='수정', review_content='내용 수정', review_score = 5, review_word='검색어 수정'
WHERE review_no = 7;

5) 패스워드 검사
SELECT COUNT(*) as passwd_cnt
FROM review
WHERE review_no=1 AND review_passwd='123';

SELECT review_no, review_passwd
FROM review 
ORDER BY review_no ASC;   

6) 삭제
-- 전체 레코드 삭제
DELETE FROM review;
COMMIT;  

DELETE FROM review
WHERE review_no=1;

7) 모든 레코드 갯수
SELECT COUNT(*) as review_cnt
FROM review;

8) 특정 회원이 작성한 글만 출력: review_cate + review + member + product
SELECT p.product_no as p_product_no, p.product_name as p_product_name, p.product_cost as p_product_cost, p.product_thumb1 as p_product_thumb1,
          r.review_no as r_review_no, r.review_title as r_review_title, r.review_score as r_review_score, r.review_date as r_review_date,
          m.member_no as m_member_no, m.member_nickname as m_member_nickname        
FROM   review r, member m, product p
WHERE r.member_no = m.member_no AND m.member_no = 1 AND r.product_no = p.product_no
ORDER BY p.product_no ASC, r.review_no DESC;

-- ANSI 이거 주의!
SELECT p.product_no as p_product_no, p.product_name as p_product_name, p.product_cost as p_product_cost, p.product_thumb1 as p_product_thumb1,
          r.review_no as r_review_no, r.review_title as r_review_title, r.review_score as r_review_score, r.review_date as r_review_date,
          m.member_no as m_member_no, m.member_nickname as m_member_nickname        
FROM product p
INNER JOIN review r
ON p.product_no = r.product_no
INNER JOIN member m
ON r.member_no = m.member_no
WHERE m.member_no = 1
ORDER BY p.product_no ASC, r.review_no DESC;

9) 첨부 파일 변경(등록, 변경, 수정, 삭제)
UPDATE review
SET review_file='file name', review_thumb='thumb file name', review_size=5000
WHERE review_no=1; 
  

9) 검색 + 페이징 + 메인 이미지
-- step 1
SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size
FROM review
WHERE product_no = 1 AND review_word LIKE '%검색어%'
ORDER BY review_no DESC;

-- step 2
SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size, rownum as r
FROM (
          SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
                    review_file, review_thumb, review_size
          FROM review
          WHERE product_no = 1 AND review_word LIKE '%검색어%'
          ORDER BY review_no DESC
);

-- step 3, 1 page
SELECT review_no, member_no, member_nickname, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, r
FROM (
        SELECT review_no, member_no, member_nickname, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, rownum as r
           FROM (
                     SELECT  r.review_no, r.member_no, m.member_nickname, p.product_no, r.review_title, r.review_content, r.review_score, r.review_good, r.review_view, re.review_reply_cnt, 
                                r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size
                     FROM review r, member m, product p, review_reply re
                     WHERE r.product_no = 2
                                AND r.member_no = m.member_no
                                AND r.product_no = p.product_no
                                AND r.review_reply_cnt = re.review_reply_cnt
                                AND (review_title LIKE '%%' OR review_content LIKE '%%' OR review_word LIKE '%%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 1 AND r <= 10;

-- step 3, 2 page
SELECT review_no, member_no, member_nickname, review_cate_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, r
FROM (
        SELECT review_no, member_no, member_nickname, review_cate_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, rownum as r
           FROM (
                     SELECT  r.review_no, r.member_no, m.member_nickname, r.review_cate_no, p.product_no, r.review_title, r.review_content, r.review_score, r.review_good, r.review_view, r.review_reply_cnt, 
                                r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size
                     FROM review r, member m, product p
                     WHERE review_cate_no = 3
                                AND r.member_no = m.member_no
                                AND r.product_no = p.product_no
                                AND (review_title LIKE '%%' OR review_content LIKE '%%' OR review_word LIKE '%%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 11 AND r <= 20;

-------------------------------------------------------------------------------------------------------------------------------------------------------------- 
-- 리뷰 전체목록 + 검색 + 페이징 추가 2021-02-02

SELECT review_no, member_no, member_nickname, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, r
FROM (
        SELECT review_no, member_no, member_nickname, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, rownum as r
           FROM (
                     SELECT  r.review_no, r.member_no, m.member_nickname, p.product_no, r.review_title, r.review_content, r.review_score, r.review_good, r.review_view, r.review_reply_cnt, 
                                r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size
                     FROM review r, member m, product p
                     WHERE  r.member_no = m.member_no
                                AND r.product_no = p.product_no
                                AND (review_title LIKE '%%' OR review_content LIKE '%%' OR review_word LIKE '%%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 1 AND r <= 10;

--------------------------------------------------------------------------------------------------------------------------------------------------------------
 
   
10 - 1) 댓글수 증가
UPDATE review
SET review_reply_cnt = review_reply_cnt + 1
WHERE review_no = 1;

10 - 2) 댓글수 감소
UPDATE review
SET review_reply_cnt = review_reply_cnt - 1
WHERE review_no = 1;

10 - 3) 댓글수 초기화
UPDATE review
SET review_reply_cnt = 0;

11 - 1) 조회수 증가
UPDATE review
SET review_view = review_view + 1
WHERE review_no = 1;

11 - 2) 조회수 초기화
UPDATE review
SET review_view = 0;

12 - 1) 좋아요
UPDATE review
SET review_good = review_good + 1
WHERE review_no = 1;

12 - 2) 좋아요 초기화
UPDATE review
SET review_good = 0;



