/**********************************/
/* Table Name: �Խù� ����*/
/**********************************/
DROP TABLE FORUM_CONTENTS;

DROP TABLE attachfile;
DROP TABLE forum_contents CASCADE CONSTRAINTS;
CREATE TABLE forum_contents(
        forum_contents_no                            NUMBER(10)         NOT NULL         PRIMARY KEY,
        member_no                              NUMBER(10)     NOT NULL ,
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
        ip                                         VARCHAR2(15)         NULL,
        passwd                                VARCHAR2(15)         NOT NULL,
        grpno                                 NUMBER(8)         DEFAULT 0         NOT NULL,
        indent                                NUMBER(2)         DEFAULT 0         NOT NULL,
        ansnum                                NUMBER(3)         DEFAULT 0         NOT NULL,
        word                                  VARCHAR2(300)         NULL ,
        rdate                                 DATE               NOT NULL,
        file1                                   VARCHAR(100)          NULL,
        thumb1                              VARCHAR(100)          NULL,
        size1                                 NUMBER(10)      DEFAULT 0 NULL,  
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (forum_no) REFERENCES forum (forum_no)
);

COMMENT ON TABLE forum_contents is '������';
COMMENT ON COLUMN forum_contents.forum_contents_no is '������ ��ȣ';
COMMENT ON COLUMN forum_contents.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN forum_contents.forum_no is 'ī�װ� ��ȣ';
COMMENT ON COLUMN forum_contents.title is '����';
COMMENT ON COLUMN forum_contents.content is '����';
COMMENT ON COLUMN forum_contents.recom is '��õ��';
COMMENT ON COLUMN forum_contents.cnt is '��ȸ��';
COMMENT ON COLUMN forum_contents.replycnt is '��ۼ�';
COMMENT ON COLUMN forum_contents.web is '���ͳ� �ּ�';
COMMENT ON COLUMN forum_contents.map is '����';
COMMENT ON COLUMN forum_contents.youtube is 'Youtube';
COMMENT ON COLUMN forum_contents.mp3 is 'MP3';
COMMENT ON COLUMN forum_contents.mp4 is 'MP4';
COMMENT ON COLUMN forum_contents.visible is '��� ���';
COMMENT ON COLUMN forum_contents.ip is 'IP';
COMMENT ON COLUMN forum_contents.passwd is '�н�����';
COMMENT ON COLUMN forum_contents.grpno is '�׷��ȣ';
COMMENT ON COLUMN forum_contents.indent is '�鿩����/�亯����';
COMMENT ON COLUMN forum_contents.ansnum is '�亯����';
COMMENT ON COLUMN forum_contents.word is '�˻���';
COMMENT ON COLUMN forum_contents.rdate is '�����';
COMMENT ON COLUMN forum_contents.file1 is '���� �̹���';
COMMENT ON COLUMN forum_contents.thumb1 is '���� �̹��� Preview';
COMMENT ON COLUMN forum_contents.size1 is ' ���� �̹��� ũ��';

DROP SEQUENCE forum_contents_seq;
CREATE SEQUENCE forum_contents_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
1) �� ���(�̹��� ���� �÷� �߰�)
-- memberno: 1, cateno: 1�� ������ ����̵Ǿ� �־�� INSERT ����
INSERT INTO forum_contents(forum_contents_no, member_no, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(forum_contents_seq.nextval, 1, 1, '�����Խ��� ù��', '�׽�Ʈ�� ù��', 'http://www.daum.net',
            '127.0.0.1', '1234', '�׽�Ʈ', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO forum_contents(forum_contents_no, member_no, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(forum_contents_seq.nextval, 1, 2, '����ũ�Խ��� ù��', '�׽�Ʈ�� ù��', 'http://www.daum.net',
            '127.0.0.1', '1234', '�׽�Ʈ', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);
            
INSERT INTO forum_contents(forum_contents_no, member_no, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(forum_contents_seq.nextval, 1, 3, '��Ÿ�Խ��� ù��', '�׽�Ʈ�� ù��', 'http://www.daum.net',
            '127.0.0.1', '1234', '�׽�Ʈ', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

COMMIT;

SELECT forum_contents_no, member_no, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM forum_contents 
ORDER BY forum_contents_no ASC;    

-- ���� sequence�� Ȯ��
SELECT forum_contents_seq.nextval FROM dual;
SELECT forum_contents_seq.currval FROM dual;

2) ��ü���
SELECT forum_contents_no, member_no, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1 
FROM forum_contents 
ORDER BY forum_contents_no DESC;

-- 2-1) forum_no�� ���
SELECT forum_contents_no, member_no, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM forum_contents 
WHERE forum_no = 1
ORDER BY forum_contents_no DESC;

2-2) forum_no�� �˻� ���
1) �˻�
�� forum_no�� �˻� ���
SELECT forum_contents_no, member_no, forum_no, title, content, 
           recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM contents
WHERE cateno=4 AND word LIKE '%������%'
ORDER BY forum_contents_no DESC;

SELECT forum_contents_no, member_no, forum_no, title, content, 
           recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM forum_contents
WHERE cateno=4 AND word LIKE '%���ǽ�%'
ORDER BY contentsno DESC;

SELECT contentsno, member_no, cateno, title, content, 
           recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM contents
WHERE cateno=4 AND word LIKE '%���ǽ�%'
ORDER BY contentsno DESC;

SELECT contentsno, member_no, cateno, title, content, 
           recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM contents
WHERE cateno=4 AND word LIKE '%swiss%'
ORDER BY contentsno DESC;

SELECT contentsno, member_no, cateno, title, content, 
           recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM contents
WHERE cateno=4 AND word LIKE '%����%'
ORDER BY contentsno DESC;

-- title, content, word column search
SELECT contentsno, member_no, cateno, title, content, 
           recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM contents
WHERE cateno=4 AND (title LIKE '%����%' OR content LIKE '%����%' OR word LIKE '%����%')
ORDER BY contentsno DESC;


�� �˻� ���ڵ� ����
-- ��ü ���ڵ� ����
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=4;

-- cateno �� �˻��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=4 AND word LIKE '%������%';

SELECT COUNT(*) as cnt
FROM contents
WHERE cateno=4 AND (title LIKE '%����%' OR content LIKE '%����%' OR word LIKE '%����%')


3) 1�� ��ȸ
SELECT contentsno, member_no, cateno, title, content, recom, web, map, youtube, mp3, mp4, ip, passwd,
          word, rdate, file1, thumb1, size1
FROM contents
WHERE contentsno = 1;

4) ����
UPDATE contents 
SET title='����', content='����', web='http://', word='�˻���'
WHERE contentsno = 5;

COMMIT;

5) �н����� �˻�
SELECT COUNT(*) as passwd_cnt
FROM contents
WHERE contentsno=5 AND passwd='1234';

SELECT contentsno, passwd
FROM contents 
ORDER BY contentsno DESC;    

6) ����
-- ��ü ���ڵ� ����
DELETE FROM contents;
COMMIT;  

DELETE FROM contents
WHERE contentsno=13;

COMMIT;  


7) ��� ���ڵ� ����
SELECT COUNT(*) as cnt
FROM contents;
 
 COUNT
 -----
     5
     
8) Ư�� ȸ���� �ۼ��� �۸� ���: cate + contents + member
SELECT c.forum_no as c_forum_no, c.forum_name as c_forum_name, c.forum_rdate as c_forum_rdate,
          t.forum_contents_no as t_forum_contents_no, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate,
          m.member_no as m_member_no, m.member_name as m_member_name          
FROM forum c, forum_contents t, member m
WHERE c.forum_no = t.forum_no AND t.member_no = m.member_no AND m.member_no = 1
ORDER BY c.forum_no ASC, t.forum_contents_no DESC;

-- ANSI
SELECT c.cateno as c_cateno, c.name as c_name, c.rdate as c_rdate,
          t.contentsno as t_contentsno, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate,
          m.member_no as m_memberno, m.mname as m_mname          
FROM cate c
INNER JOIN contents t
ON c.cateno = c.cateno
INNER JOIN member m
ON t.memberno = m.member_no
WHERE m.memberno = 1
ORDER BY c.cateno ASC, t.contentsno DESC;

-- Ư�� ȸ���� �� ����� ���� cate, contents join
SELECT c.cateno as c_cateno, c.name as c_name, c.rdate as c_rdate,
          t.contentsno as t_contentsno, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate        
FROM cate c, contents t, member m
WHERE c.cateno = t.cateno AND t.memberno = m.memberno AND m.memberno = 1
ORDER BY c.cateno ASC, t.contentsno DESC;

9) map
-- map                                   VARCHAR2(1000)         NULL ,
UPDATE contents
SET map='��â ������ ����'
WHERE contentsno=1 AND passwd='123'; 
  
SELECT contentsno, memberno, cateno, web, map
FROM contents 
ORDER BY contentsno ASC;    

SELECT contentsno, memberno, cateno, web, map
FROM contents 
WHERE contentsno=11;    

10) Youtube
-- map                                   VARCHAR2(1000)         NULL ,
UPDATE contents
SET youtube='youtube URL'
WHERE contentsno=13 AND passwd='123'; 

SELECT contentsno, memberno, cateno, web, map, youtube
FROM contents 
WHERE contentsno=1 

11) MP3
UPDATE contents
SET mp3='mp3 file name'
WHERE contentsno=1 AND passwd='123'; 
  
SELECT contentsno, memberno, cateno, web, map, youtube, mp3
FROM contents 
ORDER BY contentsno ASC;

12) ÷�� ���� ����(���, ����, ����, ����)
UPDATE contents
SET file1='file name', thumb1='thumb file name', size1=5000
WHERE contentsno=7; 
  
SELECT contentsno, memberno, cateno, file1, thumb1, size1
FROM contents 
ORDER BY contentsno ASC; 

COMMIT;

13) �˻� + ����¡ + ���� �̹���
-- step 1
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1
FROM contents
WHERE cateno=27 AND word LIKE '%��ǳ%'
ORDER BY contentsno DESC;

-- step 2
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1, rownum as r
FROM (
          SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                    file1, thumb1, size1
          FROM contents
          WHERE cateno=27 AND word LIKE '%��ǳ%'
          ORDER BY contentsno DESC
);

-- step 3, 1 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                     file1, thumb1, size1, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                               file1, thumb1, size1
                     FROM contents
                     WHERE cateno=27 AND word LIKE '%��ǳ%'
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 1 AND r <= 10;

-- step 3, 2 page
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                     file1, thumb1, size1, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                               file1, thumb1, size1
                     FROM contents
                     WHERE cateno=27 AND word LIKE '%��ǳ%'
                     ORDER BY contentsno DESC
           )          
)
WHERE r >= 11 AND r <= 20;


----------------------------------------------------------------------------------------------
�亯 ���� ����
----------------------------------------------------------------------------------------------
-- 1���� ���� �亯 ��Ͽ�: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM categrp;
SELECT * FROM cateno;

DROP TABLE contents  CASCADE CONSTRAINTS;

1) ��� ����
- grpno: ���Ӱ� ���� ����ϸ� �ϳ��� �ű� �׷��� ������, (SELECT NVL(MAX(grpno), 0) + 1 FROM contents), 0, 0)
- indent: �鿩 ����, n�� �亯�� ���� ȿ��
- ansnum: �亯 ���� ����
INSERT INTO contents(contentsno, memberno, cateno, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1,
                              grpno, indent, ansnum)
VALUES(contents_seq.nextval, 1, 1, '�ű�Ȯ�� 2��', '���� �Ա��˿��� Ȯ��', 'http://www.daum.net',
           '127.0.0.1', '123', '�ڷγ�', sysdate, 'spring.jpg', 'spring_t.jpg', 23657,
           (SELECT NVL(MAX(grpno), 0) + 1 FROM contents), 0, 0);
            
2) 1�� ��ȸ ����
SELECT contentsno, memberno, cateno, title, content, recom, web,
          map, youtube, mp3, mp4, ip, passwd, word, rdate,
          file1, thumb1, size1, grpno, indent, ansnum
FROM contents
WHERE contentsno = 1;

3) ���ο� �亯�� �ֽ����� ����ϱ����� ���� �亯�� �ڷ� �̷�ϴ�.
-- ��� ���� �켱 ������ 1�� ������, 1�� -> 2��
UPDATE contents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2����� �켱 ������ 1�� ������, 2�� -> 3��
UPDATE contents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3����� �켱 ������ 1�� ������, 3�� -> 4��
UPDATE contents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6����� �켱 ������ 1�� ������, 6�� -> 7��
UPDATE contents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;
 
 
4) �亯 ���
- catenono: FK, mno: FK
 
INSERT INTO contents(contentsno,
                          cateno, mno, title, content, web, ip, passwd, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(contentsno), 0) + 1 as contentsno FROM contents),
            1, 1, '����', '����','�ּ�','172.0.0.1','1234', 0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
5) �亯�� ���� ���� ���� ����    
-- ORDER BY grpno DESC, ansnum ASC
SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1,
          grpno, indent, ansnum, r
FROM (
           SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                     file1, thumb1, size1,
                     grpno, indent, ansnum, rownum as r
           FROM (
                     SELECT contentsno, memberno, cateno, title, content, recom, cnt, replycnt, rdate, word, ip,
                               file1, thumb1, size1,
                               grpno, indent, ansnum
                     FROM contents
                     WHERE cateno=29 AND (title LIKE '%swiss%' OR content LIKE '%swiss%' OR word LIKE '%swiss%')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;        
   
----------------------------------------------------------------------------------------------
�亯 ���� ����
----------------------------------------------------------------------------------------------

1)����
----------------------------------------------------------------------------------------------
�亯 + member join start
----------------------------------------------------------------------------------------------
SELECT c.forum_contents_no, c.member_no, c.forum_no, m.member_id
FROM forum_contents c, member m
WHERE c.member_no = m.member_no;



-- 2���� �÷��� �ߺ��Ǵ°��� as�� ����Ͽ� �÷����� ����, id�� member_id�� ����
SELECT forum_contents_no, member_no, forum_no, title, content, recom, cnt, replycnt, rdate, word, ip,
          file1, thumb1, size1, grpno, indent, ansnum, member_id, r
FROM (
           SELECT forum_contents_no, member_no, forum_no, title, content, recom, cnt, replycnt, rdate, word, ip,
                     file1, thumb1, size1, grpno, indent, ansnum, member_id, rownum as r
           FROM (
                     SELECT c.forum_contents_no, c.member_no, c.forum_no, c.title, c.content, c.recom, c.cnt, c.replycnt, c.rdate, c.word, c.ip,
                               c.file1, c.thumb1, c.size1, c.grpno, c.indent, c.ansnum,
                               m.member_id as member_id
                     FROM forum_contents c, member m
                     WHERE forum_no=1 
                               AND c.member_no = m.member_no 
                               AND (title LIKE '%swiss%' OR content LIKE '%swiss%' OR word LIKE '%swiss%')
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;        
   
----------------------------------------------------------------------------------------------
�亯 + member join end
----------------------------------------------------------------------------------------------


1) ��ۼ� ����
UPDATE contents
SET replycnt = replycnt + 1
WHERE contentsno = 1;

2) ��ۼ� ����
UPDATE contents
SET replycnt = replycnt - 1
WHERE contentsno = 1;   







  
  