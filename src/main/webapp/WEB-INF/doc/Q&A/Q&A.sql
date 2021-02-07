/**********************************/
/* Table Name: ȸ�� */
/**********************************/
DROP TABLE member;
CREATE TABLE member(
    member_no                         NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_name                       VARCHAR2(50)     NOT NULL,
    member_id                         VARCHAR2(50)     NOT NULL,
    member_address                    VARCHAR2(200)    NOT NULL,
    member_phone                      NUMERIC(10)    NOT NULL
);

COMMENT ON TABLE  is 'ȸ��';
COMMENT ON COLUMN member.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN member.member_name is 'ȸ�� �̸�';
COMMENT ON COLUMN member.member_id is 'ȸ�� ID';
COMMENT ON COLUMN member.member_address is 'ȸ�� �ּ�';
COMMENT ON COLUMN member.member_phone is 'ȸ�� ����ó';

DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

-- ���
INSERT INTO member(member_no, member_name, member_id, member_address, member_phone)
VALUES (member_seq.nextval, '������', 'user1', '����Ư����', 01011112222);

INSERT INTO member(member_no, member_name, member_id, member_address, member_phone)
VALUES (member_seq.nextval, 'ȫ�浿', 'user2', '�λ걤����', 01011112222);

-- ����
DELETE member
WHERE member_no =1;

SELECT * FROM member;

commit;

/**********************************/
/* Table Name: Ŀ�´�Ƽ */
/**********************************/
DROP TABLE community;
CREATE TABLE community(
    community_no NUMERIC(3) NOT NULL PRIMARY KEY,
    community_name VARCHAR(50) NOT NULL,
    community_seqno NUMERIC(10) NOT NULL,
    community_visible CHAR(1) DEFAULT 'Y' NOT NULL,
    community_rdate DATE NOT NULL
);

COMMENT ON TABLE community is 'Ŀ�´�Ƽ';
COMMENT ON COLUMN community.community_no is 'Ŀ�´�Ƽ ��ȣ';
COMMENT ON COLUMN community.community_name is '�̸�';
COMMENT ON COLUMN community.community_seqno is '��¼���';
COMMENT ON COLUMN community.community_visible is '��¸��';
COMMENT ON COLUMN community.community_rdate is '�׷� ������';

DROP SEQUENCE community_seq;
CREATE SEQUENCE community_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- insert
INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, '���� �Խ���', 1, 'Y', sysdate);

INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, '�� �Խ���', 2, 'Y', sysdate);

INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, '��Ÿ �Խ���', 3, 'Y', sysdate);

INSERT INTO community(community_no, community_name, community_seqno, community_visible, community_rdate)
VALUES(community_seq.nextval, 'Q&A', 4, 'Y', sysdate);

SELECT * FROM community ORDER BY community_no ASC;
  
commit;  

/**********************************/
/* Table Name: Q&A */
/**********************************/
DROP TABLE qna;
CREATE TABLE qna(
    qna_no NUMERIC(10) NOT NULL PRIMARY KEY,
    community_no NUMERIC(3),
    member_no NUMERIC(10),
    qna_title VARCHAR(50),
    qna_content VARCHAR(500) NOT NULL,
    qna_passwd VARCHAR(20) NOT NULL,
    qna_rdate DATE NOT NULL,
    qna_count NUMERIC(3) NOT NULL,
    qna_check CHAR(1) DEFAULT 'N' NULL,
        qna_visible CHAR(1) DEFAULT 'N' NULL,
        file1         VARCHAR(100)          NULL,
        thumb1    VARCHAR(100)          NULL,
        size1        NUMBER(10)      DEFAULT 0 NULL,  
        qna_word  VARCHAR2(300)  NULL,
        grpno    NUMBER(8)         DEFAULT 0         NOT NULL,
        indent   NUMBER(2)         DEFAULT 0         NOT NULL,
        ansnum NUMBER(3)         DEFAULT 0         NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (community_no) REFERENCES community (community_no)
);

COMMENT ON TABLE qna is 'Q&A';
COMMENT ON COLUMN qna.qna_no is 'Q&A ��ȣ';
COMMENT ON COLUMN qna.community_no is 'Ŀ�´�Ƽ ��ȣ';
COMMENT ON COLUMN qna.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN qna.qna_title is '���� ����';
COMMENT ON COLUMN qna.qna_content is '���� ����';
COMMENT ON COLUMN qna.qna_passwd is '��й�ȣ';
COMMENT ON COLUMN qna.qna_rdate is '���� �����';
COMMENT ON COLUMN qna.qna_count is '��ȸ��';
COMMENT ON COLUMN qna.qna_check is '��б� ���';
COMMENT ON COLUMN qna.qna_visible is '÷������ Ȯ��';
COMMENT ON COLUMN qna.file1 is '���� �̹���';
COMMENT ON COLUMN qna.thumb1 is '���� �̹��� Preview';
COMMENT ON COLUMN qna.size1 is ' ���� �̹��� ũ��';
COMMENT ON COLUMN qna.qna_word is '�˻���';
COMMENT ON COLUMN qna.grpno is '�׷��ȣ';
COMMENT ON COLUMN qna.indent is '�鿩����/�亯����';
COMMENT ON COLUMN qna.ansnum is '�亯����';

DROP SEQUENCE qna_seq;
CREATE SEQUENCE qna_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

-- ���
INSERT INTO qna(qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word)
VALUES(qna_seq.nextval, 4, 1, 'test ����', '���� ����', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '�׽�Ʈ');

INSERT INTO qna(qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word)
VALUES(qna_seq.nextval, 4, 2, 'test ����', '���� ����', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '�׽�Ʈ');

-- ���
SELECT *
FROM qna 
ORDER BY qna_no DESC;

-- ��ȸ
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word
FROM qna
WHERE qna_no = 1;

-- ��й�ȣ �˻�
SELECT COUNT(*) as passwd_cnt
FROM qna
WHERE qna_no=1 AND qna_passwd='1234';

-- ����
UPDATE qna
SET community_no=4, qna_title='���� test1123', qna_content='�亯 ������ test1', qna_passwd='1234'
WHERE qna_no = 1;

-- ����
DELETE FROM qna
WHERE qna_no =1;

-- ��� ����� ����
UPDATE qna
SET qna_visible='Y'
WHERE qna_no= 1;

UPDATE qna
SET qna_visible='N'
WHERE qna_no=2;

--  ��ȸ(ī��Ʈ)
UPDATE qna
SET cnt = cnt +1
WHERE qna_no = 1;

SELECT * FROM qna;

commit;

-- ÷�� ���� ����(���, ����, ����, ����)
UPDATE qna
SET file1='file name', thumb1='thumb file name', size1=5000
WHERE qna_no=1;

-- qna + member join ���

SELECT m.member_id,
          q.qna_no, q.community_no, q.member_no, q.qna_title, q.qna_content, q.qna_passwd, q.qna_rdate, q.qna_count, q.qna_visible, q.qna_check, q.qna_word
FROM member m,  qna q
WHERE m.member_no = q.member_no
ORDER BY q.qna_no DESC;

-- �˻� + ����¡
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word, r
FROM (
           SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word, rownum as r
           FROM (
                     SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word
                     FROM qna
                     WHERE community_no=4 AND qna_word LIKE '%�׽�Ʈ%'
                     ORDER BY qna_no DESC
           )          
)
WHERE r >= 1 AND r <= 10;

----------------------------------------------------------------------------------------------
�亯 ���� ����
----------------------------------------------------------------------------------------------
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM community_no;


DROP TABLE qna  CASCADE CONSTRAINTS;

1) ��� ����
- grpno: ���Ӱ� ���� ����ϸ� �ϳ��� �ű� �׷��� ������, (SELECT NVL(MAX(grpno), 0) + 1 FROM contents), 0, 0)
- indent: �鿩 ����, n�� �亯�� ���� ȿ��
- ansnum: �亯 ���� ����
INSERT INTO qna(qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                              grpno, indent, ansnum)
VALUES(qna_seq.nextval, 4, 1, 'test ����', '���� ����', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '�׽�Ʈ',
           (SELECT NVL(MAX(grpno), 0) + 1 FROM qna), 0, 0);
            
2) 1�� ��ȸ ����
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
           grpno, indent, ansnum
FROM qna
WHERE qna_no = 1;

3) ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE qna
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;
 
 
4) �亯 ���
- community_no: FK, member_no: FK
 
INSERT INTO qna(qna_no,
                          community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                          grpno, indent, ansnum)  
VALUES((SELECT NVL(MAX(qna_no), 0) + 1 as qna_no FROM qna),
            4, 1, 'test �亯', '�亯 ����', '1234', sysdate, 0, 'N', 'N', 'spring.jpg', 'spring_t.jpg', 23657, '',
            1, 1, 1);
 
 
5) �亯�� ���� ���� ���� ����    
-- ORDER BY grpno DESC, ansnum ASC
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
          grpno, indent, ansnum, r
FROM (
           SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                     grpno, indent, ansnum, rownum as r
           FROM (
                     SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                               grpno, indent, ansnum
                     FROM qna
                     WHERE community_no=4 AND (qna_title LIKE '�׽�Ʈ' OR qna_content LIKE '�׽�Ʈ' OR qna_word LIKE '�׽�Ʈ')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;     
   
----------------------------------------------------------------------------------------------
�亯 ���� ����
----------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------
�亯 + member join start
----------------------------------------------------------------------------------------------
SELECT m.member_id,
           q.qna_no, q.member_no, q.community_no
FROM qna q, member m
WHERE q.member_no = m.member_no;

CONTENTSNO   MEMBERNO     CATENO ID                  
---------- ---------- ---------- --------------------
        35          3                  27        user1               
        40          3                  27        user1               
        41          3                  27        user1               
        42          3                  27        user1       

-- 2���� �÷��� �ߺ��Ǵ°��� as�� ����Ͽ� �÷����� ����, id�� mid�� ����
SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
            grpno, indent, ansnum, mid, r
FROM (
           SELECT qna_no, community_no, member_no, qna_title, qna_content, qna_passwd, qna_rdate, qna_count, qna_check, qna_visible, file1, thumb1, size1, qna_word,
                       grpno, indent, ansnum, mid, rownum as r
           FROM (
                     SELECT q.qna_no, q.community_no, q.member_no, q.qna_title, q.qna_content, q.qna_passwd, q.qna_rdate, q.qna_count, q.qna_check, q.qna_visible, q.file1, q.thumb1, q.size1, q.qna_word,
                                 q.grpno, q.indent, q.ansnum,
                                 m.member_id as mid
                     FROM qna q, member m
                     WHERE community_no=4 
                               AND q.member_no = m.member_no 
                               AND (qna_title LIKE '%�׽�Ʈ%' OR qna_content LIKE '%�׽�Ʈ%' OR qna_word LIKE '%�׽�Ʈ%')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;        
   
----------------------------------------------------------------------------------------------
�亯 + member join end
----------------------------------------------------------------------------------------------

commit;
