package dev.mvc.snslogin;

import java.util.List;

public interface SnsloginDAOInter {
  
  /**
   * 등록
   * @param snsloginVO
   * @return
   */
  public int create(SnsloginVO snsloginVO);
  
  /**
   * 목록
   * @return
   */
  public List<SnsloginVO> list();

  /**
   * 조회
   * @param snslogin_no
   * @return
   */
  public SnsloginVO read(int snslogin_no);
  
  /**
   * 수정
   * @param snsloginVO
   * @return
   */
  public int update(SnsloginVO snsloginVO);
  
  /**
   * 삭제
   * @param snslogin_no
   * @return
   */
  public int delete(int snslogin_no);
}
