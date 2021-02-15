package dev.mvc.event;

import org.springframework.web.multipart.MultipartFile;

//event_no                          NUMBER(10)     NOT NULL    PRIMARY KEY,
//event_grp_no                      NUMBER(10)     NOT NULL,
//admin_no                          NUMBER(10)     NOT NULL,
//event_title                       VARCHAR2(100)    NOT NULL,
//event_content                     CLOB   NOT NULL,
//event_view                        NUMBER(10)     DEFAULT 0     NOT NULL,
//event_passwd                      VARCHAR2(10)     NOT NULL,
//event_word                        VARCHAR2(300)    NULL ,
//event_date                        DATE     NOT NULL,
//event_file                        VARCHAR2(100)    NULL ,
//event_thumb                       VARCHAR2(100)    NULL ,
//event_size                        NUMBER(10)     NULL ,
//FOREIGN KEY (event_grp_no) REFERENCES event_grp (event_grp_no),
//FOREIGN KEY (admin_no) REFERENCES admin (admin_no)

public class EventVO {
  
  /** �̺�Ʈ ��ȣ */
  private int event_no = 0;
  
  /** �̺�Ʈ �׷� ��ȣ */
  private int event_grp_no = 0;
  
  /** ������ ��ȣ */
  private int admin_no = 0;
  
  /** �̺�Ʈ�� */
  private String event_title = "";
  
  /** �̺�Ʈ ���� */
  private String event_content = "";
  
  /** �̺�Ʈ ��ȸ�� */
  private int event_view = 0;
  
  /** �̺�Ʈ ��й�ȣ */
  private String event_passwd = "";
  
  /** �̺�Ʈ �˻��� */
  private String event_word = "";
  
  /** �̺�Ʈ ����� */
  private String event_date = "";
  
  /** �̺�Ʈ ���ϸ� */
  private String event_file = "";
  
  /** �̺�Ʈ ������ */
  private String event_thumb = "";
  
  /** �̺�Ʈ ����ũ�� */
  private long event_size;
  
  /** �̺�Ʈ ���� �̹��� ũ�� �뷮 ���̺� */
  private String event_size_label;
  
  private MultipartFile event_fileMF;
  
/////////////////////////////////////////////////////////////////////////////////////////////////////

  public int getEvent_no() {
    return event_no;
  }

  public void setEvent_no(int event_no) {
    this.event_no = event_no;
  }

  public int getEvent_grp_no() {
    return event_grp_no;
  }

  public void setEvent_grp_no(int event_grp_no) {
    this.event_grp_no = event_grp_no;
  }

  public int getAdmin_no() {
    return admin_no;
  }

  public void setAdmin_no(int admin_no) {
    this.admin_no = admin_no;
  }

  public String getEvent_title() {
    return event_title;
  }

  public void setEvent_title(String event_title) {
    this.event_title = event_title;
  }

  public String getEvent_content() {
    return event_content;
  }

  public void setEvent_content(String event_content) {
    this.event_content = event_content;
  }

  public int getEvent_view() {
    return event_view;
  }

  public void setEvent_view(int event_view) {
    this.event_view = event_view;
  }

  public String getEvent_passwd() {
    return event_passwd;
  }

  public void setEvent_passwd(String event_passwd) {
    this.event_passwd = event_passwd;
  }

  public String getEvent_word() {
    return event_word;
  }

  public void setEvent_word(String event_word) {
    this.event_word = event_word;
  }

  public String getEvent_date() {
    return event_date;
  }

  public void setEvent_date(String event_date) {
    this.event_date = event_date;
  }

  public String getEvent_file() {
    return event_file;
  }

  public void setEvent_file(String event_file) {
    this.event_file = event_file;
  }

  public String getEvent_thumb() {
    return event_thumb;
  }

  public void setEvent_thumb(String event_thumb) {
    this.event_thumb = event_thumb;
  }

  public long getEvent_size() {
    return event_size;
  }

  public void setEvent_size(long event_size) {
    this.event_size = event_size;
  }

  public String getEvent_size_label() {
    return event_size_label;
  }

  public void setEvent_size_label(String event_size_label) {
    this.event_size_label = event_size_label;
  }

  public MultipartFile getEvent_fileMF() {
    return event_fileMF;
  }

  public void setEvent_fileMF(MultipartFile event_fileMF) {
    this.event_fileMF = event_fileMF;
  }

}
