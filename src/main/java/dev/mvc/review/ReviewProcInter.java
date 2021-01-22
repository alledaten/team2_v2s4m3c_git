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
   * ��� ī�װ��� ��ϵ� ���� ���
   * @return
   */
  public List<ReviewVO> list_all();
  
   /**
   * Ư�� ī�װ��� ��ϵ� ���� ���
   * @return
   */
  public List<ReviewVO> list_by_review_cate_no(int review_cate_no);
  
  /**
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public List<Review_MemberVO> list_by_review_cate_no_search_paging(HashMap<String, Object> map);
  
  /**
   * ī�װ��� �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
   /**
   * ������ ��� ���ڿ� ����, Box ����
   * @param listFile
   * @param review_cate_no
   * @param search_count
   * @param nowPage
   * @param review_word
   * @return
   */
  public String pagingBox(String listFile, int review_cate_no, int search_count, int nowPage, String review_word);
  
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
   * @param reviewVO
   * @return
   */
  public int update(ReviewVO reviewVO);
  
  /**
   * ����
   * @param review_no
   * @return
   */
  public int delete(int review_no);
  
  /**
   * �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap<String, Object> hashMap);
  
  
  
  /////////////////////////////////////// �̹��� ���� ���, ����, ���� ���� ////////////////////////////////////////////////////
  
  /**
   * �̹��� ���
   * @param reviewVO
   * @return
   */
  public int img_create(ReviewVO reviewVO);
  
  /**
   * �̹��� ����
   * @param reviewVO
   * @return
   */
  public int img_update(ReviewVO reviewVO);
  
   /**
   * �̹��� ����
   * @param reviewVO
   * @return
   */
  public int img_delete(ReviewVO reviewVO);
  
/////////////////////////////////////// �̹��� ���� ���, ����, ���� ���� ////////////////////////////////////////////////////
  
}
