package dev.mvc.snslogin;

import java.util.List;

public interface SnsloginDAOInter {
  
  /**
   * ���
   * @param snsloginVO
   * @return
   */
  public int create(SnsloginVO snsloginVO);
  
  /**
   * ���
   * @return
   */
  public List<SnsloginVO> list();

  /**
   * ��ȸ
   * @param snslogin_no
   * @return
   */
  public SnsloginVO read(int snslogin_no);
  
  /**
   * ����
   * @param snsloginVO
   * @return
   */
  public int update(SnsloginVO snsloginVO);
  
  /**
   * ����
   * @param snslogin_no
   * @return
   */
  public int delete(int snslogin_no);
}
