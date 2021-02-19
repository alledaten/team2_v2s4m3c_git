package dev.mvc.member;

import org.springframework.web.multipart.MultipartFile;

/*
CREATE TABLE member(
    member_no                     NUMBER(10)     NOT NULL,
    member_id                     VARCHAR2(50)     NOT NULL,
    member_passwd                 VARCHAR2(50)     NOT NULL,
    member_nickname               VARCHAR2(50)     NOT NULL,
    member_name                   VARCHAR2(50)     NULL ,
    member_isAdult                VARCHAR2(50)     NOT NULL,
    member_tel                    VARCHAR2(50)     NOT NULL,
    member_email                  VARCHAR2(100)    NULL ,
    member_rdate                  DATE             NOT NULL,
    member_zipcode                VARCHAR2(200)    NOT NULL,
    member_address1                VARCHAR2(200)     NOT NULL,
    member_address2                VARCHAR2(200)     NOT NULL,
    member_profilepic                VARCHAR2(200)     NULL,
    memberlevel_no                NUMBER(10)     NOT NULL,
    auth_no                       NUMBER(10)         NOT NULL,
    snslogin_no                   NUMBER(10)     NOT NULL,
    PRIMARY KEY (member_no),
    FOREIGN KEY (auth_no) REFERENCES auth (auth_no),
    FOREIGN KEY (memberlevel_no) REFERENCES memberlevel (memberlevel_no),
    FOREIGN KEY (snslogin_no) REFERENCES snslogin (snslogin_no)
);
 */
public class MemberVO {
  /*
    SELECT l.memberlevel_no as level_no, l.memberlevel_name as level_name,
           m.member_no, m.member_name
    FROM memberlevel l, member m
    WHERE m.memberlevel_no = l.memberlevel_no
    ORDER BY l.memberlevel_no ASC, m.member_no ASC;
   */
  //--------------------------------------------------------
  // Memberlevel Table
  //--------------------------------------------------------
  /** 부모 테이블 등급 번호*/
  private int level_no;
  /** 부모 테이블 등급 이름*/
  private String level_name;
  
  //--------------------------------------------------------
  // Member Table
  //--------------------------------------------------------
  /** 회원번호 */
  private int member_no;
  /** ID */
  private String member_id = "";
  /** 비밀번호 */
  private String member_passwd = "";
  /** 닉네임 */
  private String member_nickname = "";
  /** 이름 */
  private String member_name = "";
  /** 주민등록번호 */
  private String member_isAdult ="";
  /** 전화번호 */
  private String member_tel = "";
  /** 이메일 */
  private String member_email = "";
  /** 가입일*/
  private String member_rdate = "";
  /** 우편번호 */
  private String member_zipcode = "";
  /** 주소1 */
  private String member_address1 = "";
  /** 주소2 */
  private String member_address2 = "";
  /** 프로필사진 */
  private String member_profilepic = "";
  /** 프로필사진 */
  private String member_profilethumb = "";
  /** 이미지 MultipartFile */
  private MultipartFile file1MF;

  /** 등급 */
  private int memberlevel_no = 1;
  /** 권한 */
  private int auth_no = 1;
  /** SNS로그인*/
  private int snslogin_no = 1;
  
  public MemberVO() {
  }

  public int getLevel_no() {
    return level_no;
  }

  public void setLevel_no(int level_no) {
    this.level_no = level_no;
  }

  public String getLevel_name() {
    return level_name;
  }

  public void setLevel_name(String level_name) {
    this.level_name = level_name;
  }

  public int getMember_no() {
    return member_no;
  }

  public void setMember_no(int member_no) {
    this.member_no = member_no;
  }

  public String getMember_id() {
    return member_id;
  }

  public void setMember_id(String member_id) {
    this.member_id = member_id;
  }

  public String getMember_passwd() {
    return member_passwd;
  }

  public void setMember_passwd(String member_passwd) {
    this.member_passwd = member_passwd;
  }

  public String getMember_nickname() {
    return member_nickname;
  }

  public void setMember_nickname(String member_nickname) {
    this.member_nickname = member_nickname;
  }
  
  public String getMember_name() {
    return member_name;
  }
  
  public void setMember_name(String member_name) {
    this.member_name = member_name;
  }

  public String getMember_isAdult() {
    return member_isAdult;
  }

  public void setMember_isAdult(String member_isAdult) {
    this.member_isAdult = member_isAdult;
  }

  public String getMember_tel() {
    return member_tel;
  }

  public void setMember_tel(String member_tel) {
    this.member_tel = member_tel;
  }

  public String getMember_email() {
    return member_email;
  }

  public void setMember_email(String member_email) {
    this.member_email = member_email;
  }

  public String getMember_rdate() {
    return member_rdate;
  }

  public void setMember_rdate(String member_rdate) {
    this.member_rdate = member_rdate;
  }
  
  public String getMember_zipcode() {
    return member_zipcode;
  }

  public void setMember_zipcode(String member_zipcode) {
    this.member_zipcode = member_zipcode;
  }

  public String getMember_address1() {
    return member_address1;
  }

  public void setMember_address1(String member_address1) {
    this.member_address1 = member_address1;
  }

  public String getMember_address2() {
    return member_address2;
  }

  public void setMember_address2(String member_address2) {
    this.member_address2 = member_address2;
  }

  public String getMember_profilepic() {
    return member_profilepic;
  }

  public void setMember_profilepic(String member_profilepic) {
    this.member_profilepic = member_profilepic;
  }

  public String getMember_profilethumb() {
    return member_profilethumb;
  }

  public void setMember_profilethumb(String member_profilethumb) {
    this.member_profilethumb = member_profilethumb;
  }

  public MultipartFile getFile1MF() {
    return file1MF;
  }

  public void setFile1MF(MultipartFile file1mf) {
    file1MF = file1mf;
  }

  public int getMemberlevel_no() {
    return memberlevel_no;
  }

  public void setMemberlevel_no(int memberlevel_no) {
    this.memberlevel_no = memberlevel_no;
  }

  public int getAuth_no() {
    return auth_no;
  }

  public void setAuth_no(int auth_no) {
    this.auth_no = auth_no;
  }

  public int getSnslogin_no() {
    return snslogin_no;
  }

  public void setSnslogin_no(int snslogin_no) {
    this.snslogin_no = snslogin_no;
  }


}


