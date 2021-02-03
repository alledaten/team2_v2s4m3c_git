package dev.mvc.review_reply;

//review_reply_no                   NUMBER(10)     NOT NULL    PRIMARY KEY,
//review_no                         NUMBER(10)     NOT NULL,
//member_no                         NUMBER(10)     NOT NULL,
//review_reply_content              CLOB     NOT NULL,
//review_reply_passwd               VARCHAR2(30)     NOT NULL,
//review_reply_date                 DATE     NOT NULL,
//FOREIGN KEY (review_no) REFERENCES review (review_no),
//FOREIGN KEY (member_no) REFERENCES member (member_no)

public class Review_ReplyVO {
  
  /** ¸®ºä ´ñ±Û ¹øÈ£ */
  private int review_reply_no;
  
  /** ¸®ºä ¹øÈ£(FK) */
  private int review_no;
  
  /** È¸¿ø ¹øÈ£(FK) */
  private int member_no;
  
  /** ´ñ±Û ³»¿ë */
  private String review_reply_content = "";
  
  /** ´ñ±Û ºñ¹Ð¹øÈ£ */
  private String review_reply_passwd = "";
  
  /** ´ñ±Û µî·ÏÀÏ */
  private String review_reply_date = "";
  
  //////////////////////////////////////////////////////////////////////////////////////////////////////

  public int getReview_reply_no() {
    return review_reply_no;
  }

  public void setReview_reply_no(int review_reply_no) {
    this.review_reply_no = review_reply_no;
  }

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

  public String getReview_reply_content() {
    return review_reply_content;
  }

  public void setReview_reply_content(String review_reply_content) {
    this.review_reply_content = review_reply_content;
  }

  public String getReview_reply_passwd() {
    return review_reply_passwd;
  }

  public void setReview_reply_passwd(String review_reply_passwd) {
    this.review_reply_passwd = review_reply_passwd;
  }

  public String getReview_reply_date() {
    return review_reply_date;
  }

  public void setReview_reply_date(String review_reply_date) {
    this.review_reply_date = review_reply_date;
  }
  
}
