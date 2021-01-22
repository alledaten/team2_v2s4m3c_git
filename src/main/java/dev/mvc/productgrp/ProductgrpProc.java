package dev.mvc.productgrp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.productgrp.ProductgrpProc")
public class ProductgrpProc implements ProductgrpProcInter{
  @Autowired
  private ProductgrpDAOInter productgrpDAO;
  
  public ProductgrpProc() {
    System.out.println("--> ProductgrpProc created.");
  }

  @Override
  public int create(ProductgrpVO productgrpVO) {
    int cnt = this.productgrpDAO.create(productgrpVO);
    return cnt;
  }

  @Override
  public List<ProductgrpVO> list_productgrp_seqno_asc() {
    List<ProductgrpVO> list = this.productgrpDAO.list_productgrp_seqno_asc();
    return list;
  }

  @Override
  public ProductgrpVO read(int productgrp_no) {
    ProductgrpVO productgrpVO = this.productgrpDAO.read(productgrp_no);
    
    return productgrpVO;
  }
  
  public int update(ProductgrpVO productgrpVO) {
    int cnt = this.productgrpDAO.update(productgrpVO);
    
    return cnt;
  }
  
  public int delete(int productgrp_no) {
    int cnt = this.productgrpDAO.delete(productgrp_no);
    
    return cnt;
  }
  
  public int update_seqno_up(int productgrp_no) {
    int cnt = this.productgrpDAO.update_seqno_up(productgrp_no);
    return cnt;
  }
  
  public int update_seqno_down(int productgrp_no) {
    int cnt = this.productgrpDAO.update_seqno_down(productgrp_no);
    return cnt;
  }
  
  public int update_productgrp_visible(ProductgrpVO productgrpVO) {
    if (productgrpVO.getProductgrp_visible().equalsIgnoreCase("Y")) {
      productgrpVO.setProductgrp_visible("N");  
    } else {
      productgrpVO.setProductgrp_visible("Y");
    }
    
    int cnt = this.productgrpDAO.update_productgrp_visible(productgrpVO);
    return cnt;
  }
  
  @Override
  public int increaseCnt(int productgrp_no) {
    int cnt = this.productgrpDAO.increaseCnt(productgrp_no);
    return cnt;
  }

  @Override
  public int decreaseCnt(int productgrp_no) {
    int cnt = this.productgrpDAO.decreaseCnt(productgrp_no);
    return cnt;
  }

}
