package dev.mvc.point;

/*CREATE TABLE point(
    point_no                           NUMERIC(10)    NOT NULL    PRIMARY KEY,
    member_no                       NUMERIC(10)    NOT NULL,
    pay_no                              NUMERIC(10)    NOT NULL,
    point_num                         NUMERIC(10)    NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (pay_no) REFERENCES pay (pay_no)
);*/

public class PointVO {
  /** 포인트 번호 */
  public int point_no;
  /** 회원 번호 */
  public int member_no;
  /** 결제 번호 */
  public int pay_no;
  /** 포인트 수 */
  public int point_num;
  
  
  
  
  public int getPoint_no() {
    return point_no;
  }
  public void setPoint_no(int point_no) {
    this.point_no = point_no;
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
  public int getPoint_num() {
    return point_num;
  }
  public void setPoint_num(int point_num) {
    this.point_num = point_num;
  }
 
  
  
  
 
  
  
 
  
  
  
}
