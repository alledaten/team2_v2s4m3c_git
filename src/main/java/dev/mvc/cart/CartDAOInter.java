package dev.mvc.cart;

import java.util.List;

import dev.mvc.productgrp.ProductgrpVO;

public interface CartDAOInter {
  
  public int create(CartVO cartVO);
  
  public List<CartVO> list(int member_no);
  
  public int update(CartVO cartVO);
  
  public int delete(CartVO cartVO);

}
