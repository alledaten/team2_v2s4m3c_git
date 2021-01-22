package dev.mvc.answer;

import java.util.HashMap;
import java.util.List;


public interface AnswerProcInter {
  /**
   * ���
   * @param answerVO
   * @return
   */
  public int create(AnswerVO answerVO);
  
  /**
   * ���
   * @return
   */
  public List<AnswerVO> list_answer_no_asc();
  
  /**
   * ���� Ÿ��Ʋ ��� ��ȸ
   * @return
   */
  public List<AnswerVO> list_qnatitle_desc(int qna_no);
  
  /**
   * ��ȸ
   * @param answer_no
   * @return
   */
  public AnswerVO read(int answer_no);
  
  /**
   * ������ ��ȸ
   * @param answer_no
   * @return
   */
  public AnswerVO read_update(int answer_no);
  
  /**
   * ����
   * @param answerVO
   * @return
   */
  public int update(AnswerVO answerVO);
  
  /**
   * ����
   * @param answer_no
   * @return
   */
  public int delete(int answer_no);
  
  /**
   * �н����� �˻�
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * �̹��� ���
   * @param answerVO
   * @return
   */
  public int img_create(AnswerVO answerVO);
  
  /**
   * �̹��� ����
   * @param answerVO
   * @return
   */
  public int img_update(AnswerVO answerVO);
  
  /**
   * �̹��� ����
   * @param contentsVO
   * @return
   */
  public int img_delete(AnswerVO answerVO);
  
}
