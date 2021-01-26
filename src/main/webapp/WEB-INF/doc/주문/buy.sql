/**********************************/
/* Table Name: ȸ�� */
/**********************************/
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
VALUES (member_no_seq.nextval, 'ȫ�浿', 'hong123', '����Ư����', 01011112222);

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
    dev_address                       VARCHAR(999)     NOT NULL,
    dev_message                    VARCHAR(999)     NOT NULL,
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
COMMENT ON COLUMN dev.dev_address is '��� �ּ�';
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
INSERT INTO dev(dev_no, buy_no, dev_member, dev_phone, dev_address, dev_message, dev_rdate, dev_number, dev_check)
VALUES (dev_seq.nextval, 1, 'ȫ�浿', '010-1111-2222', '����Ư����', '���� ��� ��Ź�ؿ�', sysdate,  '0122-0121-0210', 'N');

-- ���
SELECT dev_no, buy_no, dev_member, dev_phone, dev_address, dev_message, dev_rdate, dev_number, dev_check 
FROM dev 
ORDER BY dev_no DESC;

-- ��ȸ
SELECT dev_no, buy_no, dev_member, dev_phone, dev_address, dev_message, dev_rdate, dev_number, dev_check
FROM dev
WHERE dev_no = 1;

-- ����
UPDATE dev
SET dev_member = '�迵��', dev_phone = 01099998888 dev_address = '�λ� ������', dev_number = 'EA01-2015-de41'
WHERE dev_no = 1;

-- ����
DELETE dev
WHERE dev_no = 1; 

commit;

/**********************************/
/* Table Name: ���� ���� */
/**********************************/
DROP TABLE pay;
CREATE TABLE pay(
    pay_no                            NUMERIC(10)    NOT NULL    PRIMARY KEY,
    buy_no                          NUMERIC(10),
    pay_rdate                         DATE     NOT NULL,
    pay_cost                          NUMERIC(10)    NOT NULL,
    pay_way                         VARCHAR2(50)     NOT NULL,
    pay_check                          CHAR(1)           DEFAULT 'N' NOT NULL,
  FOREIGN KEY (buy_no) REFERENCES buy (buy_no)
);

COMMENT ON TABLE pay is '���� ����';
COMMENT ON COLUMN pay.pay_no is '���� ��ȣ';
COMMENT ON COLUMN pay.buy_no is '�ֹ� ��ȣ';
COMMENT ON COLUMN pay.pay_rdate is '���� ����';
COMMENT ON COLUMN pay.pay_cost is '���� �ݾ�';
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
INSERT INTO pay(pay_no, buy_no, pay_rdate, pay_cost, pay_way, pay_check)
VALUES (pay_seq.nextval, 1, sysdate, 5000,  'ī�����', 'N');

-- ���
SELECT pay_no, buy_no, pay_rdate, pay_cost, pay_way, pay_check 
FROM pay 
ORDER BY pay_no DESC;

-- ��ȸ
SELECT pay_no, buy_no, pay_rdate, pay_cost, pay_way, pay_check
FROM pay
WHERE pay_no = 1;

-- ����
UPDATE pay
SET pay_way = '�ڵ��� ����'
WHERE pay_no = 1;

-- ����
DELETE pay
WHERE pay_no = 1; 

commit;

/**********************************/
/* Table Name: ��ٱ��� */
/**********************************/
CREATE TABLE cart(
    cart_no                           NUMERIC(10)    NOT NULL    PRIMARY KEY,
    order_no                          NUMERIC(10)    NULL ,
    member_no                         NUMERIC(10)    NOT NULL,
    alcohol_name                      VARCHAR(999)     NOT NULL,
    order_count                       NUMERIC(10)    NOT NULL,
  FOREIGN KEY (order_no) REFERENCES order (order_no)
);

COMMENT ON TABLE cart is '��ٱ���';
COMMENT ON COLUMN cart.cart_no is '��ٱ��Ϲ�ȣ';
COMMENT ON COLUMN cart.order_no is '�ֹ� ��ȣ';
COMMENT ON COLUMN cart.member_no is 'ȸ�� ��ȣ';
COMMENT ON COLUMN cart.alcohol_name is '������ �̸�';
COMMENT ON COLUMN cart.order_count is '�ֹ� ����';

DROP SEQUENCE cart_seq;
CREATE SEQUENCE cart_seq
  START WITH 1              -- ���� ��ȣ
  INCREMENT BY 1          -- ������
  MAXVALUE 9999999999 -- �ִ밪 9999999 -- NUMBER(7) ����
  CACHE 2                       -- 2���� �޸𸮿����� ���
  NOCYCLE;                     -- �ٽ� 1���� �����Ǵ� ���� ����
  
-- ���
INSERT INTO cart(cart_no, order_no, member_no, alcohol_name, order_count)
VALUES (cart_no_seq.nextval, 1, 1, '��� ���ɸ�', 5);

-- ���
SELECT * FROM cart ORDER BY cart_no ASC;

-- ��ȸ
SELECT cart_no, order_no, member_no, alcohol_name, order_count
FROM cart
WHERE cart_no = 1;

-- ����
UPDATE cart
SET order_count = 2
WHERE cart_no = 1;

-- ����
DELETE cart
WHERE cart_no = 1; 


