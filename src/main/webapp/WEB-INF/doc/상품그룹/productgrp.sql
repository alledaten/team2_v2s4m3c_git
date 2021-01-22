/**********************************/
/* Table Name: ��ǰ ���� */
/**********************************/
DROP TABLE productgrp;
CREATE TABLE productgrp(
		productgrp_no                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		productgrp_name               		VARCHAR2(20)		 NOT NULL,
        productgrp_seqno                  NUMBER(10)		 DEFAULT 0		 NOT NULL,
        productgrp_visible           		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
        productgrp_rdate                         		DATE		 NOT NULL,
        productgrp_cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL
);

COMMENT ON TABLE productgrp is '��ǰ ����';
COMMENT ON COLUMN productgrp.productgrp_no is '��ǰ ���� ��ȣ';
COMMENT ON COLUMN productgrp.productgrp_name is '��ǰ ����';
COMMENT ON COLUMN productgrp.productgrp_seqno is '��� ����';
COMMENT ON COLUMN productgrp.productgrp_visible is '��� ���';
COMMENT ON COLUMN productgrp.productgrp_rdate is '�׷� ������';
COMMENT ON COLUMN productgrp.productgrp_cnt is '��ϵ� �� ��';

DROP SEQUENCE productgrp_seq;
CREATE SEQUENCE productgrp_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;    

-- insert
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, 'Ź��', 1, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '����', 2, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '������', 3, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '������', 4, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '��Ÿ', 5, 'Y', sysdate);

COMMIT;

-- list
SELECT productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate
FROM productgrp
ORDER BY productgrp_seqno ASC;

PRODUCTTYPE_NO PRODUCTTYPE_NAME    
-------------- --------------------
             1 Ź��                
             2 ����                
             3 ������              
             4 ������              
             5 ��Ÿ         
             
-- ��ȸ
SELECT productgrp_no, productgrp_name, productgrp_visible
FROM productgrp
WHERE productgrp_no = 1;

PRODUCTTYPE_NO PRODUCTTYPE_NAME    
-------------- --------------------
             1 Ź��          

-- ����
UPDATE productgrp
SET productgrp_name='Ź����', productgrp_seqno = 2, productgrp_visible='N'
WHERE productgrp_no = 1;

UPDATE categrp
SET name='���� ���', seqno = 3, visible='N'
WHERE categrpno = 3;

-- ����  
DELETE FROM productgrp
WHERE productgrp_no = 1;

