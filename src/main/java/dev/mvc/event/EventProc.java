package dev.mvc.event;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import dev.mvc.tool.Tool;

@Component("dev.mvc.event.EventProc")
public class EventProc implements EventProcInter{
  @Autowired
  private EventDAOInter eventDAO;
  
  @Override
  public int create(EventVO eventVO) {
    int cnt = this.eventDAO.create(eventVO);
    return cnt;
  }
  
  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int count = eventDAO.search_count(hashMap);
    return count;
  }
  
  @Override
  public List<Event_AdminVO> list_by_event_grp_no_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������ ���� rownum: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������ ���� rownum: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������ ���� rownum: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)map.get("nowPage") - 1) * Event.RECORD_PER_PAGE;
   
    // ���� rownum ����
    // 1 ������ = 0 + 1, 2 ������ = 10 + 1, 3 ������ = 20 + 1 
    int startNum = beginOfPage + 1;
    
    //  ���� rownum
    // 1 ������ = 0 + 10, 2 ������ = 0 + 20, 3 ������ = 0 + 30
    int endNum = beginOfPage + Event.RECORD_PER_PAGE;   
    /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
   
    List<Event_AdminVO> list = this.eventDAO.list_by_event_grp_no_search_paging(map);
    
    return list;
  }
  
  @Override
  public String pagingBox(String listFile, int event_grp_no, int search_count, int nowPage, String event_word) { 
    int totalPage = (int)(Math.ceil((double)search_count/Event.RECORD_PER_PAGE)); // ��ü ������  
    
    int totalGrp = (int)(Math.ceil((double)totalPage/Event.PAGE_PER_BLOCK));// ��ü �׷� 
    
    int nowGrp = (int)(Math.ceil((double)nowPage/Event.PAGE_PER_BLOCK));    // ���� �׷� 
    
    int startPage = ((nowGrp - 1) * Event.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    
    int endPage = (nowGrp * Event.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page)
    // nowGrp: 2 (11 ~ 20 page)
    // nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� ������ ������ 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� ������ ������ 20
    int _nowPage = (nowGrp-1) * Event.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&event_word="+event_word+"&nowPage="+_nowPage+"&event_grp_no="+event_grp_no+"'>����</A></span>"); 
    } 
 
    // �߾��� ������ ���
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ // ������ �������� �Ѿ�ٸ� ���� ��� ����
        break; 
      } 
  
      if (nowPage == i){ // �������� ������������ ���ٸ� CSS ����(������ ��)
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� �������� �̵��� �����ϵ��� ��ũ�� ����
        str.append("<span class='span_box_1'><A href='"+listFile+"?event_word="+event_word+"&nowPage="+i+"&event_grp_no="+event_grp_no+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� ���������� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� ���������� 21
    _nowPage = (nowGrp * Event.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&event_word="+event_word+"&nowPage="+_nowPage+"&event_grp_no="+event_grp_no+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
   /**
   * 1�� ��ȸ
   */
  @Override
  public EventVO read(int event_no) {
    EventVO eventVO = this.eventDAO.read(event_no);
    
    String event_title = eventVO.getEvent_title();
    event_title = Tool.convertChar(event_title);  // Ư�� ���� ó��
    eventVO.setEvent_title(event_title);
       
    long event_size = eventVO.getEvent_size();
    eventVO.setEvent_size_label(Tool.unit(event_size));
    
    return eventVO;
  }
  
   /**
   * ������ ��ȸ
   */
  @Override
  public EventVO read_update(int event_no) {
    EventVO eventVO = this.eventDAO.read(event_no);
    return eventVO;
  }
  
   /**
   * ���� ó��
   */
  @Override
  public int update(EventVO eventVO) {
    int cnt = this.eventDAO.update(eventVO);
    return cnt;
  }
  
  //���� 
 @Override
 public int delete(int event_no) {
   int cnt = this.eventDAO.delete(event_no);
   return cnt;
 }
  
 /**
  * �н����� üũ
  */
 @Override
 public int passwd_check(HashMap<String, Object> hashMap) {
   int passwd_cnt = this.eventDAO.passwd_check(hashMap);
   return passwd_cnt;
 }
 
 @Override
 public int img_create(EventVO eventVO) {
   int cnt = this.eventDAO.img_update(eventVO);
   return cnt;
 }

 @Override
 public int img_update(EventVO eventVO) {
   int cnt = this.eventDAO.img_update(eventVO);
   return cnt;
 }
 
 @Override
 public int img_delete(EventVO eventVO) {
   int cnt = this.eventDAO.img_update(eventVO);
   return cnt;
 }
 
 @Override
 public int update_event_view(int event_no) {
   int cnt = this.eventDAO.update_event_view(event_no);
   return cnt;
 }

}
