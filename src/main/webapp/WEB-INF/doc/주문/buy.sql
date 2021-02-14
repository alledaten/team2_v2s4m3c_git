/**********************************/
/* Table Name: ȸ�� */
/**********************************/
DROP TABLE member CASCADE CONSTRAINTS;
CREATE TABLE member(
    member_no                         NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_name                       VARCHAR2(50)     NOT NULL,
    member_id                         VARCHAR2(50)     NOT NULL,
    member_address                    VARCHAR2(200)    NOT NULL,
    member_phone                      NUMERIC(10)    NOT NULL
);

COMMENT ON TABLE  is 'ȸ��';
COMMENT ON COLUMN member.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN member.member_name is 'ȸ�� �̸�';
COMMENT ON COLUMN member.member_id is 'ȸ�� ID';
COMMENT ON COLUMN member.member_address is 'ȸ�� �ּ�';
COMMENT ON COLUMN member.member_phone is 'ȸ�� ����ó';

DROP SEQUENCE member_seq;
CREATE SEQUENCE member_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

-- ���
INSERT INTO member(member_no, member_name, member_id, member_address, member_phone)
VALUES (member_seq.nextval, 'ȫ�浿', 'hong123', '����Ư����', 01011112222);

-- ���
SELECT * FROM member ORDER BY member_no ASC;


/**********************************/
/* Table Name: ������ */
/**********************************/
DROP TABLE product;
CREATE TABLE product(
    product_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    product_name                      VARCHAR2(30)     NOT NULL,
    product_price                     DOUBLE PRECISION     NOT NULL
);

COMMENT ON TABLE product is '������';
COMMENT ON COLUMN product.product_no is '������ ��ȣ';
COMMENT ON COLUMN product.product_name is '��ǰ��';
COMMENT ON COLUMN product.product_price is '����';

DROP SEQUENCE product_seq;
CREATE SEQUENCE product_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����

-- ���
INSERT INTO product(product_no, product_name, product_price)
VALUES (product_seq.nextval, '������ ��', '15000');

-- ���
SELECT * FROM product ORDER BY product_no ASC;

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
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no)
);

COMMENT ON TABLE dev is '��� ����';
COMMENT ON COLUMN dev.dev_no is '��� ��ȣ';
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
INSERT INTO dev(dev_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check)
VALUES (dev_seq.nextval, 1, 'ȫ�浿', '010-1111-2222', '12345', '����Ư����', '����Ʈ', '���� ��� ��Ź�ؿ�', sysdate,  '0122-0121-0210', 'N');

-- ���
SELECT dev_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
FROM dev 
ORDER BY dev_no DESC;

-- ��ȸ
SELECT dev_no, buy_no, dev_member, dev_phone, zipcode, address1, address2, dev_message, dev_rdate, dev_number, dev_check
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

COMMENT ON TABLE pay is '���� ����';
COMMENT ON COLUMN pay.pay_no is '���� ��ȣ';
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
INSERT INTO pay(pay_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check)
VALUES (pay_seq.nextval, 1, sysdate, 3000, 5000, 50, 100, 8000, 'ī�����', 'N');

-- ���
SELECT pay_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
FROM pay 
ORDER BY pay_no DESC;

-- ��ȸ
SELECT pay_no, buy_no, pay_rdate, dev_cost, product_cost, pay_point, pay_coupon, pay_total, pay_way, pay_check
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
