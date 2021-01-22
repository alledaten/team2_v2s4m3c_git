package dev.mvc.review_categrp;

//review_categrp_no            NUMBER(10)      NOT NULL PRIMARY KEY,
//review_categrp_name        VARCHAR2(50)    NOT NULL,
//review_categrp_seqno       NUMBER(10)       DEFAULT 0 NOT NULL,
//review_categrp_date         DATE                 NOT NULL

public class Review_CategrpVO {
  
  /** 리뷰 카테고리 그룹 번호 */
  private int review_categrp_no = 0;
  
  /** 리뷰 카테고리 그룹 이름 */
  private String review_categrp_name = "";
  
  /** 리뷰 카테고리 그룹 출력순서 */
  private int review_categrp_seqno = 0;
  
  /** 리뷰 카테고리 그룹 생성일 */
  private String review_categrp_date = "";

  public int getReview_categrp_no() {
    return review_categrp_no;
  }

  public void setReview_categrp_no(int review_categrp_no) {
    this.review_categrp_no = review_categrp_no;
  }

  public String getReview_categrp_name() {
    return review_categrp_name;
  }

  public void setReview_categrp_name(String review_categrp_name) {
    this.review_categrp_name = review_categrp_name;
  }

  public int getReview_categrp_seqno() {
    return review_categrp_seqno;
  }

  public void setReview_categrp_seqno(int review_categrp_seqno) {
    this.review_categrp_seqno = review_categrp_seqno;
  }

  public String getReview_categrp_date() {
    return review_categrp_date;
  }

  public void setReview_categrp_date(String review_categrp_date) {
    this.review_categrp_date = review_categrp_date;
  }

}
