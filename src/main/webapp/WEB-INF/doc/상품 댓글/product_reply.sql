/**********************************/
/* Table Name: ��� */
/**********************************/
DROP TABLE product_reply;

CREATE TABLE product_reply(
        product_reply_no                                NUMBER(10)         NOT NULL         PRIMARY KEY,
        product_no                           NUMBER(10)    NOT     NULL ,
        member_no                            NUMBER(6)         NOT NULL ,
        product_reply_content                               VARCHAR2(1000)         NOT NULL,
        product_reply_passwd                                VARCHAR2(20)         NOT NULL,
        product_reply_rdate                              DATE NOT NULL,
  FOREIGN KEY (product_no) REFERENCES product (product_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE product_reply is '���';
COMMENT ON COLUMN product_reply.product_reply_no is '��۹�ȣ';
COMMENT ON COLUMN product_reply.product_no is '��ǰ��ȣ';
COMMENT ON COLUMN product_reply.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN product_reply.product_reply_content is '����';
COMMENT ON COLUMN product_reply.product_reply_passwd is '��й�ȣ';
COMMENT ON COLUMN product_reply.product_reply_rdate is '�����';

1) ���
INSERT INTO product_reply(product_reply_no, product_no, member_no, product_reply_content, product_reply_passwd, product_reply_rdate)
VALUES((SELECT NVL(MAX(product_reply_no), 0) + 1 as product_reply_no FROM product_reply),
             1, 1, '���1', '1234', sysdate);
INSERT INTO reply(replyno, product_no, memberno, content, passwd, rdate)
VALUES((SELECT NVL(MAX(replyno), 0) + 1 as replyno FROM reply),
             35, 1, '���2', '1234', sysdate);
INSERT INTO reply(replyno, contentsno, memberno, content, passwd, rdate)
VALUES((SELECT NVL(MAX(replyno), 0) + 1 as replyno FROM reply),
             35, 1, '���3', '1234', sysdate);             

commit;

2) ��ü ���
SELECT product_reply_no, product_no, member_no, product_reply_content, product_reply_passwd, product_reply_rdate
FROM product_reply
ORDER BY product_reply_no DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD RDATE
 ------- ---------- -------- ------- ------ ---------------------
       3          1        1 ���3     1234   2019-12-17 16:59:38.0
       2          1        1 ���2     1234   2019-12-17 16:59:37.0
       1          1        1 ���1     1234   2019-12-17 16:59:36.0


3) product_no �� ���
SELECT replyno, product_no, memberno, content, passwd, rdate
FROM reply
WHERE product_no=1
ORDER BY replyno DESC;

 REPLYNO CONTENTSNO MEMBERNO CONTENT PASSWD RDATE
 ------- ---------- -------- ------- ------ ---------------------
       3          1        1 ���3     1234   2019-12-17 16:59:38.0
       2          1        1 ���2     1234   2019-12-17 16:59:37.0
       1          1        1 ���1     1234   2019-12-17 16:59:36.0


4) ����
-- �н����� �˻�
SELECT count(passwd) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

 CNT
 ---
   1
   
-- ����
DELETE FROM reply
WHERE replyno=1;

COMMIT;

5) contentsno�� �ش��ϴ� ��� �� Ȯ�� �� ����
SELECT COUNT(*) as cnt
FROM reply
WHERE contentsno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE contentsno=1;

6) memberno�� �ش��ϴ� ��� �� Ȯ�� �� ����
SELECT COUNT(*) as cnt
FROM reply
WHERE memberno=1;

 CNT
 ---
   1

DELETE FROM reply
WHERE memberno=1;

7) ȸ�� ID�� ���
SELECT m.id,
           r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE (m.memberno = r.memberno) AND r.contentsno=1
ORDER BY r.replyno DESC;

 ID    REPLYNO CONTENTSNO MEMBERNO CONTENT                                                                                                                                                                         PASSWD RDATE
 ----- ------- ---------- -------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------ ---------------------
 user1       3          1        1 ��� 3                                                                                                                                                                            123    2019-12-18 16:46:43.0
 user1       2          1        1 ��� 2                                                                                                                                                                            123    2019-12-18 16:46:39.0
 user1       1          1        1 ��� 1                                                                                                                                                                            123    2019-12-18 16:46:35.0
 
 
8) ������ �н����� �˻�
SELECT COUNT(*) as cnt
FROM reply
WHERE replyno=1 AND passwd='1234';

 CNT
 ---
   0

9) ����
DELETE FROM reply
WHERE replyno=1;


10) reply + member join ���

SELECT m.id,
          r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE m.memberno = r.memberno
ORDER BY r.replyno DESC;

11) reply + member join ��ȸ

SELECT m.id,
          r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
FROM member m,  reply r
WHERE (m.memberno = r.memberno) AND r.contentsno=53
ORDER BY r.replyno DESC;


12) ������ ��ư ����¡,  contentsno �� ���
SELECT id, replyno, contentsno, memberno, content, passwd, rdate, r
FROM (
        SELECT id, replyno, contentsno, memberno, content, passwd, rdate, rownum as r
        FROM (
                SELECT m.id,
                           r.replyno, r.contentsno, r.memberno, r.content, r.passwd, r.rdate
                FROM member m,  reply r
                WHERE (m.memberno = r.memberno) AND r.contentsno=53
                ORDER BY r.replyno DESC
        )
)
WHERE r >= 1 AND r <= 2;
 
 