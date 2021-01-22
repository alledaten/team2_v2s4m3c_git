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
   * ��� �� http://localhost:9090/resort/attachfile/create.do X
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
   * ��� ó��
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
    // ���� ���� �ڵ� ����
    // ---------------------------------------------------------------
    int review_no = review_AttachfileVO.getReview_no(); // �θ�� ��ȣ
    String review_attachfile_rname = ""; // ���� ���ϸ�
    String review_attachfile_upname = ""; // ���ε�� ���ϸ�
    long review_attachfile_size = 0; // ���� ������
    String review_attachfile_thumb = ""; // Preview �̹���
    int upload_count = 0; // ����ó���� ���ڵ� ����

    String upDir = Tool.getRealPath(request, "/review_attachfile/storage");

    // ���� ������ ����� fnamesMF ��ü�� ������.
    List<MultipartFile> review_attachfile_rnamesMF = review_AttachfileVO.getReview_attachfile_rnamesMF();

    int count = review_attachfile_rnamesMF.size(); // ���� ���� ����
    if (count > 0) {
      for (MultipartFile multipartFile : review_attachfile_rnamesMF) { // ���� ����, 1���̻� ���� ó��
        review_attachfile_size = multipartFile.getSize(); // ���� ũ��
        if (review_attachfile_size > 0) { // ���� ũ�� üũ
          review_attachfile_rname = multipartFile.getOriginalFilename(); // ���� ���ϸ�
          review_attachfile_upname = Upload.saveFileSpring(multipartFile, upDir); // ���� ����, ���ε�� ���ϸ�

          if (Tool.isImage(review_attachfile_rname)) { // �̹������� �˻�
            review_attachfile_thumb = Tool.preview(upDir, review_attachfile_upname, 200, 150); // thumb �̹��� ����
          }
        }
        Review_AttachfileVO vo = new Review_AttachfileVO();
        vo.setReview_no(review_no);
        vo.setReview_attachfile_rname(review_attachfile_rname);
        vo.setReview_attachfile_upname(review_attachfile_upname);
        vo.setReview_attachfile_thumb(review_attachfile_thumb);
        vo.setReview_attachfile_size(review_attachfile_size);

        // ���� 1�� ��� ���� dbms ����, ������ 20���̸� 20���� record insert.
        upload_count = upload_count + review_attachfileProc.create(vo);
      }
    }
    // -----------------------------------------------------
    // ���� ���� �ڵ� ����
    // -----------------------------------------------------

    mav.addObject("review_no", review_no); // redirect parameter ����
    mav.addObject("review_cate_no", review_cate_no); // redirect parameter ����
    mav.addObject("upload_count", upload_count); // redirect parameter ����
    mav.addObject("url", "create_msg"); // create_msg.jsp, redirect parameter ����
    // �� ��� ���� �� ���� �����ؾ��Ѵ�
    mav.setViewName("redirect:/review_attachfile/msg.do"); // ���ΰ�ħ ���� �� ��� ���� �� ���� �����ؾ��Ѵ�
    // �� ��� ���� �� ���� �����ؾ��Ѵ�
    return mav;
  }

   /**
   * ���ΰ�ħ�� �����ϴ� �޽��� ���
   * 
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/review_attachfile/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    // ��� ó�� �޽���: create_msg --> /attachfile/create_msg.jsp
    // ���� ó�� �޽���: update_msg --> /attachfile/update_msg.jsp
    // ���� ó�� �޽���: delete_msg --> /attachfile/delete_msg.jsp
    mav.setViewName("/review_attachfile/" + url); // forward
    //mav.setViewName("/review_attachfile/create_msg"); // forward

    return mav; // forward
  }
  
   /**
   * ��� http://localhost:9090/team2/review_attachfile/list.do
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
   * �ϳ��� review_no�� ��� 
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
   * ÷�� ���� 1�� ���� ó��
   * 
   * @return
   */
  @RequestMapping(value = "/review_attachfile/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(HttpServletRequest request, int review_attachfile_no,
    @RequestParam(value = "review_no", defaultValue = "0") int review_no, String rurl) {
    ModelAndView mav = new ModelAndView();

    // ������ ���� ������ �о��.
    Review_AttachfileVO review_AttachfileVO = review_attachfileProc.read(review_attachfile_no);

    String upDir = Tool.getRealPath(request, "/review_attachfile/storage"); // ���� ���
    Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_rname()); // Folder���� 1���� ���� ����
    Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_thumb()); // 1���� Thumb ���� ����

    // DBMS���� 1���� ���� ����
    review_attachfileProc.delete(review_attachfile_no);

    List<Review_AttachfileVO> list = review_attachfileProc.list(); // ��� ���� ��ħ
    mav.addObject("list", list);

    mav.addObject("review_no", review_no);

    mav.setViewName("redirect:/review_attachfile/" + rurl);

    return mav;
  }
  

 /**
  * FK�� ����� ���ڵ� ����
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
   int cnt = 0; // ������ ���ڵ� ����

   String upDir = Tool.getRealPath(request, "/review_attachfile/storage"); // ���� ���
   
   for (Review_AttachfileVO review_AttachfileVO: list) { // ���� ������ŭ ��ȯ
     Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_rname()); // Folder���� 1���� ���� ����
     Tool.deleteFile(upDir, review_AttachfileVO.getReview_attachfile_thumb()); // 1���� Thumb ���� ����
   
     review_attachfileProc.delete(review_AttachfileVO.getReview_attachfile_no());  // DBMS���� 1���� ���� ����
     cnt = cnt + 1;

   }
   
   JSONObject json = new JSONObject();
   json.put("cnt", cnt);

   return json.toString();
 }

  
  /**
  * �θ�Ű�� ���� ����
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
