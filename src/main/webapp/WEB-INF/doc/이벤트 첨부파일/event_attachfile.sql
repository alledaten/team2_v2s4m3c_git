DROP TABLE event_attachfile CASCADE CONSTRAINTS;
DROP SEQUENCE event_attachfile_seq;

/**********************************/
/* Table Name: �̺�Ʈ ÷������ */
/**********************************/
CREATE TABLE event_attachfile(
		event_attachfile_no           		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		event_no                      		NUMBER(10)		 NULL ,
		event_attachfile_rname        		VARCHAR2(100)		 NOT NULL,
		event_attachfile_upname       		VARCHAR2(100)		 NOT NULL,
		event_attachfile_thumb        		VARCHAR2(100)		 NULL ,
		event_attachfile_size         		NUMBER(10)	DEFAULT 0	 NOT NULL,
		event_attachfile_date         		DATE		 NOT NULL,
   FOREIGN KEY (event_no) REFERENCES event (event_no)
);

COMMENT ON TABLE event_attachfile is '�̺�Ʈ ÷������';
COMMENT ON COLUMN event_attachfile.event_attachfile_no is '÷������ ��ȣ';
COMMENT ON COLUMN event_attachfile.event_no is '�̺�Ʈ ��ȣ';
COMMENT ON COLUMN event_attachfile.event_attachfile_rname is '���� ����';
COMMENT ON COLUMN event_attachfile.event_attachfile_upname is '���ε� ����';
COMMENT ON COLUMN event_attachfile.event_attachfile_thumb is '������ ����';
COMMENT ON COLUMN event_attachfile.event_attachfile_size is '���� ũ��';
COMMENT ON COLUMN event_attachfile.event_attachfile_date is '�����';

CREATE SEQUENCE event_attachfile_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- 1) ���
INSERT INTO event_attachfile(event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date)
VALUES(event_attachfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO event_attachfile(event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date)
VALUES(event_attachfile_seq.nextval, 1, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO event_attachfile(event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date)
VALUES(event_attachfile_seq.nextval,  1, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate); 

-- 2) ��ü ���(event_no ���� ���� ����, event_attachfile_no ���� ��������)
SELECT event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date
FROM event_attachfile
ORDER BY event_no DESC,  event_attachfile_no ASC;

-- 3) PK(event_attachfile_no) ���� �ϳ��� ���ڵ� ��ȸ
SELECT event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date
FROM event_attachfile
WHERE event_attachfile_no = 1;

-- 4) FK ���� event_no ������ ���ڵ� ��ȸ, fname ���� ����
SELECT event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date
FROM event_attachfile
WHERE event_no = 1
ORDER BY event_attachfile_rname ASC;

-- 5) �ϳ��� ���� ����
DELETE FROM event_attachfile
WHERE event_attachfile_no = 3;

-- 6) �θ�Ű�� ���� ����
SELECT COUNT(*) as cnt
FROM event_attachfile
WHERE event_no = 1;

-- 6) FK �θ�Ű�� ���ڵ� ����
DELETE FROM event_attachfile
WHERE event_no = 1;

-- 7) event & event_attachfile join
    SELECT  e.event_title, 
               ea.event_attachfile_no, ea.event_no, ea.event_attachfile_rname, ea.event_attachfile_upname, ea.event_attachfile_thumb, ea.event_attachfile_size, ea.event_attachfile_date
    FROM event e, event_attachfile ea
    WHERE e.event_no = ea.event_no
    ORDER BY e.event_no DESC,  ea.event_attachfile_no ASC;
   

  
  
  

