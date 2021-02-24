/**********************************/
/* Table Name: 회원 *  /           
/**********************************/

-- member(PL 작성) 테이블 필요

DROP TABLE member;
CREATE TABLE member(
    member_no                     NUMBER(10)    NOT NULL    PRIMARY KEY,
    member_id                     VARCHAR2(50)    NULL,
    member_passwd                 VARCHAR2(50)    NULL,
    member_nickname               VARCHAR2(50)    NULL,
    member_name                   VARCHAR2(50)    NULL,
    member_isAdult                VARCHAR2(50)    NULL,
    member_tel                    VARCHAR2(50)    NULL,
    member_email                  VARCHAR2(100)   NULL,
    member_rdate                  DATE            NULL,
    member_zipcode                VARCHAR2(200)   NULL,
    member_address1               VARCHAR2(200)     NULL,
    member_address2               VARCHAR2(200)     NULL,
    member_profilepic             VARCHAR2(200)     NULL,
    member_profilethumb           VARCHAR2(200)     NULL,
    memberlevel_no                NUMBER(10)    NULL,
    auth_no                       NUMBER(10)        NULL,
    snslogin_no                   NUMBER(10)    NULL,
    FOREIGN KEY (auth_no) REFERENCES auth (auth_no),
    FOREIGN KEY (memberlevel_no) REFERENCES memberlevel (memberlevel_no),
    FOREIGN KEY (snslogin_no) REFERENCES snslogin (snslogin_no)
);

COMMENT ON TABLE member is '회원';
COMMENT ON COLUMN member.member_no is '회원번호';
COMMENT ON COLUMN member.member_id is 'ID';
COMMENT ON COLUMN member.member_passwd is '비밀번호';
COMMENT ON COLUMN member.member_nickname is '닉네임';
COMMENT ON COLUMN member.member_name is '이름';
COMMENT ON COLUMN member.member_isAdult is '주민등록번호';
COMMENT ON COLUMN member.member_tel is '전화번호';
COMMENT ON COLUMN member.member_email is '이메일';
COMMENT ON COLUMN member.member_rdate is '가입일';
COMMENT ON COLUMN member.member_zipcode is '우편번호';
COMMENT ON COLUMN member.member_address1 is '주소1';
COMMENT ON COLUMN member.member_address2 is '주소2';
COMMENT ON COLUMN member.member_profilepic is '프로필사진';
COMMENT ON COLUMN member.member_profilepic is '프로필섬네일';
COMMENT ON COLUMN member.memberlevel_no is '등급';
COMMENT ON COLUMN member.auth_no is '권한';
COMMENT ON COLUMN member.snslogin_no is 'SNS로그인';

DROP SEQUENCE member_no_seq;
CREATE SEQUENCE member_no_SEQ
  START WITH 1           -- 시작 번호
  INCREMENT BY 1       -- 증가값
  MAXVALUE 9999999999 -- 최대값: 99999999 --> NUMBER(10) 대응
  CACHE 2                  -- 2번은 메모리에서만 계산
  NOCYCLE;                -- 다시 1부터 생성되?? 것을 방지


/**********************************/
/* Table Name: 전통주 */
/**********************************/

-- product(DA 작성) 테이블 필요

DROP TABLE product;
CREATE TABLE product(
    product_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
        member_no                              NUMBER(10)     NOT NULL ,
    product_name                      VARCHAR2(100)    NOT NULL,
    product_brand                     VARCHAR2(100)    NOT NULL,
    product_origin                    VARCHAR2(100)    NOT NULL,
    product_frequency               VARCHAR2(100)    NOT NULL,
    product_description               VARCHAR2(2000)     NOT NULL,
    product_cost                      VARCHAR2(100)    NOT NULL,
    product_ml                        VARCHAR2(100)    NOT NULL,
        product_word                       VARCHAR2(300)         NULL ,
    product_passwd                    NUMBER(20)     NOT NULL,
    product_replycnt                  NUMBER(7)    DEFAULT 0     NOT NULL,
    product_file1                     VARCHAR2(100)    NULL ,
    product_thumb1                    VARCHAR2(100)    NULL ,
    product_size1                     NUMBER(10)     DEFAULT 0     NULL ,
    product_indent                    NUMBER(2)    DEFAULT 0     NOT NULL,
    product_ansnum                    NUMBER(3)    DEFAULT 0     NOT NULL,
    product_grpno                     NUMBER(8)    DEFAULT 0     NOT NULL,
    product_cnt                       NUMBER(7)    DEFAULT 0     NOT NULL,
    product_recom                     NUMBER(7)    DEFAULT 0     NOT NULL,
    product_rdate                     DATE     NOT NULL,
        productgrp_no                     NUMBER(10)     NOT NULL,
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


/**********************************/
/* Table Name: 주문 */
/**********************************/
DROP TABLE buy;
CREATE TABLE buy(
    buy_no                          NUMERIC(10)    NOT NULL    PRIMARY KEY,
    cart_no                           NUMERIC(10)    NOT NULL,
    member_no                         NUMERIC(10)    NOT NULL,
    product_no                        NUMBER(10)     NOT NULL,
    order_check                      VARCHAR2(30)    NOT NULL,
    dev_no                            NUMERIC(10)    NOT NULL,
    pay_no                            NUMERIC(10)    NULL ,
    pay_count                         NUMERIC(10)    NOT NULL,
    pay_rdate                         DATE     NOT NULL,
    buy_check                          CHAR(1)           DEFAULT 'N' NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (product_no) REFERENCES product (product_no)
);

COMMENT ON TABLE buy is '주문 관리';
COMMENT ON COLUMN buy.buy_no is '주문 번호';
COMMENT ON COLUMN buy.cart_no is '장바구니 번호';
COMMENT ON COLUMN buy.member_no is '회원 번호';
COMMENT ON COLUMN buy.product_no is '전통주 번호';
COMMENT ON COLUMN buy.order_check is '접수 확인';
COMMENT ON COLUMN buy.dev_no is '배송 번호';
COMMENT ON COLUMN buy.pay_no is '결제 번호';
COMMENT ON COLUMN buy.pay_count is '주문 수량';
COMMENT ON COLUMN buy.pay_rdate is '주문 일자';
COMMENT ON COLUMN buy.buy_check is '주문 확인';

DROP SEQUENCE buy_seq;
CREATE SEQUENCE buy_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO buy(buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check)
VALUES (buy_seq.nextval, 1, 1, 1, '주문 접수', 1, 1, 3, sysdate, 'N');

-- 목록
SELECT buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check 
FROM buy
ORDER BY buy_no DESC;

-- 수정 목록
SELECT buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check 
FROM buy
WHERE buy_no=1
ORDER BY buy_no DESC;

-- 조회
SELECT buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check
FROM buy
WHERE buy_no = 1;

-- 수정
UPDATE buy
SET pay_count = 2
WHERE buy_no = 1;

-- 삭제
DELETE buy
WHERE buy_no = 4; 
  
commit;


/**********************************/
/* Table Name: 배송 관리 */
/**********************************/
DROP TABLE dev;
CREATE TABLE dev(
    dev_no                            NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                         NUMERIC(10)    NOT NULL,
    buy_no                          NUMERIC(10),
    dev_member                        VARCHAR(999)     NOT NULL,
    dev_phone                       VARCHAR(50)    NOT NULL ,
    zipcode                           VARCHAR(5)        NULL, -- 우편번호, 12345
    address1                          VARCHAR(80)       NULL, -- 주소 1
    address2                          VARCHAR(50)       NULL, -- 주소 2
    dev_message                    VARCHAR(999)     NULL,
    dev_rdate                         DATE     NOT NULL,
    dev_number                      VARCHAR(999)     NOT NULL,
    dev_check                          CHAR(1)           DEFAULT 'N' NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no)
);

COMMENT ON TABLE dev is '배송 관리';
COMMENT ON COLUMN dev.dev_no is '배송 번호';
COMMENT ON COLUMN dev.member_no is '회원 번호';
COMMENT ON COLUMN dev.buy_no is '주문 번호';
COMMENT ON COLUMN dev.dev_member is '배송 받는분';
COMMENT ON COLUMN dev.dev_phone is '배송 받는분 연락처';
COMMENT ON COLUMN dev.zipcode is '우편 번호';
COMMENT ON COLUMN dev.address1 is '주소';
COMMENT ON COLUMN dev.address2 is '주소 자세히';
COMMENT ON COLUMN dev.dev_message is '배송 메세지';
COMMENT ON COLUMN dev.dev_rdate is '배송 일자';
COMMENT ON COLUMN dev.dev_number is '운송장 번호';
COMMENT ON COLUMN dev.dev_check is '배송 확인';

DROP SEQUENCE dev_seq;
CREATE SEQUENCE dev_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO dev(dev_no, member_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check)
VALUES (dev_seq.nextval, 1, 1, '홍길동', '010-1111-2222', '12345', '서울특별시', '아파트', '빠른 배송 부탁해요', sysdate,  '0122-0121-0210', 'N');

-- 목록
SELECT dev_no, member_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
FROM dev 
ORDER BY dev_no DESC;

-- 조회
SELECT dev_no, member_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
FROM dev
WHERE dev_no = 1;

-- 수정
UPDATE dev
SET dev_member = '김영희', dev_phone = 01099998888, zipcode='22222', address1 = '부산 광역시', address2='12-1', dev_number = 'EA01-2015-de41'
WHERE dev_no = 1;

-- 삭제
DELETE dev
WHERE dev_no = 1; 

commit;

/**********************************/
/* Table Name: 주소록 */
/**********************************/
DROP TABLE address;
CREATE TABLE address(
    address_no                       NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                      NUMERIC(10)    NOT NULL,
    address_name                   VARCHAR(50)    NOT NULL ,
    address_member               VARCHAR(50)     NOT NULL,
    address_phone                  VARCHAR(50)    NOT NULL ,
    zipcode                           VARCHAR(5)        NULL, -- 우편번호, 12345
    address1                          VARCHAR(200)       NULL, -- 주소 1
    address2                          VARCHAR(100)       NULL, -- 주소 2
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE address is '주소록 관리';
COMMENT ON COLUMN address.address_no is '주소록 번호';
COMMENT ON COLUMN address.member_no is '회원 번호';
COMMENT ON COLUMN address.address_name is '주소록 이름';
COMMENT ON COLUMN address.address_member is '이름';
COMMENT ON COLUMN address.address_phone is '연락처';
COMMENT ON COLUMN address.zipcode is '우편번호';
COMMENT ON COLUMN address.address1 is '주소';
COMMENT ON COLUMN address.address2 is '주소 자세히';

DROP SEQUENCE address_seq;
CREATE SEQUENCE address_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO address(address_no, member_no, address_name, address_member, address_phone, zipcode, address1, address2)
VALUES (address_seq.nextval, 1,  '베프', '홍길동', '010-1111-2222', '12345', '서울', '아파트 101동');

-- 목록
SELECT address_no, member_no, address_name, address_member, address_phone, zipcode, address1, address2
FROM address 
ORDER BY address_no DESC;

-- 조회
SELECT address_no, member_no, address_name, address_member, address_phone, zipcode, address1, address2
FROM address
WHERE address_no = 1;

-- 수정
UPDATE address
SET address_name = '회사직원', address_member = '알콜요정', address_phone = 01099998888, zipcode='22222', address1 = '부산 광역시', address2='12-1'
WHERE address_no = 1;

-- 삭제
DELETE address
WHERE address_no = 1; 

commit;

/**********************************/
/* Table Name: 결제 관리 */
/**********************************/
DROP TABLE pay;
CREATE TABLE pay(
    pay_no                            NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                      NUMERIC(10)    NOT NULL,
    buy_no                          NUMERIC(10),
    pay_rdate                        DATE     NOT NULL,
    dev_cost                         NUMERIC(10)    NOT NULL,
    product_cost                   NUMERIC(10)    NOT NULL,
    pay_point                       NUMERIC(10)    NULL,
    pay_coupon                    NUMERIC(10)    NULL,
    pay_total                        NUMERIC(10)    NOT NULL,
    pay_way                         VARCHAR2(50)     NOT NULL,
    pay_check                          CHAR(1)           DEFAULT 'N' NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no)
);

COMMENT ON TABLE pay is '결제 관리';
COMMENT ON COLUMN pay.pay_no is '결제 번호';
COMMENT ON COLUMN pay.member_no is '회원 번호';
COMMENT ON COLUMN pay.buy_no is '주문 번호';
COMMENT ON COLUMN pay.pay_rdate is '결제 일자';
COMMENT ON COLUMN pay.dev_cost is '배송 금액';
COMMENT ON COLUMN pay.product_cost is '상품 금액';
COMMENT ON COLUMN pay.pay_point is '포인트';
COMMENT ON COLUMN pay.pay_coupon is '쿠폰';
COMMENT ON COLUMN pay.pay_total is '결제 금액';
COMMENT ON COLUMN pay.pay_way is '결제 방법';
COMMENT ON COLUMN pay.pay_check is '결제 확인';

DROP SEQUENCE pay_seq;
CREATE SEQUENCE pay_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO pay(pay_no, member_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check)
VALUES (pay_seq.nextval, 1, 1, sysdate, 3000, 5000, 50, 100, 8000, '카드결제', 'N');

-- 목록
SELECT pay_no, member_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
FROM pay 
ORDER BY pay_no DESC;

-- 조회
SELECT pay_no, member_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
FROM pay
WHERE pay_no = 1;

-- 수정
UPDATE pay
SET pay_cost= 7000, pay_way = '핸드폰 결제'
WHERE pay_no = 5;

-- 삭제
DELETE pay
WHERE pay_no = 1; 

commit;

/**********************************/
/* Table Name: 포인트 */
/**********************************/
DROP TABLE point;
CREATE TABLE point(
    point_no                           NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                       NUMERIC(10)    NOT NULL,
    pay_no                              NUMERIC(10)    NULL,
    point_num                         NUMERIC(10)    NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (pay_no) REFERENCES pay (pay_no)
);

COMMENT ON TABLE point is '포인트';
COMMENT ON COLUMN point.point_no is '포인트 번호';
COMMENT ON COLUMN point.member_no is '회원 번호';
COMMENT ON COLUMN point.pay_no is '결제 번호';
COMMENT ON COLUMN point.point_num is '포인트 수';

DROP SEQUENCE point_seq;
CREATE SEQUENCE point_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO point(point_no, member_no, pay_no, point_num)
VALUES (point_seq.nextval, 1, 1, 50);

INSERT INTO point(point_no, member_no, pay_no, point_num)
VALUES (point_seq.nextval, 2, 1, 150);

-- 목록
SELECT * FROM point ORDER BY point_no ASC;

-- 조회
SELECT point_no, member_no, pay_no, point_num
FROM point
WHERE point_no = 1;

-- 수정
UPDATE point
SET point_num = 20
WHERE point_no = 1;

-- 삭제
DELETE point
WHERE point_no = 2; 

SELECT point_no, member_no, pay_no, point_num
FROM point
WHERE member_no=1;

commit;


/**********************************/
/* Table Name: 쿠폰 */
/**********************************/
DROP TABLE coupon;
CREATE TABLE coupon(
    coupon_no                         NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                       NUMERIC(10)    NOT NULL,
    pay_no                              NUMERIC(10)    NULL,
    coupon_num                      NUMERIC(10)    NOT NULL,
    coupon_rdate                      DATE     NOT NULL, 
    coupon_use_rdate                VARCHAR2(50)     NULL,
    coupon_until_rdate               VARCHAR2(50)     NULL,
    coupon_check                     CHAR(1)           DEFAULT 'N' NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (pay_no) REFERENCES pay (pay_no)
);

COMMENT ON TABLE coupon is '쿠폰';
COMMENT ON COLUMN coupon.coupon_no is '쿠폰 번호';
COMMENT ON COLUMN coupon.member_no is '회원 번호';
COMMENT ON COLUMN coupon.pay_no is '결제 번호';
COMMENT ON COLUMN coupon.coupon_num is '쿠폰 금액';
COMMENT ON COLUMN coupon.coupon_rdate is '쿠폰 발급날짜';
COMMENT ON COLUMN coupon.coupon_use_rdate is '쿠폰 사용날짜';
COMMENT ON COLUMN coupon.coupon_until_rdate is '쿠폰 유효기간';
COMMENT ON COLUMN coupon.coupon_check is '쿠폰 사용여부';


DROP SEQUENCE coupon_seq;
CREATE SEQUENCE coupon_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지
  
-- 등록
INSERT INTO coupon(coupon_no, member_no, pay_no, coupon_num, coupon_rdate, coupon_use_rdate, coupon_until_rdate, coupon_check)
VALUES (coupon_seq.nextval, 1, 1, 10000, sysdate, '2021-02-02', '2021-02-20', 'Y');

-- 목록
SELECT * FROM coupon ORDER BY coupon_no DESC;

-- 조회
SELECT coupon_no, member_no, pay_no, coupon_num, coupon_rdate, coupon_use_rdate, coupon_until_rdate, coupon_check
FROM coupon
WHERE coupon_no = 1;

-- 수정
UPDATE coupon
SET coupon_check = 'N'
WHERE coupon_no = 1;

-- 삭제
DELETE coupon
WHERE coupon_no = 1; 

SELECT  coupon_no, member_no, pay_no, coupon_num, coupon_rdate, coupon_use_rdate, coupon_until_rdate, coupon_check
FROM coupon
WHERE member_no=1;

commit;

