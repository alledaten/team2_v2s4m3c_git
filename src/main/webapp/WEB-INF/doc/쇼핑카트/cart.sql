/**********************************/
/* Table Name: 쇼핑카트 */
/**********************************/
DROP TABLE cart;
CREATE TABLE cart(
		cart_no                       		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
    product_no                             NUMBER(10)     NOT NULL ,
    member_no                             NUMBER(10)     NOT NULL ,
		cart_cnt                      		NUMBER(10)		 NULL ,
		cart_rdate                    		DATE		 NOT NULL,
    FOREIGN KEY (member_no) REFERENCES member (member_no),
    FOREIGN KEY (product_no) REFERENCES product (product_no)
);

COMMENT ON TABLE cart is '쇼핑카트';
COMMENT ON COLUMN cart.cart_no is '카트번호';
COMMENT ON COLUMN cart.product_no is '상품번호';
COMMENT ON COLUMN product.member_no is '회원 번호';
COMMENT ON COLUMN cart.cart_cnt is '수량';
COMMENT ON COLUMN cart.cart_rdate is '날짜';

DROP SEQUENCE cart_seq;
CREATE SEQUENCE cart_seq
  START WITH 1              -- 시작 번호
  INCREMENT BY 1          -- 증가값
  MAXVALUE 9999999999 -- 최대값: 9999999 --> NUMBER(7) 대응
  CACHE 2                       -- 2번은 메모리에서만 계산
  NOCYCLE;   
  
COMMIT;
  
INSERT INTO cart(cart_no, product_no, member_no, cart_cnt, cart_rdate)
VALUES(cart_seq.nextval, 1, 3, 1, sysdate);



SELECT c.cart_no, c.cart_cnt, c.cart_rdate, p.product_name, m.member_id, m.member_no,
              p.product_cost, p.product_thumb1
FROM cart c, product p, member m
WHERE c.product_no = p.product_no and c.member_no = m.member_no and c.member_no = 4
ORDER BY cart_no ASC;



select NVL(sum(product_cost * cart_cnt), 0) money
from product p, cart c
where c.product_no = p.product_no and c.member_no = 3;

SELECT *
FROM cart;



commit;












