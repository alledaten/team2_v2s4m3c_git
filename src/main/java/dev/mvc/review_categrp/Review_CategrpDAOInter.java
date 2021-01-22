package dev.mvc.review_categrp;

import java.util.List;

public interface Review_CategrpDAOInter {
  
   /**
   * 등록
   * @param review_CategrpVO
   * @return
   */
  public int create(Review_CategrpVO review_CategrpVO);
  
   /**
   * 리뷰 번호에 따른 목록
   * @return
   */
  public List<Review_CategrpVO> list_review_categrp_no_asc();
  
   /**
   * 조회
   * @param review_CategrpVO
   * @return
   */
  public Review_CategrpVO read(int review_categrp_no);
  
   /**
   * 수정
   * @param review_CategrpVO
   * @return
   */
  public int update(Review_CategrpVO review_CategrpVO);
  
   /**
   * 삭제
   * @param review_categrp_no
   * @return
   */
  public int delete(int review_categrp_no);
  
   /**
   * 리뷰 카테고리 그룹 순서별 목록  
   * @return
   */
  public List<Review_CategrpVO> list_review_categrp_seqno();
  
   /**
   * 출력 순서 상향
   * @param review_categrp_no
   * @return
   */
  public int update_review_categrp_seqno_up(int review_categrp_no);
  
   /**
   * 출력 순서 하향
   * @param review_categrp_no
   * @return
   */
  public int update_review_categrp_seqno_down(int review_categrp_no);
  

}
