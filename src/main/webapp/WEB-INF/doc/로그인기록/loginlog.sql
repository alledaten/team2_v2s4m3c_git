DROP TABLE login_log;

/**********************************/
/* Table Name: �α��α�� */
/**********************************/
CREATE TABLE login_log(
	login_log_no                  		NUMBER(30)		 NOT NULL		 PRIMARY KEY,
	member_no                     		NUMBER(10)		 NOT NULL,
	login_log_date                		DATE		 NOT NULL,
	login_log_ip                  		VARCHAR2(200)		 NOT NULL,
    FOREIGN KEY (member_no) REFERENCES team2.member (member_no)
);

COMMENT ON TABLE login_log is '�α��α��';
COMMENT ON COLUMN login_log.login_log_no is '�α��ι�ȣ';
COMMENT ON COLUMN login_log.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN login_log.login_log_date is '�α����Ͻ�';
COMMENT ON COLUMN login_log.login_log_ip is '�α������';

DROP SEQUENCE login_log_no_seq;
CREATE SEQUENCE login_log_no_SEQ
  START WITH 1           -- ���� ��ȣ
  INCREMENT BY 1       -- ������
  MAXVALUE 9999999999 -- �ִ밪: 99999999 --> NUMBER(10) ����
  CACHE 2                  -- 2���� �޸𸮿����� ���
  NOCYCLE;                -- �ٽ� 1���� ������?? ���� ����

--���
Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 1, sysdate, '123.123.123.455');

Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 2, sysdate, '123.123.123.455');

Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 3, sysdate, '123.123.123.455');

Insert into login_log (login_log_no, member_no, login_log_date, login_log_ip)
values (login_log_no_seq.nextval, 2, sysdate, '123.123.123.123');

--���
SELECT login_log_no, member_no, login_log_date, login_log_ip
FROM login_log
ORDER BY login_log_no ASC;

commit;

--��ȸ
SELECT member_no, login_log_date, login_log_ip
FROM login_log
WHERE member_no = 2;

SELECT member_no, login_log_date, login_log_ip
FROM login_log
WHERE login_log_no = 2;

--����
UPDATE login_log
SET login_log_ip = '123.456.789.012', login_log_date = '2021-02-01 04:00:00'
WHERE login_log_no = 5;

--�ϳ� ����
DELETE FROM login_log
WHERE login_log_no = 6;

-- ��� ����
DELETE FROM login_log

