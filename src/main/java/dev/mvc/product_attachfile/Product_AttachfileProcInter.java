package dev.mvc.product_attachfile;

import java.util.List;

public interface Product_AttachfileProcInter {
  /**
   * ���� ���  
   * @param product_attachfileVO
   * @return
   */
  public int create(Product_AttachfileVO product_attachfileVO);
  
  /**
   * ��ü �̹��� ���
   * @return
   */
  public List<Product_AttachfileVO> list();
  
  
  /**
   * ��ȸ
   * @param product_attachfile_no
   * @return
   */
  public Product_AttachfileVO read(int product_attachfile_no);
  
  /**
   * review_no�� ���� ���� ���
   * @param contentsno
   * @return
   */
  public List<Product_AttachfileVO> list_by_product_no(int product_no);
  
  /**
   * ����
   * @param product_attachfile_no
   * @return
   */
  public int delete(int product_attachfile_no);
  
  /**
   * product_no�� ����
   * @param contentsno
   * @return
   */
  public int count_by_product_no(int product_no);

  /**
   * product_no�� ī��Ʈ
   * @param contentsno
   * @return
   */
  public int delete_by_product_no(int product_no);
  
}


