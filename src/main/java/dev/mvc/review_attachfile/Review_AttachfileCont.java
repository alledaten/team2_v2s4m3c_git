package dev.mvc.review_attachfile;

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

import dev.mvc.review.ReviewProcInter;
import dev.mvc.review.ReviewVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class Review_AttachfileCont {
  @Autowired
  @Qualifier("dev.mvc.review_attachfile.Review_AttachfileProc")
  private Review_AttachfileProcInter review_attachfileProc;
  
  @Autowired
  @Qualifier("dev.mvc.review.ReviewProc")
  private ReviewProcInter reviewProc;
  
  ////////////////////////////////////////////////////////////////////////////////////////////

  /**
   * 등록 폼 http://localhost:9090/resort/attachfile/create.do X
   * http://localhost:9090/team2/review_attachfile/create.do?review_cate_no=1&review_no=22 O
   * 
   * @return
   */
  @RequestMapping(value = "/review_attachfile/create.do", method = RequestMethod.GET)
  public ModelAndView create(int review_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review_attachfile/create"); // webapp/review_attachfile/create.jsp

    return mav;
  }
  
   /**
   * 등록 처리
   * @param ra
   * @param request
   * @param attachfileVO
   * @param categrpno
   * @return
   */
  @RequestMapping(value = "/review_attachfile/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, Review_AttachfileVO review_AttachfileVO, int review_cate_no) {

    ModelAndView mav = new ModelAndView();
    // ---------------------------------------------------------------
    // 파일 전송 코드 시작
    // ---------------------------------------------------------------
    int review_no = review_AttachfileVO.getReview_no(); // 부모글 번호
    String review_attachfile_rname = ""; // 원본 파일명
    String review_attachfile_upname = ""; // 업로드된 파일명
    long review_attachfile_size = 0; // 파일 사이즈
    String review_attachfile_thumb = ""; // Preview 이미지
    int upload_count = 0; // 정상처리된 레코드 갯수

    String upDir = Tool.getRealPath(request, "/review_attachfile/storage");

    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    List<MultipartFile> review_attachfile_rnamesMF = review_AttachfileVO.getReview_attachfile_rnamesMF();

    int count = review_attachfile_rnamesMF.size(); // 전송 파일 갯수
    if (count > 0) {
      for (MultipartFile multipartFile : review_attachfile_rnamesMF) { // 파일 추출, 1개이상 파일 처리
        review_attachfile_size = multipartFile.getSize(); // 파일 크기
        if (review_attachfile_size > 0) { // 파일 크기 체크
          review_attachfile_rname = multipartFile.getOriginalFilename(); // 원본 파일명
          review_attachfile_upname = Upload.saveFileSpring(multipartFile, upDir); // 파일 저장, 업로드된 파일명

          if (Tool.isImage(review_attachfile_rname)) { // 이미지인지 검사
            review_attachfile_thumb = Tool.preview(upDir, review_attachfile_upname, 200, 150); // thumb 이미지 생성
          }
        }
        Review_AttachfileVO vo = new Review_AttachfileVO();
        vo.setReview_no(review_no);
        vo.setReview_attachfile_rname(review_attachfile_rname);
        vo.setReview_attachfile_upname(review_attachfile_upname);
        vo.setReview_attachfile_thumb(review_attachfile_thumb);
        vo.setReview_attachfile_size(review_attachfile_size);

        // 파일 1건 등록 정보 dbms 저장, 파일이 20개이면 20개의 record insert.
        upload_count = upload_count + review_attachfileProc.create(vo);
      }
    }
    // -----------------------------------------------------
    // 파일 전송 코드 종료
    // -----------------------------------------------------

    mav.addObject("review_no", review_no); // redirect parameter 적용
    mav.addObject("review_cate_no", review_cate_no); // redirect parameter 적용
    mav.addObject("upload_count", upload_count); // redirect parameter 적용
    mav.addObject("url", "create_msg"); // create_msg.jsp, redirect parameter 적용
    // ★ 목록 생성 후 여기 수정해야한다
    mav.setViewName("redirect:/review_attachfile/msg.do"); // 새로고침 방지 ★ 목록 생성 후 여기 수정해야한다
    // ★ 목록 생성 후 여기 수정해야한다
    return mav;
  }

   /**
   * 새로고침을 방지하는 메시지 출력
   * 
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/review_attachfile/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    // 등록 처리 메시지: create_msg --> /attachfile/create_msg.jsp
    // 수정 처리 메시지: update_msg --> /attachfile/update_msg.jsp
    // 삭제 처리 메시지: delete_msg --> /attachfile/delete_msg.jsp
    mav.setViewName("/review_attachfile/" + url); // forward
    //mav.setViewName("/review_attachfile/create_msg"); // forward

    return mav; // forward
  }
  
   /**
   * 목록 http://localhost:9090/team2/review_attachfile/list.do
   * @return
   */
  @RequestMapping(value = "/review_attachfile/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    List<Review_AttachfileVO> list = this.review_attachfileProc.list();
    
    mav.addObject("list", list);
    mav.setViewName("/review_attachfile/list");

    return mav;
  }
  
   /**
   * 하나의 review_no별 목록 
   * http://localhost:9090/team2/review_attachfile/list_by_review_no.do?review_no=22
   * @return
   */
  @RequestMapping(value = "/review_attachfile/list_by_review_no.do", method = RequestMethod.GET)
  public ModelAndView list_by_review_no(int review_no) {
    ModelAndView mav = new ModelAndView();

    List<Review_AttachfileVO> list = review_attachfileProc.list_by_review_no(review_no);
    mav.addObject("list", list);

    ReviewVO reviewVO = this.reviewProc.read(review_no);
    mav.addObject("reviewVO", reviewVO);
    mav.setViewName("/review_attachfile/list_by_review_no"); // list_by_review_no.jsp

    return mav;
  }
  
  
   /** 
   * 첨부 파일 1건 삭제 처리
   * 
   * @return
   */
  @RequestMapping(value = "/review_attachfile/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(HttpServletRequest request, int review_attachfile_no,
    @RequestParam(value = "review_no", defaultValue = "0") int review_no, String rurl) {
    ModelAndView mav = new ModelAndView();

    // 삭제할 파일 정보를 읽어옴.
    Review_AttachfileVO review_AttachfileVO = review_attachfileProc.read(review_attachfile_no);

    String upDir = Tool.getRealPath(request, "/review_attachfile/storage"); // 절대 경로
    Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_rname()); // Folder에서 1건의 파일 삭제
    Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_thumb()); // 1건의 Thumb 파일 삭제

    // DBMS에서 1건의 파일 삭제
    review_attachfileProc.delete(review_attachfile_no);

    List<Review_AttachfileVO> list = review_attachfileProc.list(); // 목록 새로 고침
    mav.addObject("list", list);

    mav.addObject("review_no", review_no);

    mav.setViewName("redirect:/review_attachfile/" + rurl);

    return mav;
  }
  

 /**
  * FK를 사용한 레코드 삭제
  * http://localhost:9090/team2/review_attachfile/list_by_review_no.do?review_no=22&review_cate_no=1
  * @param request
  * @param review_no
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/review_attachfile/delete_by_review_no.do", method = RequestMethod.POST,
                         produces = "text/plain;charset=UTF-8")
 public String delete_by_review_no(HttpServletRequest request,
                                             @RequestParam(value = "review_no", defaultValue = "0") int review_no) {
   try {
     Thread.sleep(3000);
   } catch (InterruptedException e) {
     e.printStackTrace();
   }
   
   List<Review_AttachfileVO> list = this.review_attachfileProc.list_by_review_no(review_no);
   int cnt = 0; // 삭제된 레코드 갯수

   String upDir = Tool.getRealPath(request, "/review_attachfile/storage"); // 절대 경로
   
   for (Review_AttachfileVO review_AttachfileVO: list) { // 파일 갯수만큼 순환
     Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_rname()); // Folder에서 1건의 파일 삭제
     Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_thumb()); // 1건의 Thumb 파일 삭제
   
     review_attachfileProc.delete(review_AttachfileVO.getReview_attachfile_no());  // DBMS에서 1건의 파일 삭제
     cnt = cnt + 1;

   }
   
   JSONObject json = new JSONObject();
   json.put("cnt", cnt);

   return json.toString();
 }

  
  /**
  * 부모키별 갯수 산출
  * //http://localhost:9090/team2/review_attachfile/count_by_review_no.do?review_no=14
  * @return
  */
 @ResponseBody
 @RequestMapping(value = "/review_attachfile/count_by_review_no.do", method = RequestMethod.GET, 
                         produces = "text/plain;charset=UTF-8")
 public String count_by_review_no(int review_no) {
   try {
     Thread.sleep(3000);
   } catch (InterruptedException e) {
     e.printStackTrace();
   }
   
   int cnt = this.review_attachfileProc.count_by_review_no(review_no);

   JSONObject json = new JSONObject();
   json.put("cnt", cnt);

   return json.toString();
 }
  
  
  

}
