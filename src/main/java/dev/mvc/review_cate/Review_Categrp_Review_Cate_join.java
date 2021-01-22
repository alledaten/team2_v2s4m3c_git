package dev.mvc.review_cate;

/*
 * SELECT g.review_categrp_no as g_review_categrp_no, g.review_categrp_name as g_categrp_name, 
             c.review_cate_no, c.review_categrp_no, c.review_cate_name, c.review_cate_seqno, c.review_cate_date, c.review_cate_cnt
    FROM review_categrp g, review_cate c
    WHERE g.review_categrp_no = c.review_categrp_no
    ORDER BY g.review_categrp_no ASC, c.review_cate_seqno ASC;*/

public class Review_Categrp_Review_Cate_join {
  // -------------------------------------------------------------------
  // Review_Categrp table(부모)
  // -------------------------------------------------------------------
  /** 부모 테이블 카테고리 그룹 번호 */
  private int g_review_categrp_no;
  
  /** 부모 테이블 카테고리 그룹 이름 */
  private String g_review_categrp_name;
  
  // -------------------------------------------------------------------
  // Review_Cate table(자식)
  // -------------------------------------------------------------------  
  /** 카테고리 번호 */
  private int review_cate_no;  
  
  /** 카테고리 그룹 번호 */
  private int review_categrp_no;
  
  /**  카테고리 이름 */
  private String review_cate_name;
  
  /** 출력 순서 */
  private int review_cate_seqno;
  
  /** 등록일 */
  private String review_cate_date;
  
  /** 등록된 글 수 */
  private int review_cate_cnt;
  
  
  
  public int getG_review_categrp_no() {
    return g_review_categrp_no;
  }

  public void setG_review_categrp_no(int g_review_categrp_no) {
    this.g_review_categrp_no = g_review_categrp_no;
  }

  public String getG_review_categrp_name() {
    return g_review_categrp_name;
  }

  public void setG_review_categrp_name(String g_review_categrp_name) {
    this.g_review_categrp_name = g_review_categrp_name;
  }

  public int getReview_cate_no() {
    return review_cate_no;
  }

  public void setReview_cate_no(int review_cate_no) {
    this.review_cate_no = review_cate_no;
  }

  public int getReview_categrp_no() {
    return review_categrp_no;
  }

  public void setReview_categrp_no(int review_categrp_no) {
    this.review_categrp_no = review_categrp_no;
  }

  public String getReview_cate_name() {
    return review_cate_name;
  }

  public void setReview_cate_name(String review_cate_name) {
    this.review_cate_name = review_cate_name;
  }

  public int getReview_cate_seqno() {
    return review_cate_seqno;
  }

  public void setReview_cate_seqno(int review_cate_seqno) {
    this.review_cate_seqno = review_cate_seqno;
  }

  public String getReview_cate_date() {
    return review_cate_date;
  }

  public void setReview_cate_date(String review_cate_date) {
    this.review_cate_date = review_cate_date;
  }

  public int getReview_cate_cnt() {
    return review_cate_cnt;
  }

  public void setReview_cate_cnt(int review_cate_cnt) {
    this.review_cate_cnt = review_cate_cnt;
  }

}