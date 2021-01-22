DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE review_cate CASCADE CONSTRAINTS;
DROP TABLE review_categrp CASCADE CONSTRAINTS;
DROP TABLE review_attachfile CASCADE CONSTRAINTS;

DROP SEQUENCE review_seq CASCADE CONSTRAINTS;
DROP SEQUENCE review_cate_seq CASCADE CONSTRAINTS;
DROP SEQUENCE review_categrp_seq CASCADE CONSTRAINTS;
DROP SEQUENCE review_seq CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: 리뷰 */
/**********************************/

CREATE TABLE review(
		review_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		member_no                     		NUMBER(10)		 NOT NULL,
		review_cate_no                		NUMBER(10)		 NOT NULL,
		review_title                  		VARCHAR2(100)     NOT NULL,
		review_content                		CLOB         	         NOT NULL,
		review_score                  		NUMBER(2)		     NOT NULL,
		review_good                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		review_view                   		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		review_reply_cnt              		NUMBER(10)		 DEFAULT 0      NOT NULL,
		review_passwd                 		VARCHAR2(20)		 NOT NULL,
		review_grpno                  		NUMBER(10)		 DEFAULT 0      NOT NULL,
		review_indent                 		NUMBER(3)		     DEFAULT 0      NOT NULL,
		review_answer_no                  NUMBER(3)		     DEFAULT 0      NOT NULL,
		review_word                   		VARCHAR2(300)     NULL,
		review_date                   		DATE		             NOT NULL,
		review_file                   		    VARCHAR2(100)     NULL,
		review_thumb                  		VARCHAR2(100)	 NULL,
		review_size                   		NUMBER(10)		 DEFAULT 0      NULL,
  FOREIGN KEY (review_cate_no) REFERENCES review_cate (review_cate_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE review is '리뷰';
COMMENT ON COLUMN review.review_no is '리뷰 번호';
COMMENT ON COLUMN review.member_no is '회원번호';
COMMENT ON COLUMN review.review_cate_no is '리뷰 카테고리 번호';
COMMENT ON COLUMN review.review_title is '제목';
COMMENT ON COLUMN review.review_content is '내용';
COMMENT ON COLUMN review.review_score is '평점';
COMMENT ON COLUMN review.review_good is '추천수';
COMMENT ON COLUMN review.review_view is '조회수';
COMMENT ON COLUMN review.review_reply_cnt is '댓글수';
COMMENT ON COLUMN review.review_passwd is '패스워드';
COMMENT ON COLUMN review.review_grpno is '그룹번호';
COMMENT ON COLUMN review.review_indent is '들여쓰기 및 답변차수';
COMMENT ON COLUMN review.review_answer_no is '답변순서';
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
-- member_no: 1, review_cate_no: 1이 사전에 등록이되어 있어야 INSERT 가능
INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 1, '탁주 리뷰', '탁주 리뷰의 내용', 5, '1234', '전통주, 탁주', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 2, '리뷰 2', '리뷰 2의 내용', 4, '123', '전통주2', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 3, '리뷰 3', '리뷰 3의 내용', 3, '123', '전통주3', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 2, 3, '리뷰 4', '리뷰 4의 내용', 2, '123', '전통주4', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

2-1) 전체목록
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date, review_file, review_thumb, review_size
FROM review 
ORDER BY review_no DESC; 

commit;

2-2) review_cate_no별 목록
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review 
WHERE review_cate_no = 1
ORDER BY review_no DESC;

2-3) review_cate_no별 검색 목록
1) 검색
① review_cate_no별 검색 목록
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE review_cate_no=1 AND review_word LIKE '%전통주%'
ORDER BY review_no DESC;

SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE review_cate_no=1 AND (review_title LIKE '%유럽%' OR review_content LIKE '%유럽%' OR review_word LIKE '전통주%')
ORDER BY review_no DESC;

2-4) 전체 레코드 검색 갯수
SELECT COUNT(*) as review_cnt
FROM review
WHERE review_no=1;

2-5) cateno 별 검색된 레코드 갯수
SELECT COUNT(*) as review_cnt
FROM review
WHERE review_cate_no=1 AND review_word LIKE '%전통주%';

SELECT COUNT(*) as review_cnt
FROM review
WHERE review_cate_no=1 AND (review_title LIKE '%리뷰%' OR review_content LIKE '%전통주%' OR review_word LIKE '%유럽%')

3) 1건 조회
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE review_cate_no = 1;

4) 수정
UPDATE review 
SET review_title='수정했다고', review_content='내용 수정', review_score = 10, review_word='검색어 수정'
WHERE review_no = 13;

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

8) 특정 회원이 작성한 글만 출력: review_cate + review + member
SELECT c.review_cate_no as c_review_cate_no, c.review_cate_name as c_review_cate_name, c.review_cate_date as c_review_cate_date,
          r.review_no as r_review_no, r.review_title as r_review_title, r.review_score as r_review_score, r.review_date as r_review_date,
          m.member_no as m_member_no, m.member_nickname as m_member_nickname        
FROM review_cate c, review r, member m
WHERE c.review_cate_no = r.review_cate_no AND r.member_no = m.member_no AND m.member_no = 1
ORDER BY c.review_cate_no ASC, r.review_no DESC;

-- ANSI 이거 주의!
SELECT c.review_cate_no as c_review_cate_no, c.review_cate_name as c_review_cate_name, c.review_cate_date as c_review_cate_date,
          r.review_no as r_review_no, r.review_title as r_review_title, r.review_score as r_review_score, r.review_date as r_review_date,
          m.member_no as m_member_no, m.member_nickname as m_member_nickname        
FROM review_cate c
INNER JOIN review r
ON c.review_cate_no = c.review_cate_no
INNER JOIN member m
ON r.member_no = m.member_no
WHERE m.member_no = 1
ORDER BY c.review_cate_no ASC, r.review_no DESC;

9) 첨부 파일 변경(등록, 변경, 수정, 삭제)
UPDATE review
SET review_file='file name', review_thumb='thumb file name', review_size=5000
WHERE review_no=13; 
  
SELECT review_no, member_no, review_cate_no, review_file, review_thumb, review_size
FROM review 
ORDER BY review_no ASC; 


9) 검색 + 페이징 + 메인 이미지
-- step 1
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size
FROM review
WHERE review_cate_no=1 AND review_word LIKE '%검색어%'
ORDER BY review_no DESC;

-- step 2
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size, rownum as r
FROM (
          SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
                    review_file, review_thumb, review_size
          FROM review
          WHERE review_cate_no=1 AND review_word LIKE '%전통주%'
          ORDER BY review_no DESC
);

-- step 3, 1 page
SELECT review_no, member_no, member_nickname, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, r
FROM (
        SELECT review_no, member_no, member_nickname, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, rownum as r
           FROM (
                     SELECT  r.review_no, r.member_no, m.member_nickname, r.review_cate_no, r.review_title, r.review_content, r.review_score, r.review_good, r.review_view, r.review_reply_cnt, 
                                r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size
                     FROM review r, member m
                     WHERE review_cate_no = 1 
                                AND r.member_no = m.member_no
                                AND (review_title LIKE '%탁주%' OR review_content LIKE '%탁주%' OR review_word LIKE '%탁주%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 1 AND r <= 10;

-- step 3, 2 page
SELECT review_no, member_no, member_nickname, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, r
FROM (
        SELECT review_no, member_no, member_nickname, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, rownum as r
           FROM (
                     SELECT  r.review_no, r.member_no, m.member_nickname, r.review_cate_no, r.review_title, r.review_content, r.review_score, r.review_good, r.review_view, r.review_reply_cnt, 
                                r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size
                     FROM review r, member m
                     WHERE review_cate_no = 1 
                                AND r.member_no = m.member_no
                                AND (review_title LIKE '%탁주%' OR review_content LIKE '%탁주%' OR review_word LIKE '%탁주%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 11 AND r <= 20;

----------------------------------------------------------------------------------------------
10) 답변 관련 시작
----------------------------------------------------------------------------------------------
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM review_categrp;
SELECT * FROM review_cate;

DROP TABLE contents  CASCADE CONSTRAINTS;

1) 등록 변경
- grpno: 새롭게 글을 등록하면 하나의 신규 그룹이 생성됨, (SELECT NVL(MAX(grpno), 0) + 1 FROM contents), 0, 0)
- indent: 들여 쓰기, n차 답변에 대한 효과
- ansnum: 답변 순서 지정
INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                               review_file, review_thumb, review_size, review_grpno, review_indent, review_answer_no)
VALUES(review_seq.nextval, 1, 1, '리뷰 1', '리뷰 1의 내용', 8, '123', '전통주', sysdate, 'spring.jpg', 'spring_t.jpg', 23657,
           (SELECT NVL(MAX(review_grpno), 0) + 1 FROM review), 0, 0);
           
2) 1건 조회 변경
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_good, review_passwd, review_word, review_date,
          review_file, review_thumb, review_size, review_grpno, review_indent, review_answer_no
FROM review
WHERE review_no = 1;

3) 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 5;
 

4) 답변 등록
- review_cate_no: FK, member_no: FK
 
INSERT INTO review(review_no,
                          review_cate_no, member_no, review_title, review_content, review_score, review_passwd, review_good, review_thumb, review_file, review_size, review_view, review_reply_cnt, review_date, 
                          review_grpno, review_indent, review_answer_no, review_word)  
VALUES((SELECT NVL(MAX(review_no), 0) + 1 as review_no FROM review),
            1, 1, '제목', '내용', 10, '1234', 0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
5) 답변에 따른 정렬 순서 변경    
-- ORDER BY grpno DESC, ansnum ASC
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_good, review_view, review_reply_cnt, review_date, review_word,
          review_file, review_thumb, review_size,
          review_grpno, review_indent, review_answer_no, r
FROM (
           SELECT review_no, member_no, review_cate_no, review_title, review_content, review_good, review_view, review_reply_cnt, review_date, review_word,
                     review_file, review_thumb, review_size,
                     review_grpno, review_indent, review_answer_no, rownum as r
           FROM (
                     SELECT review_no, member_no, review_cate_no, review_title, review_content, review_good, review_view, review_reply_cnt, review_date, review_word,
                               review_file, review_thumb, review_size,
                               review_grpno, review_indent, review_answer_no
                     FROM review
                     WHERE review_cate_no=1 AND (review_title LIKE '%맥주%' OR review_content LIKE '%전통주%' OR review_word LIKE '%수정%')
                     ORDER BY review_grpno DESC, review_answer_no ASC
           )          
)
WHERE r >= 1 AND r <= 10;          
   
----------------------------------------------------------------------------------------------
답변 관련 종료
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
답변 + memer join start
----------------------------------------------------------------------------------------------
SELECT r.review_no, r.member_no, r.review_cate_no, m.member_id       -- join이 되는지 테스트, join은 일반적(대다수)으로 자식 테이블에 구현된다
from review r, member m
where r.member_no = m.member_no;

CONTENTSNO   MEMBERNO     CATENO ID                  
---------- ---------- ---------- --------------------
        50          3          2 user1               
        45          3          2 user1               
        54          3          2 user1               
        53          3          2 user1               
        51          3          2 user1  

-- 2개의 테이블에 컬럼이 중복되는 경우(여기서는 id) as를 사용하여 컬럼명를 변경한다(mid, 난 m_id로 하고 싶었음)
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_good, review_view, review_reply_cnt, review_date, review_word,
          review_file, review_thumb, review_size,
          review_grpno, review_indent, review_answer_no, mid, r
FROM (
           SELECT review_no, member_no, review_cate_no, review_title, review_content, review_good, review_view, review_reply_cnt, review_date, review_word,
                     review_file, review_thumb, review_size,
                     review_grpno, review_indent, review_answer_no, mid, rownum as r
           FROM (
                     SELECT r.review_no, r.member_no, r.review_cate_no, r.review_title, r.review_content, r.review_good, r.review_view, r.review_reply_cnt, r.review_date, r.review_word,
                               r.review_file, r.review_thumb, r.review_size, r.review_grpno, r.review_indent, r.review_answer_no,
                               m.member_id as mid
                     FROM review r, member m
                     WHERE review_cate_no=1 
                               AND r.member_no = m.member_no 
                               AND (review_title LIKE '%맥주%' OR review_content LIKE '%내용%' OR review_word LIKE '%수정%')
                     ORDER BY review_grpno DESC, review_answer_no ASC
           )          
)
WHERE r >= 1 AND r <= 10;     
----------------------------------------------------------------------------------------------
답변 + memer join end
----------------------------------------------------------------------------------------------
   
1) 댓글수 증가
UPDATE review
SET review_reply_cnt = review_reply_cnt + 1
WHERE review_no = 1;

2) 댓글수 감소
UPDATE review
SET review_reply_cnt = review_reply_cnt - 1
WHERE review_no = 1;
  


SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1, grpno, indent, ansnum, mid, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                     file1, thumb1, size1, grpno, indent, ansnum, mid, rownum as r
           FROM (
                     SELECT c.contentsno, c.memberno, c.cateno, c.title, c.content, c.recom, c.cnt, c.replycnt, c.rdate, c.word, c.ip,
                               c.file1, c.thumb1, c.size1, c.grpno, c.indent, c.ansnum,
                               m.id as mid
                     FROM contents c, member m
                     WHERE cateno=29 
                               AND c.memberno = m.memberno 
                               AND (title LIKE '%swiss%' OR content LIKE '%swiss%' OR word LIKE '%swiss%')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;  


=====================================

SELECT review_no, member_no, member_nickname, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, r
FROM (
        SELECT review_no, member_no, member_nickname, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date, review_file, 
          review_thumb, review_size, rownum as r
           FROM (
                     SELECT  r.review_no, r.member_no, m.member_nickname, r.review_cate_no, r.review_title, r.review_content, r.review_score, r.review_good, r.review_view, r.review_reply_cnt, 
                                r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size
                     FROM review r, member m
                     WHERE review_cate_no = 1 
                                AND r.member_no = m.member_no
                                AND (review_title LIKE '%탁주%' OR review_content LIKE '%탁주%' OR review_word LIKE '%탁주%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 1 AND r <= 10;
