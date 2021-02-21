package dev.mvc.snslogin;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;

import dev.mvc.login_log.Login_logProcInter;
import dev.mvc.login_log.Login_logVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class SnsloginCont {
  @Autowired
  @Qualifier("dev.mvc.snslogin.SnsloginProc")
  private SnsloginProcInter snsloginProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;

  @Autowired
  @Qualifier("dev.mvc.login_log.Login_logProc")
  private Login_logProcInter login_logProc;

  public SnsloginCont() {
    System.out.println("--> SnsloginCont created");
  }
  
  /**
   * 목록
   * http://localhost:9090/team2/snslogin/list.do
   * @return
   */
  @RequestMapping(value = "/snslogin/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/snslogin/list");
    
    List<SnsloginVO> list = this.snsloginProc.list();
    mav.addObject("list", list);
    
    return mav;
  }
    
  /**
   * ajax기반 권한 등록처리
   * http://localhost:9090/team2/snslogin/create.do
   * @param snsloginVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/create.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String create(SnsloginVO snsloginVO) {
    int cnt = this.snsloginProc.create(snsloginVO);
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }
  

  /**
   * Ajax기반 조회
   * http://localhost:9090/team2/snslogin/read.do
   * @param snslogin_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/read.do", method = RequestMethod.GET,
                  produces = "text/plain;charset=UTF-8")
  public String read(int snslogin_no) {
    
    SnsloginVO snsloginVO = this.snsloginProc.read(snslogin_no);

    JSONObject json = new JSONObject();
    json.put("snslogin_no", snslogin_no);
    json.put("snslogin_name", snsloginVO.getSnslogin_name());

    return json.toString();
  }

  /**
   * Ajax 기반 수정 처리
   * @param snsloginVO
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/update.do", method = RequestMethod.POST,
                produces = "text/plain;charset=UTF-8")
  public String update(SnsloginVO snsloginVO) {
    int cnt = this.snsloginProc.update(snsloginVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }

  /**
   * Ajax 기반 삭제 처리
   * @param snslogin_no
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/snslogin/delete.do", method = RequestMethod.POST,
                  produces = "text/plain;charset=UTF-8")
  public String delete(int snslogin_no) {
    int cnt = this.snsloginProc.delete(snslogin_no);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
  
  /**********************************************************************************************/

  private NaverLoginBO naverLoginBO;
  private String apiResult = null;
  
  @Autowired
  private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
    this.naverLoginBO = naverLoginBO;
  }

  //네이버 로그인 성공시 callback호출 메소드
  @RequestMapping(value = "/snslogin/callback.do", method = { RequestMethod.GET, RequestMethod.POST })
  public ModelAndView callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, HttpServletRequest request)
      throws IOException {
    ModelAndView mav = new ModelAndView();
    System.out.println("여기는 callback");
    
    OAuth2AccessToken oauthToken;
        oauthToken = naverLoginBO.getAccessToken(session, code, state);
        //로그인 사용자 정보를 읽어온다.
        apiResult = naverLoginBO.getUserProfile(oauthToken);
      
    // 가입여부를 판단하기위해 id를 확인함
    JSONObject naverUserInfo = new JSONObject(apiResult).getJSONObject("response");
    String sns_id = naverUserInfo.getString("id");
    
    // 가입여부체크
    int checkIdCnt = this.memberProc.checkID(sns_id);
    
    if (checkIdCnt == 0) {
      System.out.println("없어서 등록함");
      // 없으면 등록
      MemberVO memberVO = new MemberVO();
      memberVO.setMember_id(sns_id);
      memberVO.setMember_email(naverUserInfo.getString("email"));
      memberVO.setMember_nickname(naverUserInfo.getString("nickname"));
      memberVO.setSnslogin_no(2); // 2: 네이버
      this.memberProc.create(memberVO);

    } else {
      System.out.println("있는 아이디");
    }
    // DB에 등록된 정보를 읽어옴
    MemberVO memberVO = this.memberProc.readById(sns_id);

    /************* 로그인 로그 등록 *******/
    Login_logVO login_logVO = new Login_logVO();
    
    login_logVO.setMember_no(memberVO.getMember_no());  // 회원 번호
    login_logVO.setLogin_log_ip(request.getRemoteAddr()); // IP주소

    int cnt = this.login_logProc.create(login_logVO);
    
    if(cnt == 1) {
      System.out.println("--> " + sns_id +" 회원 로그인 등록 성공");
    } else {
      System.out.println("--> 등록실패");
    }
    /**************************************/
    
    // 세션에 정보 저장
    session.setAttribute("member_no", memberVO.getMember_no());
    session.setAttribute("member_id", sns_id);
    session.setAttribute("member_name", memberVO.getMember_nickname());
    
    // 모델에 정보 저장
    mav.addObject("member_no", memberVO.getMember_no());
    mav.addObject("result", apiResult);
    mav.setViewName("redirect:/index.do");
    
    /* 네이버 로그인 성공 페이지 View 호출 */
    return mav;
  }
  
}
