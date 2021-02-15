package dev.mvc.event_grp;

//event_grp_no                      NUMBER(10)     NOT NULL    PRIMARY KEY,
//event_grp_title                   VARCHAR2(50)     NOT NULL,
//event_grp_seqno                   NUMBER(10)     DEFAULT 0     NOT NULL,
//event_grp_date                    DATE     NOT NULL

public class Event_GrpVO {
  
  /** 이벤트 그룹 번호 */
  private int event_grp_no = 0;
  
  /** 이벤투 그룹 이름 */
  private String event_grp_title = "";
  
  /** 이벤트 그룹 출력순서 */
  private int event_grp_seqno = 0;
  
  /** 이벤트 그룹 생성일 */
  private String event_grp_date = "";
  
  //////////////////////////////////////////////////////////////////////////////// GET & SETTER ////////////////////////////////////////////////////////////////////////////////////////////////////

  public int getEvent_grp_no() {
    return event_grp_no;
  }

  public void setEvent_grp_no(int event_grp_no) {
    this.event_grp_no = event_grp_no;
  }

  public String getEvent_grp_title() {
    return event_grp_title;
  }

  public void setEvent_grp_title(String event_grp_title) {
    this.event_grp_title = event_grp_title;
  }

  public int getEvent_grp_seqno() {
    return event_grp_seqno;
  }

  public void setEvent_grp_seqno(int event_grp_seqno) {
    this.event_grp_seqno = event_grp_seqno;
  }

  public String getEvent_grp_date() {
    return event_grp_date;
  }

  public void setEvent_grp_date(String event_grp_date) {
    this.event_grp_date = event_grp_date;
  }

}
