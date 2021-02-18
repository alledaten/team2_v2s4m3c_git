package dev.mvc.cart;

import java.util.List;

public interface CartProcInter {
  
  public int create(CartVO cartVO);
  
  public List<CartVO> list(int member_no);
  
  public int update(CartVO cartVO);
  
  public int delete(CartVO cartVO);
  
}
