DROP TABLE review_categrp;
DROP SEQUENCE review_categrp_seq;

/**********************************/
/* Table Name: ���� ī�װ� �׷� */
/**********************************/
CREATE TABLE review_categrp(
		review_categrp_no            NUMBER(10)      NOT NULL PRIMARY KEY,
		review_categrp_name        VARCHAR2(50)    NOT NULL,
		review_categrp_seqno       NUMBER(10)       DEFAULT 0 NOT NULL,
		review_categrp_date         DATE                 NOT NULL
);

COMMENT ON TABLE review_categrp is '���� ī�װ� �׷�';
COMMENT ON COLUMN review_categrp.review_categrp_no is '���� ī�װ� �׷� ��ȣ';
COMMENT ON COLUMN review_categrp.review_categrp_name is  '���� ī�װ� �׷� �̸�';
COMMENT ON COLUMN review_categrp.review_categrp_seqno is '���� ī�װ� �׷� ��¼���';
COMMENT ON COLUMN review_categrp.review_categrp_date is '���� ī�װ� �׷� ������';

CREATE SEQUENCE review_categrp_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

1) ���
INSERT INTO review_categrp(review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date)
VALUES(review_categrp_seq.nextval, '��', 1, sysdate);

INSERT INTO review_categrp(review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date)
VALUES(review_categrp_seq.nextval, '����', 2, sysdate);

INSERT INTO review_categrp(review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date)
VALUES(review_categrp_seq.nextval, '��Ÿ', 3, sysdate); 


2) ���
SELECT review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date
FROM review_categrp
ORDER BY review_categrp_no ASC;

3) ��ȸ
SELECT review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date
FROM review_categrp
WHERE review_categrp_no = 1;

4) ����
UPDATE review_categrp 
SET review_categrp_name='��(SQL ����)', review_categrp_seqno='1'
WHERE review_categrp_no = 1;

5) ����
DELETE FROM review_categrp
WHERE review_categrp_no = 3;

 
6) ��� ������ ���� ��ü ���
SELECT review_categrp_no, review_categrp_name, review_categrp_seqno, review_categrp_date
FROM review_categrp
ORDER BY review_categrp_seqno ASC;
 
-- ��� ���� ����, 10 �� 1
UPDATE review_categrp
SET review_categrp_seqno = review_categrp_seqno - 1
WHERE review_categrp_no=1;
 
-- ��¼��� ����, 1 �� 10
UPDATE review_categrp
SET review_categrp_seqno = review_categrp_seqno + 1
WHERE review_categrp_no=1;
