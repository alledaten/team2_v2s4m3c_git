package dev.mvc.event_attachfile;

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

import dev.mvc.event.EventProcInter;
import dev.mvc.event.EventVO;
import dev.mvc.review.ReviewProcInter;
import dev.mvc.review.ReviewVO;
import dev.mvc.review.Review_Member_ProductVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class Event_AttachfileCont {
  @Autowired
  @Qualifier("dev.mvc.event_attachfile.Event_AttachfileProc")
  private Event_AttachfileProcInter event_attachfileProc;
  
  @Autowired
  @Qualifier("dev.mvc.event.EventProc")
  private EventProcInter eventProc;
  
  ////////////////////////////////////////////////////////////////////////////////////////////

  /**
   * 등록 폼
   * http://localhost:9090/team2/event_attachfile/create.do?event_grp_no=1&event_no=22 O
   * @return
   */
  @RequestMapping(value = "/event_attachfile/create.do", method = RequestMethod.GET)
  public ModelAndView create(int event_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/event_attachfile/create"); // webapp/event_attachfile/create.jsp

    return mav;
  }
  
   /**
   * 등록 처리
   * @param ra
   * @param request
   * @param event_attachfileVO
   * @param event_grp_no
   * @return
   */
  @RequestMapping(value = "/event_attachfile/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, Event_AttachfileVO event_attachfileVO, int event_grp_no) {

    ModelAndView mav = new ModelAndView();
    // ---------------------------------------------------------------
    // 파일 전송 코드 시작
    // ---------------------------------------------------------------
    int event_no = event_attachfileVO.getEvent_no(); // 부모글 번호
    String event_attachfile_rname = ""; // 원본 파일명
    String event_attachfile_upname = ""; // 업로드된 파일명
    long event_attachfile_size = 0; // 파일 사이즈
    String event_attachfile_thumb = ""; // Preview 이미지
    int upload_count = 0; // 정상처리된 레코드 갯수

    String upDir = Tool.getRealPath(request, "/event_attachfile/storage");

    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    List<MultipartFile> event_attachfile_rnamesMF = event_attachfileVO.getEvent_attachfile_rnamesMF();

    int count = event_attachfile_rnamesMF.size(); // 전송 파일 갯수
    if (count > 0) {
      for (MultipartFile multipartFile : event_attachfile_rnamesMF) { // 파일 추출, 1개이상 파일 처리
        event_attachfile_size = multipartFile.getSize(); // 파일 크기
        if (event_attachfile_size > 0) { // 파일 크기 체크
          event_attachfile_rname = multipartFile.getOriginalFilename(); // 원본 파일명
          event_attachfile_upname = Upload.saveFileSpring(multipartFile, upDir); // 파일 저장, 업로드된 파일명

          if (Tool.isImage(event_attachfile_rname)) { // 이미지인지 검사
            event_attachfile_thumb = Tool.preview(upDir, event_attachfile_upname, 200, 150); // thumb 이미지 생성
          }
        }
        Event_AttachfileVO vo = new Event_AttachfileVO();
        vo.setEvent_no(event_no);
        vo.setEvent_attachfile_rname(event_attachfile_rname);
        vo.setEvent_attachfile_upname(event_attachfile_upname);
        vo.setEvent_attachfile_thumb(event_attachfile_thumb);
        vo.setEvent_attachfile_size(event_attachfile_size);

        // 파일 1건 등록 정보 dbms 저장, 파일이 20개이면 20개의 record insert.
        upload_count = upload_count + event_attachfileProc.create(vo);
      }
    }
    // -----------------------------------------------------
    // 파일 전송 코드 종료
    // -----------------------------------------------------

    mav.addObject("event_no", event_no); // redirect parameter 적용
    mav.addObject("event_grp_no", event_grp_no); // redirect parameter 적용
    mav.addObject("upload_count", upload_count); // redirect parameter 적용
    mav.addObject("url", "create_msg"); // create_msg.jsp, redirect parameter 적용
    mav.setViewName("redirect:/event_attachfile/msg.do"); 
    
    return mav;
  }

   /**
   * 새로고침을 방지하는 메시지 출력
   * 
   * @param admin_no
   * @return
   */
  @RequestMapping(value = "/event_attachfile/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    mav.setViewName("/event_attachfile/" + url); 

    return mav; // forward
  }
  
   /**
   * 목록 http://localhost:9090/team2/event_attachfile/list.do
   * @return
   */
  @RequestMapping(value = "/event_attachfile/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    
    List<Event_AttachfileVO> list = this.event_attachfileProc.list();
    mav.addObject("list", list);
    
    mav.setViewName("/event_attachfile/list");
    
    return mav;
  }
  
   /**
   * 하나의 event_no별 목록 
   * http://localhost:9090/team2/event_attachfile/list_by_event_no.do?event_no=22
   * @return
   */
  @RequestMapping(value = "/event_attachfile/list_by_event_no.do", method = RequestMethod.GET)
  public ModelAndView list_by_event_no(int event_no) {
    ModelAndView mav = new ModelAndView();

    List<Event_AttachfileVO> list = event_attachfileProc.list_by_event_no(event_no);
    mav.addObject("list", list);

    EventVO eventVO = this.eventProc.read(event_no);
    mav.addObject("eventVO", eventVO);
    
    mav.setViewName("/event_attachfile/list_by_event_no"); // list_by_event_no.jsp
    
    return mav;
  }
  
  
   /** 
   * 첨부 파일 1건 삭제 처리
   * @return
   */
  @RequestMapping(value = "/event_attachfile/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(HttpServletRequest request, int event_attachfile_no,
    @RequestParam(value = "event_no", defaultValue = "0") int event_no, String rurl) {
    ModelAndView mav = new ModelAndView();

    // 삭제할 파일 정보를 읽어옴.
    Event_AttachfileVO event_attachfileVO = event_attachfileProc.read(event_attachfile_no);

    String upDir = Tool.getRealPath(request, "/event_attachfile/storage"); // 절대 경로
    Tool.deleteFile(upDir, event_attachfileVO.getEvent_attachfile_rname()); // Folder에서 1건의 파일 삭제
    Tool.deleteFile(upDir, event_attachfileVO.getEvent_attachfile_thumb()); // 1건의 Thumb 파일 삭제

    // DBMS에서 1건의 파일 삭제
    event_attachfileProc.delete(event_attachfile_no);

    List<Event_AttachfileVO> list = event_attachfileProc.list(); // 목록 새로 고침
    mav.addObject("list", list);
    mav.addObject("event_no", event_no);

    mav.setViewName("redirect:/event_attachfile/" + rurl);

    return mav;
  }
  

 /**
  * FK를 사용한 레코드 삭제
  * http://localhost:9090/team2/event_attachfile/delete_by_event_no.do?event_no=22&event_grp_no=1
  * @param request
  * @param event_no
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/event_attachfile/delete_by_event_no.do", method = RequestMethod.POST,
                         produces = "text/plain;charset=UTF-8")
 public String delete_by_event_no(HttpServletRequest request,
                                             @RequestParam(value = "event_no", defaultValue = "0") int event_no) {
   try {
     Thread.sleep(3000);
   } catch (InterruptedException e) {
     e.printStackTrace();
   }
   
   List<Event_AttachfileVO> list = this.event_attachfileProc.list_by_event_no(event_no);
   int cnt = 0; // 삭제된 레코드 갯수

   String upDir = Tool.getRealPath(request, "/event_attachfile/storage"); // 절대 경로
   
   for (Event_AttachfileVO event_attachfileVO: list) { // 파일 갯수만큼 순환
     Tool.deleteFile(upDir, event_attachfileVO.getEvent_attachfile_rname()); // Folder에서 1건의 파일 삭제
     Tool.deleteFile(upDir, event_attachfileVO.getEvent_attachfile_thumb()); // 1건의 Thumb 파일 삭제
   
     event_attachfileProc.delete(event_attachfileVO.getEvent_attachfile_no());  // DBMS에서 1건의 파일 삭제
     cnt = cnt + 1;

   }
   
   JSONObject json = new JSONObject();
   json.put("cnt", cnt);

   return json.toString();
 }

  
  /**
  * 부모키별 갯수 산출
  * //http://localhost:9090/team2/event_attachfile/count_by_event_no.do?event_no=1
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/event_attachfile/count_by_event_no.do", method = RequestMethod.GET, 
                         produces = "text/plain;charset=UTF-8")
 public String count_by_event_no(int event_no) {
   try {
     Thread.sleep(3000);
   } catch (InterruptedException e) {
     e.printStackTrace();
   }
   
   int cnt = this.event_attachfileProc.count_by_event_no(event_no);

   JSONObject json = new JSONObject();
   json.put("cnt", cnt);

   return json.toString();
 }
  
  
  

}
