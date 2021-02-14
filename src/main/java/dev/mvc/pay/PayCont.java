package dev.mvc.pay;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.buy.BuyProcInter;
import dev.mvc.buy.BuyVO;
import dev.mvc.dev.DevVO;



@Controller
public class PayCont {
  @Autowired
  @Qualifier("dev.mvc.buy.BuyProc")
  private BuyProcInter buyProc;
  @Autowired
  @Qualifier("dev.mvc.pay.PayProc")
  private PayProcInter payProc;
  
  /**
   * ����� http;//localhost:9090/team2/pay/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/pay/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/pay/create"); // /webapp/pay/create.jsp

    return mav; // forward
  }
  
  /**
   * ��� ó�� http;//localhost:9090/tema2/pay/create.do
   * 
   * @return
   */
  /*
   * @RequestMapping(value = "/pay/create.do", method = RequestMethod.POST) public
   * ModelAndView create(PayVO payVO) { // request.setAttribute("devVO", devVO) �ڵ�
   * ����
   * 
   * ModelAndView mav = new ModelAndView(); mav.setViewName("/pay/create_msg"); //
   * /webapp/dev/create_msg.jsp
   * 
   * int cnt = this.payProc.create(payVO); // ��� ó�� mav.addObject("cnt", cnt); //
   * request.setAttribute("cnt", cnt)
   * 
   * return mav; // forward }
   */
  
  /**
   * Ajax ��� ó��
   * @param payVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/pay/create.do",
                            method = RequestMethod.POST,
                            produces = "text/plain;charset=UTF-8")
  public String create(PayVO payVO) {
    
    int cnt = this.payProc.create(payVO);
    
    JSONObject obj = new JSONObject();
    
    obj.put("cnt",cnt);
 
    return obj.toString(); // {"cnt":1}

  }
  
  /**
   * ��� http;//localhost:9090/team2/pay/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/pay/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/pay/list"); // /webapp/pay/list.jsp

    List<PayVO> list = this.payProc.list_pay_desc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  // http://localhost:9090/team2/pay/read.do
  /**
   * ��ȸ
   * @return
   */
  @RequestMapping(value="/pay/read.do", method=RequestMethod.GET )
  public ModelAndView read(int pay_no) {
    ModelAndView mav = new ModelAndView();

    PayVO payVO = this.payProc.read(pay_no);
    mav.addObject("payVO", payVO); // request.setAttribute("devVO", devVO);
    
    BuyVO buyVO = this.buyProc.read(payVO.getBuy_no());
    mav.addObject("buyVO", buyVO);
    
    mav.setViewName("/pay/read"); // /webapp/dev/read.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/pay/update.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/pay/update.do", method=RequestMethod.GET )
  public ModelAndView update(int pay_no) {
    ModelAndView mav = new ModelAndView();
    
    PayVO payVO = this.payProc.read(pay_no); // ������ �б�
    mav.addObject("payVO", payVO); // request.setAttribute("qnaVO", qnaVO);
    
    List<PayVO> list = this.payProc.list_pay_desc();
    mav.addObject("list", list);
    
    mav.setViewName("/pay/update"); // webapp/pay/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/pay/update.do
  /**
   * ���� ó��
   * @param payVO
   * @return
   */
  @RequestMapping(value="/pay/update.do", method=RequestMethod.POST )
  public ModelAndView update(PayVO payVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.payProc.update(payVO);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/pay/update_msg"); // webapp/pay/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/pay/delete.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/pay/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int pay_no) {
    ModelAndView mav = new ModelAndView();
    
    PayVO payVO = this.payProc.read(pay_no);
    mav.addObject("payVO", payVO);
    
    mav.setViewName("/pay/read_delete"); // webapp/pay/read_delete.jsp
    
    return mav;
  }
  
  /**
   * ���� ó��
   * @param pay_no
   * @return
   */
  @RequestMapping(value = "/pay/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int pay_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.payProc.delete(pay_no);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/pay/delete_msg"); // webapp/pay/delete_msg.jsp

    return mav;
  }
  
  
  
  
}
