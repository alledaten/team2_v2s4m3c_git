package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.product.ProductProc")
public class ProductProc implements ProductProcInter{
  
  @Autowired
  private ProductDAOInter productDAO;
  
  public ProductProc() {
    System.out.println("--> ProductProc created.");
  }
  
  @Override
  public int create(ProductVO productVO) {
     int cnt=this.productDAO.create(productVO);
    return cnt;
  }

  @Override
  public List<ProductVO> list_all() {
    List<ProductVO> list = this.productDAO.list_all();
    return list;
  }
  
  @Override
  public List<ProductVO> list_by_productgrp_no(int productgrp_no) {
    List<ProductVO> list = this.productDAO.list_by_productgrp_no(productgrp_no);
    return list;
  }

  @Override
  public ProductVO read(int product_no) {
    ProductVO productVO = this.productDAO.read(product_no);
    
    String product_name = productVO.getProduct_name();
    String product_description = productVO.getProduct_description();
    
    product_name = Tool.convertChar(product_name);
    
    productVO.setProduct_name(product_name);

    long product_size1 = productVO.getProduct_size1();
    productVO.setSize1_label(Tool.unit(product_size1));
    
    return productVO;
  }
  
  @Override
  public ProductVO read_update(int product_no) {
    ProductVO productVO = this.productDAO.read(product_no);
    return productVO;
  }

  @Override
  public int update(ProductVO productVO) {
    int cnt = this.productDAO.update(productVO);
    return cnt;
  }

  @Override
  public int passwd_check(HashMap<String, Object> hashMap) {
    int passwd_cnt = this.productDAO.passwd_check(hashMap);
    return passwd_cnt;
  } 

  @Override
  public int delete(int product_no) {
    int cnt = this.productDAO.delete(product_no);
    return cnt;
  }

  @Override
  public int img_create(ProductVO productVO) {
    int cnt = this.productDAO.update_img(productVO);
    return cnt;
  }

  @Override
  public int img_update(ProductVO productVO) {
    int cnt = this.productDAO.update_img(productVO);
    return cnt;
  }

  @Override
  public int img_delete(ProductVO productVO) {
    int cnt = this.productDAO.update_img(productVO);
    return cnt;
  }

  @Override
  public int total_count() {
    int cnt = this.productDAO.total_count();
    return cnt;
  }

  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int count = productDAO.search_count(hashMap);
    return count;
  }
  
  @Override
  public String pagingBox(String listFile, int productgrp_no, int search_count, int nowPage, String product_word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Product.RECORD_PER_PAGE)); // ��ü ������  
    
    int totalGrp = (int)(Math.ceil((double)totalPage/Product.PAGE_PER_BLOCK));// ��ü �׷� 
    
    int nowGrp = (int)(Math.ceil((double)nowPage/Product.PAGE_PER_BLOCK));    // ���� �׷� 
    
    int startPage = ((nowGrp - 1) * Product.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    
    int endPage = (nowGrp * Product.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page)
    // nowGrp: 2 (11 ~ 20 page)
    // nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� ������ ������ 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� ������ ������ 20
    int _nowPage = (nowGrp-1) * Product.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&product_word="+product_word+"&nowPage="+_nowPage+"&productgrp_no="+productgrp_no+"'>����</A></span>"); 
    } 
 
    // �߾��� ������ ���
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ // ������ �������� �Ѿ�ٸ� ���� ��� ����
        break; 
      } 
  
      if (nowPage == i){ // �������� ������������ ���ٸ� CSS ����(������ ��)
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� �������� �̵��� �����ϵ��� ��ũ�� ����
        str.append("<span class='span_box_1'><A href='"+listFile+"?product_word="+product_word+"&nowPage="+i+"&productgrp_no="+productgrp_no+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� ���������� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� ���������� 21
    _nowPage = (nowGrp * Product.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&product_word="+product_word+"&nowPage="+_nowPage+"&productgrp_no="+productgrp_no+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
  @Override
  public int increaseAnsnum(HashMap<String, Object> map) {
    int count = productDAO.increaseAnsnum(map);
    return count;
  }
  
  @Override
  public int reply(ProductVO productVO) {
    int count = productDAO.reply(productVO);
    return count;
  }

  @Override
  public List<Product_MemberVO> list_by_productgrp_no_search_paging_join(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������ ���� rownum: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������ ���� rownum: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������ ���� rownum: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)map.get("nowPage") - 1) * Product.RECORD_PER_PAGE;
   
    // ���� rownum ����
    // 1 ������ = 0 + 1, 2 ������ = 10 + 1, 3 ������ = 20 + 1 
    int startNum = beginOfPage + 1;
    
    //  ���� rownum 
    // 1 ������ = 0 + 10, 2 ������ = 0 + 20, 3 ������ = 0 + 30
    int endNum = beginOfPage + Product.RECORD_PER_PAGE;   
    /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
   
    List<Product_MemberVO> list = this.productDAO.list_by_productgrp_no_search_paging_join(map);
    
    return list;
  }

  @Override
  public int increaseReplycnt(int product_no) {
    int count = productDAO.increaseReplycnt(product_no);
    return count;
  }

  @Override
  public int decreaseReplycnt(int product_no) {
    int count = productDAO.decreaseReplycnt(product_no);
    return count;
  }
}
