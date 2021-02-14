package dev.mvc.pay;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import dev.mvc.dev.DevVO;


@Controller("dev.mvc.pay.PayProc")
public class PayProc implements PayProcInter{
  @Autowired
  private PayDAOInter payDAO;
  
  public PayProc() {
    System.out.println("--> PayProc created");
  }
  
  @Override
  public int create(PayVO payVO) {
    int cnt = this.payDAO.create(payVO);
    return cnt;
  }

  @Override
  public List<PayVO> list_pay_desc() {
    List<PayVO> list = this.payDAO.list_pay_desc();
    return list;
  }

  @Override
  public PayVO read(int pay_no) {
    PayVO payVO = this.payDAO.read(pay_no);
    return payVO;
  }
  
  @Override
  public int update(PayVO payVO) {
    int cnt = this.payDAO.update(payVO);
    return cnt;
  }
  
  @Override
  public int delete(int pay_no) {
    int cnt = this.payDAO.delete(pay_no);
    return cnt;
  }

  
}
