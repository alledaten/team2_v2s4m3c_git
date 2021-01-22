package dev.mvc.boardgrp;
 
/*
    	boardgrp_no                     		NUMBER(10)		 NOT NULL		 PRIMARY KEY,
		boardgrp_name                          		VARCHAR2(50)		 NOT NULL,
		boardgrp_seqno                         		NUMBER(7)		 DEFAULT 0		 NOT NULL,
		boardgrp_visible                       		CHAR(1)		 DEFAULT 'Y'		 NOT NULL,
		boardgrp_rdate                         		DATE		 NOT NULL
 */
public class BoardgrpVO {
  /** 카테고리 그룹 번호 */
  private int boardgrp_no = 0;
  /** 이름 */
  private String boardgrp_name = "";
  /** 출력 순서 */
  private int boardgrp_seqno = 0;
  /** 출력 모드 */
  private String boardgrp_visible = "";
  /** 그룹 생성일 */
  private String boardgrp_rdate = "";
public int getBoardgrp_no() {
	return boardgrp_no;
}
public String getBoardgrp_name() {
	return boardgrp_name;
}
public void setBoardgrp_name(String boardgrp_name) {
	this.boardgrp_name = boardgrp_name;
}
public int getBoardgrp_seqno() {
	return boardgrp_seqno;
}
public void setBoardgrp_seqno(int boardgrp_seqno) {
	this.boardgrp_seqno = boardgrp_seqno;
}
public String getBoardgrp_visible() {
	return boardgrp_visible;
}
public void setBoardgrp_visible(String boardgrp_visible) {
	this.boardgrp_visible = boardgrp_visible;
}
public String getBoardgrp_rdate() {
	return boardgrp_rdate;
}
public void setBoardgrp_rdate(String boardgrp_rdate) {
	this.boardgrp_rdate = boardgrp_rdate;
}
public void setBoardgrp_no(int boardgrp_no) {
	this.boardgrp_no = boardgrp_no;
}

  
  
} 

