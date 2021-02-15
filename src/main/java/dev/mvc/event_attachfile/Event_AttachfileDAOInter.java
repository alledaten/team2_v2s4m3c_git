package dev.mvc.event_attachfile;

import java.util.List;

public interface Event_AttachfileDAOInter {
  
  /**
   * 파일 등록  
   * @param Event_AttachfileVO
   * @return
   */
  public int create(Event_AttachfileVO event_attachfileVO);
  
   /**
   * 전체 이미지 목록
   * @return
   */
  public List<Event_AttachfileVO> list();
  
   /**
   * 조회
   * @param event_attachfile_no
   * @return
   */
  public Event_AttachfileVO read(int event_attachfile_no);
  
   /**
   * event_no에 따른 파일 목록
   * @param event_no
   * @return
   */
  public List<Event_AttachfileVO> list_by_event_no(int event_no);
  
   /**
   * 삭제
   * @param event_attachfile_no
   * @return
   */
  public int delete(int event_attachfile_no);
  
   /**
   * event_no별 삭제
   * @param event_no
   * @return
   */
  public int delete_by_event_no(int event_no);
  
   /**
   * event_no별 카운트
   * @param event_no
   * @return
   */
  public int count_by_event_no(int event_no);

  

}
