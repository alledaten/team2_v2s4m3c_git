package dev.mvc.event_grp;

import java.util.List;

public interface Event_GrpDAOInter {
  
   /**
   * 이벤트 등록
   * @param event_GrpVO
   * @return
   */
  public int create(Event_GrpVO event_GrpVO);
  
   /**
   * 이벤트 번호에 따른 목록(PK)
   * @return
   */
  public List<Event_GrpVO> list_event_grp_no();
  
  /**
   * 이벤트 그룹 출력순서에 따른 목록(Col)
   * @return
   */
  public List<Event_GrpVO> list_by_event_grp_seqno();
  
  /**
   * 조회
   * @param event_grp_no
   * @return
   */
  public Event_GrpVO read(int event_grp_no);
  
  /**
   * 수정
   * @param event_GrpVO
   * @return
   */
  public int update(Event_GrpVO event_GrpVO);
  
  /**
   * 삭제
   * @param event_grp_no
   * @return
   */
  public int delete(int event_grp_no);
  
   /**
   * 출력 순서 상향
   * @param event_grp_no
   * @return
   */
  public int update_event_grp_seqno_up(int event_grp_no);
  
   /**
   * 출력 순서 하향
   * @param event_grp_no
   * @return
   */
  public int update_event_grp_seqno_down(int event_grp_no);
  

}
