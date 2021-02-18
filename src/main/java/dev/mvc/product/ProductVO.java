package dev.mvc.product;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
  /*
  CREATE TABLE product(
    product_no                        NUMBER(10)     NOT NULL    PRIMARY KEY,
        memberno                              NUMBER(10)     NOT NULL ,
    product_name                      VARCHAR2(100)    NOT NULL,
    product_brand                     VARCHAR2(100)    NOT NULL,
    product_origin                    VARCHAR2(100)    NOT NULL,
    product_frequency               VARCHAR2(100)    NOT NULL,
    product_description               VARCHAR2(2000)     NOT NULL,
    product_cost                      VARCHAR2(100)    NOT NULL,
    product_ml                        VARCHAR2(100)    NOT NULL,
        product_word                       VARCHAR2(300)         NULL ,
    product_passwd                    NUMBER(20)     NOT NULL,
    product_replycnt                  NUMBER(7)    DEFAULT 0     NOT NULL,
    product_file1                     VARCHAR2(100)    NULL ,
    product_thumb1                    VARCHAR2(100)    NULL ,
    product_size                      NUMBER(10)     DEFAULT 0     NULL ,
    product_indent                    NUMBER(2)    DEFAULT 0     NOT NULL,
    product_ansnum                    NUMBER(3)    DEFAULT 0     NOT NULL,
    product_grpno                     NUMBER(8)    DEFAULT 0     NOT NULL,
    product_cnt                       NUMBER(7)    DEFAULT 0     NOT NULL,
    product_recom                     NUMBER(7)    DEFAULT 0     NOT NULL,
    product_rdate                     DATE     NOT NULL,
        productgrp_no                     NUMBER(10)     NOT NULL,
  FOREIGN KEY (productgrp_no) REFERENCES productgrp (productgrp_no)
  );
  */
    private int product_no;
    
    private int member_no;
    
    private int productgrp_no;
    
    private String product_name = "";
    
    private String product_brand = "";
    
    private String product_origin = "";
    
    private String product_frequency = "";
    
    private String product_description = "";
    
    private long product_cost;
    
    private String product_ml = "";
    
    private String product_word = "";
    
    private String product_passwd = "";
    
    private int product_replycnt;
    
    private String product_file1 = "";

    private String product_thumb1 = "";

    private long product_size1;
    
    private String size1_label;
    
    private int product_indent;
    
    private int product_ansnum;
    
    private int product_grpno;
    
    private int product_cnt = 0;
    
    private int product_recom;
    
    private String product_rdate = "";

    private MultipartFile file1MF;
    
    private String product_size1_label;

    public int getProduct_no() {
      return product_no;
    }

    public void setProduct_no(int product_no) {
      this.product_no = product_no;
    }

    public int getMember_no() {
      return member_no;
    }

    public void setMember_no(int member_no) {
      this.member_no = member_no;
    }

    public int getProductgrp_no() {
      return productgrp_no;
    }

    public void setProductgrp_no(int productgrp_no) {
      this.productgrp_no = productgrp_no;
    }

    public String getProduct_name() {
      return product_name;
    }

    public void setProduct_name(String product_name) {
      this.product_name = product_name;
    }

    public String getProduct_brand() {
      return product_brand;
    }

    public void setProduct_brand(String product_brand) {
      this.product_brand = product_brand;
    }

    public String getProduct_origin() {
      return product_origin;
    }

    public void setProduct_origin(String product_origin) {
      this.product_origin = product_origin;
    }

    public String getProduct_frequency() {
      return product_frequency;
    }

    public void setProduct_frequency(String product_frequency) {
      this.product_frequency = product_frequency;
    }

    public String getProduct_description() {
      return product_description;
    }

    public void setProduct_description(String product_description) {
      this.product_description = product_description;
    }

    public long getProduct_cost() {
      return product_cost;
    }

    public void setProduct_cost(long product_cost) {
      this.product_cost = product_cost;
    }

    public String getProduct_ml() {
      return product_ml;
    }

    public void setProduct_ml(String product_ml) {
      this.product_ml = product_ml;
    }

    public String getProduct_word() {
      return product_word;
    }

    public void setProduct_word(String product_word) {
      this.product_word = product_word;
    }

    public String getProduct_passwd() {
      return product_passwd;
    }

    public void setProduct_passwd(String product_passwd) {
      this.product_passwd = product_passwd;
    }

    public int getProduct_replycnt() {
      return product_replycnt;
    }

    public void setProduct_replycnt(int product_replycnt) {
      this.product_replycnt = product_replycnt;
    }

    public String getProduct_file1() {
      return product_file1;
    }

    public void setProduct_file1(String product_file1) {
      this.product_file1 = product_file1;
    }

    public String getProduct_thumb1() {
      return product_thumb1;
    }

    public void setProduct_thumb1(String product_thumb1) {
      this.product_thumb1 = product_thumb1;
    }

    public long getProduct_size1() {
      return product_size1;
    }

    public void setProduct_size1(long product_size1) {
      this.product_size1 = product_size1;
    }

    public String getSize1_label() {
      return size1_label;
    }

    public void setSize1_label(String size1_label) {
      this.size1_label = size1_label;
    }

    public int getProduct_indent() {
      return product_indent;
    }

    public void setProduct_indent(int product_indent) {
      this.product_indent = product_indent;
    }

    public int getProduct_ansnum() {
      return product_ansnum;
    }

    public void setProduct_ansnum(int product_ansnum) {
      this.product_ansnum = product_ansnum;
    }

    public int getProduct_grpno() {
      return product_grpno;
    }

    public void setProduct_grpno(int product_grpno) {
      this.product_grpno = product_grpno;
    }

    public int getProduct_cnt() {
      return product_cnt;
    }

    public void setProduct_cnt(int product_cnt) {
      this.product_cnt = product_cnt;
    }

    public int getProduct_recom() {
      return product_recom;
    }

    public void setProduct_recom(int product_recom) {
      this.product_recom = product_recom;
    }

    public String getProduct_rdate() {
      return product_rdate;
    }

    public void setProduct_rdate(String product_rdate) {
      this.product_rdate = product_rdate;
    }

    public MultipartFile getFile1MF() {
      return file1MF;
    }

    public void setFile1MF(MultipartFile file1mf) {
      file1MF = file1mf;
    }

    public String getProduct_size1_label() {
      return product_size1_label;
    }

    public void setProduct_size1_label(String product_size1_label) {
      this.product_size1_label = product_size1_label;
    }

    
  
}
