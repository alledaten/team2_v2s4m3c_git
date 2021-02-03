package dev.mvc.admin_log;

import java.util.List;

public interface Admin_logDAOInter {

  /**
   * ���
   * @param admin_logVO
   * @return
   */
  public int create(Admin_logVO admin_logVO);
  
  /**
   * ��ȸ
   * @param admin_log_no
   * @return
   */
  public Admin_logVO read(int admin_log_no);
  
  /**
   * ���
   * @param admin_no
   * @return
   */
  public List<Admin_logVO> list(int admin_no);
  
  /**
   * ����
   * @param admin_log_no
   * @return
   */
  public int delete(int admin_log_no);
}
