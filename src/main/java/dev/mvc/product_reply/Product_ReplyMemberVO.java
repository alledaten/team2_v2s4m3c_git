package dev.mvc.product_reply;

public class Product_ReplyMemberVO {
  /** 회원 id */
  private String member_id = "";
  /** 리뷰 댓글 번호 */
  private int product_reply_no;
  /** 리뷰 번호(FK) */
  private int product_no;
  /** 회원 번호(FK) */
  private int member_no;
  /** 댓글 내용 */
  private String product_reply_content;
  /** 댓글 비밀번호 */
  private String product_reply_passwd;
  /** 댓글 등록일 */
  private String product_reply_rdate;
  


  public String getMember_id() {
    return member_id;
  }
  public void setMember_id(String member_id) {
    this.member_id = member_id;
  }
  public int getProduct_no() {
    return product_no;
  }
  public void setProduct_no(int product_no) {
    this.product_no = product_no;
  }
  public int getProduct_reply_no() {
    return product_reply_no;
  }
  public void setProduct_reply_no(int product_reply_no) {
    this.product_reply_no = product_reply_no;
  }
  public int getMember_no() {
    return member_no;
  }
  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }
  public String getProduct_reply_content() {
    return product_reply_content;
  }
  public void setProduct_reply_content(String product_reply_content) {
    this.product_reply_content = product_reply_content;
  }
  public String getProduct_reply_passwd() {
    return product_reply_passwd;
  }
  public void setProduct_reply_passwd(String product_reply_passwd) {
    this.product_reply_passwd = product_reply_passwd;
  }
  public String getProduct_reply_rdate() {
    return product_reply_rdate;
  }
  public void setProduct_reply_rdate(String product_reply_rdate) {
    this.product_reply_rdate = product_reply_rdate;
  }
  
  
  
}