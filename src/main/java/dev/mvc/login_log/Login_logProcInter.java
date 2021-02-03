package dev.mvc.login_log;

import java.util.List;

public interface Login_logProcInter {
  
  /**
   * ���
   * @param login_logVO
   * @return
   */
  public int create(Login_logVO login_logVO);
  
  /**
   * ���
   * @param member_no
   * @return
   */
  public List<Login_logVO> list(int member_no);

  /**
   * ��ȸ
   * @param login_log_no
   * @return
   */
  public Login_logVO read(int login_log_no);
  
  /**
   * ����
   * @param login_log_no
   * @return
   */
  public int delete(int login_log_no);
}
