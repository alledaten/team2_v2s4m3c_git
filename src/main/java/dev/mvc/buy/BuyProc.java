package dev.mvc.buy;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.buy.BuyProc")
public class BuyProc implements BuyProcInter{
  @Autowired
  private BuyDAOInter buyDAO;

  public BuyProc() {
    System.out.println("--> BuyProc created");
  }

  @Override
  public int create(BuyVO buyVO) {
    int cnt = this.buyDAO.create(buyVO);
    return cnt;
  }

  @Override
  public List<BuyVO> list_buy_desc() {
    List<BuyVO> list = this.buyDAO.list_buy_desc();
    return list;
  }

  @Override
  public List<BuyVO> list_update_desc(int buy_no) {
    List<BuyVO> list = this.buyDAO.list_update_desc(buy_no);
    return list;
  }
  
  @Override
  public BuyVO read(int buy_no) {
    BuyVO buyVO = this.buyDAO.read(buy_no);
    return buyVO;
  }
  
  @Override
  public int update(BuyVO buyVO) {
    int cnt = this.buyDAO.update(buyVO);
    return cnt;
  }

  @Override
  public int delete(int buy_no) {
    int cnt = this.buyDAO.delete(buy_no);
    return cnt;
  }



  

  
  
  
  
  
}
