DROP TABLE review_attachfile;

/**********************************/
/* Table Name: 리뷰 첨부파일 */
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

COMMENT ON TABLE review_attachfile is '리뷰 첨부파일';
COMMENT ON COLUMN review_attachfile.review_attachfile_no is '첨부파일 번호';
COMMENT ON COLUMN review_attachfile.review_no is '리뷰 번호';
COMMENT ON COLUMN review_attachfile.review_attachfile_rname is '원본 파일';
COMMENT ON COLUMN review_attachfile.review_attachfile_upname is '업로드 파일';
COMMENT ON COLUMN review_attachfile.review_attachfile_thumb is '섬네일 파일';
COMMENT ON COLUMN review_attachfile.review_attachfile_size is '파일 크기';
COMMENT ON COLUMN review_attachfile.review_attachfile_date is '등록일';

CREATE SEQUENCE review_attachfile_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 1) 등록
INSERT INTO review_attachfile(review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date)
VALUES(review_attachfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO review_attachfile(review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date)
VALUES(review_attachfile_seq.nextval, 13, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO review_attachfile(review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date)
VALUES(review_attachfile_seq.nextval,  13, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate); 

-- 2) 전체 목록( review_no 기준 내림 차순, review_attachfile_no 기준 오르차순)
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
ORDER BY review_no DESC,  review_attachfile_no ASC;

-- 3) PK(review_attachfile_no) 기준 하나의 레코드 조회
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
WHERE review_attachfile_no = 1;

-- 4) FK 기준 review_no 동일한 레코드 조회, fname 오름 차순
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
WHERE review_no = 13
ORDER BY review_attachfile_rname ASC;

-- 5) 하나의 파일 삭제
DELETE FROM review_attachfile
WHERE review_attachfile_no = 3;

-- 6) 부모키별 갯수 산출
SELECT COUNT(*) as cnt
FROM review_attachfile
WHERE review_no=13;

-- 6) FK 부모키별 레코드 삭제
DELETE FROM review_attachfile
WHERE review_no=1;

-- 7) review & review_ attachfile join
    SELECT r.review_title, 
               a.review_attachfile_no, a.review_no, a.review_attachfile_rname, a.review_attachfile_upname, a.review_attachfile_thumb, a.review_attachfile_size, a.review_attachfile_date
    FROM review r, review_attachfile a
    WHERE r.review_no = a.review_no
    ORDER BY r.review_no DESC,  a.review_attachfile_no ASC;
   
-- 8) 조회
SELECT review_attachfile_no, review_no, review_attachfile_rname, review_attachfile_upname, review_attachfile_thumb, review_attachfile_size, review_attachfile_date
FROM review_attachfile
WHERE review_attachfile_no=1;
