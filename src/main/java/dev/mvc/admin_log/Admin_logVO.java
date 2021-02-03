package dev.mvc.admin_log;

public class Admin_logVO {
//  admin_log_no    NUMBER(10)  NOT NULL    PRIMARY KEY,
//  admin_no        NUMBER(10)  NOT NULL,
//  admin_log_date  DATE    NOT NULL,
//  admin_log_ip    VARCHAR2(100)   NOT NULL,
//  FOREIGN KEY (admin_no) REFERENCES admin (admin_no)

  /** 관리자 로그인번호*/
  private int admin_log_no;
  /** 관리자 번호*/
  private int admin_no;
  /** 관리자 로그인 날짜*/
  private String admin_log_date = "";
  /** 관리자 로그인 IP*/
  private String admin_log_ip = "";
  
  public Admin_logVO() {
  }
  
  public int getAdmin_log_no() {
    return admin_log_no;
  }
  public void setAdmin_log_no(int admin_log_no) {
    this.admin_log_no = admin_log_no;
  }
  public int getAdmin_no() {
    return admin_no;
  }
  public void setAdmin_no(int admin_no) {
    this.admin_no = admin_no;
  }
  public String getAdmin_log_date() {
    return admin_log_date;
  }
  public void setAdmin_log_date(String admin_log_date) {
    this.admin_log_date = admin_log_date;
  }
  public String getAdmin_log_ip() {
    return admin_log_ip;
  }
  public void setAdmin_log_ip(String admin_log_ip) {
    this.admin_log_ip = admin_log_ip;
  }
  
  
  
  
}
