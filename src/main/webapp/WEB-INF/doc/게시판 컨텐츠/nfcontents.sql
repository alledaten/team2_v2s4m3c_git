/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE fattachfile;
DROP TABLE fcontents CASCADE CONSTRAINTS;
CREATE TABLE fcontents(
        fcontents_no                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        memberno                              NUMBER(10)     NOT NULL ,
        forum_no                                NUMBER(10)         NOT NULL ,
        title                                 VARCHAR2(300)         NOT NULL,
        content                               CLOB                  NOT NULL,
        recom                                 NUMBER(7)         DEFAULT 0         NOT NULL,
        cnt                                   NUMBER(7)         DEFAULT 0         NOT NULL,
        replycnt                              NUMBER(7)         DEFAULT 0         NOT NULL,
        web                                   VARCHAR2(500)         NULL ,
        map                                   VARCHAR2(1000)         NULL ,
        youtube                               VARCHAR2(1000)         NULL ,
        mp3                                   VARCHAR2(1000)         NULL ,
        mp4                                   VARCHAR2(1000)         NULL ,
        visible                               CHAR(1)         DEFAULT 'Y'         NOT NULL,
        ip                                         VARCHAR2(15)         NOT NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        grpno                                 NUMBER(8)         DEFAULT 0         NOT NULL,
        indent                                NUMBER(2)         DEFAULT 0         NOT NULL,
        ansnum                                NUMBER(3)         DEFAULT 0         NOT NULL,
        word                                  VARCHAR2(300)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,
        thumb1                              VARCHAR(100)          NULL,
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  
  FOREIGN KEY (forum_no) REFERENCES forum (forum_no)
);

COMMENT ON TABLE fcontents is '�Խ��� �۳���';
COMMENT ON COLUMN fcontents.fcontents_no is '������ ��ȣ';
COMMENT ON COLUMN fcontents.forum_no is 'ī�װ� ��ȣ';
COMMENT ON COLUMN fcontents.title is '����';
COMMENT ON COLUMN fcontents.content is '����';
COMMENT ON COLUMN fcontents.recom is '��õ��';
COMMENT ON COLUMN fcontents.cnt is '��ȸ��';
COMMENT ON COLUMN fcontents.replycnt is '��ۼ�';
COMMENT ON COLUMN fcontents.web is '���ͳ� �ּ�';
COMMENT ON COLUMN fcontents.map is '����';
COMMENT ON COLUMN fcontents.youtube is 'Youtube';
COMMENT ON COLUMN fcontents.mp3 is 'MP3';
COMMENT ON COLUMN fcontents.mp4 is 'MP4';
COMMENT ON COLUMN fcontents.visible is '��� ���';
COMMENT ON COLUMN fcontents.ip is 'IP';
COMMENT ON COLUMN fcontents.passwd is '�н�����';
COMMENT ON COLUMN fcontents.grpno is '�׷��ȣ';
COMMENT ON COLUMN fcontents.indent is '�鿩����/�亯����';
COMMENT ON COLUMN fcontents.ansnum is '�亯����';
COMMENT ON COLUMN fcontents.word is '�˻���';
COMMENT ON COLUMN fcontents.rdate is '�����';
COMMENT ON COLUMN fcontents.file1 is '���� �̹���';
COMMENT ON COLUMN fcontents.thumb1 is '���� �̹��� Preview';
COMMENT ON COLUMN fcontents.size1 is ' ���� �̹��� ũ��';

DROP SEQUENCE fcontents_seq;
CREATE SEQUENCE fcontents_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
1) �� ���(�̹��� ���� �÷� �߰�)
-- memberno: 1, forum_no: 1�� ������ ����̵Ǿ� �־�� INSERT ����
INSERT INTO fcontents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(fcontents_seq.nextval, 1, 1, '�ű�Ȯ�� 2��', '���� �Ա��˿��� Ȯ��', 'http://www.daum.net',
            '127.0.0.1', '123', '�ڷγ�', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO fcontents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(fcontents_seq.nextval, 1, 2, '�ű�Ȯ�� 2��', '���� �Ա��˿��� Ȯ��', 'http://www.daum.net',
            '127.0.0.1', '123', '�ڷγ�', sysdate, 'summer.jpg', 'summer_t.jpg', 23657);
            
INSERT INTO fcontents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(fcontents_seq.nextval, 1, 3, '������', '���� ����', 'http://www.daum.net',
            '127.0.0.1', '123', '�ڷγ�', sysdate, 'maple.jpg', 'maple_t.jpg', 23657);



COMMIT;

SELECT fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM fcontents 
ORDER BY fcontents_no ASC;    

CONTENTSNO   FORUM_NO TITLE                                                                                                                                                                                                                                                                                                        CONTENT                                                                          WEB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  IP              PASSWD
---------- ---------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------- ---------------
WORD                                                                                                                                                                                                                                                                                                         RDATE    FILE1                                                                                                THUMB1                                                                                                    SIZE1
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------
         5          1 �߿� �ܿ�                                                                                                                                                                                                                                                                                                    �̹� �ܿ��� �� ��ھ��..                                                        http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             
��ܿ�     

-- ���� sequence�� Ȯ��
SELECT fcontents_seq.nextval FROM dual;
SELECT fcontents_seq.currval FROM dual;

2) ��ü���
SELECT fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM fcontents 
ORDER BY fcontents_no DESC;

CONTENTSNO   FORUM_NO TITLE                                                                                                                                                                                                                                                                                                        CONTENT                                                                          WEB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  IP              PASSWD          WORD                                                                                                                                                                                                                                                                                                         RDATE    FILE1                                                                                                THUMB1                                                                                                    SIZE1
---------- ---------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------- --------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------
         5          1 �߿� �ܿ�                                                                                                                                                                                                                                                                                                    �̹� �ܿ��� �� ��ھ��..                                                        http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             ��ܿ�                                                                                                                                                                                                                                                                                                       20/11/05 winter.jpg                                                                                           winter_t.jpg                                                                                              23657
         4          1 �ű�Ȯ�� 222��                                                                                                                                                                                                                                                                                               ����Ȱ������ ���� Ȯ��                                                           http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             �ڷγ�                                                                                                                                                                                                                                                                                                       20/11/05 fall.jpg                                                                                             fall_t.jpg                                                                                                23657
         3          1 �ű�Ȯ�� 9��                                                                                                                                                                                                                                                                                                 �ɳĹ� �ڷγ�                                                                    http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             �ڷγ�                                                                                                                                                                                                                                                                                                       20/11/05 summer.jpg                                                                                           summer_t.jpg                                                                                              23657
         2          1 �ű�Ȯ�� 2��     

2-1) forum_no�� ���
SELECT fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM fcontents 
WHERE forum_no = 1
ORDER BY fcontents_no DESC;

2-2) forum_no�� �˻� ���
1) �˻�
�� forum_no�� �˻� ���
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=1 AND word LIKE '%�ű�Ȯ�� 2��%'
ORDER BY fcontents_no DESC;

SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND word LIKE '%�ű�Ȯ�� 9��%'
ORDER BY fcontents_no DESC;

SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=2 AND word LIKE '%�߿� �ܿ�%'
ORDER BY fcontents_no DESC;

SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND word LIKE '%swiss%'
ORDER BY fcontents_no DESC;


-- title, content, word column search
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND (title LIKE '%����%' OR content LIKE '%����%' OR word LIKE '%����%')
ORDER BY fcontents_no DESC;


�� �˻� ���ڵ� ����
-- ��ü ���ڵ� ����
SELECT COUNT(*) as cnt
FROM fcontents
WHERE forum_no=25;

-- forum_no �� �˻��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM fcontents
WHERE forum_no=25 AND word LIKE '%������%';

SELECT COUNT(*) as cnt
FROM fcontents
WHERE forum_no=25 AND (title LIKE '%����%' OR content LIKE '%����%' OR word LIKE '%����%')


3) 1�� ��ȸ
SELECT fcontents_no, memberno, cateno, title, content, recom, web, map, youtube, mp3, mp4, ip, passwd,
          word, rdate, file1, thumb1, size1
FROM fcontents
WHERE fcontents_no = 1;

4) ����, id="update"
UPDATE fcontents 
SET title='����', content='����', web='http://', word='�˻���'
WHERE fcontents_no = 5;

COMMIT;

5) �н����� �˻�, id="passwd_check"
SELECT COUNT(*) as passwd_cnt
FROM fcontents
WHERE fcontents_no=5 AND passwd='123';

SELECT fcontents_no, passwd
FROM fcontents 
ORDER BY fcontents_no DESC;    

6) ����
-- ��ü ���ڵ� ����
DELETE FROM fcontents;
COMMIT;  

DELETE FROM fcontents
WHERE fcontents_no=13;

COMMIT;  


7) ��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM fcontents;
 
 COUNT
 -----
     5
     
8) Ư�� ȸ���� �ۼ��� �۸� ���: cate + contents + member
SELECT c.forum_no as c_forum_no, c.name as c_name, c.rdate as c_rdate,
          t.fcontents_no as t_fcontents_no, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate,
          m.memberno as m_memberno, m.mname as m_mname          
FROM forum c, fcontents t, member m
WHERE c.forum_no = t.forum_no AND t.memberno = m.memberno AND m.memberno = 1
ORDER BY c.forum_no ASC, t.fcontents_no DESC;

-- ANSI
SELECT c.forum_no as c_forum_no, c.name as c_name, c.rdate as c_rdate,
          t.fcontents_no as t_fcontents_no, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate,
          m.memberno as m_memberno, m.mname as m_mname          
FROM forum c
INNER JOIN fcontents t
ON c.forum_no = c.forum_no
INNER JOIN member m
ON t.memberno = m.memberno
WHERE m.memberno = 1
ORDER BY c.forum_no ASC, t.fcontents_no DESC;

-- Ư�� ȸ���� �� ����� ���� cate, contents join
SELECT c.forum_no as c_forum_no, c.name as c_name, c.rdate as c_rdate,
          t.fcontents_no as t_fcontents_no, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate        
FROM forum c, fcontents t, member m
WHERE c.forum_no = t.forum_no AND t.memberno = m.memberno AND m.memberno = 1
ORDER BY c.forum_no ASC, t.fcontents_no DESC;

9) map
-- map                                   VARCHAR2(1000)         NULL ,
UPDATE fcontents
SET map='��â ������ ����'
WHERE fcontents_no=1 AND passwd='123'; 
  
SELECT fcontents_no, memberno, forum_no, web, map
FROM fcontents 
ORDER BY fcontents_no ASC;    

10) Youtube
-- map                                   VARCHAR2(1000)         NULL ,
UPDATE fcontents
SET youtube='youtube URL'
WHERE fcontents_no=13; 

SELECT fcontents_no, memberno, cateno, web, map, youtube
FROM fcontents 
WHERE fcontents_no=1 AND passwd='123'; 

11) MP3
UPDATE fcontents
SET mp3='mp3 file name'
WHERE fcontents_no=1 AND passwd='123'; 
  
SELECT fcontents_no, memberno, cateno, web, map, youtube, mp3
FROM cfontents 
ORDER BY fcontents_no ASC;    

12) ÷�� ���� ����(���, ����, ����, ����)
UPDATE fcontents
SET file1='file name', thumb1='thumb file name', size1 =5000
WHERE fcontents_no=1 AND passwd='123';

SELECT fcontents_no, memberno,forum_eno, web, map, youtube, mp3
FROM contents
ORDER BY fcontents_no ASC;

12) �˻� + ����¡
-- step 1
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND word LIKE '%������%'
ORDER BY fcontents_no DESC;

-- step 2
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, rownum as r
FROM (
          SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
          FROM fcontents
          WHERE forum_no=25 AND word LIKE '%������%'
          ORDER BY fconten_tsno DESC
);

-- step 3, 1 page
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, r
FROM (
           SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, rownum as r
           FROM (
                     SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
                     FROM fcontents
                     WHERE forum_no=29 AND word LIKE '%������%'
                     ORDER BY fcontents_no DESC
           )          
)
WHERE r >= 1 AND r <= 10;

-- step 3, 2 page
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, r
FROM (
           SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, rownum as r
           FROM (
                     SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
                     FROM fcontents
                     WHERE forum_no=25 AND word LIKE '%������%'
                     ORDER BY fcontents_no DESC
           )          
)
WHERE r >= 11 AND r <= 20;

----------------------------------------------------------------------------------------------
�亯 ���� ����
----------------------------------------------------------------------------------------------
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM boardgrp;
SELECT * FROM forum_no;

DROP TABLE fcontents  CASCADE CONSTRAINTS;

1) ��� ����
- grpno: ���Ӱ� ���� ����ϸ� �ϳ��� �ű� �׷��� ������, (SELECT NVL(MAX(grpno), 0) + 1 FROM fcontents), 0, 0)
- indent: �鿩 ����, n�� �亯�� ���� ȿ��
- ansnum: �亯 ���� ����
INSERT INTO contents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1,
                              grpno, indent, ansnum)
VALUES(fcontents_seq.nextval, 1, 1, '�ű�Ȯ�� 2��', '���� �Ա��˿��� Ȯ��', 'http://www.daum.net',
           '127.0.0.1', '123', '�ڷγ�', sysdate, 'spring.jpg', 'spring_t.jpg', 23657,
           (SELECT NVL(MAX(grpno), 0) + 1 FROM fcontents), 0, 0);
            
2) 1�� ��ȸ ����
SELECT fcontents_no, memberno, forum_no, title, content, recom, web,
          map, youtube, mp3, mp4, ip, passwd, word, rdate,
          file1, thumb1, size1, grpno, indent, ansnum
FROM fcontents
WHERE fcontents_no = 1;

3) ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;
 
 
4) �亯 ���
- catenono: FK, mno: FK
 
INSERT INTO fcontents(fcontents_no,
                          forum_no, mno, title, content, web, ip, passwd, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(fcontents_no), 0) + 1 as fcontents_no FROM contents),
            1, 1, '����', '����','�ּ�','172.0.0.1','1234', 0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
5) �亯�� ���� ���� ���� ����    
-- ORDER BY grpno DESC, ansnum ASC
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1,
          grpno, indent, ansnum, r
FROM (
           SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, ip,
                     file1, thumb1, size1,
                     grpno, indent, ansnum, rownum as r
           FROM (
                     SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, ip,
                               file1, thumb1, size1,
                               grpno, indent, ansnum
                     FROM fcontents
                     WHERE forum_no=29 AND word LIKE '%������%'
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;        
   
----------------------------------------------------------------------------------------------
�亯 ���� ����
----------------------------------------------------------------------------------------------
   
1) ��ۼ� ����
UPDATE fcontents
SET replycnt = replycnt + 1
WHERE fcontents_no = 1;

2) ��ۼ� ����
UPDATE fcontents
SET replycnt = replycnt - 1
WHERE fcontents_no = 1;   
 
 --- join

 
SELECT c.forum_no as c_forum_no, c.forum_name as c_forum_name, c.forum_rdate as c_forum_rdate,
          t.fcontents_no as t_fcontents_no, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate,
          m.memberno as m_memberno, m.mname as m_mname          
FROM forum c, fcontents t, member m
WHERE c.forum_no = t.forum_no AND t.memberno = m.memberno AND m.memberno = 1
ORDER BY c.forum_no ASC, t.fcontents_no DESC;


-- ANSI
SELECT c.forum_no as c_forum_no, c.forum_name as c_forum_name, c.forum_rdate as c_forum_rdate,
          t.fcontents_no as t_fcontents_no, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate,
          m.memberno as m_memberno, m.mname as m_mname          
FROM forum c
INNER JOIN fcontents t
ON c.forum_no = c.forum_no
INNER JOIN member m
ON t.memberno = m.memberno
WHERE m.memberno = 1
ORDER BY c.forum_no ASC, t.fcontents_no DESC;

 
SELECT c.fontents_no, c.memberno, c.forum_no, m.id
FROM fcontents c, member m
WHERE c.memberno = m.memberno;
 
 
 SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1, grpno, indent, ansnum, mid, r
FROM (
           SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, ip,
                     file1, thumb1, size1, grpno, indent, ansnum, mid, rownum as r
           FROM (
                     SELECT c.fcontents_no, c.memberno, c.forum_no, c.title, c.content, c.recom, c.cnt, c.replycnt, c.rdate, c.word, c.ip,
                               c.file1, c.thumb1, c.size1, c.grpno, c.indent, c.ansnum,
                               m.id as mid
                     FROM fcontents c, member m
                     WHERE forum_no=1 
                               AND c.memberno = m.memberno 
                               AND (title LIKE '%swiss%' OR content LIKE '%swiss%' OR word LIKE '%swiss%')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;         
  