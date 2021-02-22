package dev.mvc.point;

import java.util.List;

public interface PointDAOInter {
  /**
   * 등록
   * @param pointVO
   * @return
   */
  public int create(PointVO pointVO);

  /**
   * 목록
   * @return
   */
  public List<PointVO> list_point_desc();
  
  /**
   * 조회
   * @param point_no
   * @return
   */
  public PointVO read(int point_no);
  
  /**
   * 수정
   * @param pointVO
   * @return
   */
  public int update(PointVO pointVO);
  
  /**
   * 삭제
   * @param point_no
   * @return
   */
  public int delete(int point_no);
  
  /**
   * Ajax 포인트 호출 목록(결제부분)
   * @return
   */
  public PointVO read_point(int member_no);
  
}
