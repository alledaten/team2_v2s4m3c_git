package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;



public interface QnaDAOInter {
  /**
   * 등록
   * @param qnaVO
   * @return
   */
  public int create(QnaVO qnaVO);
  
  /**
   * 목록
   * @return
   */
  public List<QnaVO> list_qnano_asc();
  
  /** 회원 id join
   * 
   * @return
   */
  public List<QnaMemberVO> list_member_join();
  
  /**
   * 검색 + 페이징 목록 + Member join
   * @param map
   * @return
   */
  public List<QnaMemberVO> list_search_paging_join(HashMap<String, Object> map);
  
  /**
   * 조회
   * @param qna_no
   * @return
   */
  public QnaVO read(int qna_no);
  
  /**
   * 회원 조회
   * @param qna_no
   * @return
   */
//  public QnaMemberVO read_member(int qna_no);
  
  /**
   * 수정
   * @param qnaVO
   * @return
   */
  public int update(QnaVO qnaVO);
  
  /**
   * 첨부 파일 변경
   * @param answerVO
   * @return
   */
  public int update_img(QnaVO qnaVO);
  
  /**
   * 패스워드 검사
   * @param hashMap
   * @return
   */
  public int passwd_check(HashMap hashMap);
  
  /**
   * 삭제
   * @param qna_no
   * @return
   */
  public int delete(int qna_no);
  
  /**
   * visible 수정
   * @param qnaVO
   * @return 
   */
  public int update_visible(QnaVO qnaVO);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public ArrayList<QnaVO> list_search_paging(HashMap<String, Object> map);
  
  /**
   * 카테고리별 검색 레코드 갯수
   * @param hashMap
   * @return
   */
  public int search_count(HashMap<String, Object> hashMap);
  
  /**
   * 답변 순서 증가
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);
   
  /**
   * 답변
   * @param qnaVO
   * @return
   */
  public int reply(QnaVO qnaVO);
  
}
