package dev.mvc.point;

import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;




@Controller
public class PointCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.point.PointProc")
  private PointProcInter pointProc;
  
  /**
   * ����� http;//localhost:9090/team2/point/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/point/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/point/create"); // /webapp/point/create.jsp

    return mav; // forward
  }
  
  /**
   * ��� ó�� http;//localhost:9090/tema2/point/create.do
   * 
   * @return
   */

    @RequestMapping(value = "/point/create.do", method = RequestMethod.POST) 
    public ModelAndView create(PointVO pointVO) { // request.setAttribute("devVO", devVO) �ڵ� ����
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/point/create_msg"); // /webapp/point/create_msg.jsp
    
    int cnt = this.pointProc.create(pointVO); // ��� ó��
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    return mav; // forward
  }
  
  /**
   * ��� http;//localhost:9090/team2/point/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/point/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/point/list"); // /webapp/point/list.jsp

    List<PointVO> list = this.pointProc.list_point_desc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  /**
  * AJax ����Ʈ ��ȸ
  * http://localhost:9090/team2/point/read_point.do?member_no=1
  * @param contentsno
  * @return
  */
  @ResponseBody
  @RequestMapping(value = "/point/read_point.do",
                            method = RequestMethod.GET,
                            produces = "text/plain;charset=UTF-8")
  public String read_point(int member_no) {
    PointVO pointVO = pointProc.read_point(member_no);
    
    JSONObject obj = new JSONObject();
    obj.put("member_no", member_no);
    obj.put("point_num", pointVO.getPoint_num());
 
    return obj.toString(); 

  }
  
  // http://localhost:9090/team2/point/read.do
  /**
   * ��ȸ
   * @return
   */
  @RequestMapping(value="/point/read.do", method=RequestMethod.GET )
  public ModelAndView read(int point_no) {
    ModelAndView mav = new ModelAndView();

    PointVO pointVO = this.pointProc.read(point_no);
    mav.addObject("pointVO", pointVO); 
    
    mav.setViewName("/point/read"); // /webapp/point/read.jsp
    
    return mav;
  }
  
  
  // http://localhost:9090/team2/point/update.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/point/update.do", method=RequestMethod.GET )
  public ModelAndView update(int point_no) {
    ModelAndView mav = new ModelAndView();
    
    PointVO pointVO = this.pointProc.read(point_no); // ������ �б�
    mav.addObject("pointVO", pointVO); // request.setAttribute("qnaVO", qnaVO);
    
    List<PointVO> list = this.pointProc.list_point_desc();
    mav.addObject("list", list);
    
    mav.setViewName("/point/update"); // webapp/point/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/point/update.do
  /**
   * ���� ó��
   * @param pointVO
   * @return
   */
  @RequestMapping(value="/point/update.do", method=RequestMethod.POST )
  public ModelAndView update(PointVO pointVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.pointProc.update(pointVO);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/point/update_msg"); // webapp/point/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/point/delete.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/point/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int point_no) {
    ModelAndView mav = new ModelAndView();
    
    PointVO pointVO = this.pointProc.read(point_no);
    mav.addObject("pointVO", pointVO);
    
    mav.setViewName("/point/read_delete"); // webapp/point/read_delete.jsp
    
    return mav;
  }
  
  /**
   * ���� ó��
   * @param point_no
   * @return
   */
  @RequestMapping(value = "/point/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int point_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.pointProc.delete(point_no);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/point/delete_msg"); // webapp/point/delete_msg.jsp

    return mav;
  }
  
  
  
  
}
