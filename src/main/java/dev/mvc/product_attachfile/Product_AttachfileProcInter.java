package dev.mvc.product_attachfile;

import java.util.List;

public interface Product_AttachfileProcInter {
  /**
   * 파일 등록  
   * @param product_attachfileVO
   * @return
   */
  public int create(Product_AttachfileVO product_attachfileVO);
  
  /**
   * 전체 이미지 목록
   * @return
   */
  public List<Product_AttachfileVO> list();
  
  
  /**
   * 조회
   * @param product_attachfile_no
   * @return
   */
  public Product_AttachfileVO read(int product_attachfile_no);
  
  /**
   * review_no에 따른 파일 목록
   * @param contentsno
   * @return
   */
  public List<Product_AttachfileVO> list_by_product_no(int product_no);
  
  /**
   * 삭제
   * @param product_attachfile_no
   * @return
   */
  public int delete(int product_attachfile_no);
  
  /**
   * product_no별 삭제
   * @param contentsno
   * @return
   */
  public int count_by_product_no(int product_no);

  /**
   * product_no별 카운트
   * @param contentsno
   * @return
   */
  public int delete_by_product_no(int product_no);
  
}


