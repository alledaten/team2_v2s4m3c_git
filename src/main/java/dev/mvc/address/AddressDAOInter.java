package dev.mvc.address;

import java.util.HashMap;
import java.util.List;

public interface AddressDAOInter {
  /**
   * ���
   * @param addressVO
   * @return
   */
  public int create(AddressVO addressVO);

  /**
   * ���
   * @return
   */
  public List<AddressVO> list_address_desc();
  
  /**
   * ��ȸ
   * @param address_no
   * @return
   */
  public AddressVO read(int address_no);
  
  /**
   * ����
   * @param addressVO
   * @return
   */
  public int update(AddressVO addressVO);
  
  /**
   * ����
   * @param address_no
   * @return
   */
  public int delete(int address_no);
  
  /**
   * �ּҷ� �� ����
   * @param hashMap
   * @return
   */
  public int v_address(HashMap hashMap);
  
}
