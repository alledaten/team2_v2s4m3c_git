package dev.mvc.event_attachfile;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

//event_attachfile_no               NUMBER(10)     NOT NULL    PRIMARY KEY,
//event_no                          NUMBER(10)     NULL ,
//event_attachfile_rname            VARCHAR2(100)    NOT NULL,
//event_attachfile_upname           VARCHAR2(100)    NOT NULL,
//event_attachfile_thumb            VARCHAR2(100)    NULL ,
//event_attachfile_size             NUMBER(10)  DEFAULT 0  NOT NULL,
//event_attachfile_date             DATE     NOT NULL,
//FOREIGN KEY (event_no) REFERENCES event (event_no)

public class Event_AttachfileVO {
  
  /** 첨부파일 번호(PK) */
  private int event_attachfile_no;
  
  /** 이벤트 번호(FK) */
  private int event_no;
  
  /** 원본 파일명 */
  private String event_attachfile_rname;
  
  /** 업로드 파일명 */
  private String event_attachfile_upname;
  
  /** 섬네일 이미지 */
  private String event_attachfile_thumb;
  
  /** 파일 크기 */
  private long event_attachfile_size;
  
  /** 등록일 */
  private String event_attachfile_date;
  
  //private MultipartFile fnameMF;  // 하나의 파일 처리
  /** Form의 파일을 MultipartFile로 변환하여 List에 저장  */
  private List<MultipartFile> event_attachfile_rnamesMF;
  
  /** 파일 단위 출력 */
  private String rlabel;
  
  ////////////////////////////////////////////////////////////////////////////// Getter & Setter ////////////////////////////////////////////////////////////////////////////////////////

  public int getEvent_attachfile_no() {
    return event_attachfile_no;
  }

  public void setEvent_attachfile_no(int event_attachfile_no) {
    this.event_attachfile_no = event_attachfile_no;
  }

  public int getEvent_no() {
    return event_no;
  }

  public void setEvent_no(int event_no) {
    this.event_no = event_no;
  }

  public String getEvent_attachfile_rname() {
    return event_attachfile_rname;
  }

  public void setEvent_attachfile_rname(String event_attachfile_rname) {
    this.event_attachfile_rname = event_attachfile_rname;
  }

  public String getEvent_attachfile_upname() {
    return event_attachfile_upname;
  }

  public void setEvent_attachfile_upname(String event_attachfile_upname) {
    this.event_attachfile_upname = event_attachfile_upname;
  }

  public String getEvent_attachfile_thumb() {
    return event_attachfile_thumb;
  }

  public void setEvent_attachfile_thumb(String event_attachfile_thumb) {
    this.event_attachfile_thumb = event_attachfile_thumb;
  }

  public long getEvent_attachfile_size() {
    return event_attachfile_size;
  }

  public void setEvent_attachfile_size(long event_attachfile_size) {
    this.event_attachfile_size = event_attachfile_size;
  }

  public String getEvent_attachfile_date() {
    return event_attachfile_date;
  }

  public void setEvent_attachfile_date(String event_attachfile_date) {
    this.event_attachfile_date = event_attachfile_date;
  }

  public List<MultipartFile> getEvent_attachfile_rnamesMF() {
    return event_attachfile_rnamesMF;
  }

  public void setEvent_attachfile_rnamesMF(List<MultipartFile> event_attachfile_rnamesMF) {
    this.event_attachfile_rnamesMF = event_attachfile_rnamesMF;
  }

  public String getRlabel() {
    return rlabel;
  }

  public void setRlabel(String rlabel) {
    this.rlabel = rlabel;
  }

}
