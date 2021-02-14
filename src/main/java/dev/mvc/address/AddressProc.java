package dev.mvc.address;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


@Controller("dev.mvc.address.AddressProc")
public class AddressProc implements AddressProcInter{
  @Autowired
  private AddressDAOInter addressDAO;
  
  public AddressProc() {
    System.out.println("--> AddressProc created");
  }
  
  @Override
  public int create(AddressVO addressVO) {
    int cnt = this.addressDAO.create(addressVO);
    return cnt;
  }

  @Override
  public List<AddressVO> list_address_desc() {
    List<AddressVO> list = this.addressDAO.list_address_desc();
    return list;
  }

  @Override
  public AddressVO read(int address_no) {
    AddressVO addressVO = this.addressDAO.read(address_no);
    return addressVO;
  }
  
  @Override
  public int update(AddressVO addressVO) {
    int cnt = this.addressDAO.update(addressVO);
    return cnt;
  }
  
  @Override
  public int delete(int address_no) {
    int cnt = this.addressDAO.delete(address_no);
    return cnt;
  }

  
}
