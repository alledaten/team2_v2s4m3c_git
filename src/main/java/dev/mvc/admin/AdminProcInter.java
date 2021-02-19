package dev.mvc.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface AdminProcInter {
  

  /**
   * �ߺ� ���̵� �˻�
   * @param admin_id
   * @return �ߺ� ���̵� ����
   */
  public int checkID(String admin_id);
  
  /**
   * ������ ���̵� ���
   * @param adminVO
   * @return
   */
  public int create(AdminVO adminVO);
  
  /**
   * ������ ���
   * @return
   */
  public List<AdminVO> list();

  /**
   * ������ ������ȣ�� ��ȸ
   * @param admin_no
   * @return
   */
  public AdminVO read(int admin_no);
  
  /**
   * ������ ���̵�� ��ȸ
   * @param admin_id
   * @return
   */
  public AdminVO readById(String admin_id);
  
  /**
   * ������ ���� ����
   * @param adminVO
   * @return
   */
  public int update(AdminVO adminVO);
  
  /**
   * ������ �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * ������ ����
   * @param admin_no
   * @return
   */
  public int delete(int admin_no);
  
  /**
   * ������ �α��� ó��
   * @param map
   * @return
   */
  public int login(Map<String, Object> map);
  
  /**
   * ���������� �˻�
   * @param session
   * @return
   */
  public boolean isAdmin(HttpSession session);
  
}
