DROP TABLE admin_log;

CREATE TABLE admin_log(
    admin_log_no    NUMBER(10)  NOT NULL    PRIMARY KEY,
    admin_no        NUMBER(10)  NOT NULL,
    admin_log_date  DATE    NOT NULL,
    admin_log_ip    VARCHAR2(100)   NOT NULL,
    FOREIGN KEY (admin_no) REFERENCES admin (admin_no)
);

COMMENT ON TABLE admin_log IS '관리자 로그인기록';
COMMENT ON COLUMN admin_log.admin_log_no IS '관리자 로그인 번호';
COMMENT ON COLUMN admin_log.admin_no IS '관리자 번호';
COMMENT ON COLUMN admin_log.admin_log_date IS '관리자 로그인 날짜';
COMMENT ON COLUMN admin_log.admin_log_ip IS '관리자 로그인 IP';

DROP SEQUENCE admin_log_no_seq;
CREATE SEQUENCE admin_log_no_SEQ
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999 -- 최대값: 99999999 --> NUMBER(10) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되?? 것을 방지

-- 등록
INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (ADMIN_LOG_NO_SEQ.nextval, 1, sysdate, '123.456.789.009');

INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (admin_log_no_seq.nextval, 1, sysdate, '123.123.123.123');

INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (admin_log_no_seq.nextval, 2, sysdate, '123.123.123.123');

INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (admin_log_no_seq.nextval, 2, sysdate, '123.123.123.123');

commit;

-- 목록
SELECT admin_log_no, admin_no, admin_log_date, admin_log_ip
FROM admin_log
ORDER BY admin_log_no ASC;

-- 조회
SELECT admin_log_date, admin_log_ip
FROM admin_log
WHERE admin_log_no = 1;

SELECT admin_log_date, admin_log_ip
FROM admin_log
WHERE admin_no = 1;

-- 수정
UPDATE admin_log
SET admin_log_date = '2021-02-04', admin_log_ip = '000.000.000.000'
WHERE admin_log_no = 1;

-- 삭제
DELETE FROM admin_log
WHERE admin_log_no = 5;

commit;

-- 전체삭제
DELETE FROM admin_log
