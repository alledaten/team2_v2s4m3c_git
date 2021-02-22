package dev.mvc.address;

import java.util.HashMap;
import java.util.List;

public interface AddressDAOInter {
  /**
   * 등록
   * @param addressVO
   * @return
   */
  public int create(AddressVO addressVO);

  /**
   * 목록
   * @return
   */
  public List<AddressVO> list_address_desc();
  
  /**
   * 조회
   * @param address_no
   * @return
   */
  public AddressVO read(int address_no);
  
  /**
   * 수정
   * @param addressVO
   * @return
   */
  public int update(AddressVO addressVO);
  
  /**
   * 삭제
   * @param address_no
   * @return
   */
  public int delete(int address_no);
  
  /**
   * 주소록 값 전송
   * @param hashMap
   * @return
   */
  public int v_address(HashMap hashMap);
  
}
