package dev.mvc.memberlevel;

public class MemberlevelVO {
//  MEMBERLEVEL_NO  NUMBER(10,0)    PRIMARY KEY, 
//  MEMBERLEVEL_NAME   VARCHAR2(100 BYTE)
  
  /** 등급 번호 */
  private int memberlevel_no;
  /** 등급 이름 */
  private String memberlevel_name = "";
  
  public MemberlevelVO() {
  }

  public int getMemberlevel_no() {
    return memberlevel_no;
  }

  public void setMemberlevel_no(int memberlevel_no) {
    this.memberlevel_no = memberlevel_no;
  }

  public String getMemberlevel_name() {
    return memberlevel_name;
  }

  public void setMemberlevel_name(String memberlevel_name) {
    this.memberlevel_name = memberlevel_name;
  }
  
}
