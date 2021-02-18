package dev.mvc.product_attachfile;

import java.util.List;

public interface Product_AttachfileDAOInter {
  /**
   * 
   * @param attachfileVO
   * @return
   */
  public int create(Product_AttachfileVO product_attachfileVO);
  
  /**
   * 
   * @return
   */
  public List<Product_AttachfileVO> list();
  
  /**
   * 
   * @param attachfileno
   * @return
   */
  public Product_AttachfileVO read(int product_attachfile_no);
  
  /**
   * 
   * @param contentsno
   * @return
   */
  public List<Product_AttachfileVO> list_by_product_no(int product_no);
  
  /**
   * 
   * @param attachfileno
   * @return
   */
  public int delete(int product_attachfile_no);
  
  /**
   * 
   * @param contentsno
   * @return
   */
  public int count_by_product_no(int product_no);

  /**
   * 
   * @param contentsno
   * @return
   */
  public int delete_by_product_no(int product_no);
  
  
}



