package dev.mvc.login_log;

public class Login_logVO {
  
//  login_log_no                      NUMBER(30)     NOT NULL    PRIMARY KEY,
//  member_no                         NUMBER(10)     NOT NULL,
//  login_log_date                    DATE     NOT NULL,
//  login_log_ip                      VARCHAR2(50)     NOT NULL
  
  /* 로그인로그 번호 */
  private int login_log_no;
  /* 회원 번호 */
  private int member_no;
  /* 접속일 */
  private String login_log_date = "";
  /* 접속주소 */
  private String login_log_ip = "";
  
  public Login_logVO() {
  }

  public int getLogin_log_no() {
    return login_log_no;
  }

  public void setLogin_log_no(int login_log_no) {
    this.login_log_no = login_log_no;
  }

  public int getMember_no() {
    return member_no;
  }

  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }

  public String getLogin_log_date() {
    return login_log_date;
  }

  public void setLogin_log_date(String login_log_date) {
    this.login_log_date = login_log_date;
  }

  public String getLogin_log_ip() {
    return login_log_ip;
  }

  public void setLogin_log_ip(String login_log_ip) {
    this.login_log_ip = login_log_ip;
  }
  
}
