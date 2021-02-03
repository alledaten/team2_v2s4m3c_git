package dev.mvc.review;

import java.util.HashMap;





import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.review.ReviewProc")
public class ReviewProc implements ReviewProcInter{
  @Autowired
  private ReviewDAOInter reviewDAO;
  
  @Override
  public int create(ReviewVO reviewVO) {
    int cnt = this.reviewDAO.create(reviewVO);
    return cnt;
  }
  
  @Override
  public List<ReviewVO> list_all() {
    List<ReviewVO> list = this.reviewDAO.list_all();
    return list;
  }
  
  @Override
  public List<Review_Member_ProductVO> list_by_product_no(int product_no) {
    List<Review_Member_ProductVO> list = this.reviewDAO.list_by_product_no(product_no);
    return list;
  }
  
  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int count = reviewDAO.search_count(hashMap);
    return count;
  }
  
  @Override
  public List<Review_Member_ProductVO> list_by_product_no_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������ ���� rownum: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������ ���� rownum: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������ ���� rownum: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)map.get("nowPage") - 1) * Review.RECORD_PER_PAGE;
   
    // ���� rownum ����
    // 1 ������ = 0 + 1, 2 ������ = 10 + 1, 3 ������ = 20 + 1 
    int startNum = beginOfPage + 1;
    
    //  ���� rownum
    // 1 ������ = 0 + 10, 2 ������ = 0 + 20, 3 ������ = 0 + 30
    int endNum = beginOfPage + Review.RECORD_PER_PAGE;   
    /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
   
    List<Review_Member_ProductVO> list = this.reviewDAO.list_by_product_no_search_paging(map);
    
    return list;
  }
  

  @Override
  public String pagingBox(String listFile, int product_no, int search_count, int nowPage, String review_word) { 
    int totalPage = (int)(Math.ceil((double)search_count/Review.RECORD_PER_PAGE)); // ��ü ������  
    
    int totalGrp = (int)(Math.ceil((double)totalPage/Review.PAGE_PER_BLOCK));// ��ü �׷� 
    
    int nowGrp = (int)(Math.ceil((double)nowPage/Review.PAGE_PER_BLOCK));    // ���� �׷� 
    
    int startPage = ((nowGrp - 1) * Review.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    
    int endPage = (nowGrp * Review.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page)
    // nowGrp: 2 (11 ~ 20 page)
    // nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� ������ ������ 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� ������ ������ 20
    int _nowPage = (nowGrp-1) * Review.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&review_word="+review_word+"&nowPage="+_nowPage+"&product_no="+product_no+"'>����</A></span>"); 
    } 
 
    // �߾��� ������ ���
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ // ������ �������� �Ѿ�ٸ� ���� ��� ����
        break; 
      } 
  
      if (nowPage == i){ // �������� ������������ ���ٸ� CSS ����(������ ��)
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� �������� �̵��� �����ϵ��� ��ũ�� ����
        str.append("<span class='span_box_1'><A href='"+listFile+"?review_word="+review_word+"&nowPage="+i+"&product_no="+product_no+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� ���������� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� ���������� 21
    _nowPage = (nowGrp * Review.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&review_word="+review_word+"&nowPage="+_nowPage+"&product_no="+product_no+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
  
  /**
   * 1�� ��ȸ
   */
  @Override
  public ReviewVO read(int review_no) {
    ReviewVO reviewVO = this.reviewDAO.read(review_no);
    
    String review_title = reviewVO.getReview_title();
    // String review_content = reviewVO.getReview_content(); -> Ckeditor ����ϱ� ������ �ּ�ó�� �Ͽ���

    review_title = Tool.convertChar(review_title);  // Ư�� ���� ó��
    // content = Tool.convertChar(content); // Ckeditor ���� ������� �� ��.
    
    reviewVO.setReview_title(review_title);
    // contentsVO.setContent(content);  // Ckeditor ���� ������� �� ��.
    
    long review_size = reviewVO.getReview_size();
    reviewVO.setReview_size_label(Tool.unit(review_size));

    return reviewVO;
  }
  
  /**
   * ������ ��ȸ
   */
  @Override
  public ReviewVO read_update(int review_no) {
    ReviewVO reviewVO = this.reviewDAO.read(review_no);
    return reviewVO;
  }

  /**
   * ���� ó��
   */
  @Override
  public int update(ReviewVO reviewVO) {
    int cnt = this.reviewDAO.update(reviewVO);
    return cnt;
  }
  
  // ���� 
  @Override
  public int delete(int review_no) {
    int cnt = this.reviewDAO.delete(review_no);
    return cnt;
  }

  /**
   * �н����� üũ
   */
  @Override
  public int passwd_check(HashMap<String, Object> hashMap) {
    int passwd_cnt = this.reviewDAO.passwd_check(hashMap);
    return passwd_cnt;
  } 
  
  @Override
  public int img_create(ReviewVO reviewVO) {
    int cnt = this.reviewDAO.img_update(reviewVO);
    return cnt;
  }

  @Override
  public int img_update(ReviewVO reviewVO) {
    int cnt = this.reviewDAO.img_update(reviewVO);
    return cnt;
  }
  
  @Override
  public int img_delete(ReviewVO reviewVO) {
    int cnt = this.reviewDAO.img_update(reviewVO);
    return cnt;
  }
  
  @Override
  public int update_review_view(int review_no) {
    int cnt = this.reviewDAO.update_review_view(review_no);
    return cnt;
  }

  
  
}
