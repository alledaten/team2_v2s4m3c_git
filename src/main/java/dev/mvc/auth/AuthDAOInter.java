package dev.mvc.auth;

import java.util.List;

public interface AuthDAOInter {
  
  /**
   * 등록
   * @param authVO
   * @return
   */
  public int create(AuthVO authVO);
  
  /**
   * 목록
   * @return
   */
  public List<AuthVO> list();

  /**
   * 조회, 수정폼
   * @param auth_no
   * @return
   */
  public AuthVO read(int auth_no);
  
  /**
   * 수정 처리
   * @param authVO
   * @return
   */
  public int update(AuthVO authVO);
  
  /**
   * 삭제
   * @param auth_no
   * @return
   */
  public int delete(int auth_no);

}
