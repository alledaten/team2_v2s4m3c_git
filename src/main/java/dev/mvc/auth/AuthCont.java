package dev.mvc.auth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
   * 권한 등록 http://localhost:9090/team2/auth/create.do
   * @return
   */
  @RequestMapping(value = "/auth/create.do", method = RequestMethod.POST)
  public ModelAndView create(AuthVO authVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/auth/create_msg");
    
    int cnt = this.authProc.create(authVO);
    mav.addObject("cnt", cnt);
    
    return mav;
  }
  
  /**
   * 목록 http://localhost:9090/team2/auth/create.do
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
   * 조회 + 수정폼 http://localhost:9090/team2/auth/read_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/auth/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int auth_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/auth/read_update"); // /webapp/auth/read_update.jsp

    AuthVO authVO = this.authProc.read(auth_no);
    mav.addObject("authVO", authVO);

    List<AuthVO> list = this.authProc.list();
    mav.addObject("list", list);

    return mav; // forward
  }

  /**
   * 수정 처리
   * 
   * @param categrpVO
   * @return
   */
  @RequestMapping(value = "/auth/update.do", method = RequestMethod.POST)
  public ModelAndView update(AuthVO authVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.authProc.update(authVO);
    mav.addObject("cnt", cnt); // request에 저장

    mav.setViewName("/auth/update_msg"); // webapp/auth/update_msg.jsp

    return mav;
  }

  /**
   * 삭제폼 http://localhost:9090/team2/auth/read_delete.do
   * @return
   */
  @RequestMapping(value = "/auth/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(int auth_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/auth/read_delete"); // /webapp/categrp/read_delete.jsp

    AuthVO authVO = this.authProc.read(auth_no);
    mav.addObject("authVO", authVO);

    List<AuthVO> list = this.authProc.list();
    mav.addObject("list", list);

    return mav; // forward
  }

  /**
   * 삭제 처리
   * @param auth_no
   * @return
   */
  @RequestMapping(value = "/auth/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int auth_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.authProc.delete(auth_no);
    mav.addObject("cnt", cnt); // request에 저장

    mav.setViewName("/auth/delete_msg"); // /webapp/categrp/delete_msg.jsp

    return mav;
  }
}
