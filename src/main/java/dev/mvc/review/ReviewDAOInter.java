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
   * ī�װ��� �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
   /**
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public List<Review_MemberVO> list_by_review_cate_no_search_paging(HashMap<String, Object> map);
  
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
