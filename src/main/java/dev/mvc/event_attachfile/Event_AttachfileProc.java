package dev.mvc.event_attachfile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.event_attachfile.Event_AttachfileProc")
public class Event_AttachfileProc implements Event_AttachfileProcInter {
  @Autowired
  private Event_AttachfileDAOInter event_attachfileDAO;
  
  @Override
  public int create(Event_AttachfileVO event_attachfileVO) {
    int cnt = this.event_attachfileDAO.create(event_attachfileVO);
    return cnt;
  }
  
  @Override
  public List<Event_AttachfileVO> list() {
    List<Event_AttachfileVO> list = this.event_attachfileDAO.list();
    return list;
  }
  
  @Override
  public Event_AttachfileVO read(int event_attachfile_no) {
    Event_AttachfileVO event_attachfileVO = this.event_attachfileDAO.read(event_attachfile_no);
    return event_attachfileVO;
  }

   /**
   * 첨부 파일 목록, 파일 용량 단위 출력
   */
  @Override
  public List<Event_AttachfileVO> list_by_event_no(int event_no) {
    List<Event_AttachfileVO> list = event_attachfileDAO.list_by_event_no(event_no);
    for (Event_AttachfileVO event_attachfileVO : list) {
      long event_attachfile_size = event_attachfileVO.getEvent_attachfile_size();
      String rlabel = Tool.unit(event_attachfile_size);  // 파일 단위 적용
      event_attachfileVO.setRlabel(rlabel);
    }
    return list;
  }
  
  /**
   * 삭제
   */
  @Override
  public int delete(int event_attachfile_no) {
    int cnt = this.event_attachfileDAO.delete(event_attachfile_no);
    return cnt;
    
  }
  
   /**
   * FK별 전체 삭제
   */
  @Override
  public int delete_by_event_no(int event_no) {
    int cnt = this.event_attachfileDAO.delete_by_event_no(event_no);
    return cnt;
  }
  
  /**
   * FK별 갯수
   */
  @Override
  public int count_by_event_no(int event_no) {
    int cnt = this.event_attachfileDAO.count_by_event_no(event_no);
    return cnt;
  }

}
