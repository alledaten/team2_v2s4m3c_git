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
    
    // 로그인 상태인지 체크
    if (session.getAttribute("member_id") == null) {
      // 로그인 상태가 아니라면 에러 화면으로 이동
      mav.setViewName("/login_log/list_error"); 
    } else {
      // 로그인 상태라면 본인의 로그인기록 화면으로 이동
      int member_no = (int) session.getAttribute("member_no"); 
      List<Login_logVO> list = this.login_logProc.list(member_no);
      mav.addObject("list", list);
      
      mav.setViewName("/login_log/list");
    }
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
