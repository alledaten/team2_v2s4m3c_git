DROP TABLE admin_log;

CREATE TABLE admin_log(
    admin_log_no    NUMBER(10)  NOT NULL    PRIMARY KEY,
    admin_no        NUMBER(10)  NOT NULL,
    admin_log_date  DATE    NOT NULL,
    admin_log_ip    VARCHAR2(100)   NOT NULL,
    FOREIGN KEY (admin_no) REFERENCES admin (admin_no)
);

COMMENT ON TABLE admin_log IS '������ �α��α��';
COMMENT ON COLUMN admin_log.admin_log_no IS '������ �α��� ��ȣ';
COMMENT ON COLUMN admin_log.admin_no IS '������ ��ȣ';
COMMENT ON COLUMN admin_log.admin_log_date IS '������ �α��� ��¥';
COMMENT ON COLUMN admin_log.admin_log_ip IS '������ �α��� IP';

DROP SEQUENCE admin_log_no_seq;
CREATE SEQUENCE admin_log_no_SEQ
  START WITH 1           -- ���� ��ȣ
  INCREMENT BY 1       -- ������
  MAXVALUE 9999999999 -- �ִ밪: 99999999 --> NUMBER(10) ����
  CACHE 2                  -- 2���� �޸𸮿����� ���
  NOCYCLE;                -- �ٽ� 1���� ������?? ���� ����

-- ���
INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (ADMIN_LOG_NO_SEQ.nextval, 1, sysdate, '123.456.789.009');

INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (admin_log_no_seq.nextval, 1, sysdate, '123.123.123.123');

INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (admin_log_no_seq.nextval, 2, sysdate, '123.123.123.123');

INSERT INTO admin_log (admin_log_no, admin_no, admin_log_date, admin_log_ip)
VALUES (admin_log_no_seq.nextval, 2, sysdate, '123.123.123.123');

commit;

-- ���
SELECT admin_log_no, admin_no, admin_log_date, admin_log_ip
FROM admin_log
ORDER BY admin_log_no ASC;

-- ��ȸ
SELECT admin_log_date, admin_log_ip
FROM admin_log
WHERE admin_log_no = 1;

SELECT admin_log_date, admin_log_ip
FROM admin_log
WHERE admin_no = 1;

-- ����
UPDATE admin_log
SET admin_log_date = '2021-02-04', admin_log_ip = '000.000.000.000'
WHERE admin_log_no = 1;

-- ����
DELETE FROM admin_log
WHERE admin_log_no = 5;

commit;

-- ��ü����
DELETE FROM admin_log
