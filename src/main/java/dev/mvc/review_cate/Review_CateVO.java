package dev.mvc.review_cate;

/*review_cate_no                 NUMBER(10)     NOT NULL          PRIMARY KEY,
review_categrp_no             NUMBER(10),
review_cate_name              VARCHAR2(100) NOT NULL,
review_cate_seqno             NUMBER(10) NOT NULL,
review_cate_date               DATE NOT NULL,
review_cate_cnt                NUMBER(10) DEFAULT 0 NOT NULL,
FOREIGN KEY (review_categrp_no) REFERENCES review_categrp (review_categrp_no)
);*/

public class Review_CateVO {
  
  /** ī�װ� ��ȣ */
  private int review_cate_no;
  
  /** ī�װ� �׷� ��ȣ */
  private int review_categrp_no;
  
  /** ī�װ� �̸� */
  private String review_cate_name = "";
  
  /** ī�װ� ��¼��� */
  private int review_cate_seqno;
  
  /** ī�װ� ����� */
  private String review_cate_date = "";
  
  /** ī�װ��� ��ϵ� �ۼ� */
  private int review_cate_cnt;

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
