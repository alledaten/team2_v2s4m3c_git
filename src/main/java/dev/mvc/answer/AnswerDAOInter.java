package dev.mvc.answer;

import java.util.HashMap;
import java.util.List;


public interface AnswerDAOInter {
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
   * ÷�� ���� ����
   * @param answerVO
   * @return
   */
  public int update_img(AnswerVO answerVO);
  
  
}
