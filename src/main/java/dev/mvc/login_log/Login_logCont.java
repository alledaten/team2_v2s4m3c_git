package dev.mvc.login_log;

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

@Controller
public class Login_logCont {
  @Autowired
  @Qualifier("dev.mvc.login_log.Login_logProc")
  private Login_logProcInter login_logProc;
  
  public Login_logCont() {
    System.out.println("--> Login_logCont created");
  }
    
 
  /**
   * 목록
   * http://localhost:9090/team2/login_log/list.do
   * @param session
   * @return
   */
  @RequestMapping(value="/login_log/list.do", method = RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/login_log/list");
    
    int member_no = (int) session.getAttribute("member_no");
    List<Login_logVO> list = this.login_logProc.list(member_no);
    mav.addObject("list", list);
    
    return mav;
  }
  
  /**
   * Ajax기반 조회
   * http://localhost:9090/team2/login_log/read.do
   * @param login_log_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/login_log/read.do", method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public String read(int login_log_no) {
    
    Login_logVO login_logVO = this.login_logProc.read(login_log_no);

    JSONObject json = new JSONObject();
    json.put("login_log_no", login_log_no);
    json.put("login_log_date", login_logVO.getLogin_log_date());
    json.put("login_log_ip", login_logVO.getLogin_log_ip());

    return json.toString();
  }
  
  /**
   * Ajax 기반 삭제 처리
   * @param login_log_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/login_log/delete.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String delete(int login_log_no) {
    int cnt = this.login_logProc.delete(login_log_no);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
  
}
