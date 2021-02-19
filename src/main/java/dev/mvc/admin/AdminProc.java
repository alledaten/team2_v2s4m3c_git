package dev.mvc.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.admin.AdminProc")
public class AdminProc implements AdminProcInter {
  @Autowired
  private AdminDAOInter adminDAO;
  
  public AdminProc() {
    System.out.println("--> AdminProc created");
  }
  
  @Override
  public int checkID(String admin_id) {
    int cnt = this.adminDAO.checkID(admin_id);
    return cnt;
  }

  @Override
  public int create(AdminVO adminVO) {
    int cnt = this.adminDAO.create(adminVO);
    return cnt;
  }

  @Override
  public List<AdminVO> list() {
    List<AdminVO> list = this.adminDAO.list();
    return list;
  }

  @Override
  public AdminVO read(int admin_no) {
    AdminVO adminVO = this.adminDAO.read(admin_no);
    return adminVO;
  }
  
  @Override
  public AdminVO readById(String admin_id) {
    AdminVO adminVO = this.adminDAO.readById(admin_id);
    return adminVO;
  }

  @Override
  public int update(AdminVO adminVO) {
    int cnt = this.adminDAO.update(adminVO);
    return cnt;
  }
  
  @Override
  public int passwd_check(HashMap hashMap) {
    int passwd_cnt = this.adminDAO.passwd_check(hashMap);
    return passwd_cnt;
  }

  @Override
  public int delete(int admin_no) {
    int cnt = this.adminDAO.delete(admin_no);
    return cnt;
  }
  
  @Override
  public int login(Map<String, Object> map) {
    int cnt = this.adminDAO.login(map);
    return cnt;
  }
  
  /**
   * 관리자로 로그인된 상태인지 체크
   */
  @Override
  public boolean isAdmin(HttpSession session){
    boolean sw = false;
    
    String admin_id = (String)session.getAttribute("admin_id");
    
    if (admin_id != null){
      sw = true;
    }
    return sw;
  }

}
