DROP TABLE event_attachfile CASCADE CONSTRAINTS;
DROP SEQUENCE event_attachfile_seq;

/**********************************/
/* Table Name: 이벤트 첨부파일 */
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

COMMENT ON TABLE event_attachfile is '이벤트 첨부파일';
COMMENT ON COLUMN event_attachfile.event_attachfile_no is '첨부파일 번호';
COMMENT ON COLUMN event_attachfile.event_no is '이벤트 번호';
COMMENT ON COLUMN event_attachfile.event_attachfile_rname is '원본 파일';
COMMENT ON COLUMN event_attachfile.event_attachfile_upname is '업로드 파일';
COMMENT ON COLUMN event_attachfile.event_attachfile_thumb is '섬네일 파일';
COMMENT ON COLUMN event_attachfile.event_attachfile_size is '파일 크기';
COMMENT ON COLUMN event_attachfile.event_attachfile_date is '등록일';

CREATE SEQUENCE event_attachfile_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 1) 등록
INSERT INTO event_attachfile(event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date)
VALUES(event_attachfile_seq.nextval, 1, 'samyang.jpg', 'samyang_1.jpg', 'samyang_t.jpg', 1000, sysdate);

INSERT INTO event_attachfile(event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date)
VALUES(event_attachfile_seq.nextval, 1, 'samyang2.jpg', 'samyang2_1.jpg', 'samyang2_t.jpg', 2000, sysdate);
             
INSERT INTO event_attachfile(event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date)
VALUES(event_attachfile_seq.nextval,  1, 'samyang3.jpg', 'samyang3_1.jpg', 'samyang3_t.jpg', 3000, sysdate); 

-- 2) 전체 목록(event_no 기준 내림 차순, event_attachfile_no 기준 오르차순)
SELECT event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date
FROM event_attachfile
ORDER BY event_no DESC,  event_attachfile_no ASC;

-- 3) PK(event_attachfile_no) 기준 하나의 레코드 조회
SELECT event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date
FROM event_attachfile
WHERE event_attachfile_no = 1;

-- 4) FK 기준 event_no 동일한 레코드 조회, fname 오름 차순
SELECT event_attachfile_no, event_no, event_attachfile_rname, event_attachfile_upname, event_attachfile_thumb, event_attachfile_size, event_attachfile_date
FROM event_attachfile
WHERE event_no = 1
ORDER BY event_attachfile_rname ASC;

-- 5) 하나의 파일 삭제
DELETE FROM event_attachfile
WHERE event_attachfile_no = 3;

-- 6) 부모키별 갯수 산출
SELECT COUNT(*) as cnt
FROM event_attachfile
WHERE event_no = 1;

-- 6) FK 부모키별 레코드 삭제
DELETE FROM event_attachfile
WHERE event_no = 1;

-- 7) event & event_attachfile join
    SELECT  e.event_title, 
               ea.event_attachfile_no, ea.event_no, ea.event_attachfile_rname, ea.event_attachfile_upname, ea.event_attachfile_thumb, ea.event_attachfile_size, ea.event_attachfile_date
    FROM event e, event_attachfile ea
    WHERE e.event_no = ea.event_no
    ORDER BY e.event_no DESC,  ea.event_attachfile_no ASC;
   

  
  
  

