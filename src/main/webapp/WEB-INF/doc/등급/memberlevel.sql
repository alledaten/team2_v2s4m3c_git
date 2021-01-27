DROP TABLE memberlevel;

CREATE TABLE MEMBERLEVEL (
    MEMBERLEVEL_NO  NUMBER(10,0)    PRIMARY KEY, 
	MEMBERLEVEL_NAME   VARCHAR2(100 BYTE)
);

COMMENT ON COLUMN "TEAM2"."MEMBERLEVEL"."MEMBERLEVEL_NO" IS '��� ��ȣ';
COMMENT ON COLUMN "TEAM2"."MEMBERLEVEL"."MEMBERLEVEL_NAME" IS '��� �̸�';
COMMENT ON TABLE "TEAM2"."MEMBERLEVEL"  IS '���';

--���
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (1,'��� ȸ��');
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (2,'��� ȸ��');
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (3,'��ȸ��');
Insert into TEAM2.MEMBERLEVEL (MEMBERLEVEL_NO,MEMBERLEVEL_NAME) values (4,'��ȸ��');


-- ���
SELECT *
FROM memberlevel
ORDER BY memberlevel_no ASC;

MEMBERLEVEL_NO MEMBERLEVEL_NAME                                                                                    
-------------- ----------------------------------------------------------------------------------------------------
             1 ��� ȸ��                                                                                           
             2 ��� ȸ��                                                                                           
             3 ��ȸ��                                                                                              
             4 ��ȸ��                                                                                              

-- ��ȸ
SELECT memberlevel_no, memberlevel_name
FROM memberlevel
WHERE memberlevel_no = 3;

-- ����
UPDATE memberlevel
SET memberlevel_name = '���ȸ��'
WHERE memberlevel_no = 2;

-- ����
DELETE FROM memberlevel
WHERE memberlevel_no=4;
