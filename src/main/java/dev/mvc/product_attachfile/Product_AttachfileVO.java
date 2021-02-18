package dev.mvc.product_attachfile;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Product_AttachfileVO {
  /*
    product_attachfile_no                  NUMBER(10)     NOT NULL    PRIMARY KEY,
    product_no                   NUMBER(10)    NULL ,
    product_attachfile_fname                           VARCHAR2(100)    NOT NULL,
    product_attachfile_fupname                      VARCHAR2(100)     NOT NULL,
    product_attachfile_thumb                         VARCHAR2(100)    NULL ,
    product_attachfile_fsize                             NUMBER(10)     DEFAULT 0     NOT NULL,
   */
  /** 첨부파일 번호(PK) */
  private int product_attachfile_no;
  /** 리뷰 번호(FK) */
  private int product_no;
  /** 원본 파일명 */
  private String product_attachfile_fname;
  /** 업로드 파일명 */
  private String product_attachfile_fupname;
  /** 섬네일 이미지 */
  private String product_attachfile_thumb;
  /** 파일 크기 */
  private long product_attachfile_fsize;
  /** 등록일 */
  private String product_attachfile_rdate;
  /** Form의 파일을 MultipartFile로 변환하여 List에 저장  */
  private List<MultipartFile> fnamesMF;
  
  private String flabel;
  
  public List<MultipartFile> getFnamesMF() {
    return fnamesMF;
  }
  public void setFnamesMF(List<MultipartFile> fnamesMF) {
    this.fnamesMF = fnamesMF;
  }
  public String getFlabel() {
    return flabel;
  }
  public void setFlabel(String flabel) {
    this.flabel = flabel;
  }
  public int getProduct_attachfile_no() {
    return product_attachfile_no;
  }
  public void setProduct_attachfile_no(int product_attachfile_no) {
    this.product_attachfile_no = product_attachfile_no;
  }
  public int getProduct_no() {
    return product_no;
  }
  public void setProduct_no(int product_no) {
    this.product_no = product_no;
  }
  public String getProduct_attachfile_fname() {
    return product_attachfile_fname;
  }
  public void setProduct_attachfile_fname(String product_attachfile_fname) {
    this.product_attachfile_fname = product_attachfile_fname;
  }
  public String getProduct_attachfile_fupname() {
    return product_attachfile_fupname;
  }
  public void setProduct_attachfile_fupname(String product_attachfile_fupname) {
    this.product_attachfile_fupname = product_attachfile_fupname;
  }
  public String getProduct_attachfile_thumb() {
    return product_attachfile_thumb;
  }
  public void setProduct_attachfile_thumb(String product_attachfile_thumb) {
    this.product_attachfile_thumb = product_attachfile_thumb;
  }
  public long getProduct_attachfile_fsize() {
    return product_attachfile_fsize;
  }
  public void setProduct_attachfile_fsize(long product_attachfile_fsize) {
    this.product_attachfile_fsize = product_attachfile_fsize;
  }
  public String getProduct_attachfile_rdate() {
    return product_attachfile_rdate;
  }
  public void setProduct_attachfile_rdate(String product_attachfile_rdate) {
    this.product_attachfile_rdate = product_attachfile_rdate;
  }
  
  
    
}

