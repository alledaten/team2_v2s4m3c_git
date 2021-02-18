package dev.mvc.cart;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;
@Controller
public class CartCont {

  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc")
  private CartProcInter cartProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  public CartCont() {
    System.out.println("--> CartCont created.");
  }
  
  @ResponseBody
  @RequestMapping(value = "/cart/create_ajax.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8")
  public String create_ajax(CartVO cartVO, HttpSession session) {
    
    int member_no = (int)session.getAttribute("member_no");
    cartVO.setMember_no(member_no);
    int cnt = this.cartProc.create(cartVO); // 占쎈쾻嚥∽옙
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }

  /**
   * http://localhost:9090/resort/categrp/list.do
   * 
   * @return
   */
  @RequestMapping(value="/cart/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int member_no = (int)session.getAttribute("member_no");

    List<CartVO> list = this.cartProc.list(member_no);

    mav.addObject("list", list);
    
    mav.setViewName("/cart/list");
    

    return mav;
  }
  
 

  /**
   * Ajax  http://localhost:9090/resort/categrp/update_ajax.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/cart/update_ajax.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8")
  public String update_ajax(CartVO cartVO) {

    
    int cnt = this.cartProc.update(cartVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
  
  /**
   * Ajax 기반 삭제 처리 
   * @param cartVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/cart/delete_ajax.do", method = RequestMethod.POST)
  public int delete_ajax(CartVO cartVO, 
                               @RequestParam(value="cartno_list[]") List<String> cartno_list)  {
    
    int result = 0;      // 결과
    int cart_no = 0;   // 카트 번호
    for(String cartno : cartno_list) { 
      cart_no = Integer.parseInt(cartno);  // 형변환
      cartVO.setCart_no(cart_no);  // cart_no 전달
      result = this.cartProc.delete(cartVO);  // 삭제 처리
    } 
    return result;
  }  

}
