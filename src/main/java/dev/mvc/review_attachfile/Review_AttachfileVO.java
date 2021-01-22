package dev.mvc.review_attachfile;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

/*
  * review_attachfile_no             NUMBER(10)     NOT NULL    PRIMARY KEY,
    review_no                         NUMBER(10)     NULL ,
    review_attachfile_rname           VARCHAR2(100)    NOT NULL,
    review_attachfile_upname          VARCHAR2(100)    NOT NULL,
    review_attachfile_thumb           VARCHAR2(100)    NULL ,
    review_attachfile_size            NUMBER(10)     NOT NULL,
    review_attachfile_date            DATE     NOT NULL,
    FOREIGN KEY (review_no) REFERENCES review (review_no)
 */

public class Review_AttachfileVO {
  
  /** ÷������ ��ȣ(PK) */
  private int review_attachfile_no;
  
  /** ���� ��ȣ(FK) */
  private int review_no;
  
  /** ���� ���ϸ� */
  private String review_attachfile_rname;
  
  /** ���ε� ���ϸ� */
  private String review_attachfile_upname;
  
  /** ������ �̹��� */
  private String review_attachfile_thumb;
  
  /** ���� ũ�� */
  private long review_attachfile_size;
  
  /** ����� */
  private String review_attachfile_date;
  
  //private MultipartFile fnameMF;  // �ϳ��� ���� ó��
  /** Form�� ������ MultipartFile�� ��ȯ�Ͽ� List�� ����  */
  private List<MultipartFile> review_attachfile_rnamesMF;
  
  /** ���� ���� ��� */
  private String rlabel;
  
  /////////////////////////////////////////////////////////////////////////////////////////

  public int getReview_attachfile_no() {
    return review_attachfile_no;
  }

  public void setReview_attachfile_no(int review_attachfile_no) {
    this.review_attachfile_no = review_attachfile_no;
  }

  public int getReview_no() {
    return review_no;
  }

  public void setReview_no(int review_no) {
    this.review_no = review_no;
  }

  public String getReview_attachfile_rname() {
    return review_attachfile_rname;
  }

  public void setReview_attachfile_rname(String review_attachfile_rname) {
    this.review_attachfile_rname = review_attachfile_rname;
  }

  public String getReview_attachfile_upname() {
    return review_attachfile_upname;
  }

  public void setReview_attachfile_upname(String review_attachfile_upname) {
    this.review_attachfile_upname = review_attachfile_upname;
  }

  public String getReview_attachfile_thumb() {
    return review_attachfile_thumb;
  }

  public void setReview_attachfile_thumb(String review_attachfile_thumb) {
    this.review_attachfile_thumb = review_attachfile_thumb;
  }

  public long getReview_attachfile_size() {
    return review_attachfile_size;
  }

  public void setReview_attachfile_size(long review_attachfile_size) {
    this.review_attachfile_size = review_attachfile_size;
  }

  public String getReview_attachfile_date() {
    return review_attachfile_date;
  }

  public void setReview_attachfile_date(String review_attachfile_date) {
    this.review_attachfile_date = review_attachfile_date;
  }

  public List<MultipartFile> getReview_attachfile_rnamesMF() {
    return review_attachfile_rnamesMF;
  }

  public void setReview_attachfile_rnamesMF(List<MultipartFile> review_attachfile_rnamesMF) {
    this.review_attachfile_rnamesMF = review_attachfile_rnamesMF;
  }

  public String getRlabel() {
    return rlabel;
  }

  public void setRlabel(String rlabel) {
    this.rlabel = rlabel;
  }   
  
}
