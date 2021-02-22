package dev.mvc.coupon;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.point.PointVO;



@Controller
public class CouponCont {
  @Autowired
  @Qualifier("dev.mvc.coupon.CouponProc")
  private CouponProcInter couponProc;
  
  /**
   * ����� http;//localhost:9090/team2/coupon/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/coupon/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/coupon/create"); // /webapp/coupon/create.jsp

    return mav; // forward
  }
  
  /**
   * ��� ó�� http;//localhost:9090/tema2/coupon/create.do
   * 
   * @return
   */

    @RequestMapping(value = "/coupon/create.do", method = RequestMethod.POST) 
    public ModelAndView create(CouponVO couponVO) {
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/coupon/create_msg"); // /webapp/coupon/create_msg.jsp
    
    int cnt = this.couponProc.create(couponVO); // ��� ó��
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    return mav; // forward
  }
  
  /**
   * ��� http;//localhost:9090/team2/coupon/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/coupon/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/coupon/list"); // /webapp/coupon/list.jsp

    List<CouponVO> list = this.couponProc.list_coupon_desc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  // http://localhost:9090/team2/coupon/read.do
  /**
   * ��ȸ
   * @return
   */
  @RequestMapping(value="/coupon/read.do", method=RequestMethod.GET )
  public ModelAndView read(int coupon_no) {
    ModelAndView mav = new ModelAndView();

    CouponVO couponVO = this.couponProc.read(coupon_no);
    mav.addObject("couponVO", couponVO); 
    
    mav.setViewName("/coupon/read"); // /webapp/coupon/read.jsp
    
    return mav;
  }
  
  /**
  * AJax ���� ��ȸ
  * http://localhost:9090/team2/coupon/read_coupon.do?member_no=1
  * @param contentsno
  * @return
  */
  @ResponseBody
  @RequestMapping(value = "/coupon/read_coupon.do",
                            method = RequestMethod.GET,
                            produces = "text/plain;charset=UTF-8")
  public String read_coupon(int member_no) {
    CouponVO couponVO = couponProc.read_coupon(member_no);
    
    JSONObject obj = new JSONObject();
    obj.put("member_no", member_no);
    obj.put("coupon_num", couponVO.getCoupon_num());
 
    return obj.toString(); 

  }
  
  // http://localhost:9090/team2/coupon/update.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/coupon/update.do", method=RequestMethod.GET )
  public ModelAndView update(int coupon_no) {
    ModelAndView mav = new ModelAndView();
    
    CouponVO couponVO = this.couponProc.read(coupon_no); // ������ �б�
    mav.addObject("couponVO", couponVO); 
    
    List<CouponVO> list = this.couponProc.list_coupon_desc();
    mav.addObject("list", list);
    
    mav.setViewName("/coupon/update"); // webapp/coupon/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/coupon/update.do
  /**
   * ���� ó��
   * @param couponVO
   * @return
   */
  @RequestMapping(value="/coupon/update.do", method=RequestMethod.POST )
  public ModelAndView update(CouponVO couponVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.couponProc.update(couponVO);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/coupon/update_msg"); // webapp/coupon/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/coupon/delete.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/coupon/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int coupon_no) {
    ModelAndView mav = new ModelAndView();
    
    CouponVO couponVO = this.couponProc.read(coupon_no);
    mav.addObject("couponVO", couponVO);
    
    mav.setViewName("/coupon/read_delete"); // webapp/coupon/read_delete.jsp
    
    return mav;
  }
  
  /**
   * ���� ó��
   * @param coupon_no
   * @return
   */
  @RequestMapping(value = "/coupon/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int coupon_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.couponProc.delete(coupon_no);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/coupon/delete_msg"); // webapp/coupon/delete_msg.jsp

    return mav;
  }
  
  
  
  
}
