DROP TABLE review_cate;
DROP SEQUENCE review_cate_seq;

/**********************************/
/* Table Name: ���� ī�װ� */
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
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

-- 1) ���
INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, 'Ź��', 1, sysdate, 0);

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, '���� �� û��', 2, sysdate, 0);

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, '������', 3, sysdate, 0); 

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 1, '������', 4, sysdate, 0); 

INSERT INTO review_cate(review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt)
VALUES(review_cate_seq.nextval, 2, '���', 5, sysdate, 0); 

-- 2) ���
SELECT review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt
FROM review_cate
ORDER BY review_cate_no ASC;

-- 3) ��ȸ(ī�װ� ��ȣ(PK)���� ��ȸ)
SELECT review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt
FROM review_cate
WHERE review_cate_no=3;

-- 4) ����(ī�װ� ��ȣ(PK)���� ����)
UPDATE review_cate
SET review_categrp_no=3, review_cate_name='������ ī�װ� ����(�̸�,����,��ۼ�)', review_cate_seqno=4, review_cate_cnt=10
WHERE review_cate_no = 3;

-- 5) ����(ī�װ� ��ȣ(PK)���� ����)
DELETE review_cate
WHERE review_cate_no = 6;

-- 6 - 1) ��¼��� ����
UPDATE review_cate
SET review_cate_seqno = review_cate_seqno - 1
WHERE review_cate_no=4;

-- 6 - 2) ��¼��� ����
UPDATE review_cate
SET review_cate_seqno = review_cate_seqno + 1
WHERE review_cate_no=4;

---------------------------------------------         
-- FK�� ���� ���̺� �߰� ����
---------------------------------------------
-- ���� ī�װ� �׷쿡 ���� ���� ī�װ� ���
SELECT review_cate_no, review_categrp_no, review_cate_name, review_cate_seqno, review_cate_date, review_cate_cnt
FROM review_cate
WHERE review_categrp_no = 1
ORDER BY review_cate_seqno ASC;


-- ���� VO
SELECT g.review_categrp_no as g_review_categrp_no, g.review_categrp_name as g_review_categrp_name, 
          c.review_cate_no, c.review_categrp_no, c.review_cate_name, c.review_cate_seqno, c.review_cate_date, c.review_cate_cnt
FROM review_categrp g, review_cate c
WHERE g.review_categrp_no = c.review_categrp_no
ORDER BY g.review_categrp_no ASC, c.review_cate_seqno ASC;

-- ���� VO, categrpno �� cate ���
SELECT g.review_categrp_no as g_review_categrp_no, g.review_categrp_name as g_review_categrp_name,
          c.review_cate_no, c.review_categrp_no, c.review_cate_name, c.review_cate_seqno, c.review_cate_date, c.review_cate_cnt
FROM  review_categrp g, review_cate c
WHERE (g.review_categrp_no = c.review_categrp_no) AND g.review_categrp_no=1
ORDER BY g.review_categrp_no ASC, c.review_cate_seqno ASC;

-- contents �߰��� ���� ��ϵ� �ۼ��� ����
UPDATE review_cate 
SET review_cate_cnt = review_cate_cnt + 1 
WHERE review_cate_no=1;
 
-- contents �߰��� ���� ��ϵ� �ۼ��� ����
UPDATE review_cate 
SET review_cate_cnt = review_cate_cnt - 1 
WHERE review_cate_no=1;

-- �ۼ� �ʱ�ȭ
UPDATE review_cate
SET review_cate_cnt = 0;


commit;

