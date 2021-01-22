package dev.mvc.answer;

import java.util.HashMap;
import java.util.List;


public interface AnswerDAOInter {
  /**
   * 등록
   * @param answerVO
   * @return
   */
  public int create(AnswerVO answerVO);
   
  /**
   * 목록
   * @return
   */
  public List<AnswerVO> list_answer_no_asc();
  
  /**
   * 질문 타이틀 목록 조회
   * @return
   */
  public List<AnswerVO> list_qnatitle_desc(int qna_no);
  
  /**
   * 조회
   * @param answer_no
   * @return
   */
  public AnswerVO read(int answer_no);
  
  /**
   * 수정
   * @param answerVO
   * @return
   */
  public int update(AnswerVO answerVO);
  
  /**
   * 삭제
   * @param answer_no
   * @return
   */
  public int delete(int answer_no);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * 첨부 파일 변경
   * @param answerVO
   * @return
   */
  public int update_img(AnswerVO answerVO);
  
  
}
