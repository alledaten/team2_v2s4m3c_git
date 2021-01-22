package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

public interface QnaProcInter {
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
   * 수정용 조회
   * @param qna_no
   * @return
   */
  public QnaVO read_update(int qna_no);
  
  /**
   * 수정
   * @param qnaVO
   * @return
   */
  public int update(QnaVO qnaVO);
  
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
   * 이미지 등록
   * @param qnaVO
   * @return
   */
  public int img_create(QnaVO qnaVO);
  
  /**
   * 이미지 수정
   * @param qnaVO
   * @return
   */
  public int img_update(QnaVO qnaVO);
  
  /**
   * 이미지 삭제
   * @param qnaVO
   * @return
   */
  public int img_delete(QnaVO qnaVO);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public List<QnaVO> list_search_paging(HashMap<String, Object> map);
  
  /**
   * 페이지 목록 문자열 생성, Box 형태
   * @param listFile 목록 파일명 
   * @param community_no 커뮤니티번호
   * @param search_count 검색 갯수
   * @param nowPage 현재 페이지, nowPage는 1부터 시작
   * @param qna_word 검색어
   * @return
   */
  public String pagingBox(String listFile, int community_no, int search_count, int nowPage, String qna_word);

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
