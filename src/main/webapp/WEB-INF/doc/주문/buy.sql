/**********************************/
/* Table Name: ȸ�� *  /           
/**********************************/

-- member(PL �ۼ�) ���̺� �ʿ�

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

COMMENT ON TABLE member is 'ȸ��';
COMMENT ON COLUMN member.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN member.member_id is 'ID';
COMMENT ON COLUMN member.member_passwd is '��й�ȣ';
COMMENT ON COLUMN member.member_nickname is '�г���';
COMMENT ON COLUMN member.member_name is '�̸�';
COMMENT ON COLUMN member.member_isAdult is '�ֹε�Ϲ�ȣ';
COMMENT ON COLUMN member.member_tel is '��ȭ��ȣ';
COMMENT ON COLUMN member.member_email is '�̸���';
COMMENT ON COLUMN member.member_rdate is '������';
COMMENT ON COLUMN member.member_zipcode is '�����ȣ';
COMMENT ON COLUMN member.member_address1 is '�ּ�1';
COMMENT ON COLUMN member.member_address2 is '�ּ�2';
COMMENT ON COLUMN member.member_profilepic is '�����ʻ���';
COMMENT ON COLUMN member.member_profilepic is '�����ʼ�����';
COMMENT ON COLUMN member.memberlevel_no is '���';
COMMENT ON COLUMN member.auth_no is '����';
COMMENT ON COLUMN member.snslogin_no is 'SNS�α���';

DROP SEQUENCE member_no_seq;
CREATE SEQUENCE member_no_SEQ
  START WITH 1           -- ���� ��ȣ
  INCREMENT BY 1       -- ������
  MAXVALUE 9999999999 -- �ִ밪: 99999999 --> NUMBER(10) ����
  CACHE 2                  -- 2���� �޸𸮿����� ���
  NOCYCLE;                -- �ٽ� 1���� ������?? ���� ����


/**********************************/
/* Table Name: ������ */
/**********************************/

-- product(DA �ۼ�) ���̺� �ʿ�

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

COMMENT ON TABLE product is '��ǰ';
COMMENT ON COLUMN product.product_no is '��ǰ ��ȣ';
COMMENT ON COLUMN product.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN product.product_name is '��ǰ��';
COMMENT ON COLUMN product.product_brand is '�귣��';
COMMENT ON COLUMN product.product_origin is '������';
COMMENT ON COLUMN product.product_frequency is '����';
COMMENT ON COLUMN product.product_description is '����';
COMMENT ON COLUMN product.product_cost is '����';
COMMENT ON COLUMN product.product_ml is '���뷮';
COMMENT ON COLUMN product.product_word is '�˻���';
COMMENT ON COLUMN product.product_passwd is '��й�ȣ';
COMMENT ON COLUMN product.product_replycnt is '��ۼ�';
COMMENT ON COLUMN product.product_file1 is '�����̹���';
COMMENT ON COLUMN product.product_thumb1 is '���� �̹��� Preview';
COMMENT ON COLUMN product.product_size1 is '���� �̹��� ũ��';
COMMENT ON COLUMN product.product_indent is '�鿩����/�亯����';
COMMENT ON COLUMN product.product_ansnum is '�亯����';
COMMENT ON COLUMN product.product_grpno is '�׷��ȣ';
COMMENT ON COLUMN product.product_cnt is '��ȸ��';
COMMENT ON COLUMN product.product_recom is '��õ��';
COMMENT ON COLUMN product.product_rdate is '�����';
COMMENT ON COLUMN product.productgrp_no is '��ǰ ���� ��ȣ';

DROP SEQUENCE product_seq;
CREATE SEQUENCE product_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪: 9999999 --> NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;   


/**********************************/
/* Table Name: �ֹ� */
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

COMMENT ON TABLE buy is '�ֹ� ����';
COMMENT ON COLUMN buy.buy_no is '�ֹ� ��ȣ';
COMMENT ON COLUMN buy.cart_no is '��ٱ��� ��ȣ';
COMMENT ON COLUMN buy.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN buy.product_no is '������ ��ȣ';
COMMENT ON COLUMN buy.order_check is '���� Ȯ��';
COMMENT ON COLUMN buy.dev_no is '��� ��ȣ';
COMMENT ON COLUMN buy.pay_no is '���� ��ȣ';
COMMENT ON COLUMN buy.pay_count is '�ֹ� ����';
COMMENT ON COLUMN buy.pay_rdate is '�ֹ� ����';
COMMENT ON COLUMN buy.buy_check is '�ֹ� Ȯ��';

DROP SEQUENCE buy_seq;
CREATE SEQUENCE buy_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO buy(buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check)
VALUES (buy_seq.nextval, 1, 1, 1, '�ֹ� ����', 1, 1, 3, sysdate, 'N');

-- ���
SELECT buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check 
FROM buy
ORDER BY buy_no DESC;

-- ���� ���
SELECT buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check 
FROM buy
WHERE buy_no=1
ORDER BY buy_no DESC;

-- ��ȸ
SELECT buy_no, cart_no, member_no, product_no, order_check, dev_no, pay_no, pay_count, pay_rdate, buy_check
FROM buy
WHERE buy_no = 1;

-- ����
UPDATE buy
SET pay_count = 2
WHERE buy_no = 1;

-- ����
DELETE buy
WHERE buy_no = 4; 
  
commit;


/**********************************/
/* Table Name: ��� ���� */
/**********************************/
DROP TABLE dev;
CREATE TABLE dev(
    dev_no                            NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                         NUMERIC(10)    NOT NULL,
    buy_no                          NUMERIC(10),
    dev_member                        VARCHAR(999)     NOT NULL,
    dev_phone                       VARCHAR(50)    NOT NULL ,
    zipcode                           VARCHAR(5)        NULL, -- �����ȣ, 12345
    address1                          VARCHAR(80)       NULL, -- �ּ� 1
    address2                          VARCHAR(50)       NULL, -- �ּ� 2
    dev_message                    VARCHAR(999)     NULL,
    dev_rdate                         DATE     NOT NULL,
    dev_number                      VARCHAR(999)     NOT NULL,
    dev_check                          CHAR(1)           DEFAULT 'N' NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no)
);

COMMENT ON TABLE dev is '��� ����';
COMMENT ON COLUMN dev.dev_no is '��� ��ȣ';
COMMENT ON COLUMN dev.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN dev.buy_no is '�ֹ� ��ȣ';
COMMENT ON COLUMN dev.dev_member is '��� �޴º�';
COMMENT ON COLUMN dev.dev_phone is '��� �޴º� ����ó';
COMMENT ON COLUMN dev.zipcode is '���� ��ȣ';
COMMENT ON COLUMN dev.address1 is '�ּ�';
COMMENT ON COLUMN dev.address2 is '�ּ� �ڼ���';
COMMENT ON COLUMN dev.dev_message is '��� �޼���';
COMMENT ON COLUMN dev.dev_rdate is '��� ����';
COMMENT ON COLUMN dev.dev_number is '����� ��ȣ';
COMMENT ON COLUMN dev.dev_check is '��� Ȯ��';

DROP SEQUENCE dev_seq;
CREATE SEQUENCE dev_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO dev(dev_no, member_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check)
VALUES (dev_seq.nextval, 1, 1, 'ȫ�浿', '010-1111-2222', '12345', '����Ư����', '����Ʈ', '���� ��� ��Ź�ؿ�', sysdate,  '0122-0121-0210', 'N');

-- ���
SELECT dev_no, member_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
FROM dev 
ORDER BY dev_no DESC;

-- ��ȸ
SELECT dev_no, member_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
FROM dev
WHERE dev_no = 1;

-- ����
UPDATE dev
SET dev_member = '�迵��', dev_phone = 01099998888, zipcode='22222', address1 = '�λ� ������', address2='12-1', dev_number = 'EA01-2015-de41'
WHERE dev_no = 1;

-- ����
DELETE dev
WHERE dev_no = 1; 

commit;

/**********************************/
/* Table Name: �ּҷ� */
/**********************************/
DROP TABLE address;
CREATE TABLE address(
    address_no                       NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                      NUMERIC(10)    NOT NULL,
    address_name                   VARCHAR(50)    NOT NULL ,
    address_member               VARCHAR(50)     NOT NULL,
    address_phone                  VARCHAR(50)    NOT NULL ,
    zipcode                           VARCHAR(5)        NULL, -- �����ȣ, 12345
    address1                          VARCHAR(200)       NULL, -- �ּ� 1
    address2                          VARCHAR(100)       NULL, -- �ּ� 2
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE address is '�ּҷ� ����';
COMMENT ON COLUMN address.address_no is '�ּҷ� ��ȣ';
COMMENT ON COLUMN address.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN address.address_name is '�ּҷ� �̸�';
COMMENT ON COLUMN address.address_member is '�̸�';
COMMENT ON COLUMN address.address_phone is '����ó';
COMMENT ON COLUMN address.zipcode is '�����ȣ';
COMMENT ON COLUMN address.address1 is '�ּ�';
COMMENT ON COLUMN address.address2 is '�ּ� �ڼ���';

DROP SEQUENCE address_seq;
CREATE SEQUENCE address_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO address(address_no, member_no, address_name, address_member, address_phone, zipcode, address1, address2)
VALUES (address_seq.nextval, 1,  '����', 'ȫ�浿', '010-1111-2222', '12345', '����', '����Ʈ 101��');

-- ���
SELECT address_no, member_no, address_name, address_member, address_phone, zipcode, address1, address2
FROM address 
ORDER BY address_no DESC;

-- ��ȸ
SELECT address_no, member_no, address_name, address_member, address_phone, zipcode, address1, address2
FROM address
WHERE address_no = 1;

-- ����
UPDATE address
SET address_name = 'ȸ������', address_member = '���ݿ���', address_phone = 01099998888, zipcode='22222', address1 = '�λ� ������', address2='12-1'
WHERE address_no = 1;

-- ����
DELETE address
WHERE address_no = 1; 

commit;

/**********************************/
/* Table Name: ���� ���� */
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

COMMENT ON TABLE pay is '���� ����';
COMMENT ON COLUMN pay.pay_no is '���� ��ȣ';
COMMENT ON COLUMN pay.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN pay.buy_no is '�ֹ� ��ȣ';
COMMENT ON COLUMN pay.pay_rdate is '���� ����';
COMMENT ON COLUMN pay.dev_cost is '��� �ݾ�';
COMMENT ON COLUMN pay.product_cost is '��ǰ �ݾ�';
COMMENT ON COLUMN pay.pay_point is '����Ʈ';
COMMENT ON COLUMN pay.pay_coupon is '����';
COMMENT ON COLUMN pay.pay_total is '���� �ݾ�';
COMMENT ON COLUMN pay.pay_way is '���� ���';
COMMENT ON COLUMN pay.pay_check is '���� Ȯ��';

DROP SEQUENCE pay_seq;
CREATE SEQUENCE pay_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO pay(pay_no, member_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check)
VALUES (pay_seq.nextval, 1, 1, sysdate, 3000, 5000, 50, 100, 8000, 'ī�����', 'N');

-- ���
SELECT pay_no, member_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
FROM pay 
ORDER BY pay_no DESC;

-- ��ȸ
SELECT pay_no, member_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
FROM pay
WHERE pay_no = 1;

-- ����
UPDATE pay
SET pay_cost= 7000, pay_way = '�ڵ��� ����'
WHERE pay_no = 5;

-- ����
DELETE pay
WHERE pay_no = 1; 

commit;

/**********************************/
/* Table Name: ����Ʈ */
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

COMMENT ON TABLE point is '����Ʈ';
COMMENT ON COLUMN point.point_no is '����Ʈ ��ȣ';
COMMENT ON COLUMN point.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN point.pay_no is '���� ��ȣ';
COMMENT ON COLUMN point.point_num is '����Ʈ ��';

DROP SEQUENCE point_seq;
CREATE SEQUENCE point_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO point(point_no, member_no, pay_no, point_num)
VALUES (point_seq.nextval, 1, 1, 50);

INSERT INTO point(point_no, member_no, pay_no, point_num)
VALUES (point_seq.nextval, 2, 1, 150);

-- ���
SELECT * FROM point ORDER BY point_no ASC;

-- ��ȸ
SELECT point_no, member_no, pay_no, point_num
FROM point
WHERE point_no = 1;

-- ����
UPDATE point
SET point_num = 20
WHERE point_no = 1;

-- ����
DELETE point
WHERE point_no = 2; 

SELECT point_no, member_no, pay_no, point_num
FROM point
WHERE member_no=1;

commit;


/**********************************/
/* Table Name: ���� */
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

COMMENT ON TABLE coupon is '����';
COMMENT ON COLUMN coupon.coupon_no is '���� ��ȣ';
COMMENT ON COLUMN coupon.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN coupon.pay_no is '���� ��ȣ';
COMMENT ON COLUMN coupon.coupon_num is '���� �ݾ�';
COMMENT ON COLUMN coupon.coupon_rdate is '���� �߱޳�¥';
COMMENT ON COLUMN coupon.coupon_use_rdate is '���� ��볯¥';
COMMENT ON COLUMN coupon.coupon_until_rdate is '���� ��ȿ�Ⱓ';
COMMENT ON COLUMN coupon.coupon_check is '���� ��뿩��';


DROP SEQUENCE coupon_seq;
CREATE SEQUENCE coupon_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO coupon(coupon_no, member_no, pay_no, coupon_num, coupon_rdate, coupon_use_rdate, coupon_until_rdate, coupon_check)
VALUES (coupon_seq.nextval, 1, 1, 10000, sysdate, '2021-02-02', '2021-02-20', 'Y');

-- ���
SELECT * FROM coupon ORDER BY coupon_no DESC;

-- ��ȸ
SELECT coupon_no, member_no, pay_no, coupon_num, coupon_rdate, coupon_use_rdate, coupon_until_rdate, coupon_check
FROM coupon
WHERE coupon_no = 1;

-- ����
UPDATE coupon
SET coupon_check = 'N'
WHERE coupon_no = 1;

-- ����
DELETE coupon
WHERE coupon_no = 1; 

SELECT  coupon_no, member_no, pay_no, coupon_num, coupon_rdate, coupon_use_rdate, coupon_until_rdate, coupon_check
FROM coupon
WHERE member_no=1;

commit;

