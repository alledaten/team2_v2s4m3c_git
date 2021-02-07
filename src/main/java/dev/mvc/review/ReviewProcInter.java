package dev.mvc.review;

import java.util.HashMap;


import java.util.List;


public interface ReviewProcInter {
  
   /**
   * ���� ���
   * @param reviewVO
   * @return
   */
  public int create(ReviewVO reviewVO);
  
  /**
   * ��� ��ǰ�� ��ϵ� ���� ���
   * @return
   */
  public List<Review_Member_ProductVO> list_all(HashMap<String, Object> map);
  
   /**
   * Ư�� ��ǰ�� ��ϵ� ���� ���
   * @return
   */
  public List<Review_Member_ProductVO> list_by_product_no(int product_no);
  
  
   /**
   * ��ǰ�� �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * ��� ���� �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count_all(HashMap<String, Object> hashMap);
  
  /**
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public List<Review_Member_ProductVO> list_by_product_no_search_paging(HashMap<String, Object> map);
  
  
   /**
   * ������ ��� ���ڿ� ����, Box ����
   * @param listFile
   * @param product_no
   * @param search_count
   * @param nowPage
   * @param review_word
   * @return
   */
  public String pagingBox(String listFile, int product_no, int search_count, int nowPage, String review_word);
  
  /**
   * ������ ��� ���ڿ� ����, Box ����
   * @param listFile
   * @param product_no
   * @param search_count
   * @param nowPage
   * @param review_word
   * @return
   */
  public String pagingBox_all(String listFile, int search_count, int nowPage, String review_word);
  
  /**
   * ��ȸ
   * @param review_no
   * @return
   */
  public ReviewVO read(int review_no);
  
   /**
   * ������ ��ȸ
   * @param contentsno
   * @return
   */
  public ReviewVO read_update(int review_no);
  
   /**
   * ���� ó��
   * @param review_member_productVO
   * @return
   */
  public int update(ReviewVO reviewVO);
  
   /**
   * �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap<String, Object> hashMap);
  
  /**
   * ����
   * @param review_no
   * @return
   */
  public int delete(int review_no);
  
  /////////////////////////////////////// �̹��� ���� ���, ����, ���� ���� ////////////////////////////////////////////////////
  
  /**
   * �̹��� ���
   * @param review_member_productVO
   * @return
   */
  public int img_create(ReviewVO reviewVO);
  
  /**
   * �̹��� ����
   * @param review_member_productVO
   * @return
   */
  public int img_update(ReviewVO reviewVO);
  
   /**
   * �̹��� ����
   * @param review_member_productVO
   * @return
   */
  public int img_delete(ReviewVO reviewVO);
  
/////////////////////////////////////// �̹��� ���� ���, ����, ���� ���� ////////////////////////////////////////////////////
  
   /**
   * ��ȸ�� ����
   * @param review_no
   * @return
   */
  public int update_review_view(int review_no);
  
  /**
   * ���ƿ� ����
   * @param review_no
   * @return
   */
  public int update_review_good(int review_no);
  
  


  
}
