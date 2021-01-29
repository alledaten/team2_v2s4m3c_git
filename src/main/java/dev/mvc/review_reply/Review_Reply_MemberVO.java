package dev.mvc.review_reply;

public class Review_Reply_MemberVO {
  
  /** 회원 id */
  private String member_id = "";
  
  /** 회원 닉네임 */
  private String member_nickname = "";
  
  /** 리뷰 댓글 번호 */
  private int review_reply_no = 0;
  
  /** 리뷰 번호(FK) */
  private int review_no = 0;
  
  /** 회원 번호(FK) */
  private int member_no = 0;
  
  /** 댓글 내용 */
  private String review_reply_content = "";
  
  /** 댓글 비밀번호 */
  private String review_reply_passwd = "";
  
  /** 댓글 등록일 */
  private String review_reply_date = "";
  
  ////////////////////////////////////////////////////////////////////////////////////////

  public String getMember_id() {
    return member_id;
  }

  public void setMember_id(String member_id) {
    this.member_id = member_id;
  }

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
  
  public String getMember_nickname() {
    return member_nickname;
  }

  public void setMember_nickname(String member_nickname) {
    this.member_nickname = member_nickname;
  }

}
