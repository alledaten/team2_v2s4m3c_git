package dev.mvc.event;

import java.util.HashMap;
import java.util.List;

public interface EventDAOInter {
  
   /**
   * 이벤트 등록
   * @param eventVO
   * @return
   */
  public int create(EventVO eventVO);
  
  /**
   * 이벤트 그룹별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
   /**
   * 특정 이벤트 그룹에 등록된 이벤트 목록 + 검색 + 페이징
   * @return
   */
  public List<Event_AdminVO> list_by_event_grp_no_search_paging(HashMap<String, Object> map);

  /**
   * 조회
   * @param event_no
   * @return
   */
  public EventVO read(int event_no);
  
   /**
   * 수정 처리
   * @param eventVO
   * @return
   */
  public int update(EventVO eventVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap<String, Object> hashMap);
  
   /**
   * 삭제
   * @param event_no
   * @return
   */
  public int delete(int event_no);
  

   /**
   * 이미지 변경
   * @param eventVO
   * @return
   */
  public int img_update(EventVO eventVO);
  
   /**
   * 조회수 증가
   * @param event_no
   * @return
   */
  public int update_event_view(int event_no);
  
  
}
