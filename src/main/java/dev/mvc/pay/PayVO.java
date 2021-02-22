package dev.mvc.pay;

/*CREATE TABLE pay(
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
);*/

public class PayVO {
  /** ���� ��ȣ */
  public int pay_no;
  /** ȸ�� ��ȣ */
  public int member_no;
  /** �ֹ� ��ȣ */
  public int buy_no;
  /** ���� ���� */
  public String pay_rdate;
  /** ��� �ݾ�*/
  public int dev_cost;
  /** ��ǰ �ݾ� */
  public int product_cost;
  /** ����Ʈ */
  public int pay_point;
  /** ���� */
  public int pay_coupon;
  /** ���� �ݾ� */
  public int pay_total;
  /** ���� ��� */
  public String pay_way;
  /** ���� Ȯ�� */
  public String pay_check;
  
  
  
  public int getPay_no() {
    return pay_no;
  }
  public void setPay_no(int pay_no) {
    this.pay_no = pay_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public int getBuy_no() {
    return buy_no;
  }
  public void setBuy_no(int buy_no) {
    this.buy_no = buy_no;
  }
  public String getPay_rdate() {
    return pay_rdate;
  }
  public void setPay_rdate(String pay_rdate) {
    this.pay_rdate = pay_rdate;
  }
  public int getDev_cost() {
    return dev_cost;
  }
  public void setDev_cost(int dev_cost) {
    this.dev_cost = dev_cost;
  }
  public int getProduct_cost() {
    return product_cost;
  }
  public void setProduct_cost(int product_cost) {
    this.product_cost = product_cost;
  }
  public int getPay_point() {
    return pay_point;
  }
  public void setPay_point(int pay_point) {
    this.pay_point = pay_point;
  }
  public int getPay_coupon() {
    return pay_coupon;
  }
  public void setPay_coupon(int pay_coupon) {
    this.pay_coupon = pay_coupon;
  }
  public int getPay_total() {
    return pay_total;
  }
  public void setPay_total(int pay_total) {
    this.pay_total = pay_total;
  }
  public String getPay_way() {
    return pay_way;
  }
  public void setPay_way(String pay_way) {
    this.pay_way = pay_way;
  }
  public String getPay_check() {
    return pay_check;
  }
  public void setPay_check(String pay_check) {
    this.pay_check = pay_check;
  }
  
  
  
 
  


  
  
  
}
