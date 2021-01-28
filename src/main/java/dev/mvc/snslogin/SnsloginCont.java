package dev.mvc.snslogin;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.auth.AuthVO;

@Controller
public class SnsloginCont {
  @Autowired
  @Qualifier("dev.mvc.snslogin.SnsloginProc")
  private SnsloginProcInter snsloginProc;

  public SnsloginCont() {
    System.out.println("--> SnsloginCont created");
  }
  
  /**
   * 목록 http://localhost:9090/team2/snslogin/list.do
   * @return
   */
  @RequestMapping(value = "/snslogin/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/snslogin/list");
    
    List<SnsloginVO> list = this.snsloginProc.list();
    mav.addObject("list", list);
    
    return mav;
  }
    
  /**
   * ajax기반 권한 등록처리 http://localhost:9090/team2/snslogin/create.do
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/create.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String create(SnsloginVO snsloginVO) {
    int cnt = this.snsloginProc.create(snsloginVO);
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
  

  /**
   * Ajax기반 조회 http://localhost:9090/team2/snslogin/read.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/read.do", method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public String read(int snslogin_no) {
    
    SnsloginVO snsloginVO = this.snsloginProc.read(snslogin_no);

    JSONObject json = new JSONObject();
    json.put("snslogin_no", snslogin_no);
    json.put("snslogin_name", snsloginVO.getSnslogin_name());

    return json.toString();
  }

  /**
   * Ajax 기반 수정 처리
   * 
   * @param SnsloginVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/update.do", method = RequestMethod.POST,
                produces = "text/plain;charset=UTF-8")
  public String update(SnsloginVO snsloginVO) {
    int cnt = this.snsloginProc.update(snsloginVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }

  /**
   * Ajax 기반 삭제 처리
   * @param snslogin_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/delete.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String delete(int snslogin_no) {
    int cnt = this.snsloginProc.delete(snslogin_no);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
}
