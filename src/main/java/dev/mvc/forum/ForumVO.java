package dev.mvc.forum;

/*
CREATE TABLE cate(
    cateno                            NUMBER(10)     NOT NULL    PRIMARY KEY,
    categrpno                       NUMBER(10)     NOT NULL,
    name                              VARCHAR2(100)    NOT NULL,
    seqno                             NUMBER(10)     DEFAULT 1     NOT NULL,
    visible                             CHAR(1)    DEFAULT 'Y'     NOT NULL,
    rdate                              DATE     NOT NULL,
    cnt                                 NUMBER(10)     DEFAULT 0     NOT NULL,
  FOREIGN KEY (categrpno) REFERENCES categrp (categrpno)
); 
 */
public class ForumVO {
  /** 카테고리 번호 */
  private int forum_no;  
  /** 카테고리 그룹 번호 */
  private int boardgrp_no;
  /** 카테고리 이름 */
  private String forum_name;
  /** 출력 순서 */
  private int forum_seqno;
  /** 출력 모드 */
  private String forum_visible;
  /** 등록일 */
  private String forum_rdate;
  /** 등록된 글 수 */
  private int forum_cnt;
public int getForum_no() {
	return forum_no;
}
public void setForum_no(int forum_no) {
	this.forum_no = forum_no;
}
public int getBoardgrp_no() {
	return boardgrp_no;
}
public void setBoardgrp_no(int boardgrp_no) {
	this.boardgrp_no = boardgrp_no;
}
public String getForum_name() {
	return forum_name;
}
public void setForum_name(String forum_name) {
	this.forum_name = forum_name;
}
public int getForum_seqno() {
	return forum_seqno;
}
public void setForum_seqno(int forum_seqno) {
	this.forum_seqno = forum_seqno;
}
public String getForum_visible() {
	return forum_visible;
}
public void setForum_visible(String forum_visible) {
	this.forum_visible = forum_visible;
}
public String getForum_rdate() {
	return forum_rdate;
}
public void setForum_rdate(String forum_rdate) {
	this.forum_rdate = forum_rdate;
}
public int getForum_cnt() {
	return forum_cnt;
}
public void setForum_cnt(int forum_cnt) {
	this.forum_cnt = forum_cnt;
}
  
 
}


