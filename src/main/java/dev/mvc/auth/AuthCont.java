package dev.mvc.auth;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class AuthCont {
  @Autowired
  @Qualifier("dev.mvc.auth.AuthProc")
  private AuthProcInter authProc;
  
  public AuthCont() {
    System.out.println("--> AuthCont created");
  }
  
  /**
   * 권한 등록 http://localhost:9090/team2/auth/create.do
   * @return
   */
  @RequestMapping(value = "/auth/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/auth/create");
    
    return mav;
  }
  
  /**
   * ajax기반 권한 등록처리 http://localhost:9090/team2/auth/create.do
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/auth/create.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String create(AuthVO authVO) {
    int cnt = this.authProc.create(authVO);
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
  
  /**
   * 목록 http://localhost:9090/team2/auth/list.do
   * @return
   */
  @RequestMapping(value = "/auth/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/auth/list");
    
    List<AuthVO> list = this.authProc.list();
    mav.addObject("list", list);
    
    return mav;
  }
  
  /**
   * Ajax기반 조회 http://localhost:9090/team2/auth/read.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/auth/read.do", method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public String read(int auth_no) {
    
    AuthVO authVO = this.authProc.read(auth_no);

    JSONObject json = new JSONObject();
    json.put("auth_no", auth_no);
    json.put("auth_content", authVO.getAuth_content());

    return json.toString();
  }

  /**
   * Ajax 기반 수정 처리
   * 
   * @param AuthVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/auth/update.do", method = RequestMethod.POST,
                produces = "text/plain;charset=UTF-8")
  public String update(AuthVO authVO) {
    int cnt = this.authProc.update(authVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }

  /**
   * Ajax 기반 삭제 처리
   * @param auth_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/auth/delete.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String delete(int auth_no) {
    System.out.println("AuthCont delete() excuted.");
    int cnt = this.authProc.delete(auth_no);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
}
