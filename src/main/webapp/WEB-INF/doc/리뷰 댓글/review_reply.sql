DROP TABLE review_reply;

/**********************************/
/* Table Name: 댓글 */
/**********************************/
CREATE TABLE review_reply(
		review_reply_no               		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		review_no                     		NUMBER(10)		 NOT NULL,
		member_no                     		NUMBER(10)		 NOT NULL,
		review_reply_content          		CLOB		 NOT NULL,
		review_reply_passwd           		VARCHAR2(30)		 NOT NULL,
		review_reply_date             		DATE		 NOT NULL,
  FOREIGN KEY (review_no) REFERENCES review (review_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE review_reply is '댓글';
COMMENT ON COLUMN review_reply.review_reply_no is '댓글 번호';
COMMENT ON COLUMN review_reply.review_no is '리뷰 번호';
COMMENT ON COLUMN review_reply.member_no is '회원번호';
COMMENT ON COLUMN review_reply.review_reply_content is '내용';
COMMENT ON COLUMN review_reply.review_reply_passwd is '비밀번호';
COMMENT ON COLUMN review_reply.review_reply_date is '등록일';

1) 등록
INSERT INTO review_reply(review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date)
VALUES((SELECT NVL(MAX(review_reply_no), 0) + 1 as review_reply_no FROM review_reply),
             24, 1, '댓글1', '1234', sysdate);
INSERT INTO review_reply(review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date)
VALUES((SELECT NVL(MAX(review_reply_no), 0) + 1 as review_reply_no FROM review_reply),
             24, 1, '댓글2', '1234', sysdate);
INSERT INTO review_reply(review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date)
VALUES((SELECT NVL(MAX(review_reply_no), 0) + 1 as review_reply_no FROM review_reply),
             24, 1, '댓글3', '1234', sysdate);
             
2) 전체 목록           
SELECT review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date
FROM review_reply
ORDER BY review_reply_no DESC;

3) review_no 별 조회
SELECT review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date
FROM review_reply
WHERE review_no = 24
ORDER BY review_reply_no DESC;

4) 삭제
DELETE FROM review_reply
WHERE review_reply_no = 5;

5) 댓글의 패스워드 검사
SELECT count(review_reply_passwd) as cnt
FROM review_reply
WHERE review_reply_no = 2 AND review_reply_passwd='1234';

7) review_no 해당하는 댓글 수 확인
SELECT COUNT(*) as cnt
FROM review_reply
WHERE review_no = 24;

8) member_no 해당하는 댓글 수 확인
SELECT COUNT(*) as cnt
FROM review_reply
WHERE member_no = 1;

9) member_no 기반 댓글 삭제
DELETE FROM review_reply
WHERE member_no = 1;

10-1) review_reply + member join 전체 목록

SELECT m.member_id,
           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
FROM member m, review_reply r
WHERE m.member_no = r.member_no 
ORDER BY r.review_reply_no DESC;

5-2) review_reply + member join 목록 + 회원 ID
SELECT m.member_id,
           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
FROM member m, review_reply r
WHERE (m.member_no = r.member_no) AND r.review_no= 24
ORDER BY r.review_reply_no DESC;

5-3) 더보기 버튼 페이징, review_no 별 목록
SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, r
FROM (
        SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, rownum as r
        FROM (
                SELECT m.member_id,
                           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
                FROM member m, review_reply r
                WHERE (m.member_no = r.member_no) AND r.review_no=24
                ORDER BY r.review_reply_no DESC
        )
)
WHERE r >= 1 AND r <= 5;

SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, r
FROM (
        SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, rownum as r
        FROM (
                SELECT m.member_id,
                           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
                FROM member m, review_reply r
                WHERE (m.member_no = r.member_no) AND r.review_no=24
                ORDER BY r.review_reply_no DESC
        )
)
WHERE r >= 6 AND r <= 10;