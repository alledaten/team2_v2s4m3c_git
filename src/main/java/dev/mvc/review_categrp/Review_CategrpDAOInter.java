package dev.mvc.review_categrp;

import java.util.List;

public interface Review_CategrpDAOInter {
  
   /**
   * ���
   * @param review_CategrpVO
   * @return
   */
  public int create(Review_CategrpVO review_CategrpVO);
  
   /**
   * ���� ��ȣ�� ���� ���
   * @return
   */
  public List<Review_CategrpVO> list_review_categrp_no_asc();
  
   /**
   * ��ȸ
   * @param review_CategrpVO
   * @return
   */
  public Review_CategrpVO read(int review_categrp_no);
  
   /**
   * ����
   * @param review_CategrpVO
   * @return
   */
  public int update(Review_CategrpVO review_CategrpVO);
  
   /**
   * ����
   * @param review_categrp_no
   * @return
   */
  public int delete(int review_categrp_no);
  
   /**
   * ���� ī�װ� �׷� ������ ���  
   * @return
   */
  public List<Review_CategrpVO> list_review_categrp_seqno();
  
   /**
   * ��� ���� ����
   * @param review_categrp_no
   * @return
   */
  public int update_review_categrp_seqno_up(int review_categrp_no);
  
   /**
   * ��� ���� ����
   * @param review_categrp_no
   * @return
   */
  public int update_review_categrp_seqno_down(int review_categrp_no);
  

}
