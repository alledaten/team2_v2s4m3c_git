package dev.mvc.address;

/*CREATE TABLE address(
    address_no                       NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                      NUMERIC(10)    NOT NULL,
    address_name                   VARCHAR(50)    NOT NULL ,
    address_member               VARCHAR(999)     NOT NULL,
    address_phone                  VARCHAR(50)    NOT NULL ,
    zipcode                           VARCHAR(5)        NULL, -- 우편번호, 12345
    address1                          VARCHAR(80)       NULL, -- 주소 1
    address2                          VARCHAR(50)       NULL, -- 주소 2
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);*/

public class AddressVO {
  /** 주소록 번호 */
  public int address_no;
  /** 회원 번호 */
  public int member_no;
  /** 주소록 이름 */
  public String address_name;
  /** 이름 */
  public String address_member;
  /** 연락처 */
  public String address_phone;
  /** 우편 번호 */
  public String zipcode;
  /** 주소 1 */
  public String address1;
  /** 주소 2(자세히) */
  public String address2;
  
  
  
  public int getAddress_no() {
    return address_no;
  }
  public void setAddress_no(int address_no) {
    this.address_no = address_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public String getAddress_name() {
    return address_name;
  }
  public void setAddress_name(String address_name) {
    this.address_name = address_name;
  }
  public String getAddress_member() {
    return address_member;
  }
  public void setAddress_member(String address_member) {
    this.address_member = address_member;
  }
  public String getAddress_phone() {
    return address_phone;
  }
  public void setAddress_phone(String address_phone) {
    this.address_phone = address_phone;
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
  
  
 
  
  
 
  
  
  
}
