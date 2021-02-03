DROP TABLE login_log;

/**********************************/
/* Table Name: 로그인기록 */
/**********************************/
CREATE TABLE login_log(
	login_log_no                  		NUMBER(30)		 NOT NULL		 PRIMARY KEY,
	member_no                     		NUMBER(10)		 NOT NULL,
	login_log_date                		DATE		 NOT NULL,
	login_log_ip                  		VARCHAR2(200)		 NOT NULL,
    FOREIGN KEY (member_no) REFERENCES team2.member (member_no)
);

COMMENT ON TABLE login_log is '로그인기록';
COMMENT ON COLUMN login_log.login_log_no is '로그인번호';
COMMENT ON COLUMN login_log.member_no is '회원번호';
COMMENT ON COLUMN login_log.login_log_date is '로그인일시';
COMMENT ON COLUMN login_log.login_log_ip is '로그인장소';

DROP SEQUENCE login_log_no_seq;
CREATE SEQUENCE login_log_no_SEQ
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999 -- 최대값: 99999999 --> NUMBER(10) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되?? 것을 방지

--등록
Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 1, sysdate, '123.123.123.455');

Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 2, sysdate, '123.123.123.455');

Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 3, sysdate, '123.123.123.455');

Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 2, sysdate, '123.123.123.123');

--목록
SELECT login_log_no, member_no, login_log_date, login_log_ip
FROM login_log
ORDER BY login_log_no ASC;

commit;

--조회
SELECT member_no, login_log_date, login_log_ip
FROM login_log
WHERE member_no = 2;

SELECT member_no, login_log_date, login_log_ip
FROM login_log
WHERE login_log_no = 2;

--수정
UPDATE login_log
SET login_log_ip = '123.456.789.012', login_log_date = '2021-02-01 04:00:00'
WHERE login_log_no = 5;

--하나 삭제
DELETE FROM login_log
WHERE login_log_no = 6;

-- 모두 삭제
DELETE FROM login_log

