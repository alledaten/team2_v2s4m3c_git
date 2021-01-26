package dev.mvc.buy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class BuyCont {
  @Autowired
  @Qualifier("dev.mvc.buy.BuyProc")
  private BuyProcInter buyProc;
  
  /**
   * 등록폼 http;//localhost:9090/team2/buy/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/buy/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/buy/create"); // /webapp/buy/create.jsp

    return mav; // forward
  }
  
  /**
   * 등록 처리 http;//localhost:9090/tema2/buy/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/buy/create.do", method = RequestMethod.POST)
  public ModelAndView create(BuyVO buyVO) {
    // request.setAttribute("buyVO", buyVO) 자동 실행

    ModelAndView mav = new ModelAndView();
    mav.setViewName("/buy/create_msg"); // /webapp/buy/create_msg.jsp

    int cnt = this.buyProc.create(buyVO); // 등록 처리
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    return mav; // forward
  }
  
  /**
   * 목록 http;//localhost:9090/team2/buy/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/buy/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/buy/list"); // /webapp/buy/list.jsp

    List<BuyVO> list = this.buyProc.list_buy_desc();
    // List<QnaVO> list = this.qnaProc.list_seqno_asc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  // http://localhost:9090/team2/buy/read.do
  /**
   * 조회
   * @return
   */
  @RequestMapping(value="/buy/read.do", method=RequestMethod.GET )
  public ModelAndView read(int buy_no) {
    ModelAndView mav = new ModelAndView();

    BuyVO buyVO = this.buyProc.read(buy_no);
    mav.addObject("buyVO", buyVO); // request.setAttribute("buyVO", buyVO);
    
    mav.setViewName("/buy/read"); // /webapp/buy/read.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/buy/update.do
  /**
   * 수정 폼
   * @return
   */
  @RequestMapping(value="/buy/read_update.do", method=RequestMethod.GET )
  public ModelAndView read_update(int buy_no) {
    ModelAndView mav = new ModelAndView();
    
    BuyVO buyVO = this.buyProc.read(buy_no); // 수정용 읽기
    mav.addObject("buyVO", buyVO); // request.setAttribute("qnaVO", qnaVO);
    
    List<BuyVO> list = this.buyProc.list_update_desc(buy_no);
    mav.addObject("list", list);
    
    mav.setViewName("/buy/read_update"); // webapp/buy/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/buy/update.do
  /**
   * 수정 처리
   * @param buyVO
   * @return
   */
  @RequestMapping(value="/buy/update.do", method=RequestMethod.POST )
  public ModelAndView update(BuyVO buyVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.buyProc.update(buyVO);
    mav.addObject("cnt", cnt); // request에 저장

    mav.setViewName("/buy/update_msg"); // webapp/buy/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/buy/delete.do
  /**
   * 삭제 폼
   * @return
   */
  @RequestMapping(value="/buy/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int buy_no) {
    ModelAndView mav = new ModelAndView();
    
    BuyVO buyVO = this.buyProc.read(buy_no);
    mav.addObject("buyVO", buyVO);
    
    mav.setViewName("/buy/read_delete"); // webapp/buy/read_delete.jsp
    
    return mav;
  }
  
  /**
   * 삭제 처리
   * @param buy_no
   * @return
   */
  @RequestMapping(value = "/buy/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int buy_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.buyProc.delete(buy_no);
    mav.addObject("cnt", cnt); // request에 저장

    mav.setViewName("/buy/delete_msg"); // webapp/buy/delete_msg.jsp

    return mav;
  }
  
  
}
