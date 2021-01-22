package dev.mvc.review;

import java.util.HashMap;


import java.util.List;


public interface ReviewProcInter {
  
   /**
   * 리뷰 등록
   * @param reviewVO
   * @return
   */
  public int create(ReviewVO reviewVO);
  
   /**
   * 모든 카테고리에 등록된 리뷰 목록
   * @return
   */
  public List<ReviewVO> list_all();
  
   /**
   * 특정 카테고리에 등록된 리뷰 목록
   * @return
   */
  public List<ReviewVO> list_by_review_cate_no(int review_cate_no);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public List<Review_MemberVO> list_by_review_cate_no_search_paging(HashMap<String, Object> map);
  
  /**
   * 카테고리별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
   /**
   * 페이지 목록 문자열 생성, Box 형태
   * @param listFile
   * @param review_cate_no
   * @param search_count
   * @param nowPage
   * @param review_word
   * @return
   */
  public String pagingBox(String listFile, int review_cate_no, int search_count, int nowPage, String review_word);
  
  /**
   * 조회
   * @param review_no
   * @return
   */
  public ReviewVO read(int review_no);
  
   /**
   * 수정용 조회
   * @param contentsno
   * @return
   */
  public ReviewVO read_update(int review_no);
  
  /**
   * 수정 처리
   * @param reviewVO
   * @return
   */
  public int update(ReviewVO reviewVO);
  
  /**
   * 삭제
   * @param review_no
   * @return
   */
  public int delete(int review_no);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap<String, Object> hashMap);
  
  
  
  /////////////////////////////////////// 이미지 관련 등록, 수정, 삭제 시작 ////////////////////////////////////////////////////
  
  /**
   * 이미지 등록
   * @param reviewVO
   * @return
   */
  public int img_create(ReviewVO reviewVO);
  
  /**
   * 이미지 변경
   * @param reviewVO
   * @return
   */
  public int img_update(ReviewVO reviewVO);
  
   /**
   * 이미지 삭제
   * @param reviewVO
   * @return
   */
  public int img_delete(ReviewVO reviewVO);
  
/////////////////////////////////////// 이미지 관련 등록, 수정, 삭제 종료 ////////////////////////////////////////////////////
  
}
