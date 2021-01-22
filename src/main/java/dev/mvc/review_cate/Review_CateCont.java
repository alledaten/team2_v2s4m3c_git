package dev.mvc.review_cate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.review_categrp.Review_CategrpProcInter;
import dev.mvc.review_categrp.Review_CategrpVO;

@Controller
public class Review_CateCont {
  @Autowired
  @Qualifier("dev.mvc.review_cate.Review_CateProc")
  private Review_CateProcInter review_CateProc;
  
  @Autowired
  @Qualifier("dev.mvc.review_categrp.Review_CategrpProc")
  private Review_CategrpProcInter review_CategrpProc;
  
   /** 
   * http://localhost:9090/team2/review_cate/create.do
   * 등록폼
   * @return
   */
  @RequestMapping(value = "/review_cate/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review_cate/create");
    
    return mav;
  }
  
   /**
   * 등록 처리
   * @param review_CateVO
   * @return
   */
  @RequestMapping(value = "/review_cate/create.do", method = RequestMethod.POST)
  public ModelAndView create(Review_CateVO review_CateVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CateProc.create(review_CateVO);
    mav.addObject("cnt", cnt);
    
    mav.setViewName("redirect:/review_cate/list.do?review_categrp_no=" + review_CateVO.getReview_categrp_no()); // 파라미터 자동 전달 안됨. 
    
    return mav;
  }
  

   /**
   * Review_Categrp + Review_Cate join 전체 목록
   * @return
   */
  @RequestMapping(value="/review_cate/list_join.do", method=RequestMethod.GET )
  public ModelAndView list_join() {
    ModelAndView mav = new ModelAndView();
    
    List<Review_Categrp_Review_Cate_join> list = this.review_CateProc.list_join();
    mav.addObject("list", list); 

    mav.setViewName("/review_cate/list_join"); 
    return mav;
  }
  
   /**
   * Review_Categrp + Review_Cate join의 Categrpno 별 목록
   * @return
   */
  @RequestMapping(value="/review_cate/list.do", method=RequestMethod.GET )
  public ModelAndView list_join_by_review_categrp_no(int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_categrp_no);
    mav.addObject("review_CategrpVO", review_CategrpVO); 
    
    List<Review_Categrp_Review_Cate_join> list = this.review_CateProc.list_join_by_review_categrp_no(review_categrp_no);
    mav.addObject("list", list); 

    mav.setViewName("/review_cate/list_join_by_review_categrp_no");  

    return mav;
  }
  
   /**
   * 조회 및 수정폼
   * @param review_cate_no
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_cate/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(int review_cate_no, int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review_cate/read_update"); 

    Review_CateVO review_CateVO = this.review_CateProc.read(review_cate_no);
    mav.addObject("review_CateVO", review_CateVO);

    List<Review_Categrp_Review_Cate_join> list = this.review_CateProc.list_join_by_review_categrp_no(review_categrp_no);
    mav.addObject("list", list);

    return mav; // forward
  }
  
   /**
   * 수정 처리
   * @param review_CateVO
   * @return
   */
  @RequestMapping(value = "/review_cate/update.do", method = RequestMethod.POST)
  public ModelAndView update(Review_CateVO review_CateVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.review_CateProc.update(review_CateVO);
    mav.addObject("cnt", cnt); 

    mav.setViewName("redirect:/review_cate/list.do?review_categrp_no=" + review_CateVO.getReview_categrp_no()); // 파라미터 자동 전달 안됨. 

    return mav;
  }
  
   /**
   * 조회 + 삭제폼
   * @param review_cate_no
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_cate/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(int review_cate_no, int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review_cate/read_delete"); 

    Review_CateVO review_CateVO = this.review_CateProc.read(review_cate_no);
    mav.addObject("review_CateVO", review_CateVO);

    List<Review_Categrp_Review_Cate_join> list = this.review_CateProc.list_join_by_review_categrp_no(review_categrp_no);
    mav.addObject("list", list);

    return mav; // forward
  }
  
  
  /**
   * 삭제 처리
   * @param review_cate_no
   * @return
   */
  @RequestMapping(value = "/review_cate/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int review_cate_no, int review_categrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.review_CateProc.delete(review_cate_no);
    mav.addObject("cnt", cnt); 

    mav.setViewName("redirect:/review_cate/list.do?review_categrp_no=" + review_categrp_no); // 파라미터 자동 전달 안됨. 

    return mav;
  }
  
   /**
   * 우선 순위 상향
   * @param review_cate_no
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_cate/update_review_cate_seqno_up.do", method = RequestMethod.GET)
  public ModelAndView update_review_cate_seqno_up(int review_cate_no, int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CateProc.update_review_cate_seqno_up(review_cate_no);
    mav.setViewName("redirect:/review_cate/list.do?review_categrp_no=" + review_categrp_no);
    
    return mav;
  }
  
  /**
   * 우선 순위 하향
   * @param review_cate_no
   * @param review_categrp_no
   * @return
   */
  @RequestMapping(value = "/review_cate/update_review_cate_seqno_down.do", method = RequestMethod.GET)
  public ModelAndView update_review_cate_seqno_down(int review_cate_no, int review_categrp_no) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.review_CateProc.update_review_cate_seqno_down(review_cate_no);
    mav.setViewName("redirect:/review_cate/list.do?review_categrp_no=" + review_categrp_no);
    
    return mav;
  }
  

}
