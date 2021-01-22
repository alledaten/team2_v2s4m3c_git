package dev.mvc.forum;

import java.util.List;

import dev.mvc.boardgrp.BoardgrpVO;
 
public interface ForumDAOInter {
	  /**
	   * ���
	   * @param forumVO
	   * @return ��ϵ� ����
	   */
	  public int create(ForumVO forumVO);
	  
	  /**
	   * ���
	   * @return
	   */
	  public List<ForumVO> list_forum_no_asc();
	  
	  /**
	   * ��� - ��¼��� ����
	   * @return
	   */
	  public List<ForumVO> list_forum_seqno_asc();
	  
	  /**
	   * ��ȸ, ������
	   * @param forum_no ī�װ� ��ȣ, PK
	   * @return
	   */
	  public ForumVO read(int forum_no);
	  
	  /**
	   * ���� ó��
	   * @param forumVO
	   * @return
	   */
	  public int update(ForumVO forumVO);
	  
	  /**
	   * ���� ó�� 
	   * @param forum_no
	   * @return
	   */
	  public int delete(int forum_no);
	  
	  /**
	   * ��� ���� ����
	   * @param boardgrp_no
	   * @return ó���� ���ڵ� ����
	   */
	  public int  update_forum_seqno_up(int forum_no);
	 
	  /**
	   * ��� ���� ����
	   * @param boardgrp_no
	   * @return ó���� ���ڵ� ����
	   */
	  public int  update_forum_seqno_down(int forum_no); 
	  
	  /**
	   * visible ����
	   * @param boardgrpVO
	   * @return
	   */
	  public int update_forum_visible(ForumVO forumVO);
	  
	  /**
	   *  ī�װ� �׷캰 ���
	   *  @param boardgrp_no ī�װ� �׷��ȣ
	   *  @return
	   */
	  public List<ForumVO> list_by_boardgrp_no(int boardgrp_no);
	  
	  
	}



