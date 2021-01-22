package dev.mvc.notice;


//CREATE TABLE notice(
//    noticeno           NUMBER(10)        NOT NULL       PRIMARY KEY,
//    head               CLOB              NOT NULL,
//    content            CLOB              NOT NULL,
//    count              NUMBER(10)        DEFAULT 0       NOT NULL ,
//    rdate              DATE              NOT NULL,
//    visible            CHAR(1)           DEFAULT 'Y'     NOT NULL ,
//    passwd             VARCHAR2(15)      DEFAULT '1234'  NOT NULL
// );
  
public class NoticeVO{
  
  private int noticeno;
  private String head ="";
  private String content ="";
  private String rdate ="";
  private int count;
  private String visible ="";
  private String passwd="";
  
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public int getNoticeno() {
    return noticeno;
  }
  public void setNoticeno(int noticeno) {
    this.noticeno = noticeno;
  }
  public String getHead() {
    return head;
  }
  public void setHead(String head) {
    this.head = head;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public int getCount() {
    return count;
  }
  public void setCount(int count) {
    this.count = count;
  }
  public String getVisible() {
    return visible;
  }
  public void setVisible(String visible) {
    this.visible = visible;
  }
  
}
