package dev.mvc.admin_log;

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
public class Admin_logCont {
  @Autowired
  @Qualifier("dev.mvc.admin_log.Admin_logProc")
  private Admin_logProcInter admin_logProc;
  
  public Admin_logCont() {
    System.out.println("--> Admin_logCont created");
  }

  /**
   * 목록
   * http://localhost:9090/team2/admin_log/list.do
   * @param session
   * @return
   */
  @RequestMapping(value="/admin_log/list.do", method = RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin_log/list");
    
    int admin_no = (int) session.getAttribute("admin_no");
    List<Admin_logVO> list = this.admin_logProc.list(admin_no);
    mav.addObject("list", list);
    
    return mav;
  }

  /**
   * Ajax기반 조회
   * http://localhost:9090/team2/admin_log/read.do
   * @param admin_log_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/admin_log/read.do", method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public String read(int admin_log_no) {
    Admin_logVO admin_logVO = this.admin_logProc.read(admin_log_no);
    
    JSONObject json = new JSONObject();
    json.put("admin_log_no", admin_log_no);
    json.put("admin_log_date", admin_logVO.getAdmin_log_date());
    json.put("admin_log_ip", admin_logVO.getAdmin_log_ip());
    
    return json.toString();
  }
  
  /**
   * Ajax 기반 삭제 처리
   * @param admin_log_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/admin_log/delete.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String delete(int admin_log_no) {
    int cnt = this.admin_logProc.delete(admin_log_no);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
}
