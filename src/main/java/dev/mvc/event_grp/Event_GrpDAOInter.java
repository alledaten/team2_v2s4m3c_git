package dev.mvc.event_grp;

import java.util.List;

public interface Event_GrpDAOInter {
  
   /**
   * �̺�Ʈ ���
   * @param event_GrpVO
   * @return
   */
  public int create(Event_GrpVO event_GrpVO);
  
   /**
   * �̺�Ʈ ��ȣ�� ���� ���(PK)
   * @return
   */
  public List<Event_GrpVO> list_event_grp_no();
  
  /**
   * �̺�Ʈ �׷� ��¼����� ���� ���(Col)
   * @return
   */
  public List<Event_GrpVO> list_by_event_grp_seqno();
  
  /**
   * ��ȸ
   * @param event_grp_no
   * @return
   */
  public Event_GrpVO read(int event_grp_no);
  
  /**
   * ����
   * @param event_GrpVO
   * @return
   */
  public int update(Event_GrpVO event_GrpVO);
  
  /**
   * ����
   * @param event_grp_no
   * @return
   */
  public int delete(int event_grp_no);
  
   /**
   * ��� ���� ����
   * @param event_grp_no
   * @return
   */
  public int update_event_grp_seqno_up(int event_grp_no);
  
   /**
   * ��� ���� ����
   * @param event_grp_no
   * @return
   */
  public int update_event_grp_seqno_down(int event_grp_no);
  

}
