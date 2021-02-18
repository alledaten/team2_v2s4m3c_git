package dev.mvc.cart;

public class CartVO {
  /*
   * CREATE TABLE cart(
    cart_no                           NUMBER(10)     NOT NULL    PRIMARY KEY,
        product_no                             NUMBER(10)     NOT NULL ,
        member_no                             NUMBER(10)     NOT NULL ,
    cart_cnt                          NUMBER(10)     NULL ,
        cart_check              CHAR(1)    DEFAULT 'Y'     NOT NULL,
    cart_tot                          NUMBER(10)     NULL ,
    cart_rdate                        DATE     NOT NULL,
        FOREIGN KEY (member_no) REFERENCES member (member_no),
        FOREIGN KEY (product_no) REFERENCES product (product_no)
);
   */
  
  /* 카트 번호 */
  private int cart_no;
  /* 상품 번호 */
  private int product_no;
  /* 회원 번호 */
  private int member_no;
  /* 카트 수량 */
  private int cart_cnt;
  /* 카트 날짜 */
  private String cart_rdate;
  /////////////////////////////////////////////
  
  private String product_name;
  
  private long product_cost;
  
  private String product_file1;
  
  private String product_thumb1;
  
  private String member_id;
  
  
  
  public int getCart_no() {
    return cart_no;
  }
  public void setCart_no(int cart_no) {
    this.cart_no = cart_no;
  }
  
  public int getProduct_no() {
    return product_no;
  }
  public void setProduct_no(int product_no) {
    this.product_no = product_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public int getCart_cnt() {
    return cart_cnt;
  }
  public void setCart_cnt(int cart_cnt) {
    this.cart_cnt = cart_cnt;
  }

  public String getCart_rdate() {
    return cart_rdate;
  }
  public void setCart_rdate(String cart_rdate) {
    this.cart_rdate = cart_rdate;
  }
  public String getProduct_name() {
    return product_name;
  }
  public void setProduct_name(String product_name) {
    this.product_name = product_name;
  }
  public long getProduct_cost() {
    return product_cost;
  }
  public void setProduct_cost(long product_cost) {
    this.product_cost = product_cost;
  }
  public String getProduct_thumb1() {
    return product_thumb1;
  }
  public void setProduct_thumb1(String product_thumb1) {
    this.product_thumb1 = product_thumb1;
  }
  public String getMember_id() {
    return member_id;
  }
  public void setMember_id(String member_id) {
    this.member_id = member_id;
  }

  public String getProduct_file1() {
    return product_file1;
  }
  public void setProduct_file1(String product_file1) {
    this.product_file1 = product_file1;
  }

  
}
