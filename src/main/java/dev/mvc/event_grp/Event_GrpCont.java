package dev.mvc.event_grp;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;

@Controller
public class Event_GrpCont {
  @Autowired
  @Qualifier("dev.mvc.event_grp.Event_GrpProc")
  private Event_GrpProcInter event_grpProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") // 이름 지정
  private AdminProcInter adminProc;
  
   /** 
   * http://localhost:9090/team2/event_grp/create.do
   * 등록폼
   * @return
   */
  @RequestMapping(value = "/event_grp/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event_grp/create");
    return mav;
  }
  
  
   /**
   * Ajax + create
   * @param event_grpVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/event_grp/create_ajax.do", method = RequestMethod.POST, 
                          produces = "text/plain;charset=UTF-8")
  public String create_ajax(Event_GrpVO event_grpVO) {

    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.event_grpProc.create(event_grpVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
  
   /**
   * 상품 추천그룹 번호순 목록
   * @return
   */
  @RequestMapping(value = "/event_grp/list.do", method = RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView(); 
    mav.setViewName("/event_grp/list_ajax");     
    
    if (adminProc.isAdmin(session)) { // 관리자 로그인인 경우
      List<Event_GrpVO> list = this.event_grpProc.list_by_event_grp_seqno();
      
      mav.addObject("list", list);
      mav.setViewName("/event_grp/list_ajax"); 
    } else {
      mav.setViewName("/admin/login_need"); 
    }
    
    return mav;
  }
  
   /**
   * read
   * @param event_grp_no
   * @return
   */
  @RequestMapping(value = "/event_grp/read.do", method = RequestMethod.GET)
  public ModelAndView read(int event_grp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event_grp/read");
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(event_grp_no);
    mav.addObject("event_grpVO", event_grpVO);
   
    List<Event_GrpVO> list = this.event_grpProc.list_by_event_grp_seqno();
    mav.addObject("list", list);
    
    return mav;
  }
  
   /**
   * Ajax + read
   * @param event_grp_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/event_grp/read_ajax.do", method = RequestMethod.GET,
                          produces = "text/plain;charset=UTF-8")
  public String read_ajax(int event_grp_no) {
    
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(event_grp_no);
    
    JSONObject json = new JSONObject();
    json.put("event_grp_no", event_grp_no);
    json.put("event_grp_title", event_grpVO.getEvent_grp_title());
    json.put("event_grp_seqno", event_grpVO.getEvent_grp_seqno());
    
    return json.toString();
  }
  
   /**
   * 수정폼
   * @param event_grp_no
   * @return
   */
  @RequestMapping(value = "/event_grp/update.do", method = RequestMethod.GET)
  public ModelAndView update(int event_grp_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/event_grp/update");
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(event_grp_no);
    mav.addObject("event_grpVO", event_grpVO);

    return mav;
  }
  
   /**
   * 수정 처리
   * @param event_grpVO
   * @return
   */
  @RequestMapping(value = "/event_grp/update.do", method = RequestMethod.POST)
  public ModelAndView update(Event_GrpVO event_grpVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.event_grpProc.update(event_grpVO);
    mav.addObject("cnt", cnt);
    
    
    mav.setViewName("/event_grp/update_msg");
    
    return mav;
  }
  
   /**
   * Ajax + update_proc
   * @param event_grpVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/event_grp/update_ajax.do", method = RequestMethod.POST, 
                          produces = "text/plain;charset=UTF-8") 
  public String update_ajax(Event_GrpVO event_grpVO) {
    
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    int cnt = this.event_grpProc.update(event_grpVO);
    
    JSONObject json = new JSONObject(); 
    json.put("cnt", cnt);

    return json.toString();
  }
   
   /**
   * 삭제폼
   * @param event_grp_no
   * @return
   */
  @RequestMapping(value = "/event_grp/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int event_grp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event_grp/delete");
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(event_grp_no);
    mav.addObject("event_grpVO", event_grpVO);
    
    return mav;
  }
   
  /**
   * 삭제 처리
   * @param event_grp_no
   * @return
   */
  @RequestMapping(value = "/event_grp/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(int event_grp_no) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.event_grpProc.delete(event_grp_no);
    mav.addObject("cnt", cnt);
    
    mav.setViewName("/event_grp/delete_msg");
    
    return mav;
  }
  
   /**
   * delete + ajax
   * @param event_grp_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/event_grp/delete_ajax.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8") 
  public String delete_ajax(int event_grp_no) {
    
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.event_grpProc.delete(event_grp_no);
    
    JSONObject json = new JSONObject();

    json.put("cnt", cnt);

    return json.toString();
  }
  
   /**
   * 새로고침을 방지하는 메시지 출력
   * @param url
   * @return
   */
  @RequestMapping(value = "/event_grp/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/event_grp/" + url);
    
    return mav;
  }
  
   /**
   * 우선순위 상향 + ajax
   * @param event_grp_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/event_grp/update_event_grp_seqno_up_ajax.do", method = RequestMethod.POST)
  public String update_event_grp_seqno_up_ajax(int event_grp_no) {
    
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.event_grpProc.update_event_grp_seqno_up(event_grp_no);
    
    JSONObject json = new JSONObject();

    json.put("cnt", cnt);

    return json.toString();
  }
  
   /**
   * 우선순위 하향 + ajax
   * @param event_grp_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/event_grp/update_event_grp_seqno_down_ajax.do", method = RequestMethod.POST)
  public String update_event_grp_seqno_down_ajax(int event_grp_no) {
    
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.event_grpProc.update_event_grp_seqno_down(event_grp_no);
    
    JSONObject json = new JSONObject();

    json.put("cnt", cnt);

    return json.toString();

  }

}
