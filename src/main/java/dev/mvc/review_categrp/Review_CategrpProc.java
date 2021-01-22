package dev.mvc.review_categrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.review_categrp.Review_CategrpProc")
public class Review_CategrpProc implements Review_CategrpProcInter{
  @Autowired
  private Review_CategrpDAOInter review_CategrpDAO;
  
  @Override
  public int create(Review_CategrpVO review_CategrpVO) {
    int cnt = this.review_CategrpDAO.create(review_CategrpVO);
    return cnt;
  }
  
  @Override
  public List<Review_CategrpVO> list_review_categrp_no_asc() {
    List<Review_CategrpVO> list = this.review_CategrpDAO.list_review_categrp_no_asc();
    return list;
  }
  
  @Override
  public Review_CategrpVO read(int review_categrp_no) {
    Review_CategrpVO review_CategrpVO = this.review_CategrpDAO.read(review_categrp_no);
    return review_CategrpVO;
  }
  
  @Override
  public int update(Review_CategrpVO review_CategrpVO) {
    int cnt = this.review_CategrpDAO.update(review_CategrpVO);
    return cnt;
  }
  
  @Override
  public int delete(int review_categrp_no) {
    int cnt = this.review_CategrpDAO.delete(review_categrp_no);
    
    return cnt; 
  }
  
  @Override
  public List<Review_CategrpVO> list_review_categrp_seqno() {
    List<Review_CategrpVO> list = this.review_CategrpDAO.list_review_categrp_seqno();
    
    return list; 
  }
  
  @Override
  public int update_review_categrp_seqno_up(int review_categrp_no) {
    int cnt = this.review_CategrpDAO.update_review_categrp_seqno_up(review_categrp_no);
    
    return cnt;
  }
  
  @Override
  public int update_review_categrp_seqno_down(int review_categrp_no) {
    int cnt = this.review_CategrpDAO.update_review_categrp_seqno_down(review_categrp_no);
    
    return cnt;
  }
  
  
}
