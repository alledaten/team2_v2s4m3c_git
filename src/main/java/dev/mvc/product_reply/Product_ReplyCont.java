package dev.mvc.product_reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;

@Controller
public class Product_ReplyCont {
  @Autowired
  @Qualifier("dev.mvc.product_reply.Product_ReplyProc") 
  private Product_ReplyProcInter product_replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  /**
   * 댓글 등록 처리
   * @param product_replyVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_reply/create.do",
                            method = RequestMethod.POST,
                            produces = "text/plain;charset=UTF-8")
  public String create(Product_ReplyVO product_replyVO) {
    int cnt = product_replyProc.create(product_replyVO);
    
    JSONObject obj = new JSONObject();
    obj.put("cnt",cnt);
 
    return obj.toString(); // {"cnt":1}

  }
  
  /**
   * 관리자만 목록 확인 가능
   * @param session
   * @return
   */
  @RequestMapping(value="/product_reply/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (adminProc.isAdmin(session)) {
      List<Product_ReplyMemberVO> list = product_replyProc.list_member_join();
      
      mav.addObject("list", list);
      mav.setViewName("/product_reply/list_join"); // /webapp/reply/list_join.jsp

    } else {
      mav.setViewName("redirect:/admin/login_need.jsp"); // /webapp/admin/login_need.jsp
    }
    
    return mav;
  }
  
  /**
   * http://localhost:9090/team2/review_reply/list_by_review_no.do?review_no=1
   * @param review_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_reply/list_by_product_no.do",
                            method = RequestMethod.GET,
                            produces = "text/plain;charset=UTF-8")
  public String list_by_product_no(int product_no) {
    List<Product_ReplyVO> list = product_replyProc.list_by_product_no(product_no);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString(); 

  }
  
  /**
   * http://localhost:9090/team2/product__reply/list_by_product_no_join.do?product_no=45 목록을 JSON 배열 형식으로 사용
   * @param review_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_reply/list_by_product_no_join.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
  public String list_by_product_no_join(int product_no) {
    
    List<Product_ReplyMemberVO> list = product_replyProc.list_by_product_no_join(product_no);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString();     
  }

  /**
   * 패스워드를 검사한 후 댓글만 삭제 
   * http://localhost:9090/team2/product_reply/delete.do?product_reply_no=1&review_reply_passwd=1234  --> GET 방식으로 테스트해볼수 있음
   * @param review_reply_no
   * @param review_reply_passwd
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_reply/delete.do", 
                              method = RequestMethod.POST,
                              produces = "text/plain;charset=UTF-8")
  public String delete(int product_reply_no, String product_reply_passwd) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("product_reply_no", product_reply_no);
    map.put("product_reply_passwd", product_reply_passwd);
    
    int passwd_cnt = product_replyProc.checkPasswd(map); 
    int delete_cnt = 0;                                   
    if (passwd_cnt == 1) {
      delete_cnt = product_replyProc.delete(product_reply_no); 
    }
    
    JSONObject obj = new JSONObject();
    obj.put("passwd_cnt", passwd_cnt); 
    obj.put("delete_cnt", delete_cnt);
    
    return obj.toString();
  }
  
  /**
   * 
   * http://localhost:9090/team2/product_reply/list_by_product_no_join_add.do?product_no=53&replyPage=1
   * @param product_no 
   * @param replyPage 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_reply/list_by_product_no_join_add.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
  public String list_by_product_no_join(int product_no, int replyPage) {
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("product_no", product_no); 
    map.put("replyPage", replyPage);    
    
    List<Product_ReplyMemberVO> list = product_replyProc.list_by_product_no_join_add(map);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString();     
  }
  
}


