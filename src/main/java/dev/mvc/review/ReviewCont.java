package dev.mvc.review;

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

import dev.mvc.review_attachfile.Review_AttachfileProcInter;
import dev.mvc.review_attachfile.Review_AttachfileVO;
import dev.mvc.review_cate.Review_CateProcInter;
import dev.mvc.review_cate.Review_CateVO;
import dev.mvc.review_categrp.Review_CategrpProcInter;
import dev.mvc.review_categrp.Review_CategrpVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ReviewCont {
  @Autowired
  @Qualifier("dev.mvc.review_attachfile.Review_AttachfileProc")
  private Review_AttachfileProcInter review_attachfileProc;
  
  @Autowired
  @Qualifier("dev.mvc.review.ReviewProc")
  private ReviewProcInter reviewProc;

  @Autowired
  @Qualifier("dev.mvc.review_cate.Review_CateProc")
  private Review_CateProcInter review_CateProc;

  @Autowired
  @Qualifier("dev.mvc.review_categrp.Review_CategrpProc")
  private Review_CategrpProcInter review_CategrpProc;

  /**
   * 등록폼 http://localhost:9090/team2/review/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/create.do", method = RequestMethod.GET)
  public ModelAndView create(int review_cate_no) {
    ModelAndView mav = new ModelAndView();

    Review_CateVO review_CateVO = this.review_CateProc.read(review_cate_no);
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_CateVO.getReview_categrp_no());

    mav.addObject("review_CateVO", review_CateVO);
    mav.addObject("review_CategrpVO", review_CategrpVO);
    mav.setViewName("/review/create");

    return mav; // forward
  }

  /**
   * 등록 처리 http://localhost:9090/team2/review/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    Review_CateVO review_CateVO = review_CateProc.read(reviewVO.getReview_cate_no());
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO);
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String review_file = ""; // main image
    String review_thumb = ""; // preview image

    String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // 절대 경로

    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    // <input type='file' class="form-control" name='file1MF' id='file1MF'
    // value='' placeholder="파일 선택" multiple="multiple">
    MultipartFile mf = reviewVO.getReview_fileMF();

    long review_size = mf.getSize(); // 파일 크기
    if (review_size > 0) { // 파일 크기 체크
      // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
      // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
      review_file = Upload.saveFileSpring(mf, upDir);

      if (Tool.isImage(review_file)) { // 이미지인지 검사
        // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
        review_thumb = Tool.preview(upDir, review_file, 200, 150);
      }

    }

    reviewVO.setReview_file(review_file);
    reviewVO.setReview_thumb(review_thumb);
    reviewVO.setReview_size(review_size);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    // Call By Reference: 메모리 공유, Hashcode 전달
    int cnt = this.reviewProc.create(reviewVO);

    // -------------------------------------------------------------------
    // PK의 return
    // -------------------------------------------------------------------
    System.out.println("--> review_no: " + reviewVO.getReview_no());
    mav.addObject("review_no", reviewVO.getReview_no()); // redirect parameter 적용
    // -------------------------------------------------------------------

    if (cnt == 1) {
      review_CateProc.increaseCnt(reviewVO.getReview_cate_no());
    }
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    // <c:import> 정상 작동안됨.
    // mav.setViewName("/contents/create_msg"); // /webapp/contents/create_msg.jsp

    // System.out.println("--> cateno: " + contentsVO.getCateno());
    // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
    mav.addObject("review_cate_no", reviewVO.getReview_cate_no()); // redirect parameter 적용
    mav.setViewName("redirect:/review/list.do?review_cate_no=" + reviewVO.getReview_cate_no() + "&review_categrp_no=" + review_CategrpVO.getReview_categrp_no());
    
    return mav; // forward
  }

  /**
   * 목록 http://localhost:9090/team2/review/list_all.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/list_all.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review/list_all"); // /webapp/review/list_all.jsp

    List<ReviewVO> list = this.reviewProc.list_all();
    mav.addObject("list", list);

    return mav; // forward
  }

  /**
   * 카테고리별 목록
   * 
   * @param review_cate_no
   * @return
   */
//  @RequestMapping(value = "/review/list.do", method = RequestMethod.GET)
//  public ModelAndView list_by_review_cate_no(int review_cate_no) {
//    ModelAndView mav = new ModelAndView();
//    mav.setViewName("/review/list_by_list_by_review_cate_no_table_img");
//
//    Review_CateVO review_CateVO = this.review_CateProc.read(review_cate_no);
//    mav.addObject("review_CateVO", review_CateVO);
//
//    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_CateVO.getReview_categrp_no());
//    mav.addObject("review_CategrpVO", review_CategrpVO);
//
//    List<ReviewVO> list = this.reviewProc.list_by_review_cate_no(review_cate_no);
//    mav.addObject("list", list);
//
//    return mav; // forward
//  }

   /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9090/team2/review/list.do
   * http://localhost:9090/team2/review/list.do?review_cate_no=1&review_word=스위스&nowPage=1
   * @param review_cate_no
   * @param review_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/review/list.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_review_cate_no_search_paging(
      @RequestParam(value="review_cate_no", defaultValue="1") int review_cate_no,
      @RequestParam(value="review_word", defaultValue="") String review_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    
    ModelAndView mav = new ModelAndView();
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("review_cate_no", review_cate_no); // #{cateno}
    map.put("review_word", review_word);     // #{word}
    map.put("nowPage", nowPage);  // 페이지에 출력할 레코드의 범위를 산출하기위해 사용     
    //System.out.println("--> nowPage: " + nowPage);
    
    // 검색 목록
    List<Review_MemberVO> list = reviewProc.list_by_review_cate_no_search_paging(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = reviewProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Review_CateVO review_CateVO = review_CateProc.read(review_cate_no);
    mav.addObject("review_CateVO", review_CateVO);
    
    Review_CategrpVO review_CategrpVO = review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * 
     * @param listFile 목록 파일명 
     * @param review_cate_no 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param review_word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = reviewProc.pagingBox("list.do", review_cate_no, search_count, nowPage, review_word);
    
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
    mav.setViewName("/review/list_by_review_cate_no_table_img_search_paging");   
    
    return mav;
  }    
  
  

   /**
   * 조회 http://localhost:9090/team2/review/read.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/read.do", method = RequestMethod.GET)
  public ModelAndView read(int review_no) {
    ModelAndView mav = new ModelAndView();

    ReviewVO reviewVO = this.reviewProc.read(review_no);
    mav.addObject("reviewVO", reviewVO);
    
    int review_view = this.reviewProc.update_review_view(review_no);
    mav.addObject("review_view", review_view); // request에 저장
    
    System.out.println("--> review_no: " + review_no);

    Review_CateVO review_CateVO = review_CateProc.read(reviewVO.getReview_cate_no());
    mav.addObject("review_CateVO", review_CateVO);

    Review_CategrpVO review_CategrpVO = review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO);

    // 첨부 파일 목록
    List<Review_AttachfileVO> review_attachfile_list = this.review_attachfileProc.list_by_review_no(review_no);
    mav.addObject("review_attachfile_list", review_attachfile_list);
    // System.out.println("--> 첨부 파일 갯수: " + attachfile_list.size());

    mav.setViewName("/review/read"); // /webapp/contents/read.jsp
    // mav.setViewName("/contents/read_img"); // /webapp/contents/read_img.jsp
    // mav.setViewName("/contents/read_img_attachfile"); //
    // /webapp/contents/read_img_attachfile.jsp
    // mav.setViewName("/contents/read_img_attachfile_reply"); //
    // /webapp/contents/read_img_attachfile_reply.jsp
    // mav.setViewName("/contents/read_img_attachfile_reply_add_pg"); //
    // /webapp/contents/read_img_attachfile_reply_add.jsp
    return mav;
  }
  
   /**
   * 수정 폼
   * @return
   */
  @RequestMapping(value="/review/update.do", method=RequestMethod.GET )
  public ModelAndView update(int review_no) {
    ModelAndView mav = new ModelAndView();
    
    ReviewVO reviewVO = this.reviewProc.read_update(review_no); // 수정용 읽기
    mav.addObject("reviewVO", reviewVO); // request.setAttribute("contentsVO", contentsVO);
    
    Review_CateVO review_CateVO = review_CateProc.read(reviewVO.getReview_cate_no());
    mav.addObject("review_CateVO", review_CateVO);
    
    Review_CategrpVO review_CategrpVO = review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO);
    
    mav.setViewName("/review/update"); // webapp/contents/update.jsp
    
    return mav;
  }
  
   /**
   * 수정 처리
   * @param contentsVO
   * @return
   */
  @RequestMapping(value="/review/update.do", method = RequestMethod.POST )
  public ModelAndView update(ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    Review_CateVO review_CateVO = this.review_CateProc.read(reviewVO.getReview_cate_no()); 
    // mav.addObject("cateVO", cateVO); // 전달안됨.
    mav.addObject("review_cate_name", review_CateVO.getReview_cate_name());
    mav.addObject("review_cate_no", review_CateVO.getReview_cate_no());

    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    // mav.addObject("categrpVO", categrpVO); // 전달안됨.
    mav.addObject("review_categrp_name", review_CategrpVO.getReview_categrp_name());
    
    mav.addObject("review_no", reviewVO.getReview_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", reviewVO.getReview_no());
    hashMap.put("review_passwd", reviewVO.getReview_passwd());
    
    int passwd_cnt = 0;   // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 수정
      cnt = this.reviewProc.update(reviewVO);
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
        
    mav.setViewName("/review/update_msg"); // webapp/review/update_msg.jsp
    
    return mav;
  }
  
 /** 
   * 삭제폼
   * @param review_no
   * @return
   */
  @RequestMapping(value = "/review/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int review_no) {
    ModelAndView mav = new ModelAndView();
    
    ReviewVO reviewVO = this.reviewProc.read_update(review_no);
    mav.addObject("reviewVO", reviewVO);
    
    mav.setViewName("/review/delete");
    return mav;
  }
  
  /**
   * 삭제 처리 + 파일 삭제
   * @param request
   * @param review_no
   * @param review_cate_no
   * @param review_passwd
   * @param review_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/review/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpServletRequest request, int review_no, int review_cate_no, String review_passwd, 
      @RequestParam(value = "review_word", defaultValue = "") String review_word,
      @RequestParam(value = "nowPage", defaultValue = "1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    ReviewVO reviewVO = this.reviewProc.read(review_no);
    String review_title = reviewVO.getReview_title();
    mav.addObject("review_title", review_title);

    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", review_no);
    hashMap.put("review_passwd", review_passwd);

    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0; // 수정된 레코드 갯수

    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    boolean sw = false;

    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 수정
      cnt = this.reviewProc.delete(review_no);
      if (cnt == 1) {
        review_CateProc.decreaseCnt(review_cate_no);

        // -------------------------------------------------------------------------------------
        // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("review_cate_no", review_cate_no);
        map.put("review_word", review_word);
        // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
        if (reviewProc.search_count(map) % Review.RECORD_PER_PAGE == 0) {
          nowPage = nowPage - 1;
          if (nowPage < 1) {
            nowPage = 1; // 시작 페이지
          }
        }
        // -------------------------------------------------------------------------------------
      }

      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, reviewVO.getReview_file()); // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, reviewVO.getReview_thumb()); // Folder에서 1건의 파일 삭제

    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
    mav.addObject("nowPage", nowPage); // request에 저장
    // System.out.println("--> ContentsCont.java nowPage: " + nowPage);

    mav.addObject("review_cate_no", reviewVO.getReview_cate_no()); // redirect parameter 적용
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter 적용

    // mav.setViewName("/contents/delete_msg"); // webapp/contents/delete_msg.jsp
    //mav.setViewName("/review/delete_msg");
    mav.setViewName("redirect:/review/delete_msg.jsp");

    return mav;
  }
  
  
  /////////////////////////////////////////////////////////////////////////////////
  /////////// ------------ 이미지 관련 시작  ------------- ///////////////
  /////////////////////////////////////////////////////////////////////////////////
  
  /**
   * 메인 이미지 등록 폼 http://localhost:9090/team2/review/img_create.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/img_create.do", method = RequestMethod.GET)
  public ModelAndView img_create(int review_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review/img_create"); // /webapp/review/img_create.jsp
    
    ReviewVO reviewVO = this.reviewProc.read(review_no);
    mav.addObject("reviewVO", reviewVO);
    
    Review_CateVO review_CateVO = this.review_CateProc.read(reviewVO.getReview_cate_no());
    mav.addObject("review_CateVO", review_CateVO); 
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO); 
    
    return mav; // forward
  }

   /**
   * 메인 이미지 등록 처리 http://localhost:9090/team2/review/img_create.do
   * @return
   */
  @RequestMapping(value = "/review/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", reviewVO.getReview_no());
    hashMap.put("review_passwd", reviewVO.getReview_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      String review_file = "";     // main image
      String review_thumb = ""; // preview image
          
      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // 절대 경로
      // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택" multiple="multiple">
      MultipartFile mf = reviewVO.getReview_fileMF();
      long review_size = mf.getSize(); // 파일 크기
      if (review_size > 0) { // 파일 크기 체크
        // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        review_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(review_file)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          review_thumb = Tool.preview(upDir, review_file, 200, 150); 
        }
      }    
      
      reviewVO.setReview_file(review_file);
      reviewVO.setReview_thumb(review_thumb);
      reviewVO.setReview_size(review_size);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/review/read.do?review_no=" + reviewVO.getReview_no());
      
      cnt = this.reviewProc.img_create(reviewVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/review/update_msg"); // webapp/contents/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
            
    return mav;    
  }
   
   /**
   * 메인 이미지 삭제 및 수정 폼 http://localhost:9090/team2/review/img_update.do
   * @return
   */
  @RequestMapping(value = "/review/img_update.do", method = RequestMethod.GET)
  public ModelAndView img_update(int review_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/review/img_update"); // /webapp/review/img_update.jsp

    ReviewVO reviewVO = this.reviewProc.read(review_no);
    mav.addObject("reviewVO", reviewVO);
    
    Review_CateVO review_CateVO = this.review_CateProc.read(reviewVO.getReview_cate_no());
    mav.addObject("review_CateVO", review_CateVO); 
    
    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO); 
    
    return mav; // forward
  }
  
  /**
   * 메인 이미지 삭제 처리 http://localhost:9090/team2/review/img_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/img_delete.do", method = RequestMethod.POST)
  public ModelAndView img_delete(HttpServletRequest request,
                                                 int review_no, int review_cate_no, String review_passwd) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", review_no);
    hashMap.put("review_passwd", review_passwd);
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      ReviewVO reviewVO = reviewProc.read(review_no);

      String review_file = reviewVO.getReview_file().trim();
      String review_thumb = reviewVO.getReview_thumb().trim();
      long review_size = reviewVO.getReview_size();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, reviewVO.getReview_file());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, reviewVO.getReview_thumb());  // Folder에서 1건의 파일 삭제
      
      review_file = "";
      review_thumb = "";
      review_size = 0;
      
      reviewVO.setReview_file(review_file);
      reviewVO.setReview_thumb(review_thumb);
      reviewVO.setReview_size(review_size);
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/review/read.do?review_no=" + review_no);
      
      cnt = this.reviewProc.img_delete(reviewVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/review/update_msg"); // webapp/review/update_msg.jsp 여기 주소 변경
      
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
            
    return mav;    
  }
  
   /**
   * 메인 이미지 수정 처리 http://localhost:9090/team2/review/img_update.do
   * 기존 이미지 삭제후 새로운 이미지 등록(수정 처리)
   * @return
   */
  @RequestMapping(value = "/review/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", reviewVO.getReview_no());
    hashMap.put("review_passwd", reviewVO.getReview_passwd());

    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      ReviewVO vo = reviewProc.read(reviewVO.getReview_no());
      
      String review_file = vo.getReview_file().trim();
      String review_thumb = vo.getReview_thumb().trim();
      long review_size = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, reviewVO.getReview_file());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, reviewVO.getReview_thumb());  // Folder에서 1건의 파일 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
      // <input type='review_file' class="form-control" name='review_fileMF' id='review_fileMF' 
      //           value='' placeholder="파일 선택" multiple="multiple">
      MultipartFile mf = reviewVO.getReview_fileMF();
      review_size = mf.getSize();  // 파일 크기
      if (review_size > 0) { // 파일 크기 체크
        // mp3 = mf.getOriginalFilename(); // 원본 파일명, spring.jpg
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        review_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(review_file)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          review_thumb = Tool.preview(upDir, review_file, 200, 150); 
        }
      }    
      
      reviewVO.setReview_file(review_file);
      reviewVO.setReview_thumb(review_thumb);
      reviewVO.setReview_size(review_size);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------

      mav.setViewName("redirect:/review/read.do?review_no=" + reviewVO.getReview_no());
      
      cnt = this.reviewProc.img_create(reviewVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/review/update_msg"); // webapp/review/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
            
    return mav;    
  }
  

}
