package dev.mvc.review_reply;

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
public class Review_ReplyCont {
  @Autowired
  @Qualifier("dev.mvc.review_reply.Review_ReplyProc")
  private Review_ReplyProcInter review_replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  
   /**
   * ��� ��� ó��
   * @param review_ReplyVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_reply/create.do",
                            method = RequestMethod.POST,
                            produces = "text/plain;charset=UTF-8")
  public String create(Review_ReplyVO review_ReplyVO) {
    int cnt = review_replyProc.create(review_ReplyVO);
    
    JSONObject obj = new JSONObject();
    obj.put("cnt",cnt);
 
    return obj.toString(); // {"count":1}

  }
  
   /**
   * �����ڸ� ��� Ȯ�� ����
   * @param session
   * @return
   */
  @RequestMapping(value="/review_reply/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (adminProc.isAdmin(session)) {
      List<Review_Reply_MemberVO> list = review_replyProc.list_member_join();
      
      mav.addObject("list", list);
      mav.setViewName("/review_reply/list_join"); // /webapp/reply/list_join.jsp

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
  @RequestMapping(value = "/review_reply/list_by_review_no.do",
                            method = RequestMethod.GET,
                            produces = "text/plain;charset=UTF-8")
  public String list_by_review_no(int review_no) {
    List<Review_ReplyVO> list = review_replyProc.list_by_review_no(review_no);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString(); 

  }
  
  
  /**
   * http://localhost:9090/team2/review_reply/list_by_review_no_join.do?review_no=45 ����� JSON �迭 �������� ���
   * @param review_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_reply/list_by_review_no_join.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
  public String list_by_review_no_join(int review_no) {
    
    List<Review_Reply_MemberVO> list = review_replyProc.list_by_review_no_join(review_no);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString();     
  }
  
   /**
   * �н����带 �˻��� �� ��۸� ���� 
   * http://localhost:9090/team2/review_reply/delete.do?review_reply_no=1&review_reply_passwd=1234  --> GET ������� �׽�Ʈ�غ��� ����
   * @param review_reply_no
   * @param review_reply_passwd
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_reply/delete.do", 
                              method = RequestMethod.POST,
                              produces = "text/plain;charset=UTF-8")
  public String delete(int review_reply_no, String review_reply_passwd) {
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("review_reply_no", review_reply_no);
    map.put("review_reply_passwd", review_reply_passwd);
    
    int passwd_cnt = review_replyProc.checkPasswd(map);    // �н����� ��ġ ����, 1: ��ġ, 0: ����ġ
    int delete_cnt = 0;                                                // ������ ���
    if (passwd_cnt == 1) {                                            // �н����尡 ��ġ�� ��� 
      delete_cnt = review_replyProc.delete(review_reply_no); // ��� ����
    }
    
    JSONObject obj = new JSONObject();
    obj.put("passwd_cnt", passwd_cnt);                            // �н����� ��ġ ����, 1: ��ġ, 0: ����ġ
    obj.put("delete_cnt", delete_cnt);                              // ������ ���
    
    return obj.toString();
  }
  
  /**
   * ������ ��ư ����¡ ���
   * http://localhost:9090/team2/review_reply/list_by_review_no_join_add.do?review_no=53&review_replyPage=1
   * @param review_no
   * @param review_replyPage
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/review_reply/list_by_review_no_join_add.do",
                              method = RequestMethod.GET,
                              produces = "text/plain;charset=UTF-8")
  public String list_by_review_no_join_add(int review_no, int review_replyPage) {
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("review_no", review_no); 
    map.put("review_replyPage", review_replyPage);    
    
    List<Review_Reply_MemberVO> list = review_replyProc.list_by_review_no_join_add(map);
    
    JSONObject obj = new JSONObject();
    obj.put("list", list);
 
    return obj.toString();     
  }
  
  
  
  
  

}
