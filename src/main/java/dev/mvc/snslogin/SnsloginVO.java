package dev.mvc.snslogin;

public class SnsloginVO {
//  snslogin_no        NUMBER(10,0)  PRIMARY KEY,
//  snslogin_name      VARCHAR2(50 BYTE)
  
  /** SNS���� ��ȣ */
  private int snslogin_no;
  /** SNS���� �̸� */
  private String snslogin_name = "";
  
  public SnsloginVO() {
  }

  public int getSnslogin_no() {
    return snslogin_no;
  }

  public void setSnslogin_no(int snslogin_no) {
    this.snslogin_no = snslogin_no;
  }

  public String getSnslogin_name() {
    return snslogin_name;
  }

  public void setSnslogin_name(String snslogin_name) {
    this.snslogin_name = snslogin_name;
  }
  
}
