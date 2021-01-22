package dev.mvc.answer;

import org.springframework.web.multipart.MultipartFile;

/*CREATE TABLE answer(
    answer_no NUMERIC(10) NOT NULL PRIMARY KEY,
    member_no NUMERIC(10),
    qna_no NUMERIC(10),
    answer_content VARCHAR(5000) NOT NULL,
        answer_rdate DATE NOT NULL,
        answer_passwd   VARCHAR2(15)         NOT NULL,
        file1        VARCHAR(100)          NULL,
        thumb1   VARCHAR(100)          NULL,
        size1       NUMBER(10)      DEFAULT 0 NULL,  
  FOREIGN KEY (member_no) REFERENCES member (member_no),
  FOREIGN KEY (qna_no) REFERENCES qna (qna_no)
);*/

public class AnswerVO {
  /** �亯 ��ȣ */
  private int answer_no;
  /** ȸ�� ��ȣ */
  private int member_no;
  /** Q&A ��ȣ */
  private int qna_no;
  /** �亯 ���� */
  private String answer_content = "";
  /** �亯 ����� */
  private String answer_rdate = "";
  /** �н����� */
  private String answer_passwd = "";
  
  /** �̹��� */
  private String file1;
  /** preview �̹��� preview */
  private String thumb1;
  /** ����� ���� ������ */
  private long size1;
    /** �̹��� MultipartFile */
  private MultipartFile file1MF;
  
  
  public int getAnswer_no() {
    return answer_no;
  }
  public void setAnswer_no(int answer_no) {
    this.answer_no = answer_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public int getQna_no() {
    return qna_no;
  }
  public void setQna_no(int qna_no) {
    this.qna_no = qna_no;
  }
  public String getAnswer_content() {
    return answer_content;
  }
  public void setAnswer_content(String answer_content) {
    this.answer_content = answer_content;
  }
  public String getAnswer_rdate() {
    return answer_rdate;
  }
  public void setAnswer_rdate(String answer_rdate) {
    this.answer_rdate = answer_rdate;
  }
  public String getAnswer_passwd() {
    return answer_passwd;
  }
  public void setAnswer_passwd(String answer_passwd) {
    this.answer_passwd = answer_passwd;
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
