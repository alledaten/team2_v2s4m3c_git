package dev.mvc.memberlevel;

import java.util.List;

public interface MemberlevelDAOInter {

  /**
   * 목록
   * @return
   */
  public List<MemberlevelVO> list();

  /**
   * 등록
   * @param memberlevelVO
   * @return
   */
  public int create(MemberlevelVO memberlevelVO);
  
  /**
   * 조회
   * @param memberlevel_no
   * @return
   */
  public MemberlevelVO read(int memberlevel_no);
  
  /**
   * 수정
   * @param memberlevelVO
   * @return
   */
  public int update(MemberlevelVO memberlevelVO);
  
  /**
   * 삭제
   * @param memberlevel_no
   * @return
   */
  public int delete(int memberlevel_no);
  
}
