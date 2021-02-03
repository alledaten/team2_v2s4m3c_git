package dev.mvc.login_log;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.login_log.Login_logProc")
public class Login_logProc implements Login_logProcInter {
  @Autowired
  private Login_logDAOInter login_logDAO;

  public Login_logProc() {
    System.out.println("--> Login_logProc created");
  }
  
  @Override
  public int create(Login_logVO login_logVO) {
    int cnt = this.login_logDAO.create(login_logVO);
    return cnt;
  }

  @Override
  public List<Login_logVO> list(int member_no) {
    List<Login_logVO> list = this.login_logDAO.list(member_no);
    return list;
  }

  @Override
  public Login_logVO read(int login_log_no) {
    Login_logVO login_logVO = this.login_logDAO.read(login_log_no);
    return login_logVO;
  }
  
  @Override
  public int delete(int login_log_no) {
    int cnt = this.login_logDAO.delete(login_log_no);
    return cnt;
  }

}
