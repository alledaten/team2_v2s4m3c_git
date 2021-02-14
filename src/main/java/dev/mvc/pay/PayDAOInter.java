package dev.mvc.pay;

import java.util.List;

public interface PayDAOInter {
  /**
   * ���
   * @param payVO
   * @return
   */
  public int create(PayVO payVO);

  /**
   * ���
   * @return
   */
  public List<PayVO> list_pay_desc();
  
  /**
   * ��ȸ
   * @param pay_no
   * @return
   */
  public PayVO read(int pay_no);
  
  /**
   * ����
   * @param payVO
   * @return
   */
  public int update(PayVO payVO);
  
  /**
   * ����
   * @param pay_no
   * @return
   */
  public int delete(int pay_no);
  
  
}
