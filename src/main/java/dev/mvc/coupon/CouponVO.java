package dev.mvc.coupon;

/*CREATE TABLE coupon(
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
);*/

public class CouponVO {
  /** 쿠폰 번호 */
  public int coupon_no;
  /** 회원 번호 */
  public int member_no;
  /** 결제 번호 */
  public int pay_no;
  /** 쿠폰 금액 */
  public int coupon_num;
  /** 쿠폰 발급 날짜 */
  public String coupon_rdate="";
  /** 쿠폰 사용 날짜 */
  public String coupon_use_rdate="";
  /** 쿠폰 유효 기간 */
  public String coupon_until_rdate="";
  /** 쿠폰 사용 여부 */
  public String coupon_check="";
  
  
  
  public int getCoupon_no() {
    return coupon_no;
  }
  public void setCoupon_no(int coupon_no) {
    this.coupon_no = coupon_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public int getPay_no() {
    return pay_no;
  }
  public void setPay_no(int pay_no) {
    this.pay_no = pay_no;
  }
  public int getCoupon_num() {
    return coupon_num;
  }
  public void setCoupon_num(int coupon_num) {
    this.coupon_num = coupon_num;
  }
  public String getCoupon_rdate() {
    return coupon_rdate;
  }
  public void setCoupon_rdate(String coupon_rdate) {
    this.coupon_rdate = coupon_rdate;
  }
  public String getCoupon_use_rdate() {
    return coupon_use_rdate;
  }
  public void setCoupon_use_rdate(String coupon_use_rdate) {
    this.coupon_use_rdate = coupon_use_rdate;
  }
  public String getCoupon_until_rdate() {
    return coupon_until_rdate;
  }
  public void setCoupon_until_rdate(String coupon_until_rdate) {
    this.coupon_until_rdate = coupon_until_rdate;
  }
  public String getCoupon_check() {
    return coupon_check;
  }
  public void setCoupon_check(String coupon_check) {
    this.coupon_check = coupon_check;
  }
  
  
  
  
 
  
  

  
  
 
  
  
 
  
  
  
}
