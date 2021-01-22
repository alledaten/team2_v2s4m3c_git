/**********************************/
/* Table Name: �Խ��� �׷� */
/**********************************/
DROP TABLE boardgrp;
CREATE TABLE boardgrp(
		boardgrp_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		boardgrp_name                          		VARCHAR2(50)		 NOT NULL,
		boardgrp_seqno                         		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		boardgrp_visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		boardgrp_rdate                         		DATE		 NOT NULL
);

COMMENT ON TABLE boardgrp is '�Խ��� �׷�';
COMMENT ON COLUMN boardgrp.boardgrp_no is '�Խ��� �׷� ��ȣ';
COMMENT ON COLUMN boardgrp.boardgrp_name is '�Խ����̸�';
COMMENT ON COLUMN boardgrp.boardgrp_seqno is '�Խ��� ��� ����';
COMMENT ON COLUMN boardgrp.boardgrp_visible is '�Խ��� ��� ���';
COMMENT ON COLUMN boardgrp.boardgrp_rdate is '�Խ��� ������';



DROP SEQUENCE boardgrp_seq;
CREATE SEQUENCE boardgrp_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- insert
INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '�����Խ���', 1, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '��TALK', 2, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '��Ÿ�Խ���', 3, 'Y', sysdate);

COMMIT;

-- list
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
ORDER BY boardgrp_no ASC;

BOARDGRP_NO BOARDGRP_NAME                                      BOARDGRP_SEQNO B BOARDGRP
----------- -------------------------------------------------- -------------- - --------
          1 �����Խ���                                                      1 Y 20/11/03
          2 ��TALK                                                          2 Y 20/11/03
          3 ��Ÿ�Խ���                                                      3 Y 20/11/03

-- ��ȸ + ������
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
ORDER BY boardgrp_no ASC;
 
 CATEGRPNO NAME  SEQNO VISIBLE RDATE
 --------- ----- ----- ------- ---------------------
         1 ���� ����     1 Y       2019-05-13 13:07:50.0
         
-- ����
UPDATE boardgrp
SET boardgrp_name='��Ÿ�Խ���', boardgrp_seqno = 3, boardgrp_visible='N'
WHERE boardgrp_no = 3;

commit;

-- ��ȸ + ������ + ������
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
WHERE boardgrp_no = 3;
 
BOARDGRP_NO BOARDGRP_NAME                                      BOARDGRP_SEQNO B BOARDGRP
----------- -------------------------------------------------- -------------- - --------
          3 ��Ÿ�Խ���                                                      3 N 20/11/03

-- ����         
DELETE FROM boardgrp
WHERE boardgrp_no = 10;

commit;
 
-- ��� ���������� ��ü ���
SELECT boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate
FROM boardgrp
ORDER BY boardgrp_seqno ASC;
 
-- ��� ���� ����, 10 �� 1
UPDATE boardgrp
SET boardgrp_seqno = boardgrp_seqno - 1
WHERE boardgrp_no=1;
 
-- ��¼��� ����, 1 �� 10
UPDATE boardgrp
SET boardgrp_seqno = boardgrp_seqno + 1
WHERE boardgrp_no=1;

-- ��� ����� ����
UPDATE boardgrp
SET visible='Y'
WHERE boardgrp_no=1;

UPDATE boardgrp
SET visible='N'
WHERE boardgrp_no=1;

commit;
         
         
         
         