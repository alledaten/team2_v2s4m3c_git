package dev.mvc.buy;

import java.util.List;

import dev.mvc.qna.QnaVO;

public interface BuyDAOInter {
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
   * @param buyVO
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
