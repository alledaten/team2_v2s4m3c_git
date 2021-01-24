package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

public interface ProductDAOInter {
  
  public int create(ProductVO productVO);
  
  public List<ProductVO> list_all();
  
  public List<ProductVO> list_by_productgrp_no(int productgrp_no);
  
  public ProductVO read(int product_no);
  
  public int update(ProductVO productVO);
  
  public int passwd_check(HashMap<String, Object> hashMap);
  
  public int delete(int product_no);
  
  public int update_img(ProductVO productVO);
  
  public int total_count();

  public int search_count(HashMap<String, Object> hashMap);

  public int increaseAnsnum(HashMap<String, Object> map);

  public int reply(ProductVO productVO);
 
  public List<Product_MemberVO> list_by_productgrp_no_search_paging_join(HashMap<String, Object> map);
  
  public int increaseReplycnt(int product_no);

  public int decreaseReplycnt(int product_no);
  
}
