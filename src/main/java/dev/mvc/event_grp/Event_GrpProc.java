package dev.mvc.event_grp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.event_grp.Event_GrpProc") 
public class Event_GrpProc implements Event_GrpProcInter{
  @Autowired
  private Event_GrpDAOInter event_grpDAO;
  
  @Override
  public int create(Event_GrpVO event_GrpVO) {
    int cnt = this.event_grpDAO.create(event_GrpVO);
    return cnt;
  }
  
  @Override
  public List<Event_GrpVO> list_event_grp_no() {
    List<Event_GrpVO> list = this.event_grpDAO.list_event_grp_no();
    return list;
  }
  
  @Override
  public List<Event_GrpVO> list_by_event_grp_seqno() {
    List<Event_GrpVO> list = this.event_grpDAO.list_by_event_grp_seqno();
    return list; 
  }
  
  @Override
  public Event_GrpVO read(int event_grp_no) {
    Event_GrpVO event_grpVO = this.event_grpDAO.read(event_grp_no);
    return event_grpVO;
  }
  
  @Override
  public int update(Event_GrpVO event_GrpVO) {
    int cnt = this.event_grpDAO.update(event_GrpVO);
    return cnt;
  }
  
  @Override
  public int delete(int event_grp_no) {
    int cnt = this.event_grpDAO.delete(event_grp_no);
    return cnt; 
  }
  
  @Override
  public int update_event_grp_seqno_up(int event_grp_no) {
    int cnt = this.event_grpDAO.update_event_grp_seqno_up(event_grp_no);
    return cnt;
  }
  
  @Override
  public int update_event_grp_seqno_down(int event_grp_no) {
    int cnt = this.event_grpDAO.update_event_grp_seqno_down(event_grp_no);
    return cnt;
  }
  
  
}
