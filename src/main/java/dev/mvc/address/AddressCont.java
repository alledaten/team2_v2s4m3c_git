package dev.mvc.address;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



@Controller
public class AddressCont {
  @Autowired
  @Qualifier("dev.mvc.address.AddressProc")
  private AddressProcInter addressProc;
  
  /**
   * ����� http;//localhost:9090/team2/address/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/address/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/address/create"); // /webapp/address/create.jsp

    return mav; // forward
  }
  
  /**
   * ��� ó�� http;//localhost:9090/tema2/address/create.do
   * 
   * @return
   */

    @RequestMapping(value = "/address/create.do", method = RequestMethod.POST) 
    public ModelAndView create(AddressVO addressVO) { // request.setAttribute("devVO", devVO) �ڵ� ����
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/address/create_msg"); // /webapp/address/create_msg.jsp
    
    int cnt = this.addressProc.create(addressVO); // ��� ó��
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    return mav; // forward
  }
   
  
  /**
   * Ajax ��� ó��
   * @param payVO
   * @return
   */
//  @ResponseBody
//  @RequestMapping(value = "/address/create.do",
//                            method = RequestMethod.POST,
//                            produces = "text/plain;charset=UTF-8")
//  public String create(AddressVO addressVO) {
//    
//    int cnt = this.addressProc.create(addressVO);
//    
//    JSONObject obj = new JSONObject();
//    
//    obj.put("cnt",cnt);
// 
//    return obj.toString(); // {"cnt":1}
//
//  }
  
  /**
   * ��� http;//localhost:9090/team2/address/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/address/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/address/list"); // /webapp/pay/list.jsp

    List<AddressVO> list = this.addressProc.list_address_desc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
  * AJax ��� 
  * http://localhost:9090/team2/address/list.do?contentsno=53
  * @param contentsno
  * @return
  */
// @ResponseBody
// @RequestMapping(value = "/address/list.do",
//                             method = RequestMethod.GET,
//                             produces = "text/plain;charset=UTF-8")
// public String list() {
//   // String msg="JSON ���";
//   // return msg;
//   
//   List<AddressVO> list = addressProc.list_address_desc();
//   
//   JSONObject obj = new JSONObject();
//   obj.put("list", list);
//
//   return obj.toString();     
// }

  
  // http://localhost:9090/team2/address/read.do
  /**
   * ��ȸ
   * @return
   */
  @RequestMapping(value="/address/read.do", method=RequestMethod.GET )
  public ModelAndView read(int address_no) {
    ModelAndView mav = new ModelAndView();

    AddressVO addressVO = this.addressProc.read(address_no);
    mav.addObject("addressVO", addressVO); // request.setAttribute("devVO", devVO);
    
    mav.setViewName("/address/read"); // /webapp/address/read.jsp
    
    return mav;
  }
  
  
  // http://localhost:9090/team2/address/update.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/address/update.do", method=RequestMethod.GET )
  public ModelAndView update(int address_no) {
    ModelAndView mav = new ModelAndView();
    
    AddressVO addressVO = this.addressProc.read(address_no); // ������ �б�
    mav.addObject("addressVO", addressVO); // request.setAttribute("qnaVO", qnaVO);
    
    List<AddressVO> list = this.addressProc.list_address_desc();
    mav.addObject("list", list);
    
    mav.setViewName("/address/update"); // webapp/address/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/address/update.do
  /**
   * ���� ó��
   * @param payVO
   * @return
   */
  @RequestMapping(value="/address/update.do", method=RequestMethod.POST )
  public ModelAndView update(AddressVO addressVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.addressProc.update(addressVO);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/address/update_msg"); // webapp/address/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/address/delete.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/address/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int address_no) {
    ModelAndView mav = new ModelAndView();
    
    AddressVO addressVO = this.addressProc.read(address_no);
    mav.addObject("addressVO", addressVO);
    
    mav.setViewName("/address/read_delete"); // webapp/address/read_delete.jsp
    
    return mav;
  }
  
  /**
   * ���� ó��
   * @param address_no
   * @return
   */
  @RequestMapping(value = "/address/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int address_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.addressProc.delete(address_no);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/address/delete_msg"); // webapp/address/delete_msg.jsp

    return mav;
  }
  
  
  
  
}
