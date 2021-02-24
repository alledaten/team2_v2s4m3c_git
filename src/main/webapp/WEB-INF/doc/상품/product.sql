
/***********************************/
/* Table Name: 상품 */
/***********************************/
DROP TABLE product; 
CREATE TABLE product(
		product_no                    		NUMBER(10)		 NOT NULL    PRIMARY KEY,
    member_no                              NUMBER(10)     NOT NULL ,
		product_name                  		VARCHAR2(100)		 NOT NULL,
		product_brand                 		VARCHAR2(100)		 NOT NULL,
		product_origin                		VARCHAR2(100)		 NOT NULL,
		product_frequency             	VARCHAR2(100)		 NOT NULL,
		product_description           		VARCHAR2(2000)		 NOT NULL,
		product_cost                  		VARCHAR2(100)		 NOT NULL,
		product_ml                    		VARCHAR2(100)		 NOT NULL,
    product_word                       VARCHAR2(300)         NULL ,
		product_passwd                		NUMBER(20)		 NOT NULL,
		product_replycnt              		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		product_file1                 		VARCHAR2(100)		 NULL ,
		product_thumb1                		VARCHAR2(100)		 NULL ,
		product_size1                  		NUMBER(10)		 DEFAULT 0		 NULL ,
		product_indent                		NUMBER(2)		 DEFAULT 0		 NOT NULL,
		product_ansnum                		NUMBER(3)		 DEFAULT 0		 NOT NULL,
		product_grpno                 		NUMBER(8)		 DEFAULT 0		 NOT NULL,
		product_cnt                   		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		product_recom                 		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		product_rdate                  		DATE		 NOT NULL,
    productgrp_no                 		NUMBER(10)		 NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (productgrp_no) REFERENCES productgrp (productgrp_no)
);

COMMENT ON TABLE product is '상품';
COMMENT ON COLUMN product.product_no is '상품 번호';
COMMENT ON COLUMN product.member_no is '회원 번호';
COMMENT ON COLUMN product.product_name is '제품명';
COMMENT ON COLUMN product.product_brand is '브랜드';
COMMENT ON COLUMN product.product_origin is '원산지';
COMMENT ON COLUMN product.product_frequency is '도수';
COMMENT ON COLUMN product.product_description is '내용';
COMMENT ON COLUMN product.product_cost is '가격';
COMMENT ON COLUMN product.product_ml is '내용량';
COMMENT ON COLUMN product.product_word is '검색어';
COMMENT ON COLUMN product.product_passwd is '비밀번호';
COMMENT ON COLUMN product.product_replycnt is '댓글수';
COMMENT ON COLUMN product.product_file1 is '메인이미지';
COMMENT ON COLUMN product.product_thumb1 is '메인 이미지 Preview';
COMMENT ON COLUMN product.product_size1 is '메인 이미지 크기';
COMMENT ON COLUMN product.product_indent is '들여쓰기/답변차수';
COMMENT ON COLUMN product.product_ansnum is '답변순서';
COMMENT ON COLUMN product.product_grpno is '그룹번호';
COMMENT ON COLUMN product.product_cnt is '조회수';
COMMENT ON COLUMN product.product_recom is '추천수';
COMMENT ON COLUMN product.product_rdate is '등록일';
COMMENT ON COLUMN product.productgrp_no is '상품 종류 번호';

DROP SEQUENCE product_seq;
CREATE SEQUENCE product_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;   
  
-- insert
INSERT INTO product(product_no, member_no, productgrp_no, product_name, product_brand, product_origin, product_frequency, product_description, product_cost,product_ml, product_word, product_passwd, product_rdate)
VALUES(product_seq.nextval, 1, 1, 'asdf', '자체제작 상품', '서울 특별시', '5', '당일 배송', '2500', '750', '장수', 1234, sysdate);
INSERT INTO product(product_no, member_no, productgrp_no, product_name, product_brand, product_origin, product_frequency, product_description, product_cost,product_ml, product_word, product_passwd, product_rdate)
VALUES(product_seq.nextval, 1, 1, '이상재명가 한산소곡주', '한산소곡주', '충청남도 서천군', '16', '당일 배송', '20000', '1500', '곡주', 1234, sysdate);

COMMIT;

-- list
SELECT *
FROM product
ORDER BY product_no ASC;

SELECT product_no, productgrp_no, product_name, product_brand, product_origin, product_frequency, product_description, product_cost,product_ml, product_word, product_passwd, product_rdate
FROM product
WHERE productgrp_no=2
ORDER BY product_no ASC


PRODUCT_NO PRODUCTTYPE_NO PRODUCT_NAME                                                                                         PRODUCT_BRAND                                                                                        PRODUCT_ORIGIN                                                                                       PRODUCT_FREQUENCY PRODUCT_DESCRIPTION                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              PRODUCT_COST PRODUCT_ML PRODUCT_DATE       
---------- -------------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------ ---------- -------------------
         1              1 장수 막걸리                                                                                          자체제작 상품                                                                                        서울 특별시                                                                                                          5 당일 배송                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                2500        750 2020-10-29 12:09:12
         2              2 이상재명가 한산소곡주                                                                                한산소곡주                                                                                           충청남도 서천군                                                                                                     16 당일 배송                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               20000       1500 2020-10-29 12:09:12
         3              3 고창선운산 복분자주                                                                                  고창선운산(유)                                                                                       전북 고창군                                                                                                       16.5 당일 배송                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               23750       1800 2020-10-29 12:09:12
         4              4 도원결의                                                                                             (주)영덕주조                                                                                         국내                                                                                                                15 당일 배송                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                5220        375 2020-10-29 12:09:12
         5              5 서울의 밤                                                                                            더한주류                                                                                             국내                                                                                                                25 당일 배송                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                7500        375 2020-10-29 12:09:12

           
-- 조회
SELECT *
FROM product
WHERE product_no = 1;

PRODUCT_NO PRODUCTTYPE_NO PRODUCT_NAME                                                                                         PRODUCT_BRAND                                                                                        PRODUCT_ORIGIN                                                                                       PRODUCT_FREQUENCY PRODUCT_DESCRIPTION                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              PRODUCT_COST PRODUCT_ML PRODUCT_DATE       
---------- -------------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------ ---------- -------------------
         1              1 장수 막걸리                                                                                          자체제작 상품                                                                                        서울 특별시                                                                                                          5 당일 배송                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                2500        750 2020-10-29 12:09:12

-- 수정
UPDATE product
SET product_name='한산소곡주'
WHERE product_no = 2;

PRODUCT_NO PRODUCTTYPE_NO PRODUCT_NAME                                                                                         PRODUCT_BRAND                                                                                        PRODUCT_ORIGIN                                                                                       PRODUCT_FREQUENCY PRODUCT_DESCRIPTION                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              PRODUCT_COST PRODUCT_ML PRODUCT_DATE       
---------- -------------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ---------------------------------------------------------------------------------------------------- ----------------- -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ------------ ---------- -------------------
         2              2 한산소곡주                                                                                           한산소곡주                                                                                           충청남도 서천군                                                                                                     16 당일 배송                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               20000       1500 2020-10-29 12:09:12


-- 삭제  
DELETE FROM product
WHERE product_no = 2;

SELECT COUNT(*) as passwd_cnt
FROM product
WHERE product_no=2 AND product_passwd=1234;

------------------------------------------------------------------------------------------
UPDATE product
SET product_name='한산소곡주', product_brand='asdf', product_origin='asdf',product_frequency=1,product_description='asdf',product_cost= 1,product_ml = 1
WHERE product_no = 2;

