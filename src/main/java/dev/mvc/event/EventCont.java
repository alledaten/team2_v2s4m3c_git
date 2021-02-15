package dev.mvc.event;

import java.util.HashMap;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.event_attachfile.Event_AttachfileProcInter;
import dev.mvc.event_attachfile.Event_AttachfileVO;
import dev.mvc.event_grp.Event_GrpProcInter;
import dev.mvc.event_grp.Event_GrpVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class EventCont {
  @Autowired
  @Qualifier("dev.mvc.event.EventProc")
  private EventProcInter eventProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.event_grp.Event_GrpProc")
  private Event_GrpProcInter event_grpProc;
  
  @Autowired
  @Qualifier("dev.mvc.event_attachfile.Event_AttachfileProc")
  private Event_AttachfileProcInter event_attachfileProc;
  
   /**
   * ����� http://localhost:9090/team2/event/create.do
   * @return
   */
  @RequestMapping(value = "/event/create.do", method = RequestMethod.GET)
  public ModelAndView create(int event_grp_no) {
    ModelAndView mav = new ModelAndView();

    Event_GrpVO event_grpVO = this.event_grpProc.read(event_grp_no);
    mav.addObject("event_grpVO", event_grpVO);
    
    mav.setViewName("/event/create");

    return mav; // forward
  }
  
   /**
   * ��� ó�� http://localhost:9090/team2/event/create.do?event_grp_no=1
   * 
   * @return
   */
  @RequestMapping(value = "/event/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    
    mav.addObject("event_grpVO", event_grpVO);
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String event_file = ""; // main image
    String event_thumb = ""; // preview image

    String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // ���� ���

    // ���� ������ ����� fnamesMF ��ü�� ������.
    // <input type='file' class="form-control" name='file1MF' id='file1MF'
    // value='' placeholder="���� ����" multiple="multiple">
    MultipartFile mf = eventVO.getEvent_fileMF();

    long event_size = mf.getSize(); // ���� ũ��
    if (event_size > 0) { // ���� ũ�� üũ
      // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
      // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
      event_file = Upload.saveFileSpring(mf, upDir);

      if (Tool.isImage(event_file)) { // �̹������� �˻�
        // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
        event_thumb = Tool.preview(upDir, event_file, 200, 150);
      }

    }

    eventVO.setEvent_file(event_file);
    eventVO.setEvent_thumb(event_thumb);
    eventVO.setEvent_size(event_size);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    int cnt = this.eventProc.create(eventVO); 
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    // -------------------------------------------------------------------
    // PK�� return
    // -------------------------------------------------------------------
    mav.addObject("event_no", eventVO.getEvent_no()); // redirect parameter ����
    mav.addObject("event_grp_no", eventVO.getEvent_grp_no()); // redirect parameter ����
    // -------------------------------------------------------------------

    // mav.setViewName("/event/create_msg");
    mav.setViewName("redirect:/event/list.do?event_grp_no=" + eventVO.getEvent_grp_no());  // ��� ������ ��!

    return mav; // forward
  }
  
   /**
   * ��� + �˻� + ����¡ ����
   * http://localhost:9090/team2/event/list.do?event_grp_no=1&event_word=&nowPage=
   * @param event_grp_no
   * @param event_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/event/list.do", method = RequestMethod.GET)
  public ModelAndView list_by_event_grp_no_search_paging(
      @RequestParam(value="event_grp_no", defaultValue="1") int event_grp_no,
      @RequestParam(value="event_word", defaultValue="") String event_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    
    ModelAndView mav = new ModelAndView();
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("event_grp_no", event_grp_no); // #{event_grp_no}
    map.put("event_word", event_word);     // #{word}
    map.put("nowPage", nowPage);  // �������� ����� ���ڵ��� ������ �����ϱ����� ���     
    
    
    // �˻� ���
    List<Event_AdminVO> list = eventProc.list_by_event_grp_no_search_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = eventProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Event_GrpVO event_grpVO = event_grpProc.read(event_grp_no);
    mav.addObject("event_grpVO", event_grpVO);

     /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * @param listFile ��� ���ϸ� 
     * @param event_grp_no �̺�Ʈ �׷�
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param event_word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = eventProc.pagingBox("list.do", event_grp_no, search_count, nowPage, event_word);
    
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
    mav.setViewName("/event/list_by_event_grp_no_search_paging");   
    
    return mav;
  } 
  
   /**
   * ��ȸ
   * http://localhost:9090/team2/event/read.do?event_no=1&event_word=&nowPage=
   * @return
   */
  @RequestMapping(value = "/event/read.do", method = RequestMethod.GET)
  public ModelAndView read(int event_no) {
    ModelAndView mav = new ModelAndView();

    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);
    
    int event_view = this.eventProc.update_event_view(event_no);
    mav.addObject("event_view", event_view); // request�� ����
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    List<Event_AttachfileVO> event_attachfile_list = this.event_attachfileProc.list_by_event_no(event_no);
    mav.addObject("event_attachfile_list", event_attachfile_list);

    mav.setViewName("/event/read"); // webapp/event/read.jsp
    return mav;
  }
  
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/event/update.do", method=RequestMethod.GET )
  public ModelAndView update(int event_no) {
    ModelAndView mav = new ModelAndView();
    
    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);

    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);

    mav.setViewName("/event/update"); // webapp/event/update.jsp
    
    return mav;
  }
  
   /**
   * ���� ó��
   * @param contentsVO
   * @return
   */
  @RequestMapping(value="/event/update.do", method = RequestMethod.POST )
  public ModelAndView update(EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grp_title", event_grpVO.getEvent_grp_title());
    
    mav.addObject("event_no", eventVO.getEvent_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", eventVO.getEvent_no());
    hashMap.put("event_passwd", eventVO.getEvent_passwd());
    
    int passwd_cnt = 0;   // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      cnt = this.eventProc.update(eventVO);
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
        
    mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
    
    return mav;
  }
  
  /** 
   * ������
   * @param event_no
   * @return
   */
  @RequestMapping(value = "/event/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int event_no) {
    ModelAndView mav = new ModelAndView();
    
    EventVO eventVO = this.eventProc.read_update(event_no);
    mav.addObject("eventVO", eventVO);
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    mav.setViewName("/event/delete");
    return mav;
  }
  
  /**
   * ���� ó�� + ���� ����
   * @param request
   * @param event_no
   * @param event_passwd
   * @param event_passwd
   * @param event_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/event/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, int event_no, int event_grp_no, String event_passwd, 
      @RequestParam(value = "event_word", defaultValue = "") String event_word,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    EventVO eventVO = this.eventProc.read(event_no);
    String event_title = eventVO.getEvent_title();
    mav.addObject("event_title", event_title);

    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", event_no);
    hashMap.put("event_passwd", event_passwd);

    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0; // ������ ���ڵ� ����

    passwd_cnt = this.eventProc.passwd_check(hashMap);
    boolean sw = false;

    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      cnt = this.eventProc.delete(event_no);


        // -------------------------------------------------------------------------------------
        // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("event_grp_no", event_grp_no);
        map.put("event_word", event_word);
        // �ϳ��� �������� 3���� ���ڵ�� �����Ǵ� ��� ���� 9���� ���ڵ尡 ���� ������
        if (eventProc.search_count(map) % Event.RECORD_PER_PAGE == 0) {
          nowPage = nowPage - 1;
          if (nowPage < 1) {
            nowPage = 1; // ���� ������
          }
        }
        // -------------------------------------------------------------------------------------
      

      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, eventVO.getEvent_file()); // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, eventVO.getEvent_thumb()); // Folder���� 1���� ���� ����

    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
    mav.addObject("nowPage", nowPage); // request�� ����
    // System.out.println("--> ContentsCont.java nowPage: " + nowPage);

    mav.addObject("event_grp_no", eventVO.getEvent_grp_no()); // redirect parameter ����
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter ����

    mav.setViewName("redirect:/event/delete_msg.jsp");

    return mav;
  }
  
  /////////////////////////////////////////////////////////////////////////////////
  /////////// ------------ �̹��� ���� ����  ------------- ///////////////
  /////////////////////////////////////////////////////////////////////////////////
  
   /**
   * ���� �̹��� ��� �� 
   * http://localhost:9090/team2/event/img_create.do
   * @return
   */
  @RequestMapping(value = "/event/img_create.do", method = RequestMethod.GET)
  public ModelAndView img_create(int event_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event/img_create"); // /webapp/event/img_create.jsp
    
    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);

    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    return mav; // forward
  }
  
   /**
   * ���� �̹��� ��� ó�� 
   * http://localhost:9090/team2/event/img_create.do
   * @return
   */
  @RequestMapping(value = "/event/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", eventVO.getEvent_no());
    hashMap.put("event_passwd", eventVO.getEvent_passwd());
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      String event_file = "";     // main image
      String event_thumb = ""; // preview image
          
      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // ���� ���
      // ���� ������ ����� fnamesMF ��ü�� ������.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="���� ����" multiple="multiple">
      MultipartFile mf = eventVO.getEvent_fileMF();
      long event_size = mf.getSize(); // ���� ũ��
      if (event_size > 0) { // ���� ũ�� üũ
        // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
        // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
        event_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(event_file)) { // �̹������� �˻�
          // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
          event_thumb = Tool.preview(upDir, event_file, 200, 150); 
        }
      }    
      
      eventVO.setEvent_file(event_file);
      eventVO.setEvent_thumb(event_thumb);
      eventVO.setEvent_size(event_size);
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/event/read.do?event_no=" + eventVO.getEvent_no());
      
      cnt = this.eventProc.img_create(eventVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
  
  /**
   * ���� �̹��� ���� �� ���� �� http://localhost:9090/team2/event/img_update.do
   * @return
   */
  @RequestMapping(value = "/event/img_update.do", method = RequestMethod.GET)
  public ModelAndView img_update(int event_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event/img_update"); // /webapp/event/img_update.jsp

    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);

    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    return mav; // forward
  }
  
  /**
   * ���� �̹��� ���� ó�� http://localhost:9090/team2/event/img_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/event/img_delete.do", method = RequestMethod.POST)
  public ModelAndView img_delete(HttpServletRequest request,
                                                 int event_no, int event_grp_no, String event_passwd) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", event_no);
    hashMap.put("event_passwd", event_passwd);
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      EventVO eventVO = eventProc.read(event_no);

      String event_file = eventVO.getEvent_file().trim();
      String event_thumb = eventVO.getEvent_thumb().trim();
      long event_size = eventVO.getEvent_size();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, eventVO.getEvent_file());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, eventVO.getEvent_thumb());  // Folder���� 1���� ���� ����
      
      event_file = "";
      event_thumb = "";
      event_size = 0;
      
      eventVO.setEvent_file(event_file);
      eventVO.setEvent_thumb(event_thumb);
      eventVO.setEvent_size(event_size);
      // -------------------------------------------------------------------
      // ���� ���� ���� ����
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/event/read.do?event_no=" + event_no);
      
      cnt = this.eventProc.img_delete(eventVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
  
   /**
   * ���� �̹��� ���� ó�� 
   * http://localhost:9090/team2/event/img_update.do
   * ���� �̹��� ������ ���ο� �̹��� ���(���� ó��)
   * @return
   */
  @RequestMapping(value = "/event/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", eventVO.getEvent_no());
    hashMap.put("event_passwd", eventVO.getEvent_passwd());

    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      EventVO  vo = eventProc.read(eventVO.getEvent_no());
      
      String event_file  = vo.getEvent_file().trim();
      String event_thumb  = vo.getEvent_thumb().trim();
      long event_size = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, eventVO.getEvent_file());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, eventVO.getEvent_thumb());  // Folder���� 1���� ���� ����
      // -------------------------------------------------------------------
      // ���� ���� ���� ����
      // -------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ���� ������ ����� fnamesMF ��ü�� ������.
      // <input type='event_file' class="form-control" name='event_fileMF' id='event_fileMF' 
      //           value='' placeholder="���� ����" multiple="multiple">
      MultipartFile mf = eventVO.getEvent_fileMF();
      event_size = mf.getSize();  // ���� ũ��
      if (event_size > 0) { // ���� ũ�� üũ
        // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
        // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
        event_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(event_file)) { // �̹������� �˻�
          // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
          event_thumb = Tool.preview(upDir, event_file, 200, 150); 
        }
      }    
      
      eventVO.setEvent_file(event_file);
      eventVO.setEvent_thumb(event_thumb);
      eventVO.setEvent_size(event_size);
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------

      mav.setViewName("redirect:/event/read.do?event_no=" + eventVO.getEvent_no());
      
      cnt = this.eventProc.img_create(eventVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
  
  ////////////////////////////////// �̹��� ���� �ڵ� ���� ////////////////////////////////////////////////
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

}
