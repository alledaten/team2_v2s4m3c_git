package dev.mvc.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dev.mvc.member.MemberVO;

public interface AdminDAOInter {
  
  /**
   * 중복 아이디 검사
   * @param id
   * @return 중복 아이디 갯수
   */
  public int checkID(String admin_id);
  
  /**
   * 등록
   * @param adminVO
   * @return
   */
  public int create(AdminVO adminVO);
  
  /**
   * 목록
   * @return
   */
  public List<AdminVO> list();

  /**
   * 조회
   * @param admin_no
   * @return
   */
  public AdminVO read(int admin_no);
  
  /**
   * 수정 처리
   * @param adminVO
   * @return
   */
  public int update(AdminVO adminVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * 삭제
   * @param admin_no
   * @return
   */
  public int delete(int admin_no);
  
  /**
   * 회원 정보 조회
   * @param id
   * @return
   */
  public AdminVO readById(String admin_id);
  
  /**
   * 로그인 처리
   */
  public int login(Map<String, Object> map);
}
