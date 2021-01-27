package dev.mvc.auth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.auth.AuthProc")
public class AuthProc implements AuthProcInter {

  @Autowired
  private AuthDAOInter authDAO;
  
  public AuthProc() {
    System.out.println("--> AuthProc created");
  }

  @Override
  public int create(AuthVO authVO) {
    int cnt = this.authDAO.create(authVO);
    return cnt;
  }

  @Override
  public List<AuthVO> list() {
    List<AuthVO> list = this.authDAO.list();
    return list;
  }

  @Override
  public AuthVO read(int auth_no) {
    AuthVO authVO = this.authDAO.read(auth_no);
    return authVO;
  }

  @Override
  public int update(AuthVO authVO) {
    int cnt = this.authDAO.update(authVO);
    return cnt;
  }

  @Override
  public int delete(int auth_no) {
    int cnt = this.authDAO.delete(auth_no);
    return cnt;
  }

}
