package dev.mvc.review_cate;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.review_cate.Review_CateProc")
public class Review_CateProc implements Review_CateProcInter{
  @Autowired
  private Review_CateDAOInter review_CateDAO;
  
  @Override
  public int create(Review_CateVO review_CateVO) {
    int cnt = this.review_CateDAO.create(review_CateVO);
    return cnt;
  }
  
  @Override
  public List<Review_Categrp_Review_Cate_join> list_join() {
    List<Review_Categrp_Review_Cate_join> list = this.review_CateDAO.list_join();
    return list;
  }
  
  @Override
  public List<Review_Categrp_Review_Cate_join> list_join_by_review_categrp_no(int review_categrp_no) {
    List<Review_Categrp_Review_Cate_join> list = this.review_CateDAO.list_join_by_review_categrp_no(review_categrp_no);
    return list;
  }
  
  @Override
  public Review_CateVO read(int review_cate_no) {
    Review_CateVO review_CateVO = this.review_CateDAO.read(review_cate_no);
    return review_CateVO;
  }
  
  @Override
  public int update(Review_CateVO review_CateVO) {
    int cnt = this.review_CateDAO.update(review_CateVO);
    return cnt;
  }
  
  @Override
  public int delete(int review_cate_no) {
    int cnt = this.review_CateDAO.delete(review_cate_no);
    return cnt;
  }
  
  @Override
  public int update_review_cate_seqno_up(int review_cate_no) {
    int cnt = this.review_CateDAO.update_review_cate_seqno_up(review_cate_no);
    return cnt;
  }
  
  @Override
  public int update_review_cate_seqno_down(int review_cate_no) {
    int cnt = this.review_CateDAO.update_review_cate_seqno_down(review_cate_no);
    return cnt;
  }
  
  @Override
  public int increaseCnt(int review_cate_no) {
    int cnt = this.review_CateDAO.increaseCnt(review_cate_no);
    return cnt;
  }

  @Override
  public int decreaseCnt(int review_cate_no) {
    int cnt = this.review_CateDAO.decreaseCnt(review_cate_no);
    return cnt;
  }
  
  
}
