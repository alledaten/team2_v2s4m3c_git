package dev.mvc.dev;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

@Controller("dev.mvc.dev.DevProc")
public class DevProc implements DevProcInter{
  @Autowired
  private DevDAOInter devDAO;
  
  public DevProc() {
    System.out.println("--> DevProc created");
  }

  @Override
  public int create(DevVO devVO) {
    int cnt = this.devDAO.create(devVO);
    return cnt;
  }

  @Override
  public List<DevVO> list_dev_desc() {
    List<DevVO> list = this.devDAO.list_dev_desc();
    return list;
  }

  @Override
  public DevVO read(int dev_no) {
    DevVO devVO = this.devDAO.read(dev_no);
    return devVO;
  }

  @Override
  public int update(DevVO devVO) {
    int cnt = this.devDAO.update(devVO);
    return cnt;
  }

  @Override
  public int delete(int dev_no) {
    int cnt = this.devDAO.delete(dev_no);
    return cnt;
  }

  
  
}
