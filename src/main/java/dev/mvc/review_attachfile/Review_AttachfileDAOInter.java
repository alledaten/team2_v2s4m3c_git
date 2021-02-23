package dev.mvc.review_attachfile;

import java.util.List;

public interface Review_AttachfileDAOInter {
  
  /**
   * ���� ���  
   * @param Review_AttachfileVO
   * @return
   */
  public int create(Review_AttachfileVO review_AttachfileVO);
  
   /**
   * ��ü �̹��� ���
   * @return
   */
  public List<Review_AttachfileVO> list();
  
   /**
   * ��ȸ
   * @param review_attachfile_no
   * @return
   */
  public Review_AttachfileVO read(int review_attachfile_no);
  
   /**
   * review_no�� ���� ���� ���
   * @param review_no
   * @return
   */
  public List<Review_AttachfileVO> list_by_review_no(int review_no);
  
   /**
   * ����
   * @param review_attachfile_no
   * @return
   */
  public int delete(int review_attachfile_no);
  
  /**
   * review_no�� ����
   * @param review_no
   * @return
   */
  public int delete_by_review_no(int review_no);
  
   /**
   * review_no�� ī��Ʈ
   * @param review_no
   * @return
   */
  public int count_by_review_no(int review_no);

 
}
