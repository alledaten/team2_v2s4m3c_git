package dev.mvc.snslogin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.snslogin.SnsloginProc")
public class SnsloginProc implements SnsloginProcInter {

  @Autowired
  private SnsloginDAOInter snsloginDAO; 
  
  public SnsloginProc() {
    System.out.println("--> SnsloginProc created");
  }

  @Override
  public int create(SnsloginVO snsloginVO) {
    int cnt = this.snsloginDAO.create(snsloginVO);
    return cnt;
  }
  
  @Override
  public List<SnsloginVO> list() {
    List<SnsloginVO> list = this.snsloginDAO.list();
    return list;
  }

  @Override
  public SnsloginVO read(int snslogin_no) {
    SnsloginVO snsloginVO = this.snsloginDAO.read(snslogin_no);
    return snsloginVO;
  }

  @Override
  public int update(SnsloginVO snsloginVO) {
    int cnt = this.snsloginDAO.update(snsloginVO);
    return cnt;
  }

  @Override
  public int delete(int snslogin_no) {
    int cnt = this.snsloginDAO.delete(snslogin_no);
    return cnt;
  }

}
