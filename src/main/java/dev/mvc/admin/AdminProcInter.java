package dev.mvc.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface AdminProcInter {
  

  /**
   * 중복 아이디 검사
   * @param admin_id
   * @return 중복 아이디 갯수
   */
  public int checkID(String admin_id);
  
  /**
   * 관리자 아이디 등록
   * @param adminVO
   * @return
   */
  public int create(AdminVO adminVO);
  
  /**
   * 관리자 목록
   * @return
   */
  public List<AdminVO> list();

  /**
   * 관리자 고유번호로 조회
   * @param admin_no
   * @return
   */
  public AdminVO read(int admin_no);
  
  /**
   * 관리자 아이디로 조회
   * @param admin_id
   * @return
   */
  public AdminVO readById(String admin_id);
  
  /**
   * 관리자 정보 수정
   * @param adminVO
   * @return
   */
  public int update(AdminVO adminVO);
  
  /**
   * 관리자 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * 관리자 삭제
   * @param admin_no
   * @return
   */
  public int delete(int admin_no);
  
  /**
   * 관리자 로그인 처리
   * @param map
   * @return
   */
  public int login(Map<String, Object> map);
  
  /**
   * 관리자인지 검사
   * @param session
   * @return
   */
  public boolean isAdmin(HttpSession session);
  
}
