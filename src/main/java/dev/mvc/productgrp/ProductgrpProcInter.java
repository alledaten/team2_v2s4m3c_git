package dev.mvc.productgrp;

import java.util.List;

public interface ProductgrpProcInter {
  
  /**
   * 
   * ��ǰ �׷� ���
   * @param productgrpVO
   * @return
   */
  public int create(ProductgrpVO productgrpVO);
  
  public List<ProductgrpVO> list_productgrp_seqno_asc();
  
  public ProductgrpVO read(int productgrp_no);
  
  public int update(ProductgrpVO productgrpVO);
  
  public int delete(int productgrp_no);
  
  public int update_seqno_up(int productgrp_no);
  
  public int update_seqno_down(int productgrp_no);
  
  public int update_productgrp_visible(ProductgrpVO productgrpVO);
  
  public int increaseCnt(int productgrp_no);    

  public int decreaseCnt(int productgrp_no);

}
