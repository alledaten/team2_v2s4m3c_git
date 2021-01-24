package dev.mvc.product_reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface Product_ReplyProcInter {
  
  public int create(Product_ReplyVO product_replyVO);
  
  public List<Product_ReplyVO> list();
  
  public List<Product_ReplyVO> list_by_product_no(int product_no);
  
  public List<Product_ReplyMemberVO> list_member_join();

  public List<Product_ReplyMemberVO> list_by_product_no_join(int product_no);
  
  public int checkPasswd(Map<String, Object> map);

  public int delete(int product_reply_no);

  public List<Product_ReplyMemberVO> list_by_product_no_join_add(HashMap<String, Object> map);
  
}

