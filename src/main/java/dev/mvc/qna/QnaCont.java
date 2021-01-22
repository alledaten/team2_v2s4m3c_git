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
   * ����� http;//localhost:9090/team2/qna/create.do
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
   * ��� ó�� http;//localhost:9090/tema2/qna/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, QnaVO qnaVO) {

    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String file1 = "";     // main image
    String thumb1 = ""; // preview image
        
    String upDir = Tool.getRealPath(request, "/qna/storage/main_images"); // ���� ���
    // ���� ������ ����� fnamesMF ��ü�� ������.
    //  <input type='file' class="form-control" name='file1MF' id='file1MF' 
    //            value='' placeholder="���� ����" multiple="multiple">
    MultipartFile mf = qnaVO.getFile1MF();
    long size1 = mf.getSize();  // ���� ũ��
    if (size1 > 0) { // ���� ũ�� üũ
      // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
      // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
      file1 = Upload.saveFileSpring(mf, upDir);
      
      if (Tool.isImage(file1)) { // �̹������� �˻�
        // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
        thumb1 = Tool.preview(upDir, file1, 200, 150); 
      }
      
    }    
    
    qnaVO.setFile1(file1);
    qnaVO.setThumb1(thumb1);
    qnaVO.setSize1(size1);
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------    
    
    mav.setViewName("/qna/create_msg"); // /webapp/qna/create_msg.jsp

    int cnt = this.qnaProc.create(qnaVO); // ��� ó��
    mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)

    return mav; // forward
  }
  
//  /**
//   * ��� http;//localhost:9090/team2/qna/list.do
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
   * join ��� http;//localhost:9090/team2/qna/list.do
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
   * ��ȸ
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
   * ���� ��
   * @return
   */
  @RequestMapping(value="/qna/update.do", method=RequestMethod.GET )
  public ModelAndView update(int qna_no) {
    ModelAndView mav = new ModelAndView();
    
    QnaVO qnaVO = this.qnaProc.read_update(qna_no); // ������ �б�
    mav.addObject("qnaVO", qnaVO); // request.setAttribute("qnaVO", qnaVO);
    
    mav.setViewName("/qna/update"); // webapp/qna/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/qna/update.do
  /**
   * ���� ó��
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
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      cnt = this.qnaProc.update(qnaVO);
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
        
    mav.setViewName("/qna/update_msg"); // webapp/qna/update_msg.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/qna/delete.do
  /**
   * ���� ��
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
   * ���� ó��
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
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);    
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      
      cnt = this.qnaProc.delete(qna_no);
      
      if (cnt ==1) {
      // cateProc.decreaseCnt(cateno);
        
      // -------------------------------------------------------------------------------------
      // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
      HashMap<String, Object> map = new HashMap<String, Object>();
      // map.put("community_no", qnaVO.getCommunity_no());
      map.put("qna_word", qnaVO.getQna_word());
      // �ϳ��� �������� 3���� ���ڵ�� �����Ǵ� ��� ���� 9���� ���ڵ尡 ���� ������
      if (qnaProc.search_count(map) % Contents.RECORD_PER_PAGE == 0) {
        nowPage = nowPage - 1;
        if (nowPage < 1) {
          nowPage = 1; // ���� ������
        }
      }
      // -------------------------------------------------------------------------------------     
      }
    }
    
    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
    mav.addObject("nowPage", nowPage); // request�� ����
    // System.out.println("--> ContentsCont.java nowPage: " + nowPage);
    
    // mav.addObject("community_no", qnaVO.getCommunity_no()); // redirect parameter ����
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter ����
    
    // mav.setViewName("/qna/delete_msg"); // webapp/qna/delete_msg.jsp
    mav.setViewName("redirect:/qna/msg.do");
    
    return mav;
  }
  
  /**
   * ���ΰ�ħ�� �����ϴ� �޽��� ���
   * @param qna_no
   * @return
   */
  @RequestMapping(value="/qna/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    
    // ��� ó�� �޽���: create_msg --> /qna/create_msg.jsp
    // ���� ó�� �޽���: update_msg --> /qna/update_msg.jsp
    // ���� ó�� �޽���: delete_msg --> /qna/delete_msg.jsp
    mav.setViewName("/qna/" + url); // forward
    
    return mav; // forward
  }
  
  /**
   * ��¸�� ����
   * 
   * @param qnaVO
   * @return
   */
  @RequestMapping(value = "/qna/update_visible.do", method = RequestMethod.GET)
  public ModelAndView update_visible(QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.qnaProc.update_visible(qnaVO);
    mav.addObject("cnt", cnt); // request�� ����
    
    if(cnt == 1) {
      mav.setViewName("redirect:/qna/list.do"); // request ��ü�� ������ �ȵ�.
    } else {
      QnaVO vo = this.qnaProc.read(qnaVO.getQna_no());
      String title = vo.getQna_title();
      mav.addObject("qna_title", title);
      mav.setViewName("/qna/update_visible_mag"); // /qna/update_visible_mag.jsp
    }
    return mav;
  }

  /**
   * ���� �̹��� ����� http;//localhost:9090/team2/answer/img_create.do
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
   * ���� �̹��� ��� ó�� http;//localhost:9090/team2/qna/img_create.do
   * 
   * @return
   */
  @RequestMapping(value = "/qna/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qnaVO.getQna_no());
    hashMap.put("qna_passwd", qnaVO.getQna_passwd());
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      String file1 = "";     // main image
      String thumb1 = ""; // preview image
          
      String upDir = Tool.getRealPath(request, "/answer/storage/main_images"); // ���� ���
      // ���� ������ ����� fnamesMF ��ü�� ������.
      //  <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //            value='' placeholder="���� ����" multiple="multiple">
      MultipartFile mf = qnaVO.getFile1MF();
      long size1 = mf.getSize();  // ���� ũ��
      if (size1 > 0) { // ���� ũ�� üũ
        // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
        // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
        file1 = Upload.saveFileSpring(mf, upDir);
        
        if (Tool.isImage(file1)) { // �̹������� �˻�
          // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1, 200, 150); 
        }
        
      }    
      
      qnaVO.setFile1(file1);
      qnaVO.setThumb1(thumb1);
      qnaVO.setSize1(size1);
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
     
      mav.setViewName("redirect:/qna/read.do?qna_no=" + qnaVO.getQna_no()); // /webapp/qna/create_msg.jsp

      cnt = this.qnaProc.img_create(qnaVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/qna/update_msg"); // webapp/qna/update_msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
        
    return mav;
  }
  
  /**
   * ���� �̹��� ����/���� �� http;//localhost:9090/team2/qna/img_update.do
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
   * ���� �̹��� ���� ó�� http;//localhost:9090/team2/qna/img_delete.do
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
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      QnaVO qnaVO = qnaProc.read(qna_no);
      // System.out.println("file1: " + answerVO.getFile1());
      
      String file1 = qnaVO.getFile1().trim();
      String thumb1 = qnaVO.getThumb1().trim();
      long size1 = qnaVO.getSize1();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/contents/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, qnaVO.getFile1());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, qnaVO.getThumb1());  // Folder���� 1���� ���� ����
      // System.out.println("sw: " + sw);
      
      file1 = "";
      thumb1 = "";
      size1 = 0;
      
      qnaVO.setFile1(file1);
      qnaVO.setThumb1(thumb1);
      qnaVO.setSize1(size1);
      // -------------------------------------------------------------------
      // ���� ���� ���� ����
      // -------------------------------------------------------------------
     
      mav.setViewName("redirect:/qna/read.do?qna_no=" + qna_no);
      
      cnt = this.qnaProc.img_delete(qnaVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/qna/update_msg"); // webapp/qna/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
  
  /**
   * ���� �̹��� ���� ó�� http;//localhost:9090/team2/qna/img_update.do
   * ���� �̹��� ���� �� ���ο� �̹��� ���(���� ó��)
   * @return
   */
  @RequestMapping(value = "/qna/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("qna_no", qnaVO.getQna_no());
    hashMap.put("qna_passwd", qnaVO.getQna_passwd());
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.qnaProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      QnaVO vo = qnaProc.read(qnaVO.getQna_no());
      // System.out.println("file1: " + answerVO.getFile1());
      
      String file1 = vo.getFile1().trim();
      String thumb1 = vo.getThumb1().trim();
      long size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/qna/storage/main_images"); // ���� ���

      sw = Tool.deleteFile(upDir, qnaVO.getFile1());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, qnaVO.getThumb1());  // Folder���� 1���� ���� ����
      // System.out.println("sw: " + sw);
      
      // -------------------------------------------------------------------
      // ���� ���� ���� ����
      // -------------------------------------------------------------------
     
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ���� ������ ����� fnamesMF ��ü�� ������.
      //  <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //            value='' placeholder="���� ����" multiple="multiple">
      MultipartFile mf = qnaVO.getFile1MF();
      size1 = mf.getSize();  // ���� ũ��
      if (size1 > 0) { // ���� ũ�� üũ
        // mp3 = mf.getOriginalFilename(); // ���� ���ϸ�, spring.jpg
        // ���� ���� �� ���ε�� ���ϸ��� ���ϵ�, spring.jsp, spring_1.jpg...
        file1 = Upload.saveFileSpring(mf, upDir);
        
        if (Tool.isImage(file1)) { // �̹������� �˻�
          // thumb �̹��� ������ ���ϸ� ���ϵ�, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1, 200, 150); 
        }
        
      }    
      
      qnaVO.setFile1(file1);
      qnaVO.setThumb1(thumb1);
      qnaVO.setSize1(size1);
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/qna/read.do?answer_no=" + qnaVO.getQna_no()); 

      cnt = this.qnaProc.img_create(qnaVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/qna/update_msg"); // webapp/answer/update_msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
        
    return mav;
  }
  
  
  /**
   * ��� + �˻� + ����¡ ����
   * http://localhost:9090/team2/qna/list.do
   * http://localhost:9090/team2/qna/list.do?community_no=4&qna_word=����&nowPage=1
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
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("community_no", community_no); // #{community_no}
    map.put("qna_word", qna_word);     // #{qna_word}
    map.put("nowPage", nowPage);  // �������� ����� ���ڵ��� ������ �����ϱ����� ���     
    
    // �˻� ���
//    List<QnaVO> list = qnaProc.list_search_paging(map);
//    mav.addObject("list", list);
    
    List<QnaMemberVO> list = qnaProc.list_search_paging_join(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = qnaProc.search_count(map);
    mav.addObject("search_count", search_count);
  

    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * 
     * @param listFile ��� ���ϸ� 
     * @param community_no Ŀ�´�Ƽ ��ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param qna_word �˻���
     * @return ����¡ ���� ���ڿ�
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
   * �亯 ��
   * @return
   */
  @RequestMapping(value="/qna/reply.do", method=RequestMethod.GET )
  public ModelAndView reply(int community_no, int qna_no) {
    ModelAndView mav = new ModelAndView();
    System.out.println("�亯 ���: " + qna_no);
    
    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO);
    

    mav.setViewName("/qna/reply"); // webapp/contents/reply.jsp
    
    return mav;
  }

  // http://localhost:9090/team2/qna/reply.do
  /**
   * �亯 ��� ó��
   * @return
   */
  @RequestMapping(value="/qna/reply.do", 
                              method=RequestMethod.POST )
  public ModelAndView reply(HttpServletRequest request, QnaVO qnaVO) {
    ModelAndView mav = new ModelAndView();
    
     // --------------------------- �亯 ���� �ڵ� ���� --------------------------
     QnaVO parentVO = qnaProc.read(qnaVO.getQna_no()); // �θ�� ���� ����
     
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("grpno", parentVO.getGrpno());
     map.put("ansnum",  parentVO.getAnsnum());
     qnaProc.increaseAnsnum(map); // ���� ��ϵ� �θ�� ansnum�� 1 ������Ŵ.

     qnaVO.setGrpno(parentVO.getGrpno()); // �θ��� �׷��ȣ �Ҵ�
     qnaVO.setIndent(parentVO.getIndent() + 1); // �亯 ���� ����
     qnaVO.setAnsnum(parentVO.getAnsnum() + 1); // �θ� �ٷ� �Ʒ� ���
     // --------------------------- �亯 ���� �ڵ� ���� --------------------------
     
    int cnt = this.qnaProc.reply(qnaVO); // Call By Reference�� ����
    
    System.out.println("cnt: " + cnt);
    mav.addObject("cnt", cnt);
    
    // ---------------------------------------------------------------------------------------
    // cnt, contentsno return 
    // ---------------------------------------------------------------------------------------
    // Spring <-----> contentsVO <-----> MyBATIS
    // Spring�� MyBATIS�� ContentsVO�� �����ϰ� ����.
    // MyBATIS�� insert�� PK �÷��� contentsno������ ���� ������ PK�� �Ҵ���.
    int qna_no = qnaVO.getQna_no();  // MyBATIS ���ϵ� PK
    System.out.println("qna_no: " + qna_no);
    mav.addObject("qna_no", qna_no); // request�� ����
    // ---------------------------------------------------------------------------------------
    
    mav.addObject("community_no", qnaVO.getCommunity_no());
    mav.addObject("url", "reply_msg"); // // webapp/contents/reply_msg.jsp
    
    if (cnt == 1) {  // ���������� ���� ��ϵ� ��츸 �� �� ����
      // this.cateProc.increaseCnt(contentsVO.getCateno()); // �ۼ� ����
    }
    /*
     * // mav.setViewName("/contents/create_msg"); //
     * mav.setViewName("redirect:/contents/list.do"); // spring ��ȣ��
     * mav.setViewName("redirect:/contents/msg.do"); } else { //
     * mav.setViewName("/contents/create_msg"); // webapp/contents/create_msg.jsp }
     */    
    
    mav.setViewName("redirect:/qna/msg.do");
    
    return mav;
  }
  
  
}
