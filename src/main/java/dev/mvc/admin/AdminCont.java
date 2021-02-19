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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin_log.Admin_logProcInter;
import dev.mvc.admin_log.Admin_logVO;

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
   * ������ ��� ������
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
   * ������ ��� ó��
   * http://localhost:9090/team2/admin/create.do
   * @param adminVO
   * @return
   */
  @RequestMapping(value = "/admin/create.do", method = RequestMethod.POST)
  public ModelAndView create(AdminVO adminVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.adminProc.create(adminVO);
    mav.addObject("cnt", cnt);

    mav.setViewName("/admin/create_msg");
    return mav;
  }

  /**
  * ID �ߺ� üũ, JSON ���
  * http://localhost:9090/team2/admin/checkID.do
  * @param admin_id
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
   * ������ ���
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
  
  /**
   * ������ ���� ��ȸ (������ȣ)
   * http://localhost:9090/team2/admin/read.do
   * @param admin_no
   * @return
   */
  @RequestMapping(value="/admin/read.do", method=RequestMethod.GET )
  public ModelAndView read(int admin_no) {
    ModelAndView mav = new ModelAndView();

    AdminVO adminVO = this.adminProc.read(admin_no);
    mav.addObject("adminVO", adminVO);
    
    mav.setViewName("/admin/read");
    return mav;
  }

  /**
   * ������ ���� ���� ������
   * http://localhost:9090/resort/admin/update.do
   * @param admin_no
   * @return
   */
  @RequestMapping(value="/admin/update.do", method=RequestMethod.GET )
  public ModelAndView update(int admin_no) {
    ModelAndView mav = new ModelAndView();
    
    AdminVO adminVO = this.adminProc.read(admin_no); // ������ ���� �о����
    mav.addObject("adminVO", adminVO);
    
    mav.setViewName("/admin/update");
    
    return mav;
  }
  
  /**
   * ������ ���� ���� ó��
   * http://localhost:9090/resort/admin/update.do
   * @param adminVO
   * @return
   */
  @RequestMapping(value="/admin/update.do", method=RequestMethod.POST )
  public ModelAndView update(AdminVO adminVO) {
    ModelAndView mav = new ModelAndView();
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;        // ������ ���ڵ� ���� 

    // �н����� �˻�
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("admin_no", adminVO.getAdmin_no());
    hashMap.put("admin_passwd", adminVO.getAdmin_passwd());
    
    passwd_cnt = this.adminProc.passwd_check(hashMap);
    
    // �н����尡 ��ġ�� ��� �� ����
    if (passwd_cnt == 1) {
      cnt = this.adminProc.update(adminVO);
      mav.setViewName("/admin/update_msg");
    }

    // ó�� ��� ����
    mav.addObject("cnt", cnt);
    mav.addObject("passwd_cnt", passwd_cnt);
    
    // ���� ���� �� �ٷ� Ȯ���ϱ� ���� admin_no ����
    mav.addObject("admin_no", adminVO.getAdmin_no());
    
    return mav;
  }

  /**
   * ������ ���� ������
   * http://localhost:9090/team2/admin/update.do
   * @param admin_no
   * @return
   */
  @RequestMapping(value="/admin/delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int admin_no) {
    ModelAndView mav = new ModelAndView();

    AdminVO adminVO = this.adminProc.read(admin_no);  // ������ ���� �о����
    mav.addObject("adminVO", adminVO);
    mav.setViewName("/admin/delete");

    return mav;
  }
  
  /**
   * ������ ���� ó��
   * http://localhost:9090/team2/admin/delete.do
   * @param admin_no
   * @param passwd
   * @return
   */
  @RequestMapping(value="/admin/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(int admin_no, String passwd) {
    ModelAndView mav = new ModelAndView();
    
    // delete_msg���� ������ ������ �̸��� ǥ���ϱ����� request�� ����
    AdminVO vo = this.adminProc.read(admin_no);
    mav.addObject("admin_name", vo.getAdmin_name()); 
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;        // ������ ���ڵ� ����
    
    // �н����� �˻�
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("admin_no", admin_no);
    hashMap.put("admin_passwd", passwd);
    
    passwd_cnt = this.adminProc.passwd_check(hashMap);
    
    // �н����尡 ��ġ�� ��� ����
    if (passwd_cnt == 1) { 
      cnt = this.adminProc.delete(admin_no);
    }
    
    // ó�� ��� ����
    mav.addObject("cnt", cnt);
    mav.addObject("passwd_cnt", passwd_cnt);
    
    // admin/delete_msg.jsp�� �̵�
    mav.setViewName("/admin/delete_msg");
    
    return mav;
  }
  
  /**
   * �α��� ��
   * http://localhost:9090/team2/admin/login.do 
   * @return
   */
  @RequestMapping(value = "/admin/login.do", method = RequestMethod.GET)
  public ModelAndView login() {
    ModelAndView mav = new ModelAndView();
  
    mav.setViewName("/admin/login_form");
    return mav;
  }

  /**
   * �α��� ó��
   * http://localhost:9090/team2/admin/login.do 
   * @param session
   * @param admin_id
   * @param admin_passwd
   * @param request ������ ���� IP�ּҸ� �޾ƿ�
   * @return
   */
  @RequestMapping(value = "/admin/login.do", 
                  method = RequestMethod.POST)
  public ModelAndView login_proc(HttpSession session, String admin_id, String admin_passwd, HttpServletRequest request) {

    ModelAndView mav = new ModelAndView();
    
    // �н����� �˻�
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("admin_id", admin_id);
    map.put("admin_passwd", admin_passwd);
    
    // �α��� ���� ���� üũ
    int count = this.adminProc.login(map);
    
    if (count == 1) { // �α��� ����
      // �α����� ���ǿ� ����
      AdminVO adminVO = adminProc.readById(admin_id);
      session.setAttribute("admin_no", adminVO.getAdmin_no());
      session.setAttribute("admin_id", admin_id);
      session.setAttribute("admin_name", adminVO.getAdmin_name());
      
      /********** ������ �α��� �Ͻ� �� IP�� �ڵ����� ��� ********/
      Admin_logVO admin_logVO = new Admin_logVO();
      
      admin_logVO.setAdmin_no(adminVO.getAdmin_no()); // ������ ��ȣ ���
      admin_logVO.setAdmin_log_ip(request.getRemoteAddr()); // IP�ּ�
      
      // �α��α�� ���� ���� ���� üũ
      int cnt = this.admin_logProc.create(admin_logVO);
      
      if (cnt == 1) {
      } else {
        System.out.println("***" + admin_id + " �α��� ��� ����");
      }      
      /***********************************************************/
      
      mav.setViewName("redirect:/index.do");  
    } else {
      mav.setViewName("redirect:/admin/login_fail_msg.jsp");
    }
        
    return mav;
  }
  
  /**
   * �α׾ƿ� ó��
   * @param session
   * @return
   */
  @RequestMapping(value="/admin/logout.do", method=RequestMethod.GET)
  public ModelAndView logout(HttpSession session){
    ModelAndView mav = new ModelAndView();
    session.invalidate(); // ��� session ���� ����
    
    mav.setViewName("redirect:/admin/logout_msg.jsp");
    
    return mav;
  }

}
