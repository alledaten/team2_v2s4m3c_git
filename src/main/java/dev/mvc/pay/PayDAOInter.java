package dev.mvc.pay;

import java.util.List;

public interface PayDAOInter {
  /**
   * 등록
   * @param payVO
   * @return
   */
  public int create(PayVO payVO);

  /**
   * 목록
   * @return
   */
  public List<PayVO> list_pay_desc();
  
  /**
   * 조회
   * @param pay_no
   * @return
   */
  public PayVO read(int pay_no);
  
  /**
   * 수정
   * @param payVO
   * @return
   */
  public int update(PayVO payVO);
  
  /**
   * 삭제
   * @param pay_no
   * @return
   */
  public int delete(int pay_no);
  
  
}
