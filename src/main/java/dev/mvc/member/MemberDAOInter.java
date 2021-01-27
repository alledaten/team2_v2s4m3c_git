package dev.mvc.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface MemberDAOInter {
  
  /**
   * 중복 아이디 검사
   * @param id
   * @return 중복 아이디 갯수
   */
  public int checkID(String id);
  
  /**
   * 등록
   * @param cateVO
   * @return 등록된 갯수
   */
  public int create(MemberVO memberVO);
  
  /**
   * 목록
   * @return
   */
  public List<MemberVO> list_memberno_asc();
  
  /**
   * 목록
   * @return
   */
  public List<MemberVO> list_join();
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public List<MemberVO> list_paging(HashMap<String, Object> map);
  
  /**
   * 카테고리별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * 조회, 수정폼
   * @param member_no 멤버 번호, PK
   * @return
   */
  public MemberVO read(int member_no);

  /**
   * 회원 정보 조회
   * @param id
   * @return
   */
  public MemberVO readById(String member_id);
  
  /**
   * 수정용 조회
   * @param member_no
   * @return
   */
  public MemberVO read_update(int member_no);
  
  /**
   * 수정 처리
   * @param memberVO
   * @return
   */
  public int update(MemberVO memberVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * 삭제
   * @param member_no
   * @return
   */
  public int delete(int member_no);

  /**
   * 로그인 처리
   */
  public int login(Map<String, Object> map);
  
}





