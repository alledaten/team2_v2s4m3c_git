DROP TABLE event CASCADE CONSTRAINTS;
DROP SEQUENCE event_seq;

/**********************************/
/* Table Name: �̺�Ʈ */
/**********************************/
CREATE TABLE event(
		event_no                      		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		event_grp_no                  		NUMBER(10)		 NOT NULL,
		admin_no                      		NUMBER(10)		 NOT NULL,
		event_title                   		VARCHAR2(100)		 NOT NULL,
		event_content                 		CLOB	 NOT NULL,
		event_view                    		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		event_passwd                  		VARCHAR2(10)		 NOT NULL,
		event_word                    		VARCHAR2(300)		 NULL ,
		event_date                    		DATE		 NOT NULL,
		event_file                    		VARCHAR2(100)		 NULL ,
		event_thumb                   		VARCHAR2(100)		 NULL ,
		event_size                    		NUMBER(10)		 NULL ,
  FOREIGN KEY (event_grp_no) REFERENCES event_grp (event_grp_no),
  FOREIGN KEY (admin_no) REFERENCES admin (admin_no)
);

COMMENT ON TABLE event is '�̺�Ʈ';
COMMENT ON COLUMN event.event_no is '�̺�Ʈ ��ȣ';
COMMENT ON COLUMN event.event_grp_no is '�̺�Ʈ �׷��ȣ';
COMMENT ON COLUMN event.admin_no is '�����ڹ�ȣ';
COMMENT ON COLUMN event.event_title is '����';
COMMENT ON COLUMN event.event_content is '����';
COMMENT ON COLUMN event.event_view is '��ȸ��';
COMMENT ON COLUMN event.event_passwd is '�н�����';
COMMENT ON COLUMN event.event_word is '�˻���';
COMMENT ON COLUMN event.event_date is '�����';
COMMENT ON COLUMN event.event_file is '���� �̹��� ����';
COMMENT ON COLUMN event.event_thumb is '���� �̹��� ������';
COMMENT ON COLUMN event.event_size is '���� �̹��� ũ��';

CREATE SEQUENCE event_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

1. ���
-- admin_no: 1, event_grp_no: 1�� ������ ����̵Ǿ� �־�� INSERT ����
INSERT INTO event(event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
                          event_file, event_thumb, event_size)
VALUES(event_seq.nextval, 1, 1,  '1�� �̺�Ʈ', '1�� �̺�Ʈ ����',  '1234', '1�� �̺�Ʈ �˻���', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO event(event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
                          event_file, event_thumb, event_size)
VALUES(event_seq.nextval, 2, 2,  '2�� �̺�Ʈ', '2�� �̺�Ʈ ����',  '1234', '2�� �̺�Ʈ �˻���', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO event(event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
                          event_file, event_thumb, event_size)
VALUES(event_seq.nextval, 3, 3,  'Ư�� �̺�Ʈ', 'Ư�� �̺�Ʈ ����',  '1234', 'Ư�� �̺�Ʈ �˻���', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

2. ��ü ���
SELECT  eg.event_grp_no, eg.event_grp_title,
           e.event_no, e.event_title, e.event_date, e.event_thumb, e.event_view, 
           a.admin_no, a.admin_name
FROM event e, admin a, event_grp eg
WHERE e.admin_no = a.admin_no AND e.event_grp_no = eg.event_grp_no
ORDER BY event_no DESC; 

2-2) event_grp_no�� ���
SELECT eg.event_grp_no, eg.event_grp_title,
           e.event_no, e.event_title, e.event_date, e.event_thumb, e.event_view, 
           a.admin_no, a.admin_name
FROM event e, admin a, event_grp eg
WHERE   e.admin_no = a.admin_no AND e.event_grp_no = eg.event_grp_no AND eg.event_grp_no = 1
ORDER BY event_no DESC;

2-3) event_grp_no�� �˻� ���
SELECT event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
          event_file, event_thumb, event_size
FROM event
WHERE event_grp_no = 1 AND (event_title LIKE '%%' OR event_content LIKE '%%' OR event_word LIKE '%%')
ORDER BY event_no DESC;

2-4) event_grp_no�� �˻��� ���ڵ� ����
SELECT COUNT(*) as event_cnt
FROM event
WHERE event_grp_no = 1 AND (event_title LIKE '%%' OR event_content LIKE '%%' OR event_word LIKE '%%')

3) 1�� ��ȸ
SELECT eg.event_grp_no, eg.event_grp_title,
          e.event_no, e.event_title, e.event_content, e.event_date, e.event_thumb, e.event_file,
          e.event_view, e.event_word,
          a.admin_no, a.admin_name
FROM event e,
        admin a, 
        event_grp eg
WHERE e.event_no = 1
          AND e.admin_no = a.admin_no
          AND e.event_grp_no = eg.event_grp_no
          
4) ����
UPDATE event 
SET event_title='Ư�� �̺�Ʈ ����', event_content='���� ����',  event_word='�˻��� ����'
WHERE event_no = 3;

5) �н����� �˻�
SELECT COUNT(*) as passwd_cnt
FROM event
WHERE event_no=1 AND event_passwd='1234';

6) ����
-- ��ü ���ڵ� ����
DELETE FROM event;

-- PK ���� 1�� ����
DELETE FROM event
WHERE event_no = 6;

7) ��� ���ڵ� ����
SELECT COUNT(*) as event_cnt
FROM event;

8) ÷�� ���� ����(���, ����, ����, ����)
UPDATE event
SET event_file='file name', event_thumb='thumb file name', event_size=5000
WHERE event_no = 3; 

9) �˻� + ����¡ + ���� �̹���
SELECT event_no, event_grp_no, admin_no, admin_name, event_title, event_content, event_word, event_view, event_date,
          event_file, event_thumb, event_size, r
FROM (
        SELECT event_no, event_grp_no, admin_no, admin_name, event_title, event_content, event_word, event_view, event_date,
                  event_file, event_thumb, event_size, rownum as r
           FROM (
                     SELECT  e.event_no, e.admin_no, e.event_grp_no, e.event_title, e.event_content, 
                                e.event_word, e.event_view, e.event_date, e.event_file, e.event_thumb, 
                                e.event_size,
                                a.admin_name
                     FROM event e, admin a, event_grp eg
                     WHERE e.event_grp_no = 1
                                AND e.admin_no = a.admin_no
                                AND e.event_grp_no = eg.event_grp_no
                                AND (event_title LIKE '%%' OR event_content LIKE '%%' OR event_word LIKE '%%')           
                     ORDER BY event_no DESC
           )      
)
WHERE r >= 1 AND r <= 10;

10 - 1) ��ȸ�� ����
UPDATE event
SET event_view = event_view + 1
WHERE event_no = 1;

10 - 2) ��ȸ�� �ʱ�ȭ
UPDATE event
SET event_view = 0
WHERE event_no = 1;