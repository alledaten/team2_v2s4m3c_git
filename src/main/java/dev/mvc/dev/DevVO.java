package dev.mvc.dev;

/*CREATE TABLE dev(
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
);*/

public class DevVO {
  /** 배송 번호 */
  private int dev_no;
  /** 주문 번호 */
  private int buy_no;
  /** 배송 받는 분 */
  private String dev_member = "";
  /** 배송 받는분 연락처 */
  private String dev_phone = "";
  /** 우편 번호 */
  private String zipcode = "";
  /** 주소 1 */
  private String address1 = "";
  /** 주소 2(자세히) */
  private String address2 = "";
  /** 배송 메세지 */
  private String dev_message = "";
  /** 배송 일자 */
  private String dev_rdate = "";
  /** 운송장 번호 */
  private String dev_number = "";
  /** 배송 확인 */
  private String dev_check ="";
  
  
  
  public int getDev_no() {
    return dev_no;
  }
  public void setDev_no(int dev_no) {
    this.dev_no = dev_no;
  }
  public int getBuy_no() {
    return buy_no;
  }
  public void setBuy_no(int buy_no) {
    this.buy_no = buy_no;
  }
  public String getDev_member() {
    return dev_member;
  }
  public void setDev_member(String dev_member) {
    this.dev_member = dev_member;
  }
  public String getDev_phone() {
    return dev_phone;
  }
  public void setDev_phone(String dev_phone) {
    this.dev_phone = dev_phone;
  }
  public String getZipcode() {
    return zipcode;
  }
  public void setZipcode(String zipcode) {
    this.zipcode = zipcode;
  }
  public String getAddress1() {
    return address1;
  }
  public void setAddress1(String address1) {
    this.address1 = address1;
  }
  public String getAddress2() {
    return address2;
  }
  public void setAddress2(String address2) {
    this.address2 = address2;
  }
  public String getDev_message() {
    return dev_message;
  }
  public void setDev_message(String dev_message) {
    this.dev_message = dev_message;
  }
  public String getDev_rdate() {
    return dev_rdate;
  }
  public void setDev_rdate(String dev_rdate) {
    this.dev_rdate = dev_rdate;
  }
  public String getDev_number() {
    return dev_number;
  }
  public void setDev_number(String dev_number) {
    this.dev_number = dev_number;
  }
  public String getDev_check() {
    return dev_check;
  }
  public void setDev_check(String dev_check) {
    this.dev_check = dev_check;
  }
  
  
 
  

  
}
