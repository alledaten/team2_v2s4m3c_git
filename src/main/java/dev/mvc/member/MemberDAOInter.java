package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

public interface MemberDAOInter {
  
  /**
   * �ߺ� ���̵� �˻�
   * @param id
   * @return �ߺ� ���̵� ����
   */
  public int checkID(String id);
  
  /**
   * ���
   * @param cateVO
   * @return ��ϵ� ����
   */
  public int create(MemberVO memberVO);
  
  /**
   * ���
   * @return
   */
  public List<MemberVO> list_memberno_asc();
  
  /**
   * ���
   * @return
   */
  public List<MemberVO> list_join();
  
  /**
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public List<MemberVO> list_paging(HashMap<String, Object> map);
  
  /**
   * ī�װ��� �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * ��ȸ, ������
   * @param member_no ��� ��ȣ, PK
   * @return
   */
  public MemberVO read(int member_no);

  /**
   * ������ ��ȸ
   * @param member_no
   * @return
   */
  public MemberVO read_update(int member_no);
  
  /**
   * ���� ó��
   * @param memberVO
   * @return
   */
  public int update(MemberVO memberVO);
  
  /**
   * �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * ����
   * @param member_no
   * @return
   */
  public int delete(int member_no);
  
  
}





