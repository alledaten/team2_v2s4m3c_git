package dev.mvc.auth;

import java.util.List;

public interface AuthDAOInter {
  
  /**
   * ���
   * @param authVO
   * @return
   */
  public int create(AuthVO authVO);
  
  /**
   * ���
   * @return
   */
  public List<AuthVO> list();

  /**
   * ��ȸ, ������
   * @param auth_no
   * @return
   */
  public AuthVO read(int auth_no);
  
  /**
   * ���� ó��
   * @param authVO
   * @return
   */
  public int update(AuthVO authVO);
  
  /**
   * ����
   * @param auth_no
   * @return
   */
  public int delete(int auth_no);

}
