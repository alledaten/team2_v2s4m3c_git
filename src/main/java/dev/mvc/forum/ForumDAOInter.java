package dev.mvc.forum;

import java.util.List;

import dev.mvc.boardgrp.BoardgrpVO;
 
public interface ForumDAOInter {
	  /**
	   * 등록
	   * @param forumVO
	   * @return 등록된 갯수
	   */
	  public int create(ForumVO forumVO);
	  
	  /**
	   * 목록
	   * @return
	   */
	  public List<ForumVO> list_forum_no_asc();
	  
	  /**
	   * 목록 - 출력순서 정렬
	   * @return
	   */
	  public List<ForumVO> list_forum_seqno_asc();
	  
	  /**
	   * 조회, 수정폼
	   * @param forum_no 카테고리 번호, PK
	   * @return
	   */
	  public ForumVO read(int forum_no);
	  
	  /**
	   * 수정 처리
	   * @param forumVO
	   * @return
	   */
	  public int update(ForumVO forumVO);
	  
	  /**
	   * 삭제 처리 
	   * @param forum_no
	   * @return
	   */
	  public int delete(int forum_no);
	  
	  /**
	   * 출력 순서 상향
	   * @param boardgrp_no
	   * @return 처리된 레코드 갯수
	   */
	  public int  update_forum_seqno_up(int forum_no);
	 
	  /**
	   * 출력 순서 하향
	   * @param boardgrp_no
	   * @return 처리된 레코드 갯수
	   */
	  public int  update_forum_seqno_down(int forum_no); 
	  
	  /**
	   * visible 수정
	   * @param boardgrpVO
	   * @return
	   */
	  public int update_forum_visible(ForumVO forumVO);
	  
	  /**
	   *  카테고리 그룹별 목록
	   *  @param boardgrp_no 카테고리 그룹번호
	   *  @return
	   */
	  public List<ForumVO> list_by_boardgrp_no(int boardgrp_no);
	  
	  
	}



