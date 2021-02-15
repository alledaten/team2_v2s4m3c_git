package dev.mvc.event;

import java.util.HashMap;
import java.util.List;

public interface EventDAOInter {
  
   /**
   * �̺�Ʈ ���
   * @param eventVO
   * @return
   */
  public int create(EventVO eventVO);
  
  /**
   * �̺�Ʈ �׷캰 �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
   /**
   * Ư�� �̺�Ʈ �׷쿡 ��ϵ� �̺�Ʈ ��� + �˻� + ����¡
   * @return
   */
  public List<Event_AdminVO> list_by_event_grp_no_search_paging(HashMap<String, Object> map);

  /**
   * ��ȸ
   * @param event_no
   * @return
   */
  public EventVO read(int event_no);
  
   /**
   * ���� ó��
   * @param eventVO
   * @return
   */
  public int update(EventVO eventVO);
  
  /**
   * �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap<String, Object> hashMap);
  
   /**
   * ����
   * @param event_no
   * @return
   */
  public int delete(int event_no);
  

   /**
   * �̹��� ����
   * @param eventVO
   * @return
   */
  public int img_update(EventVO eventVO);
  
   /**
   * ��ȸ�� ����
   * @param event_no
   * @return
   */
  public int update_event_view(int event_no);
  
  
}
