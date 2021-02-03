DROP TABLE review_reply;

/**********************************/
/* Table Name: ��� */
/**********************************/
CREATE TABLE review_reply(
		review_reply_no               		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		review_no                     		NUMBER(10)		 NOT NULL,
		member_no                     		NUMBER(10)		 NOT NULL,
		review_reply_content          		CLOB		 NOT NULL,
		review_reply_passwd           		VARCHAR2(30)		 NOT NULL,
		review_reply_date             		DATE		 NOT NULL,
  FOREIGN KEY (review_no) REFERENCES review (review_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE review_reply is '���';
COMMENT ON COLUMN review_reply.review_reply_no is '��� ��ȣ';
COMMENT ON COLUMN review_reply.review_no is '���� ��ȣ';
COMMENT ON COLUMN review_reply.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN review_reply.review_reply_content is '����';
COMMENT ON COLUMN review_reply.review_reply_passwd is '��й�ȣ';
COMMENT ON COLUMN review_reply.review_reply_date is '�����';

1) ���
INSERT INTO review_reply(review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date)
VALUES((SELECT NVL(MAX(review_reply_no), 0) + 1 as review_reply_no FROM review_reply),
             9, 1, '���1', '1234', sysdate);
INSERT INTO review_reply(review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date)
VALUES((SELECT NVL(MAX(review_reply_no), 0) + 1 as review_reply_no FROM review_reply),
             9, 1, '���2', '1234', sysdate);
INSERT INTO review_reply(review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date)
VALUES((SELECT NVL(MAX(review_reply_no), 0) + 1 as review_reply_no FROM review_reply),
             9, 1, '���3', '1234', sysdate);
             
2) ��ü ���           
SELECT *
FROM review_reply
ORDER BY review_reply_no DESC;

3) review_no �� ��ȸ
SELECT review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date
FROM review_reply
WHERE review_no = 1
ORDER BY review_reply_no DESC;

4) ����
DELETE FROM review_reply
WHERE review_reply_no = 4;

5) ����� �н����� �˻�
SELECT count(review_reply_passwd) as cnt
FROM review_reply
WHERE review_reply_no = 2 AND review_reply_passwd='1234';

7) review_no �ش��ϴ� ��� �� Ȯ��
SELECT COUNT(*) as cnt
FROM review_reply
WHERE review_no =1;

8) member_no �ش��ϴ� ��� �� Ȯ��
SELECT COUNT(*) as cnt
FROM review_reply
WHERE member_no = 1;

9) member_no ��� ��� ����
DELETE FROM review_reply
WHERE member_no = 1;

10-1) review_reply + member join ��ü ���

SELECT m.member_id,
           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
FROM member m, review_reply r
WHERE m.member_no = r.member_no 
ORDER BY r.review_reply_no DESC;

5-2) review_reply + member join ��� + ȸ�� ID
SELECT m.member_id,
           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
FROM member m, review_reply r
WHERE (m.member_no = r.member_no) AND r.review_no= 1
ORDER BY r.review_reply_no DESC;

5-3) ������ ��ư ����¡, review_no �� ���
SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, r
FROM (
        SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, rownum as r
        FROM (
                SELECT m.member_id,
                           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
                FROM member m, review_reply r
                WHERE (m.member_no = r.member_no) AND r.review_no=1
                ORDER BY r.review_reply_no DESC
        )
)
WHERE r >= 1 AND r <= 5;

SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, r
FROM (
        SELECT member_id, review_reply_no, review_no, member_no, review_reply_content, review_reply_passwd, review_reply_date, rownum as r
        FROM (
                SELECT m.member_id,
                           r.review_reply_no, r.review_no, r.member_no, r.review_reply_content, r.review_reply_passwd, r.review_reply_date
                FROM member m, review_reply r
                WHERE (m.member_no = r.member_no) AND r.review_no=24
                ORDER BY r.review_reply_no DESC
        )
)
WHERE r >= 6 AND r <= 10;