package dev.mvc.review_cate;

import java.util.List;

public interface Review_CateDAOInter {
  
   /**
   * ī�װ� ���
   * @param review_CateVO
   * @return
   */
  public int create(Review_CateVO review_CateVO);
  
   /**
   * ���� VO ��� join
   * @return
   */
  public List<Review_Categrp_Review_Cate_join> list_join();
  
   /**
   * ���� VO ��� join + Review_Categrpno�� ���
   * @return
   */
  public List<Review_Categrp_Review_Cate_join> list_join_by_review_categrp_no(int review_categrp_no);

   /**
   * ��ȸ
   * @param review_cate_no
   * @return
   */
  public Review_CateVO read(int review_cate_no);
  
   /**
   * ����
   * @param review_CateVO
   * @return
   */
  public int update(Review_CateVO review_CateVO);
  
   /**
   * ����
   * @param review_cate_no
   * @return
   */
  public int delete(int review_cate_no);
  
   /**
   * ��� ���� ����
   * @param review_cate_no
   * @return
   */
  public int update_review_cate_seqno_up(int review_cate_no);
  
   /**
   * ��� ���� ����
   * @param review_cate_no
   * @return
   */
  public int update_review_cate_seqno_down(int review_cate_no);
  
   /**
   * �� �� ����
   * @return
   */
  public int increaseCnt(int review_cate_no);    

  /**
   * �� �� ����
   * @return
   */
  public int decreaseCnt(int review_cate_no);
}
