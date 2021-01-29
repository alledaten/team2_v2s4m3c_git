package dev.mvc.review_reply;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.review_reply.Review_ReplyProc")
public class Review_ReplyProc implements Review_ReplyProcInter {
  
  @Autowired
  private Review_ReplyDAOInter review_replyDAO;
  
  @Override
  public int create(Review_ReplyVO review_ReplyVO) {
    int count = review_replyDAO.create(review_ReplyVO);
    return count;
  }
  
  @Override
  public List<Review_ReplyVO> list() {
    List<Review_ReplyVO> list = review_replyDAO.list();
    return list;
  }
  
  @Override
  public List<Review_Reply_MemberVO> list_member_join() {
    List<Review_Reply_MemberVO> list = review_replyDAO.list_member_join();
    
    // 특수 문자 변경
    for (Review_Reply_MemberVO review_Reply_MemberVO:list) {
      String review_reply_content = review_Reply_MemberVO.getReview_reply_content();
      review_reply_content = Tool.convertChar(review_reply_content);
      review_Reply_MemberVO.setReview_reply_content(review_reply_content);
    }
    
    return list;
  }
  
  @Override
  public List<Review_ReplyVO> list_by_review_no(int review_no) {
    List<Review_ReplyVO> list = review_replyDAO.list_by_review_no(review_no);
    String review_reply_content = "";
    
    // 특수 문자 변경
    for (Review_ReplyVO review_ReplyVO:list) {
      review_reply_content = review_ReplyVO.getReview_reply_content();
      review_reply_content = Tool.convertChar(review_reply_content);
      review_ReplyVO.setReview_reply_content(review_reply_content);
    }
    return list;
  }
  
  @Override
  public List<Review_Reply_MemberVO> list_by_review_no_join(int review_no) {
    List<Review_Reply_MemberVO> list = review_replyDAO.list_by_review_no_join(review_no);
    String review_reply_content = "";
    
    // 특수 문자 변경
    for (Review_Reply_MemberVO review_Reply_MemberVO:list) {
      review_reply_content = review_Reply_MemberVO.getReview_reply_content();
      review_reply_content = Tool.convertChar(review_reply_content);
      review_Reply_MemberVO.setReview_reply_content(review_reply_content);
    }
    return list;
  }
  
  @Override
  public int checkPasswd(Map<String, Object> map) {
    int count = review_replyDAO.checkPasswd(map);
    return count;
  }

  @Override
  public int delete(int review_reply_no) {
    int count = review_replyDAO.delete(review_reply_no);
    return count;
  }
  
  @Override
  public List<Review_Reply_MemberVO> list_by_review_no_join_add(HashMap<String, Object> map) {
    int record_per_page = 2; // 한페이지당 2건
    
    // replyPage는 1부터 시작
    int beginOfPage = ((Integer)map.get("replyPage") - 1) * record_per_page; // 한페이지당 2건

    int startNum = beginOfPage + 1; 
    int endNum = beginOfPage + record_per_page;  // 한페이지당 2건
    /*
    1 페이지: WHERE r >= 1 AND r <= 2
    2 페이지: WHERE r >= 3 AND r <= 4
    3 페이지: WHERE r >= 5 AND r <= 6
    */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
    
    List<Review_Reply_MemberVO> list = review_replyDAO.list_by_review_no_join_add(map);
    String review_reply_content = "";
    
    // 특수 문자 변경
    for (Review_Reply_MemberVO review_Reply_MemberVO:list) {
      review_reply_content = review_Reply_MemberVO.getReview_reply_content();
      review_reply_content = Tool.convertChar(review_reply_content);
      review_Reply_MemberVO.setReview_reply_content(review_reply_content);
    }
    
    return list;
  }
 
}
