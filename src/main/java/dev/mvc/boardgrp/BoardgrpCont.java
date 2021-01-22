package dev.mvc.boardgrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardgrpCont {
  @Autowired
  @Qualifier("dev.mvc.boardgrp.BoardgrpProc")
  private BoardgrpProcInter boardgrpProc;

  public BoardgrpCont() {
    System.out.println("--> BoardgrpCont created.");
  }

  /**
   * 등록폼 http://localhost:9090/team2/boardgrp/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/boardgrp/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/boardgrp/create"); // /webapp/boardgrp/create.jsp

    return mav; // forward
  }

  /**
   * 등록 처리 http://localhost:9090/resort/boardgrp/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/boardgrp/create.do", method = RequestMethod.POST)
  public ModelAndView create(BoardgrpVO boardgrpVO) {
    // request.setAttribute("boardgrpVO", boardgrpVO) 자동 실행

    ModelAndView mav = new ModelAndView();
    mav.setViewName("/boardgrp/create_msg"); // /webapp/categrp/create_msg.jsp

    int cnt = this.boardgrpProc.create(boardgrpVO); // 등록 처리
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    return mav; // forward
  }

  /**
   * 목록 http://localhost:9090/team2/boardgrp/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/boardgrp/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/boardgrp/list"); // /webapp/boardgrp/list.jsp

    // List<BoardgrpVO> list = this.categrpProc.list_categrpno_asc();
    List<BoardgrpVO> list = this.boardgrpProc.list_boardgrp_seqno_asc();
    mav.addObject("list", list);

    return mav; // forward
  }

  /**
   * 조회 + 수정폼 http://localhost:9090/resort/categrp/read_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/boardgrp/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int boardgrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/boardgrp/read_update"); // /webapp/boardgrp/read_update.jsp

    BoardgrpVO boardgrpVO = this.boardgrpProc.read(boardgrp_no);
    mav.addObject("boardgrpVO", boardgrpVO);

    List<BoardgrpVO> list = this.boardgrpProc.list_boardgrp_seqno_asc();
    mav.addObject("list", list);

    return mav; // forward
  }

  /**
   * 수정 처리
   * 
   * @param categrpVO
   * @return
   */
  @RequestMapping(value = "/boardgrp/update.do", method = RequestMethod.POST)
  public ModelAndView update(BoardgrpVO boardgrpVO) {
    // BoardgrpVO boardgrpVO <FORM> 태그의 값으로 자동 생성됨.
    // request.setAttribute("boardgrpVO", boardgrpVO); 자동 실행

    ModelAndView mav = new ModelAndView();

    int cnt = this.boardgrpProc.update(boardgrpVO);
    mav.addObject("cnt", cnt); // request에 저장

    mav.setViewName("/boardgrp/update_msg"); // webapp/boardgrp/update_msg.jsp

    return mav;
  }

  /**
   * 삭제폼 http://localhost:9090/resort/categrp/read_delete.do
   * @return
   */
  @RequestMapping(value = "/boardgrp/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(int boardgrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/categrp/read_delete"); // /webapp/categrp/read_delete.jsp

    BoardgrpVO boardgrpVO = this.boardgrpProc.read(boardgrp_no);
    mav.addObject("boardgrpVO", boardgrpVO);

    List<BoardgrpVO> list = this.boardgrpProc.list_boardgrp_seqno_asc();
    mav.addObject("list", list);

    return mav; // forward
  }

  /**
   * 삭제 처리
   * @param boardgrpno
   * @return
   */
  @RequestMapping(value = "/boardgrp/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int boardgrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.boardgrpProc.delete(boardgrp_no);
    mav.addObject("cnt", cnt); // request에 저장

    mav.setViewName("/boardgrp/delete_msg"); // /webapp/boardgrp/delete_msg.jsp

    return mav;
  }
 
  // http://localhost:9090/team2/boardgrp/update_board_seqno_up.do?boardgrp_no=1
  // http://localhost:9090/team2/boardgrp/update_board_seqno_up.do?boardgrp_no=1000
  /**
   * 우선순위 상향 up 10 ▷ 1
   * @param categrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value="/boardgrp/update_boardgrp_seqno_up.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_boardgrp_seqno_up(int boardgrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.boardgrpProc.update_boardgrp_seqno_up(boardgrp_no);
    mav.addObject("cnt", cnt); // request에 저장
    
    BoardgrpVO boardgrpVO = this.boardgrpProc.read(boardgrp_no);
    mav.addObject("boardgrpVO", boardgrpVO);
    

    mav.setViewName("/boardgrp/update_boardgrp_seqno_up_msg"); // /categrp/update_boardgrp_seqno_up_msg.jsp

    return mav;
  }
  
  // http://localhost:9090/resort/categrp/update_boardgrp_seqno_down.do?categrpno=1
  // http://localhost:9090/resort/categrp/update_boardgrp_seqno_down.do?categrpno=1000
  /**
   * 우선순위 하향 up 1 ▷ 10
   * @param categrpno 카테고리 번호
   * @return
   */
  @RequestMapping(value="/boardgrp/update_boardgrp_seqno_down.do", 
                              method=RequestMethod.GET )
  public ModelAndView update_boardgrp_seqno_down(int boardgrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.boardgrpProc.update_boardgrp_seqno_down(boardgrp_no);
    mav.addObject("cnt", cnt); // request에 저장

    BoardgrpVO boardgrpVO = this.boardgrpProc.read(boardgrp_no);
    mav.addObject("boardgrpVO", boardgrpVO);
    
    mav.setViewName("/categrp/update_board_seqno_down_msg"); // /boardgrp/update_board_seqno_down_msg.jsp 

    return mav;
  }
  
  /**
   * 출력모드 변경
   * 
   * @param boardgrpVO
   * @return
   */
  @RequestMapping(value = "/boardgrp/update_board_visible.do", method = RequestMethod.GET)
  public ModelAndView update_board_visible(BoardgrpVO boardgrpVO) {
    ModelAndView mav = new ModelAndView();

    // System.out.println("--> boardgrp_no: " + boardgrpVO.getBoardgrpno());
    // System.out.println("--> board_visible: " + boardgrpVO.getBoard_visible());
        
    int cnt = this.boardgrpProc.update_boardgrp_visible(boardgrpVO);
    mav.addObject("cnt", cnt); // request에 저장

    mav.setViewName("redirect:/boardgrp/list.do"); // request 객체가 전달이 안됨. 

    return mav;
  }
  
}



