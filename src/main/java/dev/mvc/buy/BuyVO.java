package dev.mvc.buy;

/*CREATE TABLE buy(
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
);*/

public class BuyVO {
  /** 주문 번호 */
  private int buy_no;
  /** 장바구니 번호 */
  private int cart_no;
  /** 회원 번호 */
  private int member_no;
  /** 전통주 번호 */
  private int product_no;
  /** 접수 확인 */
  private String order_check="";
  /** 배송 번호 */
  private int dev_no;
  /** 결제 번호 */
  private int pay_no;
  /** 주문 수량 */
  private int pay_count;
  /** 주문 일자 */
  private String pay_rdate = "";
  /** 주문 확인 */
  private String buy_check ="";
  
  
  public int getBuy_no() {
    return buy_no;
  }
  public void setBuy_no(int buy_no) {
    this.buy_no = buy_no;
  }
  public int getCart_no() {
    return cart_no;
  }
  public void setCart_no(int cart_no) {
    this.cart_no = cart_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public int getProduct_no() {
    return product_no;
  }
  public void setProduct_no(int product_no) {
    this.product_no = product_no;
  }
  public String getOrder_check() {
    return order_check;
  }
  public void setOrder_check(String order_check) {
    this.order_check = order_check;
  }
  public int getDev_no() {
    return dev_no;
  }
  public void setDev_no(int dev_no) {
    this.dev_no = dev_no;
  }
  public int getPay_no() {
    return pay_no;
  }
  public void setPay_no(int pay_no) {
    this.pay_no = pay_no;
  }
  public int getPay_count() {
    return pay_count;
  }
  public void setPay_count(int pay_count) {
    this.pay_count = pay_count;
  }
  public String getPay_rdate() {
    return pay_rdate;
  }
  public void setPay_rdate(String pay_rdate) {
    this.pay_rdate = pay_rdate;
  }
  public String getBuy_check() {
    return buy_check;
  }
  public void setBuy_check(String buy_check) {
    this.buy_check = buy_check;
  }

  
  
}
