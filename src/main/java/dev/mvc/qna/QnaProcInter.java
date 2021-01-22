package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

public interface QnaProcInter {
  /**
   * ���
   * @param qnaVO
   * @return
   */
  public int create(QnaVO qnaVO);
  
  /**
   * ���
   * @return
   */
  public List<QnaVO> list_qnano_asc();
  
  /** ȸ�� id join
   * 
   * @return
   */
  public List<QnaMemberVO> list_member_join();
  
  /**
   * �˻� + ����¡ ��� + Member join
   * @param map
   * @return
   */
  public List<QnaMemberVO> list_search_paging_join(HashMap<String, Object> map);
  
  /**
   * ��ȸ
   * @param qna_no
   * @return
   */
  public QnaVO read(int qna_no);
  
  /**
   * ȸ�� ��ȸ
   * @param qna_no
   * @return
   */
//  public QnaMemberVO read_member(int qna_no);
  
  /**
   * ������ ��ȸ
   * @param qna_no
   * @return
   */
  public QnaVO read_update(int qna_no);
  
  /**
   * ����
   * @param qnaVO
   * @return
   */
  public int update(QnaVO qnaVO);
  
  /**
   * �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * ����
   * @param qna_no
   * @return
   */
  public int delete(int qna_no);
  
  /**
   * visible ����
   * @param qnaVO
   * @return 
   */
  public int update_visible(QnaVO qnaVO);
  
  /**
   * �̹��� ���
   * @param qnaVO
   * @return
   */
  public int img_create(QnaVO qnaVO);
  
  /**
   * �̹��� ����
   * @param qnaVO
   * @return
   */
  public int img_update(QnaVO qnaVO);
  
  /**
   * �̹��� ����
   * @param qnaVO
   * @return
   */
  public int img_delete(QnaVO qnaVO);
  
  /**
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public List<QnaVO> list_search_paging(HashMap<String, Object> map);
  
  /**
   * ������ ��� ���ڿ� ����, Box ����
   * @param listFile ��� ���ϸ� 
   * @param community_no Ŀ�´�Ƽ��ȣ
   * @param search_count �˻� ����
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param qna_word �˻���
   * @return
   */
  public String pagingBox(String listFile, int community_no, int search_count, int nowPage, String qna_word);

  /**
   * ī�װ��� �˻� ���ڵ� ����
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * �亯 ���� ����
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);
   
  /**
   * �亯
   * @param qnaVO
   * @return
   */
  public int reply(QnaVO qnaVO);
  
}
