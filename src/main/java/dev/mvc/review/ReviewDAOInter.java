package dev.mvc.review;

import java.util.HashMap;

import java.util.List;



public interface ReviewDAOInter {
  
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
  public List<ReviewVO> list_all();
  
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
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public List<Review_Member_ProductVO> list_by_product_no_search_paging(HashMap<String, Object> map);
  
   /**
   * ��ȸ
   * @param review_no
   * @return
   */
  public ReviewVO read(int review_no);
  
  /**
   * ���� ó��
   * @param reviewVO
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
  

   /**
   * �̹��� ����
   * @param reviewVO
   * @return
   */
  public int img_update(ReviewVO reviewVO);
  
  /**
   * ��ȸ�� ����
   * @param review_no
   * @return
   */
  public int update_review_view(int review_no);
  
  
}
