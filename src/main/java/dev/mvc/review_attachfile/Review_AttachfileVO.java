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
  
  /** 첨부파일 번호(PK) */
  private int review_attachfile_no;
  
  /** 리뷰 번호(FK) */
  private int review_no;
  
  /** 원본 파일명 */
  private String review_attachfile_rname;
  
  /** 업로드 파일명 */
  private String review_attachfile_upname;
  
  /** 섬네일 이미지 */
  private String review_attachfile_thumb;
  
  /** 파일 크기 */
  private long review_attachfile_size;
  
  /** 등록일 */
  private String review_attachfile_date;
  
  //private MultipartFile fnameMF;  // 하나의 파일 처리
  /** Form의 파일을 MultipartFile로 변환하여 List에 저장  */
  private List<MultipartFile> review_attachfile_rnamesMF;
  
  /** 파일 단위 출력 */
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
