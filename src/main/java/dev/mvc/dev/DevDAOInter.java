package dev.mvc.dev;

import java.util.List;

public interface DevDAOInter {
  /**
   * ���
   * @param devVO
   * @return
   */
  public int create(DevVO devVO);

  /**
   * ���
   * @return
   */
  public List<DevVO> list_dev_desc();
  
  /**
   * ��ȸ
   * @param buy_no
   * @return
   */
  public DevVO read(int dev_no);
  
  /**
   * ����
   * @param devVO
   * @return
   */
  public int update(DevVO devVO);
  
  /**
   * ����
   * @param dev_no
   * @return
   */
  public int delete(int dev_no);
  
  
}
