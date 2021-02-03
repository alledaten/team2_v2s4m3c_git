package dev.mvc.admin_log;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.admin_log.Admin_logProc")
public class Admin_logProc implements Admin_logProcInter {
  @Autowired
  private Admin_logDAOInter admin_logDAO;
  
  public Admin_logProc() {
    System.out.println("--> Admin_logProc created");
  }
  
  @Override
  public int create(Admin_logVO admin_logVO) {
    int cnt = this.admin_logDAO.create(admin_logVO); 
    return cnt;
  }

  @Override
  public Admin_logVO read(int admin_log_no) {
    Admin_logVO admin_logVO = this.admin_logDAO.read(admin_log_no);
    return admin_logVO;
  }

  @Override
  public List<Admin_logVO> list(int admin_no) {
    List<Admin_logVO> list = this.admin_logDAO.list(admin_no);
    return list;
  }

  @Override
  public int delete(int admin_log_no) {
    int cnt = this.admin_logDAO.delete(admin_log_no);
    return cnt;
  }

}
