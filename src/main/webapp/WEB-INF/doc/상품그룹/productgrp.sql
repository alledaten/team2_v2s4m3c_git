/**********************************/
/* Table Name: 상품 종류 */
/**********************************/
DROP TABLE productgrp;
CREATE TABLE productgrp(
        productgrp_no                 		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
	productgrp_name               		VARCHAR2(20)		 NOT NULL,
        productgrp_seqno                  NUMBER(10)		 DEFAULT 0		 NOT NULL,
        productgrp_visible           		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
        productgrp_rdate                         		DATE		 NOT NULL,
        productgrp_cnt                           		NUMBER(10)		 DEFAULT 0		 NOT NULL
);

COMMENT ON TABLE productgrp is '상품 종류';
COMMENT ON COLUMN productgrp.productgrp_no is '상품 종류 번호';
COMMENT ON COLUMN productgrp.productgrp_name is '상품 종류';
COMMENT ON COLUMN productgrp.productgrp_seqno is '출력 순서';
COMMENT ON COLUMN productgrp.productgrp_visible is '출력 모드';
COMMENT ON COLUMN productgrp.productgrp_rdate is '그룹 생성일';
COMMENT ON COLUMN productgrp.productgrp_cnt is '등록된 글 수';

DROP SEQUENCE productgrp_seq;
CREATE SEQUENCE productgrp_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;    

-- insert
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '탁주', 1, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '약주', 2, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '과실주', 3, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '증류주', 4, 'Y', sysdate);
INSERT INTO productgrp(productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate)
VALUES(productgrp_seq.nextval, '기타', 5, 'Y', sysdate);

COMMIT;

-- list
SELECT productgrp_no, productgrp_name, productgrp_seqno, productgrp_visible, productgrp_rdate
FROM productgrp
ORDER BY productgrp_seqno ASC;

PRODUCTTYPE_NO PRODUCTTYPE_NAME    
-------------- --------------------
             1 탁주                
             2 약주                
             3 과실주              
             4 증류주              
             5 기타         
             
-- 조회
SELECT productgrp_no, productgrp_name, productgrp_visible
FROM productgrp
WHERE productgrp_no = 1;

PRODUCTTYPE_NO PRODUCTTYPE_NAME    
-------------- --------------------
             1 탁주          

-- 수정
UPDATE productgrp
SET productgrp_name='탁주주', productgrp_seqno = 2, productgrp_visible='N'
WHERE productgrp_no = 1;

UPDATE categrp
SET name='업무 양식', seqno = 3, visible='N'
WHERE categrpno = 3;

-- 삭제  
DELETE FROM productgrp
WHERE productgrp_no = 1;

