package dev.mvc.forum;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.forum.ForumProc")
public class ForumProc implements ForumProcInter {

	@Autowired
	private ForumDAOInter forumDAO;

	public ForumProc() {
		System.out.println("--> ForumProc created");
	}

	@Override
	public int create(ForumVO forumVO) {
		int cnt = this.forumDAO.create(forumVO);
		return cnt;
	}

	@Override
	public List<ForumVO> list_forum_no_asc() {
		List<ForumVO> list = this.forumDAO.list_forum_no_asc();
		return list;
	}

	@Override
	public List<ForumVO> list_forum_seqno_asc() {
		List<ForumVO> list = this.forumDAO.list_forum_seqno_asc();
		return list;
	}

	@Override
	public List<ForumVO> list_by_boardgrp_no(int boardgrp_no) {
		List<ForumVO> list = this.forumDAO.list_by_boardgrp_no(boardgrp_no);
		return list;
	}

	@Override
	public ForumVO read(int forum_no) {
		ForumVO forumVO = this.forumDAO.read(forum_no);
		return forumVO;
	}

	@Override
	public int update(ForumVO forumVO) {
		int cnt = this.forumDAO.update(forumVO);
		return cnt;
	}

	@Override
	public int delete(int forum_no) {
		int cnt = this.forumDAO.delete(forum_no);
		return cnt;
	}

	@Override
	public int update_forum_seqno_up(int forum_no) {
		int cnt = this.forumDAO.update_forum_seqno_up(forum_no);
		return cnt;
	}

	@Override
	public int update_forum_seqno_down(int forum_no) {
		int cnt = this.forumDAO.update_forum_seqno_down(forum_no);
		return cnt;
	}

	@Override
	public int update_forum_visible(ForumVO forumVO) {
		if (forumVO.getForum_visible().equalsIgnoreCase("Y")) {
			forumVO.setForum_visible("N");
		} else {
			forumVO.setForum_visible("Y");
		}

		int cnt = this.forumDAO.update_forum_visible(forumVO);
		return cnt;
	}

}
