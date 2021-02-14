package dev.mvc.dev;

import java.util.List;

public interface DevDAOInter {
  /**
   * 등록
   * @param devVO
   * @return
   */
  public int create(DevVO devVO);

  /**
   * 목록
   * @return
   */
  public List<DevVO> list_dev_desc();
  
  /**
   * 조회
   * @param buy_no
   * @return
   */
  public DevVO read(int dev_no);
  
  /**
   * 수정
   * @param devVO
   * @return
   */
  public int update(DevVO devVO);
  
  /**
   * 삭제
   * @param dev_no
   * @return
   */
  public int delete(int dev_no);
  
  
}
