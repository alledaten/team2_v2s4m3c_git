package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;



public interface QnaDAOInter {
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
   * ����
   * @param qnaVO
   * @return
   */
  public int update(QnaVO qnaVO);
  
  /**
   * ÷�� ���� ����
   * @param answerVO
   * @return
   */
  public int update_img(QnaVO qnaVO);
  
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
   * �˻� + ����¡ ���
   * @param map
   * @return
   */
  public ArrayList<QnaVO> list_search_paging(HashMap<String, Object> map);
  
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
