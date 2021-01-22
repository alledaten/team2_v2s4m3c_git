package dev.mvc.member;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class MemberCont {
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;

  public MemberCont() {
    System.out.println("--> MemberCont created.");
  }

  
  // http://localhost:9090/team2/member/checkID.do?id=user1
  /**
  * ID 중복 체크, JSON 출력
  * @return
  */
  @ResponseBody
  @RequestMapping(value="/member/checkID.do", method=RequestMethod.GET ,
                  produces = "text/plain;charset=UTF-8" )
  public String checkID(String id) {
    int cnt = this.memberProc.checkID(id);
   
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
   
    return json.toString(); 
  }
  
  /**
   * 등록폼 http://localhost:9090/team2/cate/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/member/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/member/create"); // /member/create.jsp

    return mav;
  }

  /**
   * 등록처리
   * http://localhost:9090/team2/member/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/member/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, MemberVO memberVO) {
    ModelAndView mav = new ModelAndView();
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String file1 = "";     // main image
    String thumb1 = ""; // preview image
        
    String upDir = Tool.getRealPath(request, "/member/storage/profile_images"); // 절대 경로
    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    MultipartFile mf = memberVO.getFile1MF();
    long size1 = mf.getSize();  // 파일 크기
    if (size1 > 0) { // 파일 크기 체크
      // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
      // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
      file1 = Upload.saveFileSpring(mf, upDir); 
      
      if (Tool.isImage(file1)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1, 200, 150); 
      }
      
    }    
    
    memberVO.setMember_profilepic(file1);
    memberVO.setMember_profilethumb(thumb1);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    

    int cnt = this.memberProc.create(memberVO);
    mav.addObject("cnt", cnt);
    mav.addObject("url", "create_msg");

    mav.setViewName("/member/create_msg");
    return mav;
  }
  
  /**
   * 목록 http://localhost:9090/team2/member/list.do
   * 
   * @return
   */
//  @RequestMapping(value = "/member/list.do", method = RequestMethod.GET)
//  public ModelAndView list() {
//    ModelAndView mav = new ModelAndView();
//    mav.setViewName("/member/list"); // /webapp/member/list.jsp
//
//    List<MemberVO> list = this.memberProc.list_join();
//    mav.addObject("list", list);
//
//    return mav; // forward
//  }

  /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9090/resort/contents/list.do
   * http://localhost:9090/resort/contents/list.do?cateno=1&word=스위스&nowPage=1
   * @param word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/member/list.do", 
                  method = RequestMethod.GET)
  public ModelAndView list_by_cateno_search_paging(@RequestParam(value="word", defaultValue="") String word,
                                                   @RequestParam(value="nowPage", defaultValue="1") int nowPage
                                                   ) { 
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);  // 페이지에 출력할 레코드의 범위를 산출하기위해 사용     
    
    // 검색 목록
    List<MemberVO> list = memberProc.list_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = memberProc.search_count(map);
    mav.addObject("search_count", search_count);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * 
     * @param listFile 목록 파일명 
     * @param cateno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = memberProc.pagingBox("list.do", search_count, nowPage, word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);

    // /contents/list.jsp
    mav.setViewName("/member/list");   
    
    return mav;
  }    
 
  

  // http://localhost:9090/team2/member/read.do
  /**
   * 회원정보
   * @return
   */
  @RequestMapping(value="/member/read.do", method=RequestMethod.GET )
  public ModelAndView read(int member_no) {
    ModelAndView mav = new ModelAndView();

    MemberVO memberVO = this.memberProc.read(member_no);
    mav.addObject("memberVO", memberVO); // request.setAttribute("memberVO", memberVO);
    
    mav.setViewName("/member/read"); // /webapp/member/read.jsp
    return mav;
  }

  // http://localhost:9090/resort/member/update.do
  /**
   * 수정 폼
   * @return
   */
  @RequestMapping(value="/member/update.do", method=RequestMethod.GET )
  public ModelAndView update(int member_no) {
    ModelAndView mav = new ModelAndView();
    
    MemberVO memberVO = this.memberProc.read_update(member_no); // 수정용 읽기
    mav.addObject("memberVO", memberVO); // request.setAttribute("memberVO", memberVO);
    
    mav.setViewName("/member/update"); // webapp/member/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/resort/member/update.do
  /**
   * 수정 처리
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/member/update.do", method=RequestMethod.POST )
  public ModelAndView update(HttpServletRequest request, MemberVO memberVO) {
    ModelAndView mav = new ModelAndView();
    
    mav.addObject("member_no", memberVO.getMember_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("member_no", memberVO.getMember_no());
    hashMap.put("member_passwd", memberVO.getMember_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;        // 수정된 레코드 갯수 
    
    passwd_cnt = this.memberProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 수정
      
   // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      MemberVO vo = memberProc.read(memberVO.getMember_no());
      // System.out.println("file1: " + contentsVO.getFile1());
      
      String file1 = vo.getMember_profilepic().trim();
      String thumb1 = vo.getMember_profilethumb().trim();
      long size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/member/storage/profile_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, memberVO.getMember_profilepic());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, memberVO.getMember_profilethumb());  // Folder에서 1건의 파일 삭제
      // System.out.println("sw: " + sw);
      // -------------------------------------------------------------------
      // 파일 삭제 종료
      // -------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택" multiple="multiple">
      MultipartFile mf = memberVO.getFile1MF();
      size1 = mf.getSize();  // 파일 크기
      if (size1 > 0) { // 파일 크기 체크
        // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        file1 = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(file1)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1, 200, 150);
        }
      }
      
      memberVO.setMember_profilepic(file1);
      memberVO.setMember_profilethumb(thumb1);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
      
      cnt = this.memberProc.update(memberVO);
      
      mav.setViewName("/member/update_msg"); // webapp/member/update_msg.jsp
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
    
    return mav;
  }
  
  
  // http://localhost:9090/resort/member/update.do
  /**
   * 삭제 폼
   * @return
   */
  @RequestMapping(value="/member/delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int member_no) {
    ModelAndView mav = new ModelAndView();

    MemberVO memberVO = this.memberProc.read(member_no);
    mav.addObject("memberVO", memberVO); // request.setAttribute("memberVO", memberVO);
    mav.setViewName("/member/delete"); // webapp/member/update.jsp

    return mav;
  }
  
  // http://localhost:9090/resort/member/delete.do
  /**
   * 삭제 처리
   * @param memberVO
   * @return
   */
  @RequestMapping(value="/member/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(HttpServletRequest request, int member_no, String passwd,
                              @RequestParam(value="word", defaultValue="") String word,
                              @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    MemberVO vo = this.memberProc.read(member_no);
    String id = vo.getMember_id();
    mav.addObject("id", id); // request.setAttribute("memberVO", memberVO);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("member_no", member_no);
    hashMap.put("member_passwd", passwd);
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;        // 삭제된 레코드 갯수 

    passwd_cnt = this.memberProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 삭제
      cnt = this.memberProc.delete(member_no);
      
      // -------------------------------------------------------------------------------------
      // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("word", word);
      // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
      if (memberProc.search_count(map) % MemberPaging.RECORD_PER_PAGE == 0) {
        nowPage = nowPage - 1;
        if (nowPage < 1) {
          nowPage = 1; // 시작 페이지
        }
      }
      // -------------------------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      String file1 = vo.getMember_profilepic().trim();
      String thumb1 = vo.getMember_profilethumb().trim();
      long size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/member/storage/profile_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, vo.getMember_profilepic());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, vo.getMember_profilethumb());  // Folder에서 1건의 파일 삭제
      // System.out.println("sw: " + sw);
      // -------------------------------------------------------------------
      // 파일 삭제 종료
      // -------------------------------------------------------------------
      
    }
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
    
    mav.setViewName("/member/delete_msg"); // webapp/member/update_msg.jsp
    
    return mav;
  }
  
}

