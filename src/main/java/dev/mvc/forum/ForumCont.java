package dev.mvc.forum;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.boardgrp.BoardgrpProcInter;
import dev.mvc.boardgrp.BoardgrpVO;

@Controller
public class ForumCont {
   @Autowired
   @Qualifier("dev.mvc.boardgrp.BoardgrpProc")
   private BoardgrpProcInter boardgrpProc;
	
  @Autowired
  @Qualifier("dev.mvc.forum.ForumProc")
  private ForumProcInter forumProc;

  public ForumCont() {
    System.out.println("--> ForumCont created.");
  }

  /**
   * ����� http://localhost:9090/team2/forum/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/team2/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/forum/create"); // /cate/create.jsp

    return mav;
  }

  /**
   * ���ó��
   * http://localhost:9090/team2/forum/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/forum/create.do", method = RequestMethod.POST)
  public ModelAndView create(ForumVO forumVO) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/forum/create_msg");

    int cnt = this.forumProc.create(forumVO);
    mav.addObject("cnt", cnt);

    return mav;
  }
  
  /**
   * ��� http://localhost:9090/team2/forum/list_all.do
   * 
   * @return
   */
  @RequestMapping(value = "/team2/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/forum/list_all"); // /webapp/cate/list_all.jsp

    // List<CateVO> list = this.cateProc.list_cateno_asc();
    List<ForumVO> list = this.forumProc.list_forum_seqno_asc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
   * ��� http://localhost:9090/team2/forum/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/forum/list.do", method = RequestMethod.GET)
  public ModelAndView list(int boardgrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/forum/list"); // /webapp/cate/list.jsp
    
    // Categrp ����
    BoardgrpVO boardgrpVO = this.boardgrpProc.read(boardgrp_no);
    mav.addObject("boardgrpVO", boardgrpVO);
    
    // List<CateVO> list = this.cateProc.list_cateno_asc();
    List<ForumVO> list = this.forumProc.list_by_boardgrp_no(boardgrp_no);
    mav.addObject("list", list);

    return mav; // forward
  }

  /**
   * ��ȸ + ������ http://localhost:9090/team2/forum/read_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/forum/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int forum_no, int boardgrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/forum/read_update"); // /webapp/forum/read_update.jsp

    ForumVO forumVO = this.forumProc.read(forum_no);
    mav.addObject("forumVO", forumVO);

    List<ForumVO> list = this.forumProc.list_by_boardgrp_no(boardgrp_no);
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
   * ���� ó��
   * 
   * @param forumVO
   * @return
   */
  @RequestMapping(value = "/forum/update.do", method = RequestMethod.POST)
  public ModelAndView update(ForumVO forumVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.forumProc.update(forumVO);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/forum/update_msg"); // webapp/cate/update_msg.jsp

    return mav;
  }
  
  /**
   * ��ȸ + ������ http://localhost:9090/team2/forum/read_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/forum/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(int forum_no, int boardgrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/forum/read_delete"); // /webapp/forum/read_delete.jsp

    ForumVO forumVO = this.forumProc.read(forum_no);
    mav.addObject("forumVO", forumVO);

    List<ForumVO> list = this.forumProc.list_by_boardgrp_no(boardgrp_no);
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
   * ���� ó��
   * 
   * @param forumVO
   * @return
   */
  @RequestMapping(value = "/forum/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int forum_no) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.forumProc.delete(forum_no);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/forum/delete_msg"); // webapp/forum/delete_msg.jsp

    return mav;
  }
  
  /**
   * �켱���� ���� up 10 �� 1
   * @param forum_no  ��ȣ
   * @return
   */
  @RequestMapping(value="/forum/update_forum_seqno_up.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_seqno_up(int forum_no, int boardgrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.forumProc.update_forum_seqno_up(forum_no);
    // mav.addObject("cnt", cnt); // request�� ����
    
    mav.setViewName("redirect:/forum/list.do?boardgrp_no="+boardgrp_no); 

    return mav;
  }
  
  /**
   * �켱���� ���� up 1 �� 10
   * @param forum_no ī�װ� ��ȣ
   * @return
   */
  @RequestMapping(value="/forum/update_forum_seqno_down.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_forum_seqno_down(int forum_no, int boardgrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.forumProc.update_forum_seqno_down(forum_no);
    // mav.addObject("cnt", cnt); // request�� ����
    
    mav.setViewName("redirect:/forum/list.do?boardgrp_no="+boardgrp_no); 

    return mav;
  }
  
  /**
   * ��¸�� ����
   * 
   * @param forumVO
   * @return
   */
  @RequestMapping(value = "/forum/update_forum_visible.do", method = RequestMethod.GET)
  public ModelAndView update_forum_visible(ForumVO forumVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.forumProc.update_forum_visible(forumVO);
    mav.addObject("cnt", cnt); // request�� ����

    if (cnt == 1) { 
      mav.setViewName("redirect:/forum/list.do?boardgrp_no="+forumVO.getBoardgrp_no()); // request ��ü�� ������ �ȵ�. 
    } else {
      ForumVO vo = this.forumProc.read(forumVO.getForum_no());
      String forum_name = vo.getForum_name();
      mav.addObject("forum_name", forum_name);
      mav.setViewName("/forum/update_forum_visible_msg"); // /forum/update_forum_visible_msg.jsp
    }
    return mav;
  }
  
}




