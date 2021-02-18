package dev.mvc.product_reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.product_reply.Product_ReplyProc")
public class Product_ReplyProc implements Product_ReplyProcInter {
  @Autowired
  private Product_ReplyDAOInter product_replyDAO; 
  
  @Override
  public int create(Product_ReplyVO product_replyVO) {
    int count = product_replyDAO.create(product_replyVO);
    return count;
  }

  @Override
  public List<Product_ReplyVO> list() {
    List<Product_ReplyVO> list = product_replyDAO.list();
    return list;
  }

  @Override
  public List<Product_ReplyMemberVO> list_member_join() {
    List<Product_ReplyMemberVO> list = product_replyDAO.list_member_join();
    
    // Æ¯¼ö ¹®ÀÚ º¯°æ
    for (Product_ReplyMemberVO product_replyMemberVO:list) {
      String product_reply_content = product_replyMemberVO.getProduct_reply_content();
      product_reply_content = Tool.convertChar(product_reply_content);
      product_replyMemberVO.setProduct_reply_content(product_reply_content);
    }
    
    return list;
  }
  
  @Override
  public List<Product_ReplyVO> list_by_product_no(int product_no) {
    List<Product_ReplyVO> list = product_replyDAO.list_by_product_no(product_no);
    String product_reply_content = "";
    
    // Æ¯¼ö ¹®ÀÚ º¯°æ
    for (Product_ReplyVO product_replyVO:list) {
      product_reply_content = product_replyVO.getProduct_reply_content();
      product_reply_content = Tool.convertChar(product_reply_content);
      product_replyVO.setProduct_reply_content(product_reply_content);
    }
    return list;
  }

  @Override
  public List<Product_ReplyMemberVO> list_by_product_no_join(int product_no) {
    List<Product_ReplyMemberVO> list = product_replyDAO.list_by_product_no_join(product_no);
    String product_reply_content = "";
    
    // Æ¯¼ö ¹®ÀÚ º¯°æ
    for (Product_ReplyMemberVO product_replyMemberVO:list) {
      product_reply_content = product_replyMemberVO.getProduct_reply_content();
      product_reply_content = Tool.convertChar(product_reply_content);
      product_replyMemberVO.setProduct_reply_content(product_reply_content);
    }
    return list;
  }

  @Override
  public int checkPasswd(Map<String, Object> map) {
    int count = product_replyDAO.checkPasswd(map);
    return count;
  }

  @Override
  public int delete(int product_reply_no) {
    int count = product_replyDAO.delete(product_reply_no);
    return count;
  }

  @Override
  public List<Product_ReplyMemberVO> list_by_product_no_join_add(HashMap<String, Object> map) {
    int record_per_page = 2; // ÇÑÆäÀÌÁö´ç 2°Ç
    
 // replyPage´Â 1ºÎÅÍ ½ÃÀÛ
    int beginOfPage = ((Integer)map.get("replyPage") - 1) * record_per_page; // ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 2ï¿½ï¿½

    int startNum = beginOfPage + 1; 
    int endNum = beginOfPage + record_per_page;  // ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ 2ï¿½ï¿½
    /*
    1 ÆäÀÌÁö: WHERE r >= 1 AND r <= 2
    2 ÆäÀÌÁö: WHERE r >= 3 AND r <= 4
    3 ÆäÀÌÁö: WHERE r >= 5 AND r <= 6
    */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
    
    List<Product_ReplyMemberVO> list = product_replyDAO.list_by_product_no_join_add(map);
    String product_reply_content = "";
    
 // Æ¯¼ö ¹®ÀÚ º¯°æ
    for (Product_ReplyMemberVO product_replyMemberVO:list) {
      product_reply_content = product_replyMemberVO.getProduct_reply_content();
      product_reply_content = Tool.convertChar(product_reply_content);
      product_replyMemberVO.setProduct_reply_content(product_reply_content);
    }
    return list;
  }
 
 
}

