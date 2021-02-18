package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

public interface ProductDAOInter {
  
  /**
   * 상품 등록
   * @param reviewVO
   * @return
   */
  public int create(ProductVO productVO);
  
  /**
   * 모든 카테고리에 등록된 상품 목록
   * @return
   */
  public List<ProductVO> list_all();
  
  /**
   * 특정 카테고리에 등록된 상품 목록
   * @return
   */
  public List<ProductVO> list_by_productgrp_no(int productgrp_no);
  
  /**
   * 카테고리별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public ProductVO read(int product_no);
  
  /**
   * 수정 처리
   * @param reviewVO
   * @return
   */
  public int update(ProductVO productVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap<String, Object> hashMap);
  
  /**
   * 삭제
   * @param review_no
   * @return
   */
  public int delete(int product_no);
  
  /**
   * 이미지 변경
   * @param reviewVO
   * @return
   */
  public int update_img(ProductVO productVO);
  
  public int total_count();

  public int search_count(HashMap<String, Object> hashMap);

  public int increaseAnsnum(HashMap<String, Object> map);

  public int reply(ProductVO productVO);
 
  public List<Product_MemberVO> list_by_productgrp_no_search_paging_join(HashMap<String, Object> map);
  
  public int increaseReplycnt(int product_no);

  public int decreaseReplycnt(int product_no);
  
}
