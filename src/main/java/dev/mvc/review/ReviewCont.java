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
   * ����� http://localhost:9090/team2/review/create.do
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
   * ��� ó�� http://localhost:9090/team2/review/create.do
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String review_file = ""; // main image
    String review_thumb = ""; // preview image

    String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // ���� ���

    // ���� ������ ����� fnamesMF ��ü�� ������.
    // <input type='file' class="form-control" name='file1MF' id='file1MF'
    // value='' placeholder="���� ����" multiple="multiple">
    MultipartFile mf = reviewVO.getReview_fileMF();

    long review_size = mf.getSize(); // ���� ũ��
    if (review_size > 0) { // ���� ũ�� üũ
      // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
      // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
      review_file = Upload.saveFileSpring(mf, upDir);

      if (Tool.isImage(review_file)) { // �̹������� �˻�
        // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
        review_thumb = Tool.preview(upDir, review_file, 200, 150);
      }

    }

    reviewVO.setReview_file(review_file);
    reviewVO.setReview_thumb(review_thumb);
    reviewVO.setReview_size(review_size);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    // Call By Reference: �޸� ����, Hashcode ����
    int cnt = this.reviewProc.create(reviewVO);

    // -------------------------------------------------------------------
    // PK�� return
    // -------------------------------------------------------------------
    System.out.println("--> review_no: " + reviewVO.getReview_no());
    mav.addObject("review_no", reviewVO.getReview_no()); // redirect parameter ����
    // -------------------------------------------------------------------

    if (cnt == 1) {
      review_CateProc.increaseCnt(reviewVO.getReview_cate_no());
    }
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    // <c:import> ���� �۵��ȵ�.
    // mav.setViewName("/contents/create_msg"); // /webapp/contents/create_msg.jsp

    // System.out.println("--> cateno: " + contentsVO.getCateno());
    // redirect�ÿ� hidden tag�� �����͵��� ������ �ȵ����� request�� �ٽ� ����
    mav.addObject("review_cate_no", reviewVO.getReview_cate_no()); // redirect parameter ����
    mav.setViewName("redirect:/review/list.do?review_cate_no=" + reviewVO.getReview_cate_no() + "&review_categrp_no=" + review_CategrpVO.getReview_categrp_no());
    
    return mav; // forward
  }

  /**
   * ��� http://localhost:9090/team2/review/list_all.do
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
   * ī�װ��� ���
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
   * ��� + �˻� + ����¡ ����
   * http://localhost:9090/team2/review/list.do
   * http://localhost:9090/team2/review/list.do?review_cate_no=1&review_word=������&nowPage=1
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
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("review_cate_no", review_cate_no); // #{cateno}
    map.put("review_word", review_word);     // #{word}
    map.put("nowPage", nowPage);  // �������� ����� ���ڵ��� ������ �����ϱ����� ���     
    //System.out.println("--> nowPage: " + nowPage);
    
    // �˻� ���
    List<Review_MemberVO> list = reviewProc.list_by_review_cate_no_search_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = reviewProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Review_CateVO review_CateVO = review_CateProc.read(review_cate_no);
    mav.addObject("review_CateVO", review_CateVO);
    
    Review_CategrpVO review_CategrpVO = review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO);

    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * 
     * @param listFile ��� ���ϸ� 
     * @param review_cate_no ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param review_word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = reviewProc.pagingBox("list.do", review_cate_no, search_count, nowPage, review_word);
    
    mav.addObject("paging", paging);
    mav.addObject("nowPage", nowPage);
    mav.setViewName("/review/list_by_review_cate_no_table_img_search_paging");   
    
    return mav;
  }    
  
  

   /**
   * ��ȸ http://localhost:9090/team2/review/read.do
   * 
   * @return
   */
  @RequestMapping(value = "/review/read.do", method = RequestMethod.GET)
  public ModelAndView read(int review_no) {
    ModelAndView mav = new ModelAndView();

    ReviewVO reviewVO = this.reviewProc.read(review_no);
    mav.addObject("reviewVO", reviewVO);
    
    int review_view = this.reviewProc.update_review_view(review_no);
    mav.addObject("review_view", review_view); // request�� ����
    
    System.out.println("--> review_no: " + review_no);

    Review_CateVO review_CateVO = review_CateProc.read(reviewVO.getReview_cate_no());
    mav.addObject("review_CateVO", review_CateVO);

    Review_CategrpVO review_CategrpVO = review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO);

    // ÷�� ���� ���
    List<Review_AttachfileVO> review_attachfile_list = this.review_attachfileProc.list_by_review_no(review_no);
    mav.addObject("review_attachfile_list", review_attachfile_list);
    // System.out.println("--> ÷�� ���� ����: " + attachfile_list.size());

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
   * ���� ��
   * @return
   */
  @RequestMapping(value="/review/update.do", method=RequestMethod.GET )
  public ModelAndView update(int review_no) {
    ModelAndView mav = new ModelAndView();
    
    ReviewVO reviewVO = this.reviewProc.read_update(review_no); // ������ �б�
    mav.addObject("reviewVO", reviewVO); // request.setAttribute("contentsVO", contentsVO);
    
    Review_CateVO review_CateVO = review_CateProc.read(reviewVO.getReview_cate_no());
    mav.addObject("review_CateVO", review_CateVO);
    
    Review_CategrpVO review_CategrpVO = review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    mav.addObject("review_CategrpVO", review_CategrpVO);
    
    mav.setViewName("/review/update"); // webapp/contents/update.jsp
    
    return mav;
  }
  
   /**
   * ���� ó��
   * @param contentsVO
   * @return
   */
  @RequestMapping(value="/review/update.do", method = RequestMethod.POST )
  public ModelAndView update(ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    Review_CateVO review_CateVO = this.review_CateProc.read(reviewVO.getReview_cate_no()); 
    // mav.addObject("cateVO", cateVO); // ���޾ȵ�.
    mav.addObject("review_cate_name", review_CateVO.getReview_cate_name());
    mav.addObject("review_cate_no", review_CateVO.getReview_cate_no());

    Review_CategrpVO review_CategrpVO = this.review_CategrpProc.read(review_CateVO.getReview_categrp_no());
    // mav.addObject("categrpVO", categrpVO); // ���޾ȵ�.
    mav.addObject("review_categrp_name", review_CategrpVO.getReview_categrp_name());
    
    mav.addObject("review_no", reviewVO.getReview_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", reviewVO.getReview_no());
    hashMap.put("review_passwd", reviewVO.getReview_passwd());
    
    int passwd_cnt = 0;   // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      cnt = this.reviewProc.update(reviewVO);
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
        
    mav.setViewName("/review/update_msg"); // webapp/review/update_msg.jsp
    
    return mav;
  }
  
 /** 
   * ������
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
   * ���� ó�� + ���� ����
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

    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0; // ������ ���ڵ� ����

    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    boolean sw = false;

    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      cnt = this.reviewProc.delete(review_no);
      if (cnt == 1) {
        review_CateProc.decreaseCnt(review_cate_no);

        // -------------------------------------------------------------------------------------
        // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("review_cate_no", review_cate_no);
        map.put("review_word", review_word);
        // �ϳ��� �������� 3���� ���ڵ�� �����Ǵ� ��� ���� 9���� ���ڵ尡 ���� ������
        if (reviewProc.search_count(map) % Review.RECORD_PER_PAGE == 0) {
          nowPage = nowPage - 1;
          if (nowPage < 1) {
            nowPage = 1; // ���� ������
          }
        }
        // -------------------------------------------------------------------------------------
      }

      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, reviewVO.getReview_file()); // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, reviewVO.getReview_thumb()); // Folder���� 1���� ���� ����

    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
    mav.addObject("nowPage", nowPage); // request�� ����
    // System.out.println("--> ContentsCont.java nowPage: " + nowPage);

    mav.addObject("review_cate_no", reviewVO.getReview_cate_no()); // redirect parameter ����
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter ����

    // mav.setViewName("/contents/delete_msg"); // webapp/contents/delete_msg.jsp
    //mav.setViewName("/review/delete_msg");
    mav.setViewName("redirect:/review/delete_msg.jsp");

    return mav;
  }
  
  
  /////////////////////////////////////////////////////////////////////////////////
  /////////// ------------ �̹��� ���� ����  ------------- ///////////////
  /////////////////////////////////////////////////////////////////////////////////
  
  /**
   * ���� �̹��� ��� �� http://localhost:9090/team2/review/img_create.do
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
   * ���� �̹��� ��� ó�� http://localhost:9090/team2/review/img_create.do
   * @return
   */
  @RequestMapping(value = "/review/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", reviewVO.getReview_no());
    hashMap.put("review_passwd", reviewVO.getReview_passwd());
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      String review_file = "";     // main image
      String review_thumb = ""; // preview image
          
      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // ���� ���
      // ���� ������ ����� fnamesMF ��ü�� ������.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="���� ����" multiple="multiple">
      MultipartFile mf = reviewVO.getReview_fileMF();
      long review_size = mf.getSize(); // ���� ũ��
      if (review_size > 0) { // ���� ũ�� üũ
        // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
        // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
        review_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(review_file)) { // �̹������� �˻�
          // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
          review_thumb = Tool.preview(upDir, review_file, 200, 150); 
        }
      }    
      
      reviewVO.setReview_file(review_file);
      reviewVO.setReview_thumb(review_thumb);
      reviewVO.setReview_size(review_size);
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/review/read.do?review_no=" + reviewVO.getReview_no());
      
      cnt = this.reviewProc.img_create(reviewVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/review/update_msg"); // webapp/contents/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
   
   /**
   * ���� �̹��� ���� �� ���� �� http://localhost:9090/team2/review/img_update.do
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
   * ���� �̹��� ���� ó�� http://localhost:9090/team2/review/img_delete.do
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
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      ReviewVO reviewVO = reviewProc.read(review_no);

      String review_file = reviewVO.getReview_file().trim();
      String review_thumb = reviewVO.getReview_thumb().trim();
      long review_size = reviewVO.getReview_size();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, reviewVO.getReview_file());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, reviewVO.getReview_thumb());  // Folder���� 1���� ���� ����
      
      review_file = "";
      review_thumb = "";
      review_size = 0;
      
      reviewVO.setReview_file(review_file);
      reviewVO.setReview_thumb(review_thumb);
      reviewVO.setReview_size(review_size);
      // -------------------------------------------------------------------
      // ���� ���� ���� ����
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/review/read.do?review_no=" + review_no);
      
      cnt = this.reviewProc.img_delete(reviewVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/review/update_msg"); // webapp/review/update_msg.jsp ���� �ּ� ����
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
  
   /**
   * ���� �̹��� ���� ó�� http://localhost:9090/team2/review/img_update.do
   * ���� �̹��� ������ ���ο� �̹��� ���(���� ó��)
   * @return
   */
  @RequestMapping(value = "/review/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("review_no", reviewVO.getReview_no());
    hashMap.put("review_passwd", reviewVO.getReview_passwd());

    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.reviewProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      ReviewVO vo = reviewProc.read(reviewVO.getReview_no());
      
      String review_file = vo.getReview_file().trim();
      String review_thumb = vo.getReview_thumb().trim();
      long review_size = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/review/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, reviewVO.getReview_file());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, reviewVO.getReview_thumb());  // Folder���� 1���� ���� ����
      // -------------------------------------------------------------------
      // ���� ���� ���� ����
      // -------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ���� ������ ����� fnamesMF ��ü�� ������.
      // <input type='review_file' class="form-control" name='review_fileMF' id='review_fileMF' 
      //           value='' placeholder="���� ����" multiple="multiple">
      MultipartFile mf = reviewVO.getReview_fileMF();
      review_size = mf.getSize();  // ���� ũ��
      if (review_size > 0) { // ���� ũ�� üũ
        // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
        // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
        review_file = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(review_file)) { // �̹������� �˻�
          // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
          review_thumb = Tool.preview(upDir, review_file, 200, 150); 
        }
      }    
      
      reviewVO.setReview_file(review_file);
      reviewVO.setReview_thumb(review_thumb);
      reviewVO.setReview_size(review_size);
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------

      mav.setViewName("redirect:/review/read.do?review_no=" + reviewVO.getReview_no());
      
      cnt = this.reviewProc.img_create(reviewVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/review/update_msg"); // webapp/review/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
  

}
