package dev.mvc.boardgrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.boardgrp.BoardgrpProc")
public class BoardgrpProc implements BoardgrpProcInter {
  @Autowired
  private BoardgrpDAOInter boardgrpDAO; 
  
  public BoardgrpProc() {
    System.out.println("--> BoardgrpProc created.");
  }
  
  @Override
  public int create(BoardgrpVO boardgrpVO) {
    int cnt = this.boardgrpDAO.create(boardgrpVO);
    return cnt;
  }

  @Override
  public List<BoardgrpVO> list_boardgrp_no_asc() {
    List<BoardgrpVO> list = this.boardgrpDAO.list_boardgrp_no_asc();
    return list;
  }

  @Override
  public BoardgrpVO read(int boardgrp_no) {
    BoardgrpVO boardgrpVO = this.boardgrpDAO.read(boardgrp_no);
    
    return boardgrpVO;
  }

  @Override
  public int update(BoardgrpVO boardgrpVO) {
    int cnt = this.boardgrpDAO.update(boardgrpVO);
    
    return cnt;
  }

  @Override
  public int delete(int boardgrp_no) {
    int cnt = this.boardgrpDAO.delete(boardgrp_no);
    
    return cnt;
  }

  @Override
  public List<BoardgrpVO> list_boardgrp_seqno_asc() {
    List<BoardgrpVO> list = this.boardgrpDAO.list_boardgrp_seqno_asc();
    return list;
  }

  @Override
  public int update_boardgrp_seqno_up(int boardgrp_no) {
    int cnt = this.boardgrpDAO.update_boardgrp_seqno_up(boardgrp_no);
    return cnt;
  }

  @Override
  public int update_boardgrp_seqno_down(int boardgrp_no) {
    int cnt = this.boardgrpDAO.update_boardgrp_seqno_down(boardgrp_no);
    return cnt;
  }

  /**
   * Y -> N, N -> Y
   */
  @Override
  public int update_boardgrp_visible(BoardgrpVO boardgrpVO) {
    if (boardgrpVO.getBoardgrp_visible().equalsIgnoreCase("Y")) {
      boardgrpVO.setBoardgrp_visible("N");
    } else {
      boardgrpVO.setBoardgrp_visible("Y");
    }
        
    int cnt = this.boardgrpDAO.update_boardgrp_visible(boardgrpVO);
    return cnt;
  }
  
  

}




