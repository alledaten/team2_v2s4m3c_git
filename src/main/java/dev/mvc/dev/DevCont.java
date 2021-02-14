package dev.mvc.dev;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.buy.BuyProcInter;
import dev.mvc.buy.BuyVO;


@Controller
public class DevCont {
  @Autowired
  @Qualifier("dev.mvc.buy.BuyProc")
  private BuyProcInter buyProc;
  
  @Autowired
  @Qualifier("dev.mvc.dev.DevProc")
  private DevProcInter devProc;
  
  /**
   * ����� http;//localhost:9090/team2/dev/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/dev/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/dev/create"); // /webapp/dev/create.jsp

    return mav; // forward
  }
  
  /**
   * ��� ó�� http;//localhost:9090/tema2/dev/create.do
   * 
   * @return
   */
//  @RequestMapping(value = "/dev/create.do", method = RequestMethod.POST)
//  public ModelAndView create(DevVO devVO) {
//    // request.setAttribute("devVO", devVO) �ڵ� ����
//
//    ModelAndView mav = new ModelAndView();
//    mav.setViewName("/dev/create_msg"); // /webapp/dev/create_msg.jsp
//
//    int cnt = this.devProc.create(devVO); // ��� ó��
//    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
//
//    return mav; // forward
//  }
  
  /**
   * Ajax ��� ó��
   * @param devVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/dev/create.do",
                            method = RequestMethod.POST,
                            produces = "text/plain;charset=UTF-8")
  public String create(DevVO devVO) {
    
    int cnt = this.devProc.create(devVO);
    
    JSONObject obj = new JSONObject();
    obj.put("cnt",cnt);
 
    return obj.toString(); // {"cnt":1}

  }
  
  /**
   * ��� http;//localhost:9090/team2/dev/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/dev/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/dev/list"); // /webapp/dev/list.jsp

    List<DevVO> list = this.devProc.list_dev_desc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  // http://localhost:9090/team2/dev/read.do
  /**
   * ��ȸ
   * @return
   */
  @RequestMapping(value="/dev/read.do", method=RequestMethod.GET )
  public ModelAndView read(int dev_no) {
    ModelAndView mav = new ModelAndView();

    DevVO devVO = this.devProc.read(dev_no);
    mav.addObject("devVO", devVO); // request.setAttribute("devVO", devVO);
    
    BuyVO buyVO = this.buyProc.read(devVO.getBuy_no());
    mav.addObject("buyVO", buyVO); 
    
    mav.setViewName("/dev/read"); // /webapp/dev/read.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/dev/update.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/dev/update.do", method=RequestMethod.GET )
  public ModelAndView update(int dev_no) {
    ModelAndView mav = new ModelAndView();
    
    DevVO devVO = this.devProc.read(dev_no); // ������ �б�
    mav.addObject("devVO", devVO); // request.setAttribute("qnaVO", qnaVO);
    
    List<DevVO> list = this.devProc.list_dev_desc();
    mav.addObject("list", list);
    
    mav.setViewName("/dev/update"); // webapp/dev/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/dev/update.do
  /**
   * ���� ó��
   * @param devVO
   * @return
   */
  @RequestMapping(value="/dev/update.do", method=RequestMethod.POST )
  public ModelAndView update(DevVO devVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.devProc.update(devVO);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/dev/update_msg"); // webapp/dev/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/dev/delete.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/dev/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int dev_no) {
    ModelAndView mav = new ModelAndView();
    
    DevVO devVO = this.devProc.read(dev_no);
    mav.addObject("devVO", devVO);
    
    mav.setViewName("/dev/read_delete"); // webapp/dev/read_delete.jsp
    
    return mav;
  }
  
  /**
   * ���� ó��
   * @param dev_no
   * @return
   */
  @RequestMapping(value = "/dev/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int dev_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.devProc.delete(dev_no);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/dev/delete_msg"); // webapp/dev/delete_msg.jsp

    return mav;
  }
  
}
