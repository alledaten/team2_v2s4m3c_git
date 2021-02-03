package dev.mvc.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin_log.Admin_logProcInter;
import dev.mvc.admin_log.Admin_logVO;
import dev.mvc.member.MemberPaging;
import dev.mvc.member.MemberVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class AdminCont {
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin_log.Admin_logProc")
  private Admin_logProcInter admin_logProc;

  public AdminCont() {
    System.out.println("--> AdminCont created");
  }
  
  /**
   * 등록폼
   * http://localhost:9090/team2/admin/create.do
   * @return
   */
  @RequestMapping(value = "/admin/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/create");

    return mav;
  }

  /**
   * 등록처리
   * http://localhost:9090/team2/admin/create.do
   * @return
   */
  @RequestMapping(value = "/admin/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, AdminVO adminVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.adminProc.create(adminVO);
    mav.addObject("cnt", cnt);

    mav.setViewName("/admin/create_msg");
    return mav;
  }

  // http://localhost:9090/team2/admin/checkID.do
  /**
  * ID 중복 체크, JSON 출력
  * @return
  */
  @ResponseBody
  @RequestMapping(value="/admin/checkID.do", method=RequestMethod.GET ,
                  produces = "text/plain;charset=UTF-8" )
  public String checkID(String admin_id) {
    int cnt = this.adminProc.checkID(admin_id);
   
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
   
    return json.toString(); 
  }
  
  /**
   * 목록
   * http://localhost:9090/team2/admin/list.do
   * @return
   */
  @RequestMapping(value = "/admin/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/list");

    List<AdminVO> list = this.adminProc.list();
    mav.addObject("list", list);

    return mav;
  }
  


  // http://localhost:9090/team2/admin/read.do
  /**
   * 회원정보
   * @return
   */
  @RequestMapping(value="/admin/read.do", method=RequestMethod.GET )
  public ModelAndView read(int admin_no) {
    ModelAndView mav = new ModelAndView();

    AdminVO adminVO = this.adminProc.read(admin_no);
    mav.addObject("adminVO", adminVO); // request.setAttribute("memberVO", memberVO);
    
    mav.setViewName("/admin/read"); // /webapp/member/read.jsp
    return mav;
  }

  // http://localhost:9090/resort/admin/update.do
  /**
   * 수정 폼
   * @return
   */
  @RequestMapping(value="/admin/update.do", method=RequestMethod.GET )
  public ModelAndView update(int admin_no) {
    ModelAndView mav = new ModelAndView();
    
    AdminVO adminVO = this.adminProc.read(admin_no); // 수정용 읽기
    mav.addObject("adminVO", adminVO); // request.setAttribute("memberVO", memberVO);
    
    mav.setViewName("/admin/update"); // webapp/member/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/resort/admin/update.do
  /**
   * 수정 처리
   * @param adminVO
   * @return
   */
  @RequestMapping(value="/admin/update.do", method=RequestMethod.POST )
  public ModelAndView update(HttpServletRequest request, AdminVO adminVO) {
    ModelAndView mav = new ModelAndView();
    
    mav.addObject("admin_no", adminVO.getAdmin_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("admin_no", adminVO.getAdmin_no());
    hashMap.put("admin_passwd", adminVO.getAdmin_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;        // 수정된 레코드 갯수 
    
    passwd_cnt = this.adminProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 수정
      cnt = this.adminProc.update(adminVO);
      mav.setViewName("/admin/update_msg"); // webapp/member/update_msg.jsp
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
    
    return mav;
  }
  

  // http://localhost:9090/team2/admin/update.do
  /**
   * 삭제 폼
   * @return
   */
  @RequestMapping(value="/admin/delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int admin_no) {
    ModelAndView mav = new ModelAndView();

    AdminVO adminVO = this.adminProc.read(admin_no);
    mav.addObject("adminVO", adminVO); // request.setAttribute("memberVO", memberVO);
    mav.setViewName("/admin/delete"); // webapp/member/update.jsp

    return mav;
  }
  
  // http://localhost:9090/team2/admin/delete.do
  /**
   * 삭제 처리
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/admin/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(HttpServletRequest request, int admin_no, String passwd) {
    ModelAndView mav = new ModelAndView();
    
    AdminVO vo = this.adminProc.read(admin_no);
    mav.addObject("id", vo.getAdmin_id());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("admin_no", admin_no);
    hashMap.put("admin_passwd", passwd);
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;        // 삭제된 레코드 갯수 

    passwd_cnt = this.adminProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 삭제
      cnt = this.adminProc.delete(admin_no);
    }
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
    mav.addObject("admin_name", vo.getAdmin_name());
    
    mav.setViewName("/admin/delete_msg");
    
    return mav;
  }
  
  
  /**
   * 로그인 폼
   * @return
   */
  // http://localhost:9090/team2/admin/login.do 
  @RequestMapping(value = "/admin/login.do", 
                  method = RequestMethod.GET)
  public ModelAndView login() {
    ModelAndView mav = new ModelAndView();
  
    mav.setViewName("/admin/login_form");
    return mav;
  }

  /**
   * 로그인 처리
   * @return
   */
  // http://localhost:9090/team2/admin/login.do 
  @RequestMapping(value = "/admin/login.do", 
                  method = RequestMethod.POST)
  public ModelAndView login_proc(HttpSession session,
                                  String admin_id, 
                                  String admin_passwd,
                                  HttpServletRequest request) {
    // System.out.println("admin_id"+admin_id + admin_passwd);
    
    ModelAndView mav = new ModelAndView();
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("admin_id", admin_id);
    map.put("admin_passwd", admin_passwd);
    
    int count = this.adminProc.login(map);
    
    if (count == 1) { // 로그인 성공
      System.out.println(admin_id + " 로그인 성공");
      AdminVO adminVO = adminProc.readById(admin_id);
      session.setAttribute("admin_no", adminVO.getAdmin_no());
      session.setAttribute("admin_id", admin_id);
      session.setAttribute("admin_name", adminVO.getAdmin_name());
      
      /******* 관리자 로그인 기록 *****/
      
      Admin_logVO admin_logVO = new Admin_logVO();
      
      admin_logVO.setAdmin_no(adminVO.getAdmin_no()); // 관리자 번호 등록
      admin_logVO.setAdmin_log_ip(request.getRemoteAddr());// IP주소
      
      int cnt = this.admin_logProc.create(admin_logVO);
      
      if (cnt == 1) {
        System.out.println("-->" + admin_id + " 로그인 등록 성공");
      } else {
        System.out.println("--> 등록실패");
      }
      
      /*********************************/
      
      mav.setViewName("redirect:/index.do");  
    } else {
      mav.setViewName("redirect:/admin/login_fail_msg.jsp");
    }
        
    return mav;
  }
  
  /**
   * 로그아웃 처리
   * @param session
   * @return
   */
  @RequestMapping(value="/admin/logout.do", 
                  method=RequestMethod.GET)
  public ModelAndView logout(HttpSession session){
    ModelAndView mav = new ModelAndView();
    session.invalidate(); // 모든 session 변수 삭제
    
    mav.setViewName("redirect:/admin/logout_msg.jsp");
    
    return mav;
  }

}
