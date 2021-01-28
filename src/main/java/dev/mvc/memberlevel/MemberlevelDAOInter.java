package dev.mvc.memberlevel;

import java.util.List;

public interface MemberlevelDAOInter {

  /**
   * ���
   * @return
   */
  public List<MemberlevelVO> list();

  /**
   * ���
   * @param memberlevelVO
   * @return
   */
  public int create(MemberlevelVO memberlevelVO);
  
  /**
   * ��ȸ
   * @param memberlevel_no
   * @return
   */
  public MemberlevelVO read(int memberlevel_no);
  
  /**
   * ����
   * @param memberlevelVO
   * @return
   */
  public int update(MemberlevelVO memberlevelVO);
  
  /**
   * ����
   * @param memberlevel_no
   * @return
   */
  public int delete(int memberlevel_no);
  
}
