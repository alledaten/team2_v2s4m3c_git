package dev.mvc.product_attachfile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.product_attachfile.Product_AttachfileProc")
public class Product_AttachfileProc implements Product_AttachfileProcInter {
  @Autowired
  private Product_AttachfileDAOInter product_attachfileDAO;
  
  public Product_AttachfileProc(){

  }

  @Override
  public int create(Product_AttachfileVO product_attachfileVO) {
    int cnt = this.product_attachfileDAO.create(product_attachfileVO);
    
    return cnt;
  }

  @Override
  public List<Product_AttachfileVO> list() {
    List<Product_AttachfileVO> list= this.product_attachfileDAO.list();
    return list;
  }
  
  @Override
  public Product_AttachfileVO read(int product_attachfile_no) {
    Product_AttachfileVO product_attachfileVO = this.product_attachfileDAO.read(product_attachfile_no);
    
    return product_attachfileVO;
  }

  /**
   * Ã·ºÎ ÆÄÀÏ ¸ñ·Ï, ÆÄÀÏ ¿ë·® ´ÜÀ§ Ãâ·Â
   */
  @Override
  public List<Product_AttachfileVO> list_by_product_no(int product_no) {
    List<Product_AttachfileVO> list = product_attachfileDAO.list_by_product_no(product_no);
    for (Product_AttachfileVO product_attachfileVO : list) {
      long product_attachfile_fsize = product_attachfileVO.getProduct_attachfile_fsize();
      String product_attachfile_flabel = Tool.unit(product_attachfile_fsize);  // ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½ ï¿½ï¿½ï¿½ï¿½
      product_attachfileVO.setFlabel(product_attachfile_flabel);
    }
    return list;
  }
  
  /**
   * »èÁ¦
   */
  @Override
  public int delete(int product_attachfile_no) {
    int cnt = this.product_attachfileDAO.delete(product_attachfile_no);
    return cnt;
    
  }

  /**
   * FKº° °¹¼ö
   */
  @Override
  public int count_by_product_no(int product_no) {
    int cnt = this.product_attachfileDAO.count_by_product_no(product_no);
    return cnt;
  }

  /**
   * FKº° ÀüÃ¼ »èÁ¦
   */
  @Override
  public int delete_by_product_no(int product_no) {
    int cnt = this.product_attachfileDAO.delete_by_product_no(product_no);
    return cnt;
  }
  
}




