package dev.mvc.review_attachfile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.review_attachfile.Review_AttachfileProc")
public class Review_AttachfileProc implements Review_AttachfileProcInter {
  @Autowired
  private Review_AttachfileDAOInter review_attachfileDAO;
  
  @Override
  public int create(Review_AttachfileVO review_AttachfileVO) {
    int cnt = this.review_attachfileDAO.create(review_AttachfileVO);
    return cnt;
  }
  
  @Override
  public List<Review_AttachfileVO> list() {
    List<Review_AttachfileVO> list = this.review_attachfileDAO.list();
    return list;
  }
  
  @Override
  public Review_AttachfileVO read(int review_attachfile_no) {
    Review_AttachfileVO review_AttachfileVO = this.review_attachfileDAO.read(review_attachfile_no);
    
    return review_AttachfileVO;
  }

   /**
   * 첨부 파일 목록, 파일 용량 단위 출력
   */
  @Override
  public List<Review_AttachfileVO> list_by_review_no(int review_no) {
    List<Review_AttachfileVO> list = review_attachfileDAO.list_by_review_no(review_no);
    for (Review_AttachfileVO review_AttachfileVO : list) {
      long review_attachfile_size = review_AttachfileVO.getReview_attachfile_size();
      String rlabel = Tool.unit(review_attachfile_size);  // 파일 단위 적용
      review_AttachfileVO.setRlabel(rlabel);
    }
    return list;
  }
  
  /**
   * 삭제
   */
  @Override
  public int delete(int review_attachfile_no) {
    int cnt = this.review_attachfileDAO.delete(review_attachfile_no);
    return cnt;
    
  }
  
  /**
   * FK별 전체 삭제
   */
  @Override
  public int delete_by_review_no(int review_no) {
    int cnt = this.review_attachfileDAO.delete_by_review_no(review_no);
    return cnt;
  }
  
  /**
   * FK별 갯수
   */
  @Override
  public int count_by_review_no(int review_no) {
    int cnt = this.review_attachfileDAO.count_by_review_no(review_no);
    return cnt;
  }

}
