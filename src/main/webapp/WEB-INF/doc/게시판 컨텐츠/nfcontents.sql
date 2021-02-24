/**********************************/
/* Table Name: 컨텐츠 */
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

COMMENT ON TABLE fcontents is '게시판 글내용';
COMMENT ON COLUMN fcontents.fcontents_no is '컨텐츠 번호';
COMMENT ON COLUMN fcontents.forum_no is '카테고리 번호';
COMMENT ON COLUMN fcontents.title is '제목';
COMMENT ON COLUMN fcontents.content is '내용';
COMMENT ON COLUMN fcontents.recom is '추천수';
COMMENT ON COLUMN fcontents.cnt is '조회수';
COMMENT ON COLUMN fcontents.replycnt is '댓글수';
COMMENT ON COLUMN fcontents.web is '인터넷 주소';
COMMENT ON COLUMN fcontents.map is '지도';
COMMENT ON COLUMN fcontents.youtube is 'Youtube';
COMMENT ON COLUMN fcontents.mp3 is 'MP3';
COMMENT ON COLUMN fcontents.mp4 is 'MP4';
COMMENT ON COLUMN fcontents.visible is '출력 모드';
COMMENT ON COLUMN fcontents.ip is 'IP';
COMMENT ON COLUMN fcontents.passwd is '패스워드';
COMMENT ON COLUMN fcontents.grpno is '그룹번호';
COMMENT ON COLUMN fcontents.indent is '들여쓰기/답변차수';
COMMENT ON COLUMN fcontents.ansnum is '답변순서';
COMMENT ON COLUMN fcontents.word is '검색어';
COMMENT ON COLUMN fcontents.rdate is '등록일';
COMMENT ON COLUMN fcontents.file1 is '메인 이미지';
COMMENT ON COLUMN fcontents.thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN fcontents.size1 is ' 메인 이미지 크기';

DROP SEQUENCE fcontents_seq;
CREATE SEQUENCE fcontents_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
1) 글 등록(이미지 관련 컬러 추가)
-- memberno: 1, forum_no: 1이 사전에 등록이되어 있어야 INSERT 가능
INSERT INTO fcontents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(fcontents_seq.nextval, 1, 1, '신규확진 2명', '전원 입국검역서 확인', 'http://www.daum.net',
            '127.0.0.1', '123', '코로나', sysdate, 'spring.jpg', 'spring_t.jpg', 23657);

INSERT INTO fcontents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(fcontents_seq.nextval, 1, 2, '신규확진 2명', '전원 입국검역서 확인', 'http://www.daum.net',
            '127.0.0.1', '123', '코로나', sysdate, 'summer.jpg', 'summer_t.jpg', 23657);
            
INSERT INTO fcontents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1)
VALUES(fcontents_seq.nextval, 1, 3, '스위스', '가을 여행', 'http://www.daum.net',
            '127.0.0.1', '123', '코로나', sysdate, 'maple.jpg', 'maple_t.jpg', 23657);



COMMIT;

SELECT fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM fcontents 
ORDER BY fcontents_no ASC;    

CONTENTSNO   FORUM_NO TITLE                                                                                                                                                                                                                                                                                                        CONTENT                                                                          WEB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  IP              PASSWD
---------- ---------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------- ---------------
WORD                                                                                                                                                                                                                                                                                                         RDATE    FILE1                                                                                                THUMB1                                                                                                    SIZE1
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------
         5          1 추운 겨울                                                                                                                                                                                                                                                                                                    이번 겨울은 더 춥겠어요..                                                        http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             
김겨울     

-- 현재 sequence의 확인
SELECT fcontents_seq.nextval FROM dual;
SELECT fcontents_seq.currval FROM dual;

2) 전체목록
SELECT fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM fcontents 
ORDER BY fcontents_no DESC;

CONTENTSNO   FORUM_NO TITLE                                                                                                                                                                                                                                                                                                        CONTENT                                                                          WEB                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  IP              PASSWD          WORD                                                                                                                                                                                                                                                                                                         RDATE    FILE1                                                                                                THUMB1                                                                                                    SIZE1
---------- ---------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------------------------------------------------------------------------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --------------- --------------- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ -------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------
         5          1 추운 겨울                                                                                                                                                                                                                                                                                                    이번 겨울은 더 춥겠어요..                                                        http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             김겨울                                                                                                                                                                                                                                                                                                       20/11/05 winter.jpg                                                                                           winter_t.jpg                                                                                              23657
         4          1 신규확진 222명                                                                                                                                                                                                                                                                                               종교활동으로 인한 확산                                                           http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             코로나                                                                                                                                                                                                                                                                                                       20/11/05 fall.jpg                                                                                             fall_t.jpg                                                                                                23657
         3          1 신규확진 9명                                                                                                                                                                                                                                                                                                 케냐발 코로나                                                                    http://www.daum.net                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  127.0.0.1       123             코로나                                                                                                                                                                                                                                                                                                       20/11/05 summer.jpg                                                                                           summer_t.jpg                                                                                              23657
         2          1 신규확진 2명     

2-1) forum_no별 목록
SELECT fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate, file1, thumb1, size1
FROM fcontents 
WHERE forum_no = 1
ORDER BY fcontents_no DESC;

2-2) forum_no별 검색 목록
1) 검색
① forum_no별 검색 목록
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=1 AND word LIKE '%신규확진 2명%'
ORDER BY fcontents_no DESC;

SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND word LIKE '%신규확진 9명%'
ORDER BY fcontents_no DESC;

SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=2 AND word LIKE '%추운 겨울%'
ORDER BY fcontents_no DESC;

SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND word LIKE '%swiss%'
ORDER BY fcontents_no DESC;


-- title, content, word column search
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND (title LIKE '%유럽%' OR content LIKE '%유럽%' OR word LIKE '%유럽%')
ORDER BY fcontents_no DESC;


② 검색 레코드 갯수
-- 전체 레코드 갯수
SELECT COUNT(*) as cnt
FROM fcontents
WHERE forum_no=25;

-- forum_no 별 검색된 레코드 갯수
SELECT COUNT(*) as cnt
FROM fcontents
WHERE forum_no=25 AND word LIKE '%스위스%';

SELECT COUNT(*) as cnt
FROM fcontents
WHERE forum_no=25 AND (title LIKE '%유럽%' OR content LIKE '%유럽%' OR word LIKE '%유럽%')


3) 1건 조회
SELECT fcontents_no, memberno, cateno, title, content, recom, web, map, youtube, mp3, mp4, ip, passwd,
          word, rdate, file1, thumb1, size1
FROM fcontents
WHERE fcontents_no = 1;

4) 수정, id="update"
UPDATE fcontents 
SET title='제목', content='내용', web='http://', word='검색어'
WHERE fcontents_no = 5;

COMMIT;

5) 패스워드 검사, id="passwd_check"
SELECT COUNT(*) as passwd_cnt
FROM fcontents
WHERE fcontents_no=5 AND passwd='123';

SELECT fcontents_no, passwd
FROM fcontents 
ORDER BY fcontents_no DESC;    

6) 삭제
-- 전체 레코드 삭제
DELETE FROM fcontents;
COMMIT;  

DELETE FROM fcontents
WHERE fcontents_no=13;

COMMIT;  


7) 모든 레코드 갯수
SELECT COUNT(*) as cnt
FROM fcontents;
 
 COUNT
 -----
     5
     
8) 특정 회원이 작성한 글만 출력: cate + contents + member
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

-- 특정 회원의 글 출력을 위한 cate, contents join
SELECT c.forum_no as c_forum_no, c.name as c_name, c.rdate as c_rdate,
          t.fcontents_no as t_fcontents_no, t.title as t_title, t.web as t_web, t.ip as t_ip, t.rdate as t_rdate        
FROM forum c, fcontents t, member m
WHERE c.forum_no = t.forum_no AND t.memberno = m.memberno AND m.memberno = 1
ORDER BY c.forum_no ASC, t.fcontents_no DESC;

9) map
-- map                                   VARCHAR2(1000)         NULL ,
UPDATE fcontents
SET map='고창 보리밭 축제'
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

12) 첨부 파일 변경(등록, 변경, 수정, 삭제)
UPDATE fcontents
SET file1='file name', thumb1='thumb file name', size1 =5000
WHERE fcontents_no=1 AND passwd='123';

SELECT fcontents_no, memberno,forum_eno, web, map, youtube, mp3
FROM contents
ORDER BY fcontents_no ASC;

12) 검색 + 페이징
-- step 1
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
FROM fcontents
WHERE forum_no=25 AND word LIKE '%스위스%'
ORDER BY fcontents_no DESC;

-- step 2
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, rownum as r
FROM (
          SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
          FROM fcontents
          WHERE forum_no=25 AND word LIKE '%스위스%'
          ORDER BY fconten_tsno DESC
);

-- step 3, 1 page
SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, r
FROM (
           SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, rownum as r
           FROM (
                     SELECT fcontents_no, memberno, forum_no, title, content, recom, cnt, replycnt, rdate, word, file1, thumb1, size1
                     FROM fcontents
                     WHERE forum_no=29 AND word LIKE '%스위스%'
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
                     WHERE forum_no=25 AND word LIKE '%스위스%'
                     ORDER BY fcontents_no DESC
           )          
)
WHERE r >= 11 AND r <= 20;

----------------------------------------------------------------------------------------------
답변 관련 시작
----------------------------------------------------------------------------------------------
-- 1번글 기준 답변 등록예: grpno: 1, indent: 1, ansnum: 1
SELECT * FROM member;
SELECT * FROM boardgrp;
SELECT * FROM forum_no;

DROP TABLE fcontents  CASCADE CONSTRAINTS;

1) 등록 변경
- grpno: 새롭게 글을 등록하면 하나의 신규 그룹이 생성됨, (SELECT NVL(MAX(grpno), 0) + 1 FROM fcontents), 0, 0)
- indent: 들여 쓰기, n차 답변에 대한 효과
- ansnum: 답변 순서 지정
INSERT INTO contents(fcontents_no, memberno, forum_no, title, content, web, ip, passwd, word, rdate,
                              file1, thumb1, size1,
                              grpno, indent, ansnum)
VALUES(fcontents_seq.nextval, 1, 1, '신규확진 2명', '전원 입국검역서 확인', 'http://www.daum.net',
           '127.0.0.1', '123', '코로나', sysdate, 'spring.jpg', 'spring_t.jpg', 23657,
           (SELECT NVL(MAX(grpno), 0) + 1 FROM fcontents), 0, 0);
            
2) 1건 조회 변경
SELECT fcontents_no, memberno, forum_no, title, content, recom, web,
          map, youtube, mp3, mp4, ip, passwd, word, rdate,
          file1, thumb1, size1, grpno, indent, ansnum
FROM fcontents
WHERE fcontents_no = 1;

3) 새로운 답변을 최신으로 등록하기위해 기존 답변을 뒤로 미룹니다.
-- 모든 글의 우선 순위가 1씩 증가됨, 1등 -> 2등
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 0;
 
-- 2등부터 우선 순위가 1씩 증가됨, 2등 -> 3등
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 1;
 
-- 3등부터 우선 순위가 1씩 증가됨, 3등 -> 4등
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 2;
 
-- 6등부터 우선 순위가 1씩 증가됨, 6등 -> 7등
UPDATE fcontents
SET ansnum = ansnum + 1
WHERE grpno = 1 AND ansnum > 5;
 
 
4) 답변 등록
- catenono: FK, mno: FK
 
INSERT INTO fcontents(fcontents_no,
                          forum_no, mno, title, content, web, ip, passwd, good, thumbs, files, sizes, cnt, replycnt, rdate, 
                          grpno, indent, ansnum, word)  
VALUES((SELECT NVL(MAX(fcontents_no), 0) + 1 as fcontents_no FROM contents),
            1, 1, '제목', '내용','주소','172.0.0.1','1234', 0, 'summer_m.jpg', 'summer.jpg', 0, 0, 0, sysdate,
            1, 1, 1,'');
 
 
5) 답변에 따른 정렬 순서 변경    
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
                     WHERE forum_no=29 AND word LIKE '%스위스%'
                     ORDER BY grpno DESC, ansnum ASC
           )          
)
WHERE r >= 1 AND r <= 10;        
   
----------------------------------------------------------------------------------------------
답변 관련 종료
----------------------------------------------------------------------------------------------
   
1) 댓글수 증가
UPDATE fcontents
SET replycnt = replycnt + 1
WHERE fcontents_no = 1;

2) 댓글수 감소
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
  