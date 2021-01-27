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
  @Qualifier("dev.mvc.product_reply.Product_ReplyProc") // 占싱몌옙 占쏙옙占쏙옙
  private Product_ReplyProcInter product_replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") // 占싱몌옙 占쏙옙占쏙옙
  private AdminProcInter adminProc;
  
  public Product_ReplyCont(){
    System.out.println("--> ReplyCont created.");
  }
  
  /**
   * 占쏙옙占� 占쏙옙占� 처占쏙옙
   * @param replyVO
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

  @ResponseBody
  @RequestMapping(value = "/product_reply/delete.do", 
                              method = RequestMethod.POST,
                              produces = "text/plain;charset=UTF-8")
  public String delete(int product_reply_no, String product_reply_passwd) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("product_reply_no", product_reply_no);
    map.put("product_reply_passwd", product_reply_passwd);
    
    int passwd_cnt = product_replyProc.checkPasswd(map); // 占싻쏙옙占쏙옙占쏙옙 占쏙옙치 占쏙옙占쏙옙, 1: 占쏙옙치, 0: 占쏙옙占쏙옙치
    int delete_cnt = 0;                                    // 占쏙옙占쏙옙占쏙옙 占쏙옙占�
    if (passwd_cnt == 1) { // 占싻쏙옙占쏙옙占썲가 占쏙옙치占쏙옙 占쏙옙占�
      delete_cnt = product_replyProc.delete(product_reply_no); // 占쏙옙占� 占쏙옙占쏙옙
    }
    
    JSONObject obj = new JSONObject();
    obj.put("passwd_cnt", passwd_cnt); // 占싻쏙옙占쏙옙占쏙옙 占쏙옙치 占쏙옙占쏙옙, 1: 占쏙옙치, 0: 占쏙옙占쏙옙치
    obj.put("delete_cnt", delete_cnt); // 占쏙옙占쏙옙占쏙옙 占쏙옙占�
    
    return obj.toString();
  }
  
  /**
   * 占쏙옙占쏙옙占쏙옙 占쏙옙튼 占쏙옙占쏙옙징 占쏙옙占�
   * http://localhost:9090/resort/reply/list_by_contentsno_join_add.do?contentsno=53&replyPage=1
   * @param contentsno 占쏙옙占� 占싸몌옙占� 占쏙옙호
   * @param replyPage 占쏙옙占� 占쏙옙占쏙옙占쏙옙
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_reply/list_by_product_no_join_add.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
  public String list_by_product_no_join(int product_no, int replyPage) {
  //    System.out.println("contentsno: " + contentsno);
  //    System.out.println("replyPage: " + replyPage);
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("product_no", product_no); 
    map.put("replyPage", replyPage);    
    
    List<Product_ReplyMemberVO> list = product_replyProc.list_by_product_no_join_add(map);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString();     
  }
  
}


