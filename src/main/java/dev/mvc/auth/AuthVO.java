package dev.mvc.auth;

public class AuthVO {
//  auth_no       NUMBER(10)     NOT NULL    PRIMARY KEY,
//  auth_content  VARCHAR2(50)     NOT NULL

  /** 권한번호*/
  private int auth_no;
  /** 권한 이름*/
  private String auth_content = "";
  
  public AuthVO() {
  }
  
  public int getAuth_no() {
    return auth_no;
  }
  public void setAuth_no(int auth_no) {
    this.auth_no = auth_no;
  }
  public String getAuth_content() {
    return auth_content;
  }
  public void setAuth_content(String auth_content) {
    this.auth_content = auth_content;
  }
  
  
}
