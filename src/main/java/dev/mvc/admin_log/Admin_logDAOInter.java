package dev.mvc.admin_log;

import java.util.List;

public interface Admin_logDAOInter {

  /**
   * 등록
   * @param admin_logVO
   * @return
   */
  public int create(Admin_logVO admin_logVO);
  
  /**
   * 조회
   * @param admin_log_no
   * @return
   */
  public Admin_logVO read(int admin_log_no);
  
  /**
   * 목록
   * @param admin_no
   * @return
   */
  public List<Admin_logVO> list(int admin_no);
  
  /**
   * 삭제
   * @param admin_log_no
   * @return
   */
  public int delete(int admin_log_no);
}
