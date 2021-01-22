DROP TABLE review_attachfile;

/**********************************/
/* Table Name: ���� ÷������ */
/**********************************/
CREATE TABLE review_attachfile(
		review_attachfile_no          		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		review_no                     		NUMBER(10)		 NULL ,
		review_attachfile_rname       		VARCHAR2(100)		 NOT NULL,
		review_attachfile_upname      		VARCHAR2(100)		 NOT NULL,
		review_attachfile_thumb       		VARCHAR2(100)		 NULL ,
		review_attachfile_size        		NUMBER(10)	DEFAULT 0	 NOT NULL,
		review_attachfile_date        		DATE		 NOT NULL,
  FOREIGN KEY (review_no) REFERENCES review (review_no)
);

COMMENT ON TABLE review_attachfile is '���� ÷������';
COMMENT ON COLUMN review_attachfile.review_attachfile_no is '÷������ ��ȣ';
COMMENT ON COLUMN review_attachfile.review_no is '���� ��ȣ';
COMMENT ON COLUMN review_attachfile.review_attachfile_rname is '���� ����';
COMMENT ON COLUMN review_attachfile.review_attachfile_upname is '���ε� ����';
COMMENT ON COLUMN review_attachfile.review_attachfile_thumb is '������ ����';
COMMENT ON COLUMN review_attachfile.review_attachfile_size is '���� ũ��';
COMMENT ON COLUMN review_attachfile.review_attachfile_date is '�����';

CREATE SEQUENCE review_attachfile_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

-- 1) ���
INSERT INTO review_attachfile(review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date)
VALUES(review_attachfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO review_attachfile(review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date)
VALUES(review_attachfile_seq.nextval, 13, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO review_attachfile(review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date)
VALUES(review_attachfile_seq.nextval,  13, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate); 

-- 2) ��ü ���( review_no ���� ���� ����, review_attachfile_no ���� ��������)
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
ORDER BY review_no DESC,  review_attachfile_no ASC;

-- 3) PK(review_attachfile_no) ���� �ϳ��� ���ڵ� ��ȸ
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
WHERE review_attachfile_no = 1;

-- 4) FK ���� review_no ������ ���ڵ� ��ȸ, fname ���� ����
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
WHERE review_no = 13
ORDER BY review_attachfile_rname ASC;

-- 5) �ϳ��� ���� ����
DELETE FROM review_attachfile
WHERE review_attachfile_no = 3;

-- 6) �θ�Ű�� ���� ����
SELECT COUNT(*) as cnt
FROM review_attachfile
WHERE review_no=13;

-- 6) FK �θ�Ű�� ���ڵ� ����
DELETE FROM review_attachfile
WHERE review_no=1;

-- 7) review & review_ attachfile join
    SELECT r.review_title, 
               a.review_attachfile_no, a.review_no, a.review_attachfile_rname, a.review_attachfile_upname, a.review_attachfile_thumb, a.review_attachfile_size, a.review_attachfile_date
    FROM review r, review_attachfile a
    WHERE r.review_no = a.review_no
    ORDER BY r.review_no DESC,  a.review_attachfile_no ASC;
   
-- 8) ��ȸ
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
WHERE review_attachfile_no=1;
