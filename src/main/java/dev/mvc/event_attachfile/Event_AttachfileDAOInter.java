package dev.mvc.event_attachfile;

import java.util.List;

public interface Event_AttachfileDAOInter {
  
  /**
   * ���� ���  
   * @param Event_AttachfileVO
   * @return
   */
  public int create(Event_AttachfileVO event_attachfileVO);
  
   /**
   * ��ü �̹��� ���
   * @return
   */
  public List<Event_AttachfileVO> list();
  
   /**
   * ��ȸ
   * @param event_attachfile_no
   * @return
   */
  public Event_AttachfileVO read(int event_attachfile_no);
  
   /**
   * event_no�� ���� ���� ���
   * @param event_no
   * @return
   */
  public List<Event_AttachfileVO> list_by_event_no(int event_no);
  
   /**
   * ����
   * @param event_attachfile_no
   * @return
   */
  public int delete(int event_attachfile_no);
  
   /**
   * event_no�� ����
   * @param event_no
   * @return
   */
  public int delete_by_event_no(int event_no);
  
   /**
   * event_no�� ī��Ʈ
   * @param event_no
   * @return
   */
  public int count_by_event_no(int event_no);

  

}
