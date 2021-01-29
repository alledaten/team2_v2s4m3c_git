package dev.mvc.review_reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface Review_ReplyDAOInter {
  
  public int create(Review_ReplyVO review_ReplyVO);
  
  public List<Review_ReplyVO> list();
  
  public List<Review_Reply_MemberVO> list_member_join();
  
  public List<Review_ReplyVO> list_by_review_no(int review_no);
  
   /**
   * Ư���� ���� ��ü ��� ���
   * @param review_no
   * @return
   */
  public List<Review_Reply_MemberVO> list_by_review_no_join(int review_no);
  
  public int checkPasswd(Map<String, Object> map);
  
  public int delete(int review_reply_no);
  
   /**
   * ��� ������(����¡) ��ư
   * @param map
   * @return
   */
  public List<Review_Reply_MemberVO> list_by_review_no_join_add(HashMap<String, Object> map);
  
}
