DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE review_cate CASCADE CONSTRAINTS;
DROP TABLE review_categrp CASCADE CONSTRAINTS;
DROP TABLE review_attachfile CASCADE CONSTRAINTS;

DROP SEQUENCE review_seq CASCADE CONSTRAINTS;
DROP SEQUENCE review_cate_seq CASCADE CONSTRAINTS;
DROP SEQUENCE review_categrp_seq CASCADE CONSTRAINTS;
DROP SEQUENCE review_seq CASCADE CONSTRAINTS;

/**********************************/
/* Table Name: ���� */
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

COMMENT ON TABLE review is '����';
COMMENT ON COLUMN review.review_no is '���� ��ȣ';
COMMENT ON COLUMN review.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN review.review_cate_no is '���� ī�װ� ��ȣ';
COMMENT ON COLUMN review.review_title is '����';
COMMENT ON COLUMN review.review_content is '����';
COMMENT ON COLUMN review.review_score is '����';
COMMENT ON COLUMN review.review_good is '��õ��';
COMMENT ON COLUMN review.review_view is '��ȸ��';
COMMENT ON COLUMN review.review_reply_cnt is '��ۼ�';
COMMENT ON COLUMN review.review_passwd is '�н�����';
COMMENT ON COLUMN review.review_grpno is '�׷��ȣ';
COMMENT ON COLUMN review.review_indent is '�鿩���� �� �亯����';
COMMENT ON COLUMN review.review_answer_no is '�亯����';
COMMENT ON COLUMN review.review_word is '�˻���';
COMMENT ON COLUMN review.review_date is '�����';
COMMENT ON COLUMN review.review_file is '���� �̹��� ����';
COMMENT ON COLUMN review.review_thumb is '���� �̹��� ������';
COMMENT ON COLUMN review.review_size is '���� �̹��� ũ��';

CREATE SEQUENCE review_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- 1. ���
-- member_no: 1, review_cate_no: 1�� ������ ����̵Ǿ� �־�� INSERT ����
INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 1, 'Ź�� ����', 'Ź�� ������ ����', 5, '1234', '������, Ź��', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 2, '���� 2', '���� 2�� ����', 4, '123', '������2', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 3, '���� 3', '���� 3�� ����', 3, '123', '������3', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 2, 3, '���� 4', '���� 4�� ����', 2, '123', '������4', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

2-1) ��ü���
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date, review_file, review_thumb, review_size
FROM review 
ORDER BY review_no DESC; 

commit;

2-2) review_cate_no�� ���
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review 
WHERE review_cate_no = 1
ORDER BY review_no DESC;

2-3) review_cate_no�� �˻� ���
1) �˻�
�� review_cate_no�� �˻� ���
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE review_cate_no=1 AND review_word LIKE '%������%'
ORDER BY review_no DESC;

SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE review_cate_no=1 AND (review_title LIKE '%����%' OR review_content LIKE '%����%' OR review_word LIKE '������%')
ORDER BY review_no DESC;

2-4) ��ü ���ڵ� �˻� ����
SELECT COUNT(*) as review_cnt
FROM review
WHERE review_no=1;

2-5) cateno �� �˻��� ���ڵ� ����
SELECT COUNT(*) as review_cnt
FROM review
WHERE review_cate_no=1 AND review_word LIKE '%������%';

SELECT COUNT(*) as review_cnt
FROM review
WHERE review_cate_no=1 AND (review_title LIKE '%����%' OR review_content LIKE '%������%' OR review_word LIKE '%����%')

3) 1�� ��ȸ
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE review_cate_no = 1;

4) ����
UPDATE review 
SET review_title='�����ߴٰ�', review_content='���� ����', review_score = 10, review_word='�˻��� ����'
WHERE review_no = 13;

5) �н����� �˻�
SELECT COUNT(*) as passwd_cnt
FROM review
WHERE review_no=1 AND review_passwd='123';

SELECT review_no, review_passwd
FROM review 
ORDER BY review_no ASC;   

6) ����
-- ��ü ���ڵ� ����
DELETE FROM review;
COMMIT;  

DELETE FROM review
WHERE review_no=1;


7) ��� ���ڵ� ����
SELECT COUNT(*) as review_cnt
FROM review;

8) Ư�� ȸ���� �ۼ��� �۸� ���: review_cate + review + member
SELECT c.review_cate_no as c_review_cate_no, c.review_cate_name as c_review_cate_name, c.review_cate_date as c_review_cate_date,
          r.review_no as r_review_no, r.review_title as r_review_title, r.review_score as r_review_score, r.review_date as r_review_date,
          m.member_no as m_member_no, m.member_nickname as m_member_nickname        
FROM review_cate c, review r, member m
WHERE c.review_cate_no = r.review_cate_no AND r.member_no = m.member_no AND m.member_no = 1
ORDER BY c.review_cate_no ASC, r.review_no DESC;

-- ANSI �̰� ����!
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

9) ÷�� ���� ����(���, ����, ����, ����)
UPDATE review
SET review_file='file name', review_thumb='thumb file name', review_size=5000
WHERE review_no=13; 
  
SELECT review_no, member_no, review_cate_no, review_file, review_thumb, review_size
FROM review 
ORDER BY review_no ASC; 


9) �˻� + ����¡ + ���� �̹���
-- step 1
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size
FROM review
WHERE review_cate_no=1 AND review_word LIKE '%�˻���%'
ORDER BY review_no DESC;

-- step 2
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size, rownum as r
FROM (
          SELECT review_no, member_no, review_cate_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
                    review_file, review_thumb, review_size
          FROM review
          WHERE review_cate_no=1 AND review_word LIKE '%������%'
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
                                AND (review_title LIKE '%Ź��%' OR review_content LIKE '%Ź��%' OR review_word LIKE '%Ź��%')                           
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
                                AND (review_title LIKE '%Ź��%' OR review_content LIKE '%Ź��%' OR review_word LIKE '%Ź��%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 11 AND r <= 20;

----------------------------------------------------------------------------------------------
10) �亯 ���� ����
----------------------------------------------------------------------------------------------
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM review_categrp;
SELECT * FROM review_cate;

DROP TABLE contents  CASCADE CONSTRAINTS;

1) ��� ����
- grpno: ���Ӱ� ���� ����ϸ� �ϳ��� �ű� �׷��� ������, (SELECT NVL(MAX(grpno), 0) + 1 FROM contents), 0, 0)
- indent: �鿩 ����, n�� �亯�� ���� ȿ��
- ansnum: �亯 ���� ����
INSERT INTO review(review_no, member_no, review_cate_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                               review_file, review_thumb, review_size, review_grpno, review_indent, review_answer_no)
VALUES(review_seq.nextval, 1, 1, '���� 1', '���� 1�� ����', 8, '123', '������', sysdate, 'spring.jpg', 'spring_t.jpg', 23657,
           (SELECT NVL(MAX(review_grpno), 0) + 1 FROM review), 0, 0);
           
2) 1�� ��ȸ ����
SELECT review_no, member_no, review_cate_no, review_title, review_content, review_good, review_passwd, review_word, review_date,
          review_file, review_thumb, review_size, review_grpno, review_indent, review_answer_no
FROM review
WHERE review_no = 1;

3) ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE review
SET review_answer_no = review_answer_no + 1
WHERE review_grpno = 1 AND review_answer_no > 5;
 

4) �亯 ���
- review_cate_no: FK, member_no: FK
 
INSERT INTO review(review_no,
                          review_cate_no, member_no, review_title, review_content, review_score, review_passwd, review_good, review_thumb, review_file, review_size, review_view, review_reply_cnt, review_date, 
                          review_grpno, review_indent, review_answer_no, review_word)  
VALUES((SELECT NVL(MAX(review_no), 0) + 1 as review_no FROM review),
            1, 1, '����', '����', 10, '1234', 0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
5) �亯�� ���� ���� ���� ����    
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
                     WHERE review_cate_no=1 AND (review_title LIKE '%����%' OR review_content LIKE '%������%' OR review_word LIKE '%����%')
                     ORDER BY review_grpno DESC, review_answer_no ASC
           )          
)
WHERE r >= 1 AND r <= 10;          
   
----------------------------------------------------------------------------------------------
�亯 ���� ����
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
�亯 + memer join start
----------------------------------------------------------------------------------------------
SELECT r.review_no, r.member_no, r.review_cate_no, m.member_id       -- join�� �Ǵ��� �׽�Ʈ, join�� �Ϲ���(��ټ�)���� �ڽ� ���̺� �����ȴ�
from review r, member m
where r.member_no = m.member_no;

CONTENTSNO   MEMBERNO     CATENO ID                  
---------- ---------- ---------- --------------------
        50          3          2 user1               
        45          3          2 user1               
        54          3          2 user1               
        53          3          2 user1               
        51          3          2 user1  

-- 2���� ���̺� �÷��� �ߺ��Ǵ� ���(���⼭�� id) as�� ����Ͽ� �÷��� �����Ѵ�(mid, �� m_id�� �ϰ� �;���)
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
                               AND (review_title LIKE '%����%' OR review_content LIKE '%����%' OR review_word LIKE '%����%')
                     ORDER BY review_grpno DESC, review_answer_no ASC
           )          
)
WHERE r >= 1 AND r <= 10;     
----------------------------------------------------------------------------------------------
�亯 + memer join end
----------------------------------------------------------------------------------------------
   
1) ��ۼ� ����
UPDATE review
SET review_reply_cnt = review_reply_cnt + 1
WHERE review_no = 1;

2) ��ۼ� ����
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
                                AND (review_title LIKE '%Ź��%' OR review_content LIKE '%Ź��%' OR review_word LIKE '%Ź��%')                           
                     ORDER BY review_no DESC
           )      
)
WHERE r >= 1 AND r <= 10;
