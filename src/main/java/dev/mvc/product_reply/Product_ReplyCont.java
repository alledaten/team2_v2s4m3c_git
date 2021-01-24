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
  @Qualifier("dev.mvc.product_reply.Product_ReplyProc") // �̸� ����
  private Product_ReplyProcInter product_replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") // �̸� ����
  private AdminProcInter adminProc;
  
  public Product_ReplyCont(){
    System.out.println("--> ReplyCont created.");
  }
  
  /**
   * ��� ��� ó��
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
    
    int passwd_cnt = product_replyProc.checkPasswd(map); // �н����� ��ġ ����, 1: ��ġ, 0: ����ġ
    int delete_cnt = 0;                                    // ������ ���
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ���
      delete_cnt = product_replyProc.delete(product_reply_no); // ��� ����
    }
    
    JSONObject obj = new JSONObject();
    obj.put("passwd_cnt", passwd_cnt); // �н����� ��ġ ����, 1: ��ġ, 0: ����ġ
    obj.put("delete_cnt", delete_cnt); // ������ ���
    
    return obj.toString();
  }
  
  /**
   * ������ ��ư ����¡ ���
   * http://localhost:9090/resort/reply/list_by_contentsno_join_add.do?contentsno=53&replyPage=1
   * @param contentsno ��� �θ�� ��ȣ
   * @param replyPage ��� ������
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


