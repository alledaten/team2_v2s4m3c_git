package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

public interface MemberProcInter {
  
  /**
   * �ߺ� ���̵� �˻�
   * @param id
   * @return �ߺ� ���̵� ����
   */
  public int checkID(String id);
  
  /**
   * ���
   * @param memberVO
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
   * �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);

  /**
   * ������ ��� ���ڿ� ����, Box ����
   * @param listFile ��� ���ϸ� 
   * @param search_count �˻� ����
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param word �˻���
   * @return
   */
  public String pagingBox(String listFile, int search_count, int nowPage, String word);
 
  /**
   * ��ȸ, ������
   * @param memberno ��� ��ȣ, PK
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


