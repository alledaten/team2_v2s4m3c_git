package dev.mvc.point;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


@Controller("dev.mvc.point.PointProc")
public class PointProc implements PointProcInter{
  @Autowired
  private PointDAOInter pointDAO;
  
  public PointProc() {
    System.out.println("--> PointProc created");
  }
  
  @Override
  public int create(PointVO pointVO) {
    int cnt = this.pointDAO.create(pointVO);
    return cnt;
  }

  @Override
  public List<PointVO> list_point_desc() {
    List<PointVO> list = this.pointDAO.list_point_desc();
    return list;
  }

  @Override
  public PointVO read(int point_no) {
    PointVO pointVO = this.pointDAO.read(point_no);
    return pointVO;
  }
  
  @Override
  public int update(PointVO pointVO) {
    int cnt = this.pointDAO.update(pointVO);
    return cnt;
  }
  
  @Override
  public int delete(int point_no) {
    int cnt = this.pointDAO.delete(point_no);
    return cnt;
  }

  @Override
  public PointVO read_point(int member_no) {
    PointVO pointVO = this.pointDAO.read(member_no);
    return pointVO;
  }

  
}
