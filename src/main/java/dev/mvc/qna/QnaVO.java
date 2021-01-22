package dev.mvc.qna;

import org.springframework.web.multipart.MultipartFile;

/*
CREATE TABLE qna(
    qna_no NUMERIC(10) NOT NULL PRIMARY KEY,
    community_no NUMERIC(3),
    member_no NUMERIC(10),
    qna_title VARCHAR(50),
    qna_content VARCHAR(500) NOT NULL,
    qna_passwd VARCHAR(20) NOT NULL,
    qna_rdate DATE NOT NULL,
    qna_count NUMERIC(3) NOT NULL,
    qna_check CHAR(1) DEFAULT 'N' NOT NULL,
        qna_visible CHAR(1) DEFAULT 'N' NOT NULL,
        file1         VARCHAR(100)          NULL,
        thumb1    VARCHAR(100)          NULL,
        size1        NUMBER(10)      DEFAULT 0 NULL,  
        qna_word  VARCHAR2(300)  NULL,
        grpno    NUMBER(8)         DEFAULT 0         NOT NULL,
        indent   NUMBER(2)         DEFAULT 0         NOT NULL,
        ansnum NUMBER(3)         DEFAULT 0         NOT NULL,
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (community_no) REFERENCES community (community_no)
);
*/

public class QnaVO {
  /** Q&A ��ȣ */
  private int qna_no;  
  /** Ŀ�´�Ƽ ��ȣ */
  private int community_no;
  /** ȸ�� ��ȣ */
  private int member_no;
  /**  ���� ���� */
  private String qna_title = "";
  /** ���� ���� */
  private String qna_content = "";
  /** ��� ��ȣ */
  private String qna_passwd = "";
  /** ����� */
  private String qna_rdate = "";
  /** ��ȸ�� */
  private int qna_count;
  /** ÷������ Ȯ�� */
  private String qna_visible ="";
  /** ��б� ��� */
  private String qna_check ="";
  /** �˻��� */
  private String qna_word = "";
  /** �׷� ��ȣ */
  private int grpno;
  /** �鿩����/�亯�ڼ� */
  private int indent;
  /** �亯���� */
  private int ansnum;
  
  /** �̹��� */
  private String file1;
  /** preview �̹��� preview */
  private String thumb1;
  /** ����� ���� ������ */
  private long size1;
    /** �̹��� MultipartFile */
  private MultipartFile file1MF;
  
  public int getQna_no() {
    return qna_no;
  }
  public void setQna_no(int qna_no) {
    this.qna_no = qna_no;
  }
  public int getCommunity_no() {
    return community_no;
  }
  public void setCommunity_no(int community_no) {
    this.community_no = community_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public String getQna_title() {
    return qna_title;
  }
  public void setQna_title(String qna_title) {
    this.qna_title = qna_title;
  }
  public String getQna_content() {
    return qna_content;
  }
  public void setQna_content(String qna_content) {
    this.qna_content = qna_content;
  }
  public String getQna_passwd() {
    return qna_passwd;
  }
  public void setQna_passwd(String qna_passwd) {
    this.qna_passwd = qna_passwd;
  }
  public String getQna_rdate() {
    return qna_rdate;
  }
  public void setQna_rdate(String qna_rdate) {
    this.qna_rdate = qna_rdate;
  }
  public int getQna_count() {
    return qna_count;
  }
  public void setQna_count(int qna_count) {
    this.qna_count = qna_count;
  }
  public String getQna_visible() {
    return qna_visible;
  }
  public void setQna_visible(String qna_visible) {
    this.qna_visible = qna_visible;
  }
  public String getQna_check() {
    return qna_check;
  }
  public void setQna_check(String qna_check) {
    this.qna_check = qna_check;
  }
  public String getQna_word() {
    return qna_word;
  }
  public void setQna_word(String qna_word) {
    this.qna_word = qna_word;
  }
  public int getGrpno() {
    return grpno;
  }
  public void setGrpno(int grpno) {
    this.grpno = grpno;
  }
  public int getIndent() {
    return indent;
  }
  public void setIndent(int indent) {
    this.indent = indent;
  }
  public int getAnsnum() {
    return ansnum;
  }
  public void setAnsnum(int ansnum) {
    this.ansnum = ansnum;
  }
  public String getFile1() {
    return file1;
  }
  public void setFile1(String file1) {
    this.file1 = file1;
  }
  public String getThumb1() {
    return thumb1;
  }
  public void setThumb1(String thumb1) {
    this.thumb1 = thumb1;
  }
  public long getSize1() {
    return size1;
  }
  public void setSize1(long size1) {
    this.size1 = size1;
  }
  public MultipartFile getFile1MF() {
    return file1MF;
  }
  public void setFile1MF(MultipartFile file1mf) {
    file1MF = file1mf;
  }
  
  
  
  
  
  
}
