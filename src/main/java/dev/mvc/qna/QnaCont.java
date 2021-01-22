package dev.mvc.qna;

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

import dev.mvc.answer.AnswerProcInter;
import dev.mvc.answer.AnswerVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;


@Controller
public class QnaCont {
  @Autowired
  @Qualifier("dev.mvc.qna.QnaProc")
  private QnaProcInter qnaProc;
  
  @Autowired
  @Qualifier("dev.mvc.answer.AnswerProc")
  private AnswerProcInter answerProc;
  
  /**
   * 등록폼 http;//localhost:9090/team2/qna/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/create"); // /webapp/cate/create.jsp

    return mav; // forward
  }
  
  /**
   * 등록 처리 http;//localhost:9090/tema2/qna/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, QnaVO qnaVO) {

    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String file1 = "";     // main image
    String thumb1 = ""; // preview image
        
    String upDir = Tool.getRealPath(request, "/qna/storage/main_images"); // 절대 경로
    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    //  <input type='file' class="form-control" name='file1MF' id='file1MF' 
    //            value='' placeholder="파일 선택" multiple="multiple">
    MultipartFile mf = qnaVO.getFile1MF();
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
    
    qnaVO.setFile1(file1);
    qnaVO.setThumb1(thumb1);
    qnaVO.setSize1(size1);
    
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------    
    
    mav.setViewName("/qna/create_msg"); // /webapp/qna/create_msg.jsp

    int cnt = this.qnaProc.create(qnaVO); // 등록 처리
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    return mav; // forward
  }
  
//  /**
//   * 목록 http;//localhost:9090/team2/qna/list.do
//   * 
//   * @return
//   */
//  @RequestMapping(value = "/qna/list.do", method = RequestMethod.GET)
//  public ModelAndView list() {
//    ModelAndView mav = new ModelAndView();
//    mav.setViewName("/qna/list"); // /webapp/qna/list.jsp
//
//    List<QnaVO> list = this.qnaProc.list_qnano_asc();
//    // List<QnaVO> list = this.qnaProc.list_seqno_asc();
//    mav.addObject("list", list);
//
//    return mav; // forward
//  }
  
  /**
   * join 목록 http;//localhost:9090/team2/qna/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/list_member_join.do", method = RequestMethod.GET)
  public ModelAndView list_member_join() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/qna/list_member_join"); // /webapp/qna/list_member_join.jsp

    List<QnaMemberVO> list = this.qnaProc.list_member_join();
    // List<QnaVO> list = this.qnaProc.list_seqno_asc();
    mav.addObject("list", list);

    return mav; // forward
  }
  
  // http://localhost:9090/team2/qna/read.do
  /**
   * 조회
   * @return
   */
  @RequestMapping(value="/qna/read.do", method=RequestMethod.GET )
  public ModelAndView read(int qna_no) {
    ModelAndView mav = new ModelAndView();

    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO); // request.setAttribute("qnaVO", qnaVO);
    
//    AnswerVO answerVO = this.answerProc.read(qnaVO.getQna_no());
//    mav.addObject("answerVO", answerVO);
    
//    QnaMemberVO qnamemberVO = this.qnaProc.read_member(qna_no);
//    mav.addObject("qnamemberVO", qnamemberVO); 
    
//    CommunityVO communityVO = this.communityProc.read(communityVO.getCommunity_no());
//    mav.addObject("communityVO", communityVO); 
    
    mav.setViewName("/qna/read"); // /webapp/qna/read.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/qna/update.do
  /**
   * 수정 폼
   * @return
   */
  @RequestMapping(value="/qna/update.do", method=RequestMethod.GET )
  public ModelAndView update(int qna_no) {
    ModelAndView mav = new ModelAndView();
    
    QnaVO qnaVO = this.qnaProc.read_update(qna_no); // 수정용 읽기
    mav.addObject("qnaVO", qnaVO); // request.setAttribute("qnaVO", qnaVO);
    
    mav.setViewName("/qna/update"); // webapp/qna/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/qna/update.do
  /**
   * 수정 처리
   * @param qnaVO
   * @return
   */
  @RequestMapping(value="/qna/update.do", method=RequestMethod.POST )
  public ModelAndView update(QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();
    
    mav.addObject("qna_no", qnaVO.getQna_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qnaVO.getQna_no());
    hashMap.put("qna_passwd", qnaVO.getQna_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 수정
      cnt = this.qnaProc.update(qnaVO);
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
        
    mav.setViewName("/qna/update_msg"); // webapp/qna/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/qna/delete.do
  /**
   * 삭제 폼
   * @return
   */
  @RequestMapping(value="/qna/delete.do", method=RequestMethod.GET )
  public ModelAndView delete(int qna_no) {
    ModelAndView mav = new ModelAndView();
    
    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO);
    
    mav.setViewName("/qna/delete"); // webapp/qna/delete.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/qna/delete.do
  /**
   * 삭제 처리
   * @param qna_no
   * @return
   */
  @RequestMapping(value="/qna/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(QnaVO qnaVO, HttpServletRequest request, String qna_passwd,
                                          @RequestParam(value="community_no", defaultValue="4") int community_no,
                                          @RequestParam(value="qna_word", defaultValue="") String qna_word,
                                          @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    int qna_no = qnaVO.getQna_no();
    
//    QnaVO vo = this.qnaProc.read(qna_no);
//    String title = vo.getQna_title();
    String qna_title = this.qnaProc.read(qna_no).getQna_title();
    mav.addObject("qna_title", qna_title);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qna_no);
    hashMap.put("qna_passwd", qnaVO.getQna_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 삭제된 레코드 갯수 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);    
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 글 삭제
      
      cnt = this.qnaProc.delete(qna_no);
      
      if (cnt ==1) {
      // cateProc.decreaseCnt(cateno);
        
      // -------------------------------------------------------------------------------------
      // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
      HashMap<String, Object> map = new HashMap<String, Object>();
      // map.put("community_no", qnaVO.getCommunity_no());
      map.put("qna_word", qnaVO.getQna_word());
      // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
      if (qnaProc.search_count(map) % Contents.RECORD_PER_PAGE == 0) {
        nowPage = nowPage - 1;
        if (nowPage < 1) {
          nowPage = 1; // 시작 페이지
        }
      }
      // -------------------------------------------------------------------------------------     
      }
    }
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
    mav.addObject("nowPage", nowPage); // request에 저장
    // System.out.println("--> ContentsCont.java nowPage: " + nowPage);
    
    // mav.addObject("community_no", qnaVO.getCommunity_no()); // redirect parameter 적용
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter 적용
    
    // mav.setViewName("/qna/delete_msg"); // webapp/qna/delete_msg.jsp
    mav.setViewName("redirect:/qna/msg.do");
    
    return mav;
  }
  
  /**
   * 새로고침을 방지하는 메시지 출력
   * @param qna_no
   * @return
   */
  @RequestMapping(value="/qna/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    
    // 등록 처리 메시지: create_msg --> /qna/create_msg.jsp
    // 수정 처리 메시지: update_msg --> /qna/update_msg.jsp
    // 삭제 처리 메시지: delete_msg --> /qna/delete_msg.jsp
    mav.setViewName("/qna/" + url); // forward
    
    return mav; // forward
  }
  
  /**
   * 출력모드 변경
   * 
   * @param qnaVO
   * @return
   */
  @RequestMapping(value = "/qna/update_visible.do", method = RequestMethod.GET)
  public ModelAndView update_visible(QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.qnaProc.update_visible(qnaVO);
    mav.addObject("cnt", cnt); // request에 저장
    
    if(cnt == 1) {
      mav.setViewName("redirect:/qna/list.do"); // request 객체가 전달이 안됨.
    } else {
      QnaVO vo = this.qnaProc.read(qnaVO.getQna_no());
      String title = vo.getQna_title();
      mav.addObject("qna_title", title);
      mav.setViewName("/qna/update_visible_mag"); // /qna/update_visible_mag.jsp
    }
    return mav;
  }

  /**
   * 메인 이미지 등록폼 http;//localhost:9090/team2/answer/img_create.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/img_create.do", method = RequestMethod.GET)
  public ModelAndView img_create(int qna_no) {
    ModelAndView mav = new ModelAndView();    
    mav.setViewName("/qna/img_create"); // /webapp/answer/img_create.jsp
    
    
    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO); 
    
    return mav; // forward
  }
  
  /**
   * 메인 이미지 등록 처리 http;//localhost:9090/team2/qna/img_create.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qnaVO.getQna_no());
    hashMap.put("qna_passwd", qnaVO.getQna_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      String file1 = "";     // main image
      String thumb1 = ""; // preview image
          
      String upDir = Tool.getRealPath(request, "/answer/storage/main_images"); // 절대 경로
      // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
      //  <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //            value='' placeholder="파일 선택" multiple="multiple">
      MultipartFile mf = qnaVO.getFile1MF();
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
      
      qnaVO.setFile1(file1);
      qnaVO.setThumb1(thumb1);
      qnaVO.setSize1(size1);
      
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
     
      mav.setViewName("redirect:/qna/read.do?qna_no=" + qnaVO.getQna_no()); // /webapp/qna/create_msg.jsp

      cnt = this.qnaProc.img_create(qnaVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/qna/update_msg"); // webapp/qna/update_msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
        
    return mav;
  }
  
  /**
   * 메인 이미지 삭제/수정 폼 http;//localhost:9090/team2/qna/img_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/img_update.do", method = RequestMethod.GET)
  public ModelAndView img_update(int qna_no) {
    ModelAndView mav = new ModelAndView();    
    mav.setViewName("/qna/img_update"); // /webapp/qna/img_update.jsp
    
    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO); 
    
    return mav; // forward
  }

  /**
   * 메인 이미지 삭제 처리 http;//localhost:9090/team2/qna/img_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/img_delete.do", method = RequestMethod.POST)
  public ModelAndView img_delete(HttpServletRequest request,
                                             int answer_no, int qna_no, String qna_passwd) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qna_no);
    hashMap.put("qna_passwd", qna_passwd);
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      QnaVO qnaVO = qnaProc.read(qna_no);
      // System.out.println("file1: " + answerVO.getFile1());
      
      String file1 = qnaVO.getFile1().trim();
      String thumb1 = qnaVO.getThumb1().trim();
      long size1 = qnaVO.getSize1();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/contents/storage/main_images"); // 절대 경로
      sw = Tool.deleteFile(upDir, qnaVO.getFile1());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, qnaVO.getThumb1());  // Folder에서 1건의 파일 삭제
      // System.out.println("sw: " + sw);
      
      file1 = "";
      thumb1 = "";
      size1 = 0;
      
      qnaVO.setFile1(file1);
      qnaVO.setThumb1(thumb1);
      qnaVO.setSize1(size1);
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
     
      mav.setViewName("redirect:/qna/read.do?qna_no=" + qna_no);
      
      cnt = this.qnaProc.img_delete(qnaVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/qna/update_msg"); // webapp/qna/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
            
    return mav;    
  }
  
  /**
   * 메인 이미지 수정 처리 http;//localhost:9090/team2/qna/img_update.do
   * 기존 이미지 삭제 후 새로운 이미지 등록(수정 처리)
   * @return
   */
  @RequestMapping(value = "/qna/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qnaVO.getQna_no());
    hashMap.put("qna_passwd", qnaVO.getQna_passwd());
    
    int passwd_cnt = 0; // 패스워드 일치 레코드 갯수
    int cnt = 0;             // 수정된 레코드 갯수 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // 패스워드가 일치할 경우 파일 업로드
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      QnaVO vo = qnaProc.read(qnaVO.getQna_no());
      // System.out.println("file1: " + answerVO.getFile1());
      
      String file1 = vo.getFile1().trim();
      String thumb1 = vo.getThumb1().trim();
      long size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/qna/storage/main_images"); // 절대 경로

      sw = Tool.deleteFile(upDir, qnaVO.getFile1());  // Folder에서 1건의 파일 삭제
      sw = Tool.deleteFile(upDir, qnaVO.getThumb1());  // Folder에서 1건의 파일 삭제
      // System.out.println("sw: " + sw);
      
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
     
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
      //  <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //            value='' placeholder="파일 선택" multiple="multiple">
      MultipartFile mf = qnaVO.getFile1MF();
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
      
      qnaVO.setFile1(file1);
      qnaVO.setThumb1(thumb1);
      qnaVO.setSize1(size1);
      
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/qna/read.do?answer_no=" + qnaVO.getQna_no()); 

      cnt = this.qnaProc.img_create(qnaVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/qna/update_msg"); // webapp/answer/update_msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request에 저장
    mav.addObject("passwd_cnt", passwd_cnt); // request에 저장
        
    return mav;
  }
  
  
  /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9090/team2/qna/list.do
   * http://localhost:9090/team2/qna/list.do?community_no=4&qna_word=질문&nowPage=1
   * @param community_no
   * @param qna_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/qna/list.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_search_paging_join(
      @RequestParam(value="community_no", defaultValue="4") int community_no,
      @RequestParam(value="qna_word", defaultValue="") String qna_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    // System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("community_no", community_no); // #{community_no}
    map.put("qna_word", qna_word);     // #{qna_word}
    map.put("nowPage", nowPage);  // 페이지에 출력할 레코드의 범위를 산출하기위해 사용     
    
    // 검색 목록
//    List<QnaVO> list = qnaProc.list_search_paging(map);
//    mav.addObject("list", list);
    
    List<QnaMemberVO> list = qnaProc.list_search_paging_join(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = qnaProc.search_count(map);
    mav.addObject("search_count", search_count);
  

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * 
     * @param listFile 목록 파일명 
     * @param community_no 커뮤니티 번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param qna_word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = qnaProc.pagingBox("list.do", community_no, search_count, nowPage, qna_word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);

    // /qna/list_search_paging_join.jsp
    mav.setViewName("/qna/list_search_paging_join");   
    
    return mav;
  }    
  
  // http://localhost:9090/team2/qna/reply.do?community_no=4&qna_no=1
  /**
   * 답변 폼
   * @return
   */
  @RequestMapping(value="/qna/reply.do", method=RequestMethod.GET )
  public ModelAndView reply(int community_no, int qna_no) {
    ModelAndView mav = new ModelAndView();
    System.out.println("답변 대상: " + qna_no);
    
    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO);
    

    mav.setViewName("/qna/reply"); // webapp/contents/reply.jsp
    
    return mav;
  }

  // http://localhost:9090/team2/qna/reply.do
  /**
   * 답변 등록 처리
   * @return
   */
  @RequestMapping(value="/qna/reply.do", 
                              method=RequestMethod.POST )
  public ModelAndView reply(HttpServletRequest request, QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();
    
     // --------------------------- 답변 관련 코드 시작 --------------------------
     QnaVO parentVO = qnaProc.read(qnaVO.getQna_no()); // 부모글 정보 추출
     
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("grpno", parentVO.getGrpno());
     map.put("ansnum",  parentVO.getAnsnum());
     qnaProc.increaseAnsnum(map); // 현재 등록된 부모글 ansnum을 1 증가시킴.

     qnaVO.setGrpno(parentVO.getGrpno()); // 부모의 그룹번호 할당
     qnaVO.setIndent(parentVO.getIndent() + 1); // 답변 차수 증가
     qnaVO.setAnsnum(parentVO.getAnsnum() + 1); // 부모 바로 아래 등록
     // --------------------------- 답변 관련 코드 종료 --------------------------
     
    int cnt = this.qnaProc.reply(qnaVO); // Call By Reference로 전송
    
    System.out.println("cnt: " + cnt);
    mav.addObject("cnt", cnt);
    
    // ---------------------------------------------------------------------------------------
    // cnt, contentsno return 
    // ---------------------------------------------------------------------------------------
    // Spring <-----> contentsVO <-----> MyBATIS
    // Spring과 MyBATIS가 ContentsVO를 공유하고 있음.
    // MyBATIS는 insert후 PK 컬럼인 contentsno변수에 새로 생성된 PK를 할당함.
    int qna_no = qnaVO.getQna_no();  // MyBATIS 리턴된 PK
    System.out.println("qna_no: " + qna_no);
    mav.addObject("qna_no", qna_no); // request에 저장
    // ---------------------------------------------------------------------------------------
    
    mav.addObject("community_no", qnaVO.getCommunity_no());
    mav.addObject("url", "reply_msg"); // // webapp/contents/reply_msg.jsp
    
    if (cnt == 1) {  // 정상적으로 글이 등록된 경우만 글 수 증가
      // this.cateProc.increaseCnt(contentsVO.getCateno()); // 글수 증가
    }
    /*
     * // mav.setViewName("/contents/create_msg"); //
     * mav.setViewName("redirect:/contents/list.do"); // spring 재호출
     * mav.setViewName("redirect:/contents/msg.do"); } else { //
     * mav.setViewName("/contents/create_msg"); // webapp/contents/create_msg.jsp }
     */    
    
    mav.setViewName("redirect:/qna/msg.do");
    
    return mav;
  }
  
  
}
