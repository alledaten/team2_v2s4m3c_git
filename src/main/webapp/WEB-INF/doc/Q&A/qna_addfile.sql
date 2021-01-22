/**********************************/
/* Table Name: 첨부파일 */
/**********************************/
DROP TABLE qna_addfile;
CREATE TABLE qna_addfile(
        addfile_no                  NUMBER(10)         NOT NULL         PRIMARY KEY,
        qna_no                   NUMBER(10)         NULL ,
        fname                             VARCHAR2(100)         NOT NULL,
        fupname                      VARCHAR2(100)         NOT NULL,
        thumb                         VARCHAR2(100)         NULL ,
        fsize                                 NUMBER(10)         DEFAULT 0         NOT NULL,
        rdate                           DATE     NOT NULL,
  FOREIGN KEY (qna_no) REFERENCES qna (qna_no)
);

COMMENT ON TABLE qna_addfile is '첨부파일';
COMMENT ON COLUMN qna_addfile.addfile_no is '첨부파일번호';
COMMENT ON COLUMN qna_addfile.qna_no is '질문번호';
COMMENT ON COLUMN qna_addfile.fname is '원본 파일명';
COMMENT ON COLUMN qna_addfile.fupname is '업로드 파일명';
COMMENT ON COLUMN qna_addfile.thumb is 'Thumb 파일명';
COMMENT ON COLUMN qna_addfile.fsize is '파일 사이즈';
COMMENT ON COLUMN qna_addfile.rdate is '등록일';

DROP SEQUENCE qna_addfile_seq;
CREATE SEQUENCE qna_addfile_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 1) 등록
INSERT INTO qna_addfile(addfile_no, qna_no, fname, fupname, thumb, fsize, rdate)
VALUES(qna_addfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO qna_addfile(addfile_no, qna_no, fname, fupname, thumb, fsize, rdate)
VALUES(qna_addfile_seq.nextval, 1, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO qna_addfile(addfile_no, qna_no, fname, fupname, thumb, fsize, rdate)
VALUES(qna_addfile_seq.nextval,  1, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate);        

commit;
             
-- 2) 목록( qna_no 기준 내림 차순, addfile_no 기준 오름차순)
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM qna_addfile
ORDER BY qna_no DESC,  addfile_no ASC;


-- 3) PK 기준 하나의 레코드 조회
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM qna_addfile
WHERE addfile_no = 1

-- 4) FK qna_no가 동일한 기준 레코드 조회, fname 오르차순
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM qna_addfile
WHERE qna_no = 1
ORDER BY fname ASC;

-- 5) 하나의 파일 삭제
DELETE FROM qna_addfile
WHERE addfile_no = 1;

commit;

-- 5) FK qna_no 부모키 별 조회
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM qna_addfile
WHERE qna_no=1;

-- 부모키별 갯수 산출
SELECT COUNT(*) as cnt
FROM qna_addfile
WHERE qna_no=1;       
             
-- 6) FK 부모키별 레코드 삭제
DELETE FROM qna_addfile
WHERE qna_no=1;
   
-- 7) Contents, Attachfile join
    SELECT q.qna_title, 
               a.addfile_no, a.qna_no, a.fname, a.fupname, a.thumb, a.fsize, a.rdate
    FROM qna q, qna_addfile a
    WHERE q.qna_no = a.qna_no
    ORDER BY q.qna_no DESC,  a.addfile_no ASC;

-- 8) 조회
SELECT addfile_no, qna_no, fname, fupname, thumb, fsize, rdate
FROM qna_addfile
WHERE addfile_no=2;


