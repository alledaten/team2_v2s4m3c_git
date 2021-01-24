/**********************************/
/* Table Name: 댓글 */
/**********************************/
DROP TABLE product_reply;

CREATE TABLE product_reply(
        product_reply_no                                NUMBER(10)         NOT NULL         PRIMARY KEY,
        product_no                           NUMBER(10)    NOT     NULL ,
        member_no                            NUMBER(6)         NOT NULL ,
        product_reply_content                               VARCHAR2(1000)         NOT NULL,
        product_reply_passwd                                VARCHAR2(20)         NOT NULL,
        product_reply_rdate                              DATE NOT NULL,
  FOREIGN KEY (product_no) REFERENCES product (product_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE product_reply is '댓글';
COMMENT ON COLUMN product_reply.product_reply_no is '댓글번호';
COMMENT ON COLUMN product_reply.product_no is '상품번호';
COMMENT ON COLUMN product_reply.member_no is '회원 번호';
COMMENT ON COLUMN product_reply.product_reply_content is '내용';
COMMENT ON COLUMN product_reply.product_reply_passwd is '비밀번호';
COMMENT ON COLUMN product_reply.product_reply_rdate is '등록일';

1) 등록
INSERT INTO product_reply(product_reply_no, product_no, member_no, product_reply_content, product_reply_passwd, product_reply_rdate)
VALUES((SELECT NVL(MAX(product_reply_no), 0) + 1 as product_reply_no FROM product_reply),
             1, 1, '댓글1', '1234', sysdate);
INSERT INTO reply(replyno, product_no, memberno, content, passwd, rdate)
VALUES((SELECT NVL(MAX(replyno), 0) + 1 as replyno FROM reply),
             35, 1, '댓글2', '1234', sysdate);
INSERT INTO reply(replyno, contentsno, memberno, content, passwd, rdate)
VALUES((SELECT NVL(MAX(replyno), 0) + 1 as replyno FROM reply),
             35, 1, '댓글3', '1234', sysdate);             

commit;

2) 전체 목록
SELECT product_reply_no, product_no, member_no, product_reply_content, product_reply_passwd, product_reply_rdate
FROM product_reply
ORDER BY product_reply_no DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD RDATE
 ------- ---------- -------- ------- ------ ---------------------
       3          1        1 댓글3     1234   2019-12-17 16:59:38.0
       2          1        1 댓글2     1234   2019-12-17 16:59:37.0
       1          1        1 댓글1     1234   2019-12-17 16:59:36.0


3) product_no 별 목록
SELECT replyno, product_no, memberno, content, passwd, rdate
FROM reply
WHERE product_no=1
ORDER BY replyno DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD RDATE
 ------- ---------- -------- ------- ------ ---------------------
       3          1        1 댓글3     1234   2019-12-17 16:59:38.0
       2          1        1 댓글2     1234   2019-12-17 16:59:37.0
       1          1        1 댓글1     1234   2019-12-17 16:59:36.0


4) 삭제
-- 패스워드 검사
SELECT count(passwd) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

 CNT
 ---
   1
   
-- 삭제
DELETE FROM reply
WHERE replyno=1;

COMMIT;

5) contentsno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE contentsno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE contentsno=1;

6) memberno에 해당하는 댓글 수 확인 및 삭제
SELECT COUNT(*) as cnt
FROM reply
WHERE memberno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE memberno=1;

7) 회원 ID의 출력
SELECT m.id,
           r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE (m.memberno = r.memberno) AND r.contentsno=1
ORDER BY r.replyno DESC;

 ID    REPLYNO CONTENTSNO MEMBERNO CONTENT                                                                                                                                                                         PASSWD RDATE
 ----- ------- ---------- -------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------ ---------------------
 user1       3          1        1 댓글 3                                                                                                                                                                            123    2019-12-18 16:46:43.0
 user1       2          1        1 댓글 2                                                                                                                                                                            123    2019-12-18 16:46:39.0
 user1       1          1        1 댓글 1                                                                                                                                                                            123    2019-12-18 16:46:35.0
 
 
8) 삭제용 패스워드 검사
SELECT COUNT(*) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

 CNT
 ---
   0

9) 삭제
DELETE FROM reply
WHERE replyno=1;


10) reply + member join 목록

SELECT m.id,
          r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE m.memberno = r.memberno
ORDER BY r.replyno DESC;

11) reply + member join 조회

SELECT m.id,
          r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE (m.memberno = r.memberno) AND r.contentsno=53
ORDER BY r.replyno DESC;


12) 더보기 버튼 페이징,  contentsno 별 목록
SELECT id, replyno, contentsno, memberno, content, passwd, rdate, r
FROM (
        SELECT id, replyno, contentsno, memberno, content, passwd, rdate, rownum as r
        FROM (
                SELECT m.id,
                           r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
                FROM member m,  reply r
                WHERE (m.memberno = r.memberno) AND r.contentsno=53
                ORDER BY r.replyno DESC
        )
)
WHERE r >= 1 AND r <= 2;
 
 