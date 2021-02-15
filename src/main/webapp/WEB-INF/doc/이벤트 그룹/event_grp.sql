DROP TABLE event_grp CASCADE CONSTRAINTS;
DROP SEQUENCE event_grp_seq;

/**********************************/
/* Table Name: 이벤트 그룹 */
/**********************************/
CREATE TABLE event_grp(
		event_grp_no                  		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		event_grp_title               		VARCHAR2(50)		 NOT NULL,
		event_grp_seqno               		NUMBER(10)		 DEFAULT 0		 NOT NULL,
		event_grp_date                		DATE		 NOT NULL
);

COMMENT ON TABLE event_grp is '이벤트 그룹';
COMMENT ON COLUMN event_grp.event_grp_no is '이벤트 그룹번호';
COMMENT ON COLUMN event_grp.event_grp_title is '이벤트 그룹명';
COMMENT ON COLUMN event_grp.event_grp_seqno is '출력 순서';
COMMENT ON COLUMN event_grp.event_grp_date is '등록일';

CREATE SEQUENCE event_grp_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

1) 등록
INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, '1월 이벤트', 1, sysdate);

INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, '2월 이벤트', 2, sysdate);

INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, '특별 이벤트', 3, sysdate);

INSERT INTO event_grp(event_grp_no, event_grp_title, event_grp_seqno, event_grp_date)
VALUES(event_grp_seq.nextval, '삭제용', 4, sysdate);

2) 목록
SELECT event_grp_no, event_grp_title, event_grp_seqno, event_grp_date
FROM event_grp
ORDER BY event_grp_no ASC;

3) 조회
SELECT event_grp_no, event_grp_title, event_grp_seqno, event_grp_date
FROM event_grp
WHERE event_grp_no = 1;

4) 수정
UPDATE event_grp 
SET event_grp_title='1월 이벤트(수정)'
WHERE event_grp_no = 1;

5) 삭제
DELETE FROM event_grp
WHERE event_grp_no = 4;

6) 출력 순서에 따른 전체 목록
SELECT event_grp_no, event_grp_title, event_grp_seqno, event_grp_date
FROM event_grp
ORDER BY event_grp_seqno ASC;

7) 출력 순서 상향, 10 ▷ 1
UPDATE event_grp
SET event_grp_seqno = event_grp_seqno - 1
WHERE event_grp_no = 3;
 
-- 출력순서 하향, 1 ▷ 10
UPDATE event_grp
SET event_grp_seqno = event_grp_seqno + 1
WHERE event_grp_no = 3;

commit;