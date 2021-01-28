package dev.mvc.memberlevel;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.memberlevel.MemberlevelProc")
public class MemberlevelProc implements MemberlevelProcInter {
  @Autowired
  private MemberlevelDAOInter memberlevelDAO;

  public MemberlevelProc() {
    System.out.println("--> MemberlevelProc created");
  }
  
  @Override
  public List<MemberlevelVO> list() {
    List<MemberlevelVO> list = this.memberlevelDAO.list();
    return list;
  }

  @Override
  public int create(MemberlevelVO memberlevelVO) {
    int cnt = this.memberlevelDAO.create(memberlevelVO);
    return cnt;
  }

  @Override
  public MemberlevelVO read(int memberlevel_no) {
    MemberlevelVO memberlevelVO = this.memberlevelDAO.read(memberlevel_no);
    return memberlevelVO;
  }

  @Override
  public int update(MemberlevelVO memberlevelVO) {
    int cnt = this.memberlevelDAO.update(memberlevelVO);
    return cnt;
  }

  @Override
  public int delete(int memberlevel_no) {
    int cnt = this.memberlevelDAO.delete(memberlevel_no);
    return cnt;
  }

}
