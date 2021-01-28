package dev.mvc.memberlevel;

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
public class MemberlevelCont {
  @Autowired
  @Qualifier("dev.mvc.memberlevel.MemberlevelProc")
  private MemberlevelProcInter memberlevelProc;

  public MemberlevelCont() {
    System.out.println("--> MemberlevelCont created");
  }
  
  /**
   * 목록 http://localhost:9090/team2/memberlevel/list.do
   * @return
   */
  @RequestMapping(value = "/memberlevel/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/memberlevel/list");
    
    List<MemberlevelVO> list = this.memberlevelProc.list();
    mav.addObject("list", list);
    
    return mav;
  }

  /**
   * ajax기반 권한 등록처리 http://localhost:9090/team2/memberlevel/create.do
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/memberlevel/create.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String create(MemberlevelVO memberlevelVO) {
    int cnt = this.memberlevelProc.create(memberlevelVO);
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
  

  /**
   * Ajax기반 조회 http://localhost:9090/team2/memberlevel/read.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/memberlevel/read.do", method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public String read(int memberlevel_no) {
    
    MemberlevelVO memberlevelVO = this.memberlevelProc.read(memberlevel_no);

    JSONObject json = new JSONObject();
    json.put("memberlevel_no", memberlevel_no);
    json.put("memberlevel_name", memberlevelVO.getMemberlevel_name());

    return json.toString();
  }

  /**
   * Ajax 기반 수정 처리
   * 
   * @param MemberlevelVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/memberlevel/update.do", method = RequestMethod.POST,
                produces = "text/plain;charset=UTF-8")
  public String update(MemberlevelVO memberlevelVO) {
    int cnt = this.memberlevelProc.update(memberlevelVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }

  /**
   * Ajax 기반 삭제 처리
   * @param memberlevel_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/memberlevel/delete.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String delete(int memberlevel_no) {
    int cnt = this.memberlevelProc.delete(memberlevel_no);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
}
