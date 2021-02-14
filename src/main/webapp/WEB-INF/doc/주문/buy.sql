/**********************************/
/* Table Name: 회원 */
/**********************************/
DROP TABLE member CASCADE CONSTRAINTS;
CREATE TABLE member(
    member_no                         NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_name                       VARCHAR2(50)     NOT NULL,
    member_id                         VARCHAR2(50)     NOT NULL,
    member_address                    VARCHAR2(200)    NOT NULL,
    member_phone                      NUMERIC(10)    NOT NULL
);

COMMENT ON TABLE  is '회원';
COMMENT ON COLUMN member.member_no is '회원 번호';
COMMENT ON COLUMN member.member_name is '회원 이름';
COMMENT ON COLUMN member.member_id is '회원 ID';
COMMENT ON COLUMN member.member_address is '회원 주소';
COMMENT ON COLUMN member.member_phone is '회원 연락처';

DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 등록
INSERT INTO member(member_no, member_name, member_id, member_address, member_phone)
VALUES (member_seq.nextval, '홍길동', 'hong123', '서울특별시', 01011112222);

-- 목록
SELECT * FROM member ORDER BY member_no ASC;


/**********************************/
/* Table Name: 전통주 */
/**********************************/
DROP TABLE product;
CREATE TABLE product(
    product_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    product_name                      VARCHAR2(30)     NOT NULL,
    product_price                     DOUBLE PRECISION     NOT NULL
);

COMMENT ON TABLE product is '전통주';
COMMENT ON COLUMN product.product_no is '전통주 번호';
COMMENT ON COLUMN product.product_name is '제품명';
COMMENT ON COLUMN product.product_price is '가격';

DROP SEQUENCE product_seq;
CREATE SEQUENCE product_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값 9999999 -- NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;                     -- 다시 1부터 생성되는 것을 방지

-- 등록
INSERT INTO product(product_no, product_name, product_price)
VALUES (product_seq.nextval, '서울의 밤', '15000');

-- 목록
SELECT * FROM product ORDER BY product_no ASC;

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
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no)
);

COMMENT ON TABLE dev is '배송 관리';
COMMENT ON COLUMN dev.dev_no is '배송 번호';
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
INSERT INTO dev(dev_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check)
VALUES (dev_seq.nextval, 1, '홍길동', '010-1111-2222', '12345', '서울특별시', '아파트', '빠른 배송 부탁해요', sysdate,  '0122-0121-0210', 'N');

-- 목록
SELECT dev_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
FROM dev 
ORDER BY dev_no DESC;

-- 조회
SELECT dev_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
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
    buy_no                          NUMERIC(10),
    pay_rdate                        DATE     NOT NULL,
    dev_cost                         NUMERIC(10)    NOT NULL,
    product_cost                   NUMERIC(10)    NOT NULL,
    pay_point                       NUMERIC(10)    NULL,
    pay_coupon                    NUMERIC(10)    NULL,
    pay_total                        NUMERIC(10)    NOT NULL,
    pay_way                         VARCHAR2(50)     NOT NULL,
    pay_check                          CHAR(1)           DEFAULT 'N' NOT NULL,
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no)
);

COMMENT ON TABLE pay is '결제 관리';
COMMENT ON COLUMN pay.pay_no is '결제 번호';
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
INSERT INTO pay(pay_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check)
VALUES (pay_seq.nextval, 1, sysdate, 3000, 5000, 50, 100, 8000, '카드결제', 'N');

-- 목록
SELECT pay_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
FROM pay 
ORDER BY pay_no DESC;

-- 조회
SELECT pay_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
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
