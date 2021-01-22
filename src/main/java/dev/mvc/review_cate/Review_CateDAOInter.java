package dev.mvc.review_cate;

import java.util.List;

public interface Review_CateDAOInter {
  
   /**
   * 카테고리 등록
   * @param review_CateVO
   * @return
   */
  public int create(Review_CateVO review_CateVO);
  
   /**
   * 통합 VO 기반 join
   * @return
   */
  public List<Review_Categrp_Review_Cate_join> list_join();
  
   /**
   * 통합 VO 기반 join + Review_Categrpno별 목록
   * @return
   */
  public List<Review_Categrp_Review_Cate_join> list_join_by_review_categrp_no(int review_categrp_no);

   /**
   * 조회
   * @param review_cate_no
   * @return
   */
  public Review_CateVO read(int review_cate_no);
  
   /**
   * 수정
   * @param review_CateVO
   * @return
   */
  public int update(Review_CateVO review_CateVO);
  
   /**
   * 삭제
   * @param review_cate_no
   * @return
   */
  public int delete(int review_cate_no);
  
   /**
   * 출력 순서 상향
   * @param review_cate_no
   * @return
   */
  public int update_review_cate_seqno_up(int review_cate_no);
  
   /**
   * 출력 순서 하향
   * @param review_cate_no
   * @return
   */
  public int update_review_cate_seqno_down(int review_cate_no);
  
   /**
   * 글 수 증가
   * @return
   */
  public int increaseCnt(int review_cate_no);    

  /**
   * 글 수 감소
   * @return
   */
  public int decreaseCnt(int review_cate_no);
}
