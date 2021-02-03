package dev.mvc.review;

import java.util.HashMap;

import java.util.List;



public interface ReviewDAOInter {
  
   /**
   * 리뷰 등록
   * @param reviewVO
   * @return
   */
  public int create(ReviewVO reviewVO);
  
   /**
   * 모든 상품에 등록된 리뷰 목록
   * @return
   */
  public List<ReviewVO> list_all();
  
   /**
   * 특정 상품에 등록된 리뷰 목록
   * @return
   */
  public List<Review_Member_ProductVO> list_by_product_no(int product_no);
  
  
   /**
   * 상품별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
   /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public List<Review_Member_ProductVO> list_by_product_no_search_paging(HashMap<String, Object> map);
  
   /**
   * 조회
   * @param review_no
   * @return
   */
  public ReviewVO read(int review_no);
  
  /**
   * 수정 처리
   * @param reviewVO
   * @return
   */
  public int update(ReviewVO reviewVO);
  
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
  public int delete(int review_no);
  

   /**
   * 이미지 변경
   * @param reviewVO
   * @return
   */
  public int img_update(ReviewVO reviewVO);
  
  /**
   * 조회수 증가
   * @param review_no
   * @return
   */
  public int update_review_view(int review_no);
  
  
}
