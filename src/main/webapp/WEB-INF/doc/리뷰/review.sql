DROP TABLE review CASCADE CONSTRAINTS;
DROP TABLE review_attachfile CASCADE CONSTRAINTS;

DROP SEQUENCE review_seq;
DROP SEQUENCE review_attachfile;

/**********************************/
/* Table Name: ���� */
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

COMMENT ON TABLE review is '����';
COMMENT ON COLUMN review.review_no is '���� ��ȣ';
COMMENT ON COLUMN review.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN review.product_no is '��ǰ��ȣ';
COMMENT ON COLUMN review.review_title is '����';
COMMENT ON COLUMN review.review_content is '����';
COMMENT ON COLUMN review.review_score is '����';
COMMENT ON COLUMN review.review_good is '��õ��';
COMMENT ON COLUMN review.review_view is '��ȸ��';
COMMENT ON COLUMN review.review_reply_cnt is '��ۼ�';
COMMENT ON COLUMN review.review_passwd is '�н�����';
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
-- member_no: 1, review_cate_no: 1, product_no: 1�� ������ ����̵Ǿ� �־�� INSERT ����
INSERT INTO review(review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1,  1, 'asdf ����', 'asdf ������ ����', 5, '1234', 'asdf', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 2, '�̻���� ����', '�̻���� ������ ����', 4, '1234', '�̻����', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO review(review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,
                              review_file, review_thumb, review_size)
VALUES(review_seq.nextval, 1, 3, 'ó��ó�� ����', 'ó��ó�� ������ ����', 3, '1234', '������3', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

commit;

2-1) ��ü���
SELECT p.product_no, p.product_name, p.product_cost, p.product_thumb1,
          r.review_no, r.review_title, r.review_score, r.review_date, r.review_thumb,
          m.member_no, m.member_nickname
FROM review r, member m, product p
WHERE r.member_no = m.member_no AND r.product_no = p.product_no
ORDER BY review_no DESC; 

commit;

2-2) product_no�� ���
SELECT p.product_no, p.product_name, p.product_cost, p.product_thumb1,
          r.review_no, r.review_title, r.review_score, r.review_date, r.review_thumb,
          m.member_no, m.member_nickname
FROM review r, member m, product p
WHERE r.member_no = m.member_no AND p.product_no = 1 AND r.product_no = p.product_no
ORDER BY review_no DESC;

2-3) product_no�� �˻� ���
1) �˻�
�� product_no�� �˻� ���
SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE product_no = 1 AND review_word LIKE '%asdf%'
ORDER BY review_no DESC;

SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_passwd, review_word, review_date,  review_file, review_thumb, review_size
FROM review
WHERE product_no = 1 AND (review_title LIKE '%asdf%' OR review_content LIKE '%asdf%' OR review_word LIKE 'aasdf%')
ORDER BY review_no DESC;

2-4) ��ü ���ڵ� �˻� ����
SELECT COUNT(*) as review_cnt
FROM review

2-5) product_no �� �˻��� ���ڵ� ����
SELECT COUNT(*) as review_cnt
FROM review
WHERE product_no = 1 AND review_word LIKE '%asdf%';

SELECT COUNT(*) as review_cnt
FROM review
WHERE product_no = 1 AND (review_title LIKE '%����%' OR review_content LIKE '%����%' OR review_word LIKE '%����%')

3) 1�� ��ȸ
SELECT r.review_no, r.review_title, r.review_content, r.review_score, r.review_passwd, r.review_word, r.review_date, r.review_file, r.review_thumb, r.review_size,
          m.member_no, m.member_nickname,
          p.product_no, p.product_name, p.product_cost, p.product_thumb1
FROM review r, member m, product p
WHERE r.review_no = 1
                                AND r.member_no = m.member_no
                                AND r.product_no = p.product_no

4) ����
UPDATE review 
SET review_title='����', review_content='���� ����', review_score = 5, review_word='�˻��� ����'
WHERE review_no = 7;

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

8) Ư�� ȸ���� �ۼ��� �۸� ���: review_cate + review + member + product
SELECT p.product_no as p_product_no, p.product_name as p_product_name, p.product_cost as p_product_cost, p.product_thumb1 as p_product_thumb1,
          r.review_no as r_review_no, r.review_title as r_review_title, r.review_score as r_review_score, r.review_date as r_review_date,
          m.member_no as m_member_no, m.member_nickname as m_member_nickname        
FROM   review r, member m, product p
WHERE r.member_no = m.member_no AND m.member_no = 1 AND r.product_no = p.product_no
ORDER BY p.product_no ASC, r.review_no DESC;

-- ANSI �̰� ����!
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

9) ÷�� ���� ����(���, ����, ����, ����)
UPDATE review
SET review_file='file name', review_thumb='thumb file name', review_size=5000
WHERE review_no=1; 
  

9) �˻� + ����¡ + ���� �̹���
-- step 1
SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size
FROM review
WHERE product_no = 1 AND review_word LIKE '%�˻���%'
ORDER BY review_no DESC;

-- step 2
SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
          review_file, review_thumb, review_size, rownum as r
FROM (
          SELECT review_no, member_no, product_no, review_title, review_content, review_score, review_good, review_view, review_reply_cnt, review_word, review_date,
                    review_file, review_thumb, review_size
          FROM review
          WHERE product_no = 1 AND review_word LIKE '%�˻���%'
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
-- ���� ��ü��� + �˻� + ����¡ �߰� 2021-02-02

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
 
   
10 - 1) ��ۼ� ����
UPDATE review
SET review_reply_cnt = review_reply_cnt + 1
WHERE review_no = 1;

10 - 2) ��ۼ� ����
UPDATE review
SET review_reply_cnt = review_reply_cnt - 1
WHERE review_no = 1;

10 - 3) ��ۼ� �ʱ�ȭ
UPDATE review
SET review_reply_cnt = 0;

11 - 1) ��ȸ�� ����
UPDATE review
SET review_view = review_view + 1
WHERE review_no = 1;

11 - 2) ��ȸ�� �ʱ�ȭ
UPDATE review
SET review_view = 0;

12 - 1) ���ƿ�
UPDATE review
SET review_good = review_good + 1
WHERE review_no = 1;

12 - 2) ���ƿ� �ʱ�ȭ
UPDATE review
SET review_good = 0;



