package dev.mvc.buy;

import java.util.List;

import dev.mvc.qna.QnaVO;

public interface BuyDAOInter {
  /**
   * 등록
   * @param buyVO
   * @return
   */
  public int create(BuyVO buyVO);
  
  /**
   * 목록
   * @return
   */
  public List<BuyVO> list_buy_desc();
  
  /**
   * 수정 목록
   * @return
   */
  public List<BuyVO> list_update_desc(int buy_no);
  
  /**
   * 조회
   * @param buy_no
   * @return
   */
  public BuyVO read(int buy_no);
  
  /**
   * 수정
   * @param buyVO
   * @return
   */
  public int update(BuyVO buyVO);
  
  /**
   * 삭제
   * @param buy_no
   * @return
   */
  public int delete(int buy_no);
  
  
}
