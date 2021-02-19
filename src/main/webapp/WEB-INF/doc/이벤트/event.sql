DROP TABLE event CASCADE CONSTRAINTS;
DROP SEQUENCE event_seq;

/**********************************/
/* Table Name: 이벤트 */
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

COMMENT ON TABLE event is '이벤트';
COMMENT ON COLUMN event.event_no is '이벤트 번호';
COMMENT ON COLUMN event.event_grp_no is '이벤트 그룹번호';
COMMENT ON COLUMN event.admin_no is '관리자번호';
COMMENT ON COLUMN event.event_title is '제목';
COMMENT ON COLUMN event.event_content is '내용';
COMMENT ON COLUMN event.event_view is '조회수';
COMMENT ON COLUMN event.event_passwd is '패스워드';
COMMENT ON COLUMN event.event_word is '검색어';
COMMENT ON COLUMN event.event_date is '등록일';
COMMENT ON COLUMN event.event_file is '메인 이미지 파일';
COMMENT ON COLUMN event.event_thumb is '메인 이미지 섬네일';
COMMENT ON COLUMN event.event_size is '메인 이미지 크기';

CREATE SEQUENCE event_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

1. 등록
-- admin_no: 1, event_grp_no: 1가 사전에 등록이되어 있어야 INSERT 가능
INSERT INTO event(event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
                          event_file, event_thumb, event_size)
VALUES(event_seq.nextval, 1, 1,  '1월 이벤트', '1월 이벤트 내용',  '1234', '1월 이벤트 검색어', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO event(event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
                          event_file, event_thumb, event_size)
VALUES(event_seq.nextval, 2, 2,  '2월 이벤트', '2월 이벤트 내용',  '1234', '2월 이벤트 검색어', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO event(event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
                          event_file, event_thumb, event_size)
VALUES(event_seq.nextval, 3, 3,  '특별 이벤트', '특별 이벤트 내용',  '1234', '특별 이벤트 검색어', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

2. 전체 목록
SELECT  eg.event_grp_no, eg.event_grp_title,
           e.event_no, e.event_title, e.event_date, e.event_thumb, e.event_view, 
           a.admin_no, a.admin_name
FROM event e, admin a, event_grp eg
WHERE e.admin_no = a.admin_no AND e.event_grp_no = eg.event_grp_no
ORDER BY event_no DESC; 

2-2) event_grp_no별 목록
SELECT eg.event_grp_no, eg.event_grp_title,
           e.event_no, e.event_title, e.event_date, e.event_thumb, e.event_view, 
           a.admin_no, a.admin_name
FROM event e, admin a, event_grp eg
WHERE   e.admin_no = a.admin_no AND e.event_grp_no = eg.event_grp_no AND eg.event_grp_no = 1
ORDER BY event_no DESC;

2-3) event_grp_no별 검색 목록
SELECT event_no, event_grp_no, admin_no, event_title, event_content, event_passwd, event_word, event_date,
          event_file, event_thumb, event_size
FROM event
WHERE event_grp_no = 1 AND (event_title LIKE '%%' OR event_content LIKE '%%' OR event_word LIKE '%%')
ORDER BY event_no DESC;

2-4) event_grp_no별 검색된 레코드 갯수
SELECT COUNT(*) as event_cnt
FROM event
WHERE event_grp_no = 1 AND (event_title LIKE '%%' OR event_content LIKE '%%' OR event_word LIKE '%%')

3) 1건 조회
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
          
4) 수정
UPDATE event 
SET event_title='특별 이벤트 수정', event_content='내용 수정',  event_word='검색어 수정'
WHERE event_no = 3;

5) 패스워드 검사
SELECT COUNT(*) as passwd_cnt
FROM event
WHERE event_no=1 AND event_passwd='1234';

6) 삭제
-- 전체 레코드 삭제
DELETE FROM event;

-- PK 기준 1개 삭제
DELETE FROM event
WHERE event_no = 6;

7) 모든 레코드 갯수
SELECT COUNT(*) as event_cnt
FROM event;

8) 첨부 파일 변경(등록, 변경, 수정, 삭제)
UPDATE event
SET event_file='file name', event_thumb='thumb file name', event_size=5000
WHERE event_no = 3; 

9) 검색 + 페이징 + 메인 이미지
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

10 - 1) 조회수 증가
UPDATE event
SET event_view = event_view + 1
WHERE event_no = 1;

10 - 2) 조회수 초기화
UPDATE event
SET event_view = 0
WHERE event_no = 1;