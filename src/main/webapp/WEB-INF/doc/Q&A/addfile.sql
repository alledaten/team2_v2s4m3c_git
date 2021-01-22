/**********************************/
/* Table Name: ÷������ */
/**********************************/
DROP TABLE addfile;
CREATE TABLE addfile(
        addfile_no                  NUMBER(10)         NOT NULL         PRIMARY KEY,
        qna_no                   NUMBER(10)         NULL ,
        fname                             VARCHAR2(100)         NOT NULL,
        fupname                      VARCHAR2(100)         NOT NULL,
        thumb                         VARCHAR2(100)         NULL ,
        fsize                                 NUMBER(10)         DEFAULT 0         NOT NULL,
        rdate                           DATE     NOT NULL,
  FOREIGN KEY (qna_no) REFERENCES qna (qna_no)
);

COMMENT ON TABLE addfile is '÷������';
COMMENT ON COLUMN addfile.addfile_no is '÷�����Ϲ�ȣ';
COMMENT ON COLUMN addfile.qna_no is '������ȣ';
COMMENT ON COLUMN addfile.fname is '���� ���ϸ�';
COMMENT ON COLUMN addfile.fupname is '���ε� ���ϸ�';
COMMENT ON COLUMN addfile.thumb is 'Thumb ���ϸ�';
COMMENT ON COLUMN addfile.fsize is '���� ������';
COMMENT ON COLUMN addfile.rdate is '�����';

DROP SEQUENCE addfile_seq;
CREATE SEQUENCE addfile_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- 1) ���
INSERT INTO addfile(addfile_no, qna_no, fname, fupname, thumb, fsize, rdate)
VALUES(addfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO addfile(addfile_no, qna_no, fname, fupname, thumb, fsize, rdate)
VALUES(addfile_seq.nextval, 1, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO addfile(addfile_no, qna_no, fname, fupname, thumb, fsize, rdate)
VALUES(addfile_seq.nextval,  1, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate);        

commit;
             
-- 2) ���( qna_no ���� ���� ����, addfile_no ���� ��������)
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM addfile
ORDER BY qna_no DESC,  addfile_no ASC;


-- 3) PK ���� �ϳ��� ���ڵ� ��ȸ
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM addfile
WHERE addfile_no = 1

-- 4) FK qna_no�� ������ ���� ���ڵ� ��ȸ, fname ��������
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM addfile
WHERE qna_no = 1
ORDER BY fname ASC;

-- 5) �ϳ��� ���� ����
DELETE FROM addfile
WHERE addfile_no = 1;

commit;

-- 5) FK qna_no �θ�Ű �� ��ȸ
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM addfile
WHERE qna_no=1;

-- �θ�Ű�� ���� ����
SELECT COUNT(*) as cnt
FROM addfile
WHERE qna_no=1;       
             
-- 6) FK �θ�Ű�� ���ڵ� ����
DELETE FROM addfile
WHERE qna_no=1;
   
-- 7) Contents, Attachfile join
    SELECT q.qna_title, 
               a.addfile_no, a.qna_no, a.fname, a.fupname, a.thumb, a.fsize, a.rdate
    FROM qna q, addfile a
    WHERE q.qna_no = a.qna_no
    ORDER BY q.qna_no DESC,  a.addfile_no ASC;

-- 8) ��ȸ
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM addfile
WHERE addfile_no=1;