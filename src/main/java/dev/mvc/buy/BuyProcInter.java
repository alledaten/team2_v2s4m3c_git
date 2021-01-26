package dev.mvc.buy;

import java.util.List;

public interface BuyProcInter {
  /**
   * ���
   * @param buyVO
   * @return
   */
  public int create(BuyVO buyVO);
  
  /**
   * ���
   * @return
   */
  public List<BuyVO> list_buy_desc();
  
  /**
   * ���� ���
   * @return
   */
  public List<BuyVO> list_update_desc(int buy_no);
  
  /**
   * ��ȸ
   * @param buy_no
   * @return
   */
  public BuyVO read(int buy_no);
  
  /**
   * ����
   * @param qnaVO
   * @return
   */
  public int update(BuyVO buyVO);
  
  /**
   * ����
   * @param buy_no
   * @return
   */
  public int delete(int buy_no);
  
  
}
