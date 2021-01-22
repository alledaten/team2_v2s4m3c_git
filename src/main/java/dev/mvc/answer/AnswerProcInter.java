package dev.mvc.answer;

import java.util.HashMap;
import java.util.List;


public interface AnswerProcInter {
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
   * 수정용 조회
   * @param answer_no
   * @return
   */
  public AnswerVO read_update(int answer_no);
  
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
   * 이미지 등록
   * @param answerVO
   * @return
   */
  public int img_create(AnswerVO answerVO);
  
  /**
   * 이미지 수정
   * @param answerVO
   * @return
   */
  public int img_update(AnswerVO answerVO);
  
  /**
   * 이미지 삭제
   * @param contentsVO
   * @return
   */
  public int img_delete(AnswerVO answerVO);
  
}
