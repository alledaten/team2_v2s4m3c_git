package dev.mvc.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import dev.mvc.member.MemberVO;

public interface AdminDAOInter {
  
  /**
   * �ߺ� ���̵� �˻�
   * @param id
   * @return �ߺ� ���̵� ����
   */
  public int checkID(String admin_id);
  
  /**
   * ���
   * @param adminVO
   * @return
   */
  public int create(AdminVO adminVO);
  
  /**
   * ���
   * @return
   */
  public List<AdminVO> list();

  /**
   * ��ȸ
   * @param admin_no
   * @return
   */
  public AdminVO read(int admin_no);
  
  /**
   * ���� ó��
   * @param adminVO
   * @return
   */
  public int update(AdminVO adminVO);
  
  /**
   * �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * ����
   * @param admin_no
   * @return
   */
  public int delete(int admin_no);
  
  /**
   * ȸ�� ���� ��ȸ
   * @param id
   * @return
   */
  public AdminVO readById(String admin_id);
  
  /**
   * �α��� ó��
   */
  public int login(Map<String, Object> map);
}
