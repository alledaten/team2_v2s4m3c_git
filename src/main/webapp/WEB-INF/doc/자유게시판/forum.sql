-- 1. ���̺� ����
DROP TABLE boardgrp;
DROP TABLE forum;

-- 2. ���̺� ����
boardgrp
forum

-- 3. CASCADE option�� �̿��� �ڽ� ���̺��� ������ ���̺� ����, ���õ� ���������� ������.
DROP TABLE forum CASCADE CONSTRAINTS;



/**********************************/
/* Table Name: �Խ��� �׷� */
/**********************************/
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
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
  
/**********************************/
/* Table Name: �����Խ��� */
/**********************************/
DROP TABLE forum;
CREATE TABLE forum(
		forum_no                        		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		boardgrp_no                     		NUMBER(10)		 NULL ,
		forum_name                          		VARCHAR2(100)		 NOT NULL,
		forum_seqno                         		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		forum_visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		forum_rdate                         		DATE		 NOT NULL,
		forum_cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL,
  FOREIGN KEY (boardgrp_no) REFERENCES boardgrp (boardgrp_no)
);

COMMENT ON TABLE forum is '�����Խ���';
COMMENT ON COLUMN forum.forum_no is '�� ��ȣ';
COMMENT ON COLUMN forum.boardgrp_no is '�Խ��� ��ȣ';
COMMENT ON COLUMN forum.forum_name is '������';
COMMENT ON COLUMN forum.forum_seqno is '�� ��� ����';
COMMENT ON COLUMN forum.forum_visible is '��� ���';
COMMENT ON COLUMN forum.forum_rdate is '�����';
COMMENT ON COLUMN forum.forum_cnt is '�ڰ� ��ϵ� �� ��';

DROP SEQUENCE forum_seq;
CREATE SEQUENCE forum_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 1, '��Ű����õ', 1, 'Y', sysdate, 0);
���� ���� -
ORA-02291: integrity constraint (AI7.SYS_C008048) violated - parent key not found
-- FK �÷��� �� 1000�� categrp ���̺� ��� ���� �߻���.

-- �θ� ���̺� ���� �߰�
INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '�����Խ���', 1, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '��TALK', 2, 'Y', sysdate);

INSERT INTO boardgrp(boardgrp_no, boardgrp_name, boardgrp_seqno, boardgrp_visible, boardgrp_rdate)
VALUES(boardgrp_seq.nextval, '��Ÿ�Խ���', 3, 'Y', sysdate);

COMMIT;

SELECT * FROM boardgrp ORDER BY boardgrp_no ASC;

BOARDGRP_NO BOARDGRP_NAME                                      BOARDGRP_SEQNO B BOARDGRP
----------- -------------------------------------------------- -------------- - --------
          1 �����Խ���                                                      0 Y 20/11/03
          2 ��TALK                                                          2 Y 20/11/03
          3 ��Ÿ�Խ���                                                      3 N 20/11/03

-- ���: ���� �������� ����/�ܿ� ������ ��õ
INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 1, '��𰥱��', 1, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 2, '�ܿ￣ ��Ű', 2, 'Y', sysdate, 0);

INSERT INTO forum(forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt)
VALUES(forum_seq.nextval, 1, '����ٰ��', 3, 'Y', sysdate, 0);

COMMIT;

-- ���
SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
ORDER BY forum_no ASC;
        
        PK           FK 
  FORUM_NO BOARDGRP_NO FORUM_NAME                                                                                           FORUM_SEQNO F FORUM_RD  FORUM_CNT
---------- ----------- ---------------------------------------------------------------------------------------------------- ----------- - -------- ----------
         1           1 ��𰥱��                                                                                                     1 Y 20/11/03          0
         2           2 �ܿ￣ ��Ű                                                                                                    2 Y 20/11/03          0
         3           1 ����ٰ��                                                                                                     3 Y 20/11/03          0
         
-- ��ȸ
SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
WHERE forum_no=3;

-- ����
UPDATE forum
SET boardgrp_no=1, forum_name='HakubaGoryu', forum_seqno = 10, forum_visible='N', forum_cnt=0
WHERE forum_no = 3;

  FORUM_NO BOARDGRP_NO FORUM_NAME                                                                                           FORUM_SEQNO F FORUM_RD  FORUM_CNT
---------- ----------- ---------------------------------------------------------------------------------------------------- ----------- - -------- ----------
         3           1 HakubaGoryu                                                                                                   10 N 20/11/03          0

commit;

-- ����
DELETE forum
WHERE forum_no = 3;

SELECT * FROM forum;

-- ��� ���� ����, 10 �� 1
UPDATE forum
SET forum_seqno = forum_seqno - 1
WHERE forum_no=2;

SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
ORDER BY forum_seqno ASC;

-- ��¼��� ����, 1 �� 10
UPDATE forum
SET forum_seqno = forum_seqno + 1
WHERE forum_no=2;

-- ��� ����� ����
UPDATE forum
SET forum_visible='Y'
WHERE forum_no=2;

UPDATE forum
SET forum_visible='N'
WHERE forum_no=2;

commit;

---------------------------------------         
-- FK�� ���� ���̺� �߰� ����
---------------------------------------
-- ī�װ� �׷쿡 ���� ī�װ� ���
SELECT forum_no, boardgrp_no, forum_name, forum_seqno, forum_visible, forum_rdate, forum_cnt
FROM forum
WHERE boardgrp_no=1
ORDER BY forum_seqno ASC;


-- �θ� ���̺� ���ڵ� ����
DELETE FROM boardgrp
WHERE boardgrp_no = 1;
���� ���� -
ORA-02292: integrity constraint (AI7.SYS_C008048) violated - child record found

-- �����Ϸ��� ���ڵ��� categrpno�� ��𿡼� ���̴��� �˷��־����.
SELECT COUNT(*) as cnt
FROM forum
WHERE boardgrp_no=1;

       CNT
----------
         2
         
-- �ڽ� ���̺��� FK�� 1�� ���ڵ� ��� ����
DELETE FROM forum
WHERE boardgrp_no=1;

-- �θ� ���̺� ���ڵ� ����
DELETE FROM boardgrp
WHERE boardgrp_no=1;

commit;

-- �θ� ���̺� ���ڵ� ���� Ȯ��
SELECT * FROM boardgrp ORDER BY boardgrp_no ASC;


