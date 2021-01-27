DROP TABLE memberlevel;

CREATE TABLE MEMBERLEVEL (
    MEMBERLEVEL_NO  NUMBER(10,0)    PRIMARY KEY, 
	MEMBERLEVEL_NAME   VARCHAR2(100 BYTE)
);

COMMENT ON COLUMN "TEAM2"."MEMBERLEVEL"."MEMBERLEVEL_NO" IS '등급 번호';
COMMENT ON COLUMN "TEAM2"."MEMBERLEVEL"."MEMBERLEVEL_NAME" IS '등급 이름';
COMMENT ON TABLE "TEAM2"."MEMBERLEVEL"  IS '등급';

--등록
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (1,'기업 회원');
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (2,'우수 회원');
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (3,'정회원');
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (4,'준회원');


-- 목록
SELECT *
FROM memberlevel
ORDER BY memberlevel_no ASC;

MEMBERLEVEL_NO MEMBERLEVEL_NAME                                                                                    
-------------- ----------------------------------------------------------------------------------------------------
             1 기업 회원                                                                                           
             2 우수 회원                                                                                           
             3 정회원                                                                                              
             4 준회원                                                                                              

-- 조회
SELECT memberlevel_no, memberlevel_name
FROM memberlevel
WHERE memberlevel_no = 3;

-- 수정
UPDATE memberlevel
SET memberlevel_name = '우수회원'
WHERE memberlevel_no = 2;

-- 삭제
DELETE FROM memberlevel
WHERE memberlevel_no=4;
