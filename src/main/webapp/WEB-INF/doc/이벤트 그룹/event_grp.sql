DROP TABLE event_grp CASCADE CONSTRAINTS;
DROP SEQUENCE event_grp_seq;

/**********************************/
/* Table Name: �̺�Ʈ �׷� */
/**********************************/
CREATE TABLE event_grp(
		event_grp_no                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		event_grp_title               		VARCHAR2(50)		 NOT NULL,
		event_grp_seqno               		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		event_grp_date                		DATE		 NOT NULL
);

COMMENT ON TABLE event_grp is '�̺�Ʈ �׷�';
COMMENT ON COLUMN event_grp.event_grp_no is '�̺�Ʈ �׷��ȣ';
COMMENT ON COLUMN event_grp.event_grp_title is '�̺�Ʈ �׷��';
COMMENT ON COLUMN event_grp.event_grp_seqno is '��� ����';
COMMENT ON COLUMN event_grp.event_grp_date is '�����';

CREATE SEQUENCE event_grp_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

1) ���
INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, '1�� �̺�Ʈ', 1, sysdate);

INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, '2�� �̺�Ʈ', 2, sysdate);

INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, 'Ư�� �̺�Ʈ', 3, sysdate);

INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, '������', 4, sysdate);

2) ���
SELECT event_grp_no, event_grp_title, event_grp_seqno, event_grp_date
FROM event_grp
ORDER BY event_grp_no ASC;

3) ��ȸ
SELECT event_grp_no, event_grp_title, event_grp_seqno, event_grp_date
FROM event_grp
WHERE event_grp_no = 1;

4) ����
UPDATE event_grp 
SET event_grp_title='1�� �̺�Ʈ(����)'
WHERE event_grp_no = 1;

5) ����
DELETE FROM event_grp
WHERE event_grp_no = 4;

6) ��� ������ ���� ��ü ���
SELECT event_grp_no, event_grp_title, event_grp_seqno, event_grp_date
FROM event_grp
ORDER BY event_grp_seqno ASC;

7) ��� ���� ����, 10 �� 1
UPDATE event_grp
SET event_grp_seqno = event_grp_seqno - 1
WHERE event_grp_no = 3;
 
-- ��¼��� ����, 1 �� 10
UPDATE event_grp
SET event_grp_seqno = event_grp_seqno + 1
WHERE event_grp_no = 3;

commit;