package dev.mvc.review;

import org.springframework.web.multipart.MultipartFile;

/*
review_no                         NUMBER(10)     NOT NULL    PRIMARY KEY,
member_no                         NUMBER(10)     NOT NULL,
review_cate_no                    NUMBER(10)     NOT NULL,
review_title                      VARCHAR2(100)     NOT NULL,
review_content                    CLOB                   NOT NULL,
review_score                      NUMBER(2)        NOT NULL,
review_good                       NUMBER(10)     DEFAULT 0     NOT NULL,
review_view                       NUMBER(10)     DEFAULT 0     NOT NULL,
review_reply_cnt                  NUMBER(10)     DEFAULT 0      NOT NULL,
review_passwd                     VARCHAR2(20)     NOT NULL,
review_grpno                      NUMBER(10)     DEFAULT 0      NOT NULL,
review_indent                     NUMBER(3)        DEFAULT 0      NOT NULL,
review_answer_no                  NUMBER(3)        DEFAULT 0      NOT NULL,
review_word                       VARCHAR2(300)     NULL,
review_date                       DATE                 NOT NULL,
review_file                           VARCHAR2(100)     NULL,
review_thumb                      VARCHAR2(100)  NULL,
review_size                       NUMBER(10)     DEFAULT 0      NULL,
FOREIGN KEY (review_cate_no) REFERENCES review_cate (review_cate_no),
FOREIGN KEY (member_no) REFERENCES member (member_no)
*/

public class ReviewVO {
  
  /** ���� ��ȣ */
  private int review_no;
  
  /** ȸ�� ��ȣ */
  private int member_no;
  
  /** ���� ī�װ� ��ȣ */
  private int review_cate_no;
  
  /** ���� ���� */
  private String review_title = "";
  
  /** ���� ���� */
  private String review_content = "";
  
  /** ���� ���� */
  private int review_score;
  
  /** ���� ��õ�� */
  private int review_good;
  
  /** ���� ��ȸ�� */
  private int review_view = 0;
  
  /** ���� ��ۼ� */
  private int review_reply_cnt;
 
  /** ���� ��й�ȣ */
  private String review_passwd = "";
  
  /** ���� �׷��ȣ */
  private int review_grpno;
  
  /** ���� �鿩���� �� �亯���� */
  private int review_indent;
  
  /** ���� �亯���� */
  private int review_answer_no;
  
  /** ���� �˻��� */
  private String review_word = "";
  
  /** ���� ����� */
  private String review_date = "";
  
  /** ���� ���� �̹��� ���� */
  private String review_file = "";
  
  /** ���� ���� �̹��� ������ */
  private String review_thumb = "";
  
  /** ���� ���� �̹��� ũ�� */
  private long review_size;
  
  public String getReview_size_label() {
    return review_size_label;
  }

  public void setReview_size_label(String review_size_label) {
    this.review_size_label = review_size_label;
  }

  public MultipartFile getReview_fileMF() {
    return review_fileMF;
  }

  public void setReview_fileMF(MultipartFile review_fileMF) {
    this.review_fileMF = review_fileMF;
  }

  /** ���� ���� �̹��� ũ�� �뷮 ���̺� */
  private String review_size_label;
  
  private MultipartFile review_fileMF;

  public int getReview_no() {
    return review_no;
  }

  public void setReview_no(int review_no) {
    this.review_no = review_no;
  }

  public int getMember_no() {
    return member_no;
  }

  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }

  public int getReview_cate_no() {
    return review_cate_no;
  }

  public void setReview_cate_no(int review_cate_no) {
    this.review_cate_no = review_cate_no;
  }

  public String getReview_title() {
    return review_title;
  }

  public void setReview_title(String review_title) {
    this.review_title = review_title;
  }

  public String getReview_content() {
    return review_content;
  }

  public void setReview_content(String review_content) {
    this.review_content = review_content;
  }

  public int getReview_score() {
    return review_score;
  }

  public void setReview_score(int review_score) {
    this.review_score = review_score;
  }

  public int getReview_good() {
    return review_good;
  }

  public void setReview_good(int review_good) {
    this.review_good = review_good;
  }

  public int getReview_view() {
    return review_view;
  }

  public void setReview_view(int review_view) {
    this.review_view = review_view;
  }

  public int getReview_reply_cnt() {
    return review_reply_cnt;
  }

  public void setReview_reply_cnt(int review_reply_cnt) {
    this.review_reply_cnt = review_reply_cnt;
  }

  public String getReview_passwd() {
    return review_passwd;
  }

  public void setReview_passwd(String review_passwd) {
    this.review_passwd = review_passwd;
  }

  public int getReview_grpno() {
    return review_grpno;
  }

  public void setReview_grpno(int review_grpno) {
    this.review_grpno = review_grpno;
  }

  public int getReview_indent() {
    return review_indent;
  }

  public void setReview_indent(int review_indent) {
    this.review_indent = review_indent;
  }

  public int getReview_answer_no() {
    return review_answer_no;
  }

  public void setReview_answer_no(int review_answer_no) {
    this.review_answer_no = review_answer_no;
  }

  public String getReview_word() {
    return review_word;
  }

  public void setReview_word(String review_word) {
    this.review_word = review_word;
  }

  public String getReview_date() {
    return review_date;
  }

  public void setReview_date(String review_date) {
    this.review_date = review_date;
  }

  public String getReview_file() {
    return review_file;
  }

  public void setReview_file(String review_file) {
    this.review_file = review_file;
  }

  public String getReview_thumb() {
    return review_thumb;
  }

  public void setReview_thumb(String review_thumb) {
    this.review_thumb = review_thumb;
  }

  public long getReview_size() {
    return review_size;
  }

  public void setReview_size(long review_size) {
    this.review_size = review_size;
  }



}
