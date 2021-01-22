package dev.mvc.review_categrp;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class Review_CategrpCont {
  @Autowired
  @Qualifier("dev.mvc.review_categrp.Review_CategrpProc")
  private Review_CategrpProcInter review_CategrpProc;
  
   /** 
   * http://localhost:9090/team2/review_categrp/create.do
   * 등록폼
   * @return
   */
  @RequestMapping(value = "/review_categrp/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review_categrp/create");
    
    return mav;
  }
  
   /**
   * 등록 처리
   * @param review_CategrpVO
   * @return
   */
  @RequestMapping(value = "/review_categrp/create.do", method = RequestMethod.POST)
  public ModelAndView create(Review_CategrpVO review_CategrpVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CategrpProc.create(review_CategrpVO);
    
    if (cnt == 0) {
      mav.addObject("cnt", cnt);
      mav.addObject("url", "create_msg");
      mav.setViewName("redirect:/review_categrp/msg.do");
    } else {
      mav.setViewName("redirect:/review_categrp/list.do");
    }
    
    return mav;
  }
  
   /**
   * Ajax + create
   * @param review_CategrpVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_categrp/create_ajax.do", method = RequestMethod.POST, 
                          produces = "text/plain;charset=UTF-8")
  public String create_ajax(Review_CategrpVO review_CategrpVO) {

    try {
      Thread.sleep(2000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.review_CategrpProc.create(review_CategrpVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
  
   /**
   * 리뷰 카테고리 번호순 목록
   * @return
   */
  @RequestMapping(value = "/review_categrp/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<Review_CategrpVO> list = this.review_CategrpProc.list_review_categrp_seqno();
    // List<Review_CategrpVO> list = this.review_CategrpProc.list_review_categrp_no_asc();          //  seqno 추가시 주석처리 후 위 코드 사용할 것
    mav.addObject("list", list);
    
    mav.setViewName("/review_categrp/list_ajax");     
    // mav.setViewName("/review_categrp/list");                                                              //  seqno 추가시 주석처리 후 위 코드 사용할 것
    
    return mav;
  }
  
   /**
   * read
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_categrp/read.do", method = RequestMethod.GET)
  public ModelAndView read(int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review_categrp/read");
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_categrp_no);
    mav.addObject("review_CategrpVO", review_CategrpVO);
   
    List<Review_CategrpVO> list = this.review_CategrpProc.list_review_categrp_seqno(); // 여기도 seqno 추가시 변경할 것
    mav.addObject("list", list);
    
    return mav;
  }
  
   /**
   * Ajax + read
   * @param review_categrp_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_categrp/read_ajax.do", method = RequestMethod.GET,
                          produces = "text/plain;charset=UTF-8")
  public String read_ajax(int review_categrp_no) {
    
    try {
      Thread.sleep(2000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_categrp_no);
    
    JSONObject json = new JSONObject();
    json.put("review_categrp_no", review_categrp_no);
    json.put("review_categrp_name", review_CategrpVO.getReview_categrp_name());
    json.put("review_categrp_seqno", review_CategrpVO.getReview_categrp_seqno());
    
    return json.toString();
  }
  
   /**
   * 수정폼
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_categrp/update.do", method = RequestMethod.GET)
  public ModelAndView update(int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/review_categrp/update");
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_categrp_no);
    mav.addObject("review_CategrpVO", review_CategrpVO);

    return mav;
  }
  
   /**
   * 수정 처리
   * @param review_CategrpVO
   * @return
   */
  @RequestMapping(value = "/review_categrp/update.do", method = RequestMethod.POST)
  public ModelAndView update(Review_CategrpVO review_CategrpVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CategrpProc.update(review_CategrpVO);
    mav.addObject("cnt", cnt);
    
    
    mav.setViewName("/review_categrp/update_msg");
    
    return mav;
  }
  
   /**
   * Ajax + update_proc
   * @param review_CategrpVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_categrp/update_ajax.do", method = RequestMethod.POST, 
                          produces = "text/plain;charset=UTF-8") 
  public String update_ajax(Review_CategrpVO review_CategrpVO) {
    
    try {
      Thread.sleep(2000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    int cnt = this.review_CategrpProc.update(review_CategrpVO);
    
    JSONObject json = new JSONObject(); 
    json.put("cnt", cnt);

    return json.toString();
  }
   
   /**
   * 삭제폼
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_categrp/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review_categrp/delete");
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_categrp_no);
    mav.addObject("review_CategrpVO", review_CategrpVO);
    
    return mav;
  }
   
  /**
   * 삭제 처리
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_categrp/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CategrpProc.delete(review_categrp_no);
    mav.addObject("cnt", cnt);
    
    mav.setViewName("/review_categrp/delete_msg");
    
    return mav;
  }
  
   /**
   * delete + ajax
   * @param review_categrp_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_categrp/delete_ajax.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8") 
  public String delete_ajax(int review_categrp_no) {
    
    try {
      Thread.sleep(2000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.review_CategrpProc.delete(review_categrp_no);
    
    JSONObject json = new JSONObject();

    json.put("cnt", cnt);

    return json.toString();
  }
  
   /**
   * 우선순위 상향
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_categrp/update_review_categrp_seqno_up.do", method = RequestMethod.GET)
  public ModelAndView update_review_categrp_seqno_up(int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CategrpProc.update_review_categrp_seqno_up(review_categrp_no);
    mav.addObject("cnt", cnt);
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_categrp_no);
    mav.addObject("review_CategrpVO", review_CategrpVO);
    
    mav.setViewName("redirect:/review_categrp/list.do");
    
    return mav;
  }
  
   /**
   * 우선순위 하향
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_categrp/update_review_categrp_seqno_down.do", method = RequestMethod.GET)
  public ModelAndView update_review_categrp_seqno_down(int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CategrpProc.update_review_categrp_seqno_down(review_categrp_no);
    mav.addObject("cnt", cnt);
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_categrp_no);
    mav.addObject("review_CategrpVO", review_CategrpVO);
    
    mav.setViewName("redirect:/review_categrp/list.do");
    
    return mav;
  }
  
   /**
   * 새로고침을 방지하는 메시지 출력
   * @param url
   * @return
   */
  @RequestMapping(value = "/review_categrp/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/review_categrp/" + url);
    
    return mav;
  }

}
