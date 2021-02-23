package dev.mvc.review_attachfile;

import java.util.List;

public interface Review_AttachfileDAOInter {
  
  /**
   * 파일 등록  
   * @param Review_AttachfileVO
   * @return
   */
  public int create(Review_AttachfileVO review_AttachfileVO);
  
   /**
   * 전체 이미지 목록
   * @return
   */
  public List<Review_AttachfileVO> list();
  
   /**
   * 조회
   * @param review_attachfile_no
   * @return
   */
  public Review_AttachfileVO read(int review_attachfile_no);
  
   /**
   * review_no에 따른 파일 목록
   * @param review_no
   * @return
   */
  public List<Review_AttachfileVO> list_by_review_no(int review_no);
  
   /**
   * 삭제
   * @param review_attachfile_no
   * @return
   */
  public int delete(int review_attachfile_no);
  
  /**
   * review_no별 삭제
   * @param review_no
   * @return
   */
  public int delete_by_review_no(int review_no);
  
   /**
   * review_no별 카운트
   * @param review_no
   * @return
   */
  public int count_by_review_no(int review_no);

 
}
