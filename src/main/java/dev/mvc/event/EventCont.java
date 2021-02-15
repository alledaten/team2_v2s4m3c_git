package dev.mvc.event;

import java.util.HashMap;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.event_attachfile.Event_AttachfileProcInter;
import dev.mvc.event_attachfile.Event_AttachfileVO;
import dev.mvc.event_grp.Event_GrpProcInter;
import dev.mvc.event_grp.Event_GrpVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class EventCont {
  @Autowired
  @Qualifier("dev.mvc.event.EventProc")
  private EventProcInter eventProc;
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.event_grp.Event_GrpProc")
  private Event_GrpProcInter event_grpProc;
  
  @Autowired
  @Qualifier("dev.mvc.event_attachfile.Event_AttachfileProc")
  private Event_AttachfileProcInter event_attachfileProc;
  
   /**
   * 등록폼 http://localhost:9090/team2/event/create.do
   * @return
   */
  @RequestMapping(value = "/event/create.do", method = RequestMethod.GET)
  public ModelAndView create(int event_grp_no) {
    ModelAndView mav = new ModelAndView();

    Event_GrpVO event_grpVO = this.event_grpProc.read(event_grp_no);
    mav.addObject("event_grpVO", event_grpVO);
    
    mav.setViewName("/event/create");

    return mav; // forward
  }
  
   /**
   * 등록 처리 http://localhost:9090/team2/event/create.do?event_grp_no=1
   * 
   * @return
   */
  @RequestMapping(value = "/event/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    
    mav.addObject("event_grpVO", event_grpVO);
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String event_file = ""; // main image
    String event_thumb = ""; // preview image

    String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // 절대 경로

    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    // <input type='file' class="form-control" name='file1MF' id='file1MF'
    // value='' placeholder="파일 선택" multiple="multiple">
    MultipartFile mf = eventVO.getEvent_fileMF();

    long event_size = mf.getSize(); // 파일 크기
    if (event_size > 0) { // 파일 크기 체크
      // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
      // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
      event_file = Upload.saveFileSpring(mf, upDir);

      if (Tool.isImage(event_file)) { // 이미지인지 검사
        // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
        event_thumb = Tool.preview(upDir, event_file, 200, 150);
      }

    }

    eventVO.setEvent_file(event_file);
    eventVO.setEvent_thumb(event_thumb);
    eventVO.setEvent_size(event_size);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    int cnt = this.eventProc.create(eventVO); 
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    // -------------------------------------------------------------------
    // PK의 return
    // -------------------------------------------------------------------
    mav.addObject("event_no", eventVO.getEvent_no()); // redirect parameter 적용
    mav.addObject("event_grp_no", eventVO.getEvent_grp_no()); // redirect parameter 적용
    // -------------------------------------------------------------------

    // mav.setViewName("/event/create_msg");
    mav.setViewName("redirect:/event/list.do?event_grp_no=" + eventVO.getEvent_grp_no());  // 경로 수정할 것!

    return mav; // forward
  }
  
   /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9090/team2/event/list.do?event_grp_no=1&event_word=&nowPage=
   * @param event_grp_no
   * @param event_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/event/list.do", method = RequestMethod.GET)
  public ModelAndView list_by_event_grp_no_search_paging(
      @RequestParam(value="event_grp_no", defaultValue="1") int event_grp_no,
      @RequestParam(value="event_word", defaultValue="") String event_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    
    ModelAndView mav = new ModelAndView();
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("event_grp_no", event_grp_no); // #{event_grp_no}
    map.put("event_word", event_word);     // #{word}
    map.put("nowPage", nowPage);  // 페이지에 출력할 레코드의 범위를 산출하기위해 사용     
    
    
    // 검색 목록
    List<Event_AdminVO> list = eventProc.list_by_event_grp_no_search_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = eventProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Event_GrpVO event_grpVO = event_grpProc.read(event_grp_no);
    mav.addObject("event_grpVO", event_grpVO);

     /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * @param listFile 목록 파일명 
     * @param event_grp_no 이벤트 그룹
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param event_word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = eventProc.pagingBox("list.do", event_grp_no, search_count, nowPage, event_word);
    
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
    mav.setViewName("/event/list_by_event_grp_no_search_paging");   
    
    return mav;
  } 
  
   /**
   * 조회
   * http://localhost:9090/team2/event/read.do?event_no=1&event_word=&nowPage=
   * @return
   */
  @RequestMapping(value = "/event/read.do", method = RequestMethod.GET)
  public ModelAndView read(int event_no) {
    ModelAndView mav = new ModelAndView();

    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);
    
    int event_view = this.eventProc.update_event_view(event_no);
    mav.addObject("event_view", event_view); // request에 저장
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    List<Event_AttachfileVO> event_attachfile_list = this.event_attachfileProc.list_by_event_no(event_no);
    mav.addObject("event_attachfile_list", event_attachfile_list);

    mav.setViewName("/event/read"); // webapp/event/read.jsp
    return mav;
  }
  
  /**
   * 수정 폼
   * @return
   */
  @RequestMapping(value="/event/update.do", method=RequestMethod.GET )
  public ModelAndView update(int event_no) {
    ModelAndView mav = new ModelAndView();
    
    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);

    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);

    mav.setViewName("/event/update"); // webapp/event/update.jsp
    
    return mav;
  }
  
   /**
   * 수정 처리
   * @param contentsVO
   * @return
   */
  @RequestMapping(value="/event/update.do", method = RequestMethod.POST )
  public ModelAndView update(EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grp_title", event_grpVO.getEvent_grp_title());
    
    mav.addObject("event_no", eventVO.getEvent_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", eventVO.getEvent_no());
    hashMap.put("event_passwd", eventVO.getEvent_passwd());
    
    int passwd_cnt = 0;   // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 수정
      cnt = this.eventProc.update(eventVO);
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
        
    mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
    
    return mav;
  }
  
  /** 
   * 삭제폼
   * @param event_no
   * @return
   */
  @RequestMapping(value = "/event/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int event_no) {
    ModelAndView mav = new ModelAndView();
    
    EventVO eventVO = this.eventProc.read_update(event_no);
    mav.addObject("eventVO", eventVO);
    
    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    mav.setViewName("/event/delete");
    return mav;
  }
  
  /**
   * 삭제 처리 + 파일 삭제
   * @param request
   * @param event_no
   * @param event_passwd
   * @param event_passwd
   * @param event_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/event/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, int event_no, int event_grp_no, String event_passwd, 
      @RequestParam(value = "event_word", defaultValue = "") String event_word,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    EventVO eventVO = this.eventProc.read(event_no);
    String event_title = eventVO.getEvent_title();
    mav.addObject("event_title", event_title);

    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", event_no);
    hashMap.put("event_passwd", event_passwd);

    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0; // 수정된 레코드 갯수

    passwd_cnt = this.eventProc.passwd_check(hashMap);
    boolean sw = false;

    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 수정
      cnt = this.eventProc.delete(event_no);


        // -------------------------------------------------------------------------------------
        // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("event_grp_no", event_grp_no);
        map.put("event_word", event_word);
        // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
        if (eventProc.search_count(map) % Event.RECORD_PER_PAGE == 0) {
          nowPage = nowPage - 1;
          if (nowPage < 1) {
            nowPage = 1; // 시작 페이지
          }
        }
        // -------------------------------------------------------------------------------------
      

      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, eventVO.getEvent_file()); // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, eventVO.getEvent_thumb()); // Folder에서 1건의 파일 삭제

    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
    mav.addObject("nowPage", nowPage); // request에 저장
    // System.out.println("--> ContentsCont.java nowPage: " + nowPage);

    mav.addObject("event_grp_no", eventVO.getEvent_grp_no()); // redirect parameter 적용
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter 적용

    mav.setViewName("redirect:/event/delete_msg.jsp");

    return mav;
  }
  
  /////////////////////////////////////////////////////////////////////////////////
  /////////// ------------ 이미지 관련 시작  ------------- ///////////////
  /////////////////////////////////////////////////////////////////////////////////
  
   /**
   * 메인 이미지 등록 폼 
   * http://localhost:9090/team2/event/img_create.do
   * @return
   */
  @RequestMapping(value = "/event/img_create.do", method = RequestMethod.GET)
  public ModelAndView img_create(int event_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event/img_create"); // /webapp/event/img_create.jsp
    
    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);

    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    return mav; // forward
  }
  
   /**
   * 메인 이미지 등록 처리 
   * http://localhost:9090/team2/event/img_create.do
   * @return
   */
  @RequestMapping(value = "/event/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", eventVO.getEvent_no());
    hashMap.put("event_passwd", eventVO.getEvent_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      String event_file = "";     // main image
      String event_thumb = ""; // preview image
          
      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // 절대 경로
      // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택" multiple="multiple">
      MultipartFile mf = eventVO.getEvent_fileMF();
      long event_size = mf.getSize(); // 파일 크기
      if (event_size > 0) { // 파일 크기 체크
        // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        event_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(event_file)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          event_thumb = Tool.preview(upDir, event_file, 200, 150); 
        }
      }    
      
      eventVO.setEvent_file(event_file);
      eventVO.setEvent_thumb(event_thumb);
      eventVO.setEvent_size(event_size);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/event/read.do?event_no=" + eventVO.getEvent_no());
      
      cnt = this.eventProc.img_create(eventVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
            
    return mav;    
  }
  
  /**
   * 메인 이미지 삭제 및 수정 폼 http://localhost:9090/team2/event/img_update.do
   * @return
   */
  @RequestMapping(value = "/event/img_update.do", method = RequestMethod.GET)
  public ModelAndView img_update(int event_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event/img_update"); // /webapp/event/img_update.jsp

    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);

    Event_GrpVO event_grpVO = this.event_grpProc.read(eventVO.getEvent_grp_no());
    mav.addObject("event_grpVO", event_grpVO);
    
    return mav; // forward
  }
  
  /**
   * 메인 이미지 삭제 처리 http://localhost:9090/team2/event/img_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/event/img_delete.do", method = RequestMethod.POST)
  public ModelAndView img_delete(HttpServletRequest request,
                                                 int event_no, int event_grp_no, String event_passwd) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", event_no);
    hashMap.put("event_passwd", event_passwd);
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      EventVO eventVO = eventProc.read(event_no);

      String event_file = eventVO.getEvent_file().trim();
      String event_thumb = eventVO.getEvent_thumb().trim();
      long event_size = eventVO.getEvent_size();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, eventVO.getEvent_file());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, eventVO.getEvent_thumb());  // Folder에서 1건의 파일 삭제
      
      event_file = "";
      event_thumb = "";
      event_size = 0;
      
      eventVO.setEvent_file(event_file);
      eventVO.setEvent_thumb(event_thumb);
      eventVO.setEvent_size(event_size);
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/event/read.do?event_no=" + event_no);
      
      cnt = this.eventProc.img_delete(eventVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
            
    return mav;    
  }
  
   /**
   * 메인 이미지 수정 처리 
   * http://localhost:9090/team2/event/img_update.do
   * 기존 이미지 삭제후 새로운 이미지 등록(수정 처리)
   * @return
   */
  @RequestMapping(value = "/event/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, EventVO eventVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("event_no", eventVO.getEvent_no());
    hashMap.put("event_passwd", eventVO.getEvent_passwd());

    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.eventProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      EventVO  vo = eventProc.read(eventVO.getEvent_no());
      
      String event_file  = vo.getEvent_file().trim();
      String event_thumb  = vo.getEvent_thumb().trim();
      long event_size = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/event/storage/main_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, eventVO.getEvent_file());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, eventVO.getEvent_thumb());  // Folder에서 1건의 파일 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
      // <input type='event_file' class="form-control" name='event_fileMF' id='event_fileMF' 
      //           value='' placeholder="파일 선택" multiple="multiple">
      MultipartFile mf = eventVO.getEvent_fileMF();
      event_size = mf.getSize();  // 파일 크기
      if (event_size > 0) { // 파일 크기 체크
        // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        event_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(event_file)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          event_thumb = Tool.preview(upDir, event_file, 200, 150); 
        }
      }    
      
      eventVO.setEvent_file(event_file);
      eventVO.setEvent_thumb(event_thumb);
      eventVO.setEvent_size(event_size);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------

      mav.setViewName("redirect:/event/read.do?event_no=" + eventVO.getEvent_no());
      
      cnt = this.eventProc.img_create(eventVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/event/update_msg"); // webapp/event/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
            
    return mav;    
  }
  
  ////////////////////////////////// 이미지 관련 코드 종료 ////////////////////////////////////////////////
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

}
