package dev.mvc.answer;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.qna.QnaProcInter;
import dev.mvc.qna.QnaVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;



@Controller
public class AnswerCont {
  @Autowired
  @Qualifier("dev.mvc.qna.QnaProc")
  private QnaProcInter qnaProc;
  
  @Autowired
  @Qualifier("dev.mvc.answer.AnswerProc")
  private AnswerProcInter answerProc;
  
  /**
   * ����� http;//localhost:9090/team2/answer/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/create.do", method = RequestMethod.GET)
  public ModelAndView create(int qna_no) {
    
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/answer/create"); // /webapp/answer/create.jsp
    
    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO);
    
    return mav; // forward
  }
  
  /**
   * ��� ó�� http;//localhost:9090/tema2/answer/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, AnswerVO answerVO) {

    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String file1 = "";     // main image
    String thumb1 = ""; // preview image
        
    String upDir = Tool.getRealPath(request, "/answer/storage/main_images"); // ���� ���
    // ���� ������ ����� fnamesMF ��ü�� ������.
    //  <input type='file' class="form-control" name='file1MF' id='file1MF' 
    //            value='' placeholder="���� ����" multiple="multiple">
    MultipartFile mf = answerVO.getFile1MF();
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
    
    answerVO.setFile1(file1);
    answerVO.setThumb1(thumb1);
    answerVO.setSize1(size1);
    
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------    
    
    mav.setViewName("/answer/create_msg"); // /webapp/answer/create_msg.jsp

    int cnt = this.answerProc.create(answerVO); // ��� ó��
    mav.addObject("cnt", cnt); 

    return mav; // forward
  }
  
  /**
   * ��� http;//localhost:9090/team2/answer/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/answer/list_img"); // /webapp/qna/list_img.jsp

    List<AnswerVO> list = this.answerProc.list_answer_no_asc();
    // List<QnaVO> list = this.qnaProc.list_seqno_asc();
    mav.addObject("list", list);
    
    return mav; // forward
  }
  
  /**
   * ���� Ÿ��Ʋ ��� http;//localhost:9090/team2/answer/list_title.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/list_title.do", method = RequestMethod.GET)
  public ModelAndView list_title(int qna_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/answer/list_title"); // /webapp/qna/list_title.jsp

    QnaVO qnaVO = this.qnaProc.read(qna_no);
    mav.addObject("qnaVO", qnaVO);
    
    List<AnswerVO> list = this.answerProc.list_qnatitle_desc(qna_no);
    // List<QnaVO> list = this.qnaProc.list_seqno_asc();
    mav.addObject("list", list);
    
    return mav; // forward
  }
  
  // http://localhost:9090/team2/answer/read.do
  /**
   * ��ȸ
   * @return
   */
  @RequestMapping(value="/answer/read.do", method=RequestMethod.GET )
  public ModelAndView read(int answer_no) {
    ModelAndView mav = new ModelAndView();

    AnswerVO answerVO = this.answerProc.read(answer_no);
    mav.addObject("answerVO", answerVO); // request.setAttribute("answerVO", answerVO);

    QnaVO qnaVO = this.qnaProc.read(answerVO.getQna_no());
    mav.addObject("qnaVO", qnaVO);
    
    // mav.setViewName("/answer/read"); // /webapp/answer/read.jsp
    mav.setViewName("/answer/read_img"); // /webapp/answer/read.jsp
    
    return mav;
  }
  
  // http://localhost:9090/team2/answer/update.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/answer/update.do", method=RequestMethod.GET )
  public ModelAndView update(int answer_no) {
    ModelAndView mav = new ModelAndView();
    
    AnswerVO answerVO = this.answerProc.read_update(answer_no); // ������ �б�
    mav.addObject("answerVO", answerVO); // request.setAttribute("answerVO", answerVO);
    
    QnaVO qnaVO = this.qnaProc.read(answerVO.getQna_no());
    mav.addObject("qnaVO", qnaVO); 
    
    mav.setViewName("/answer/update"); // webapp/answer/update.jsp
    
    return mav;
  }
  
  /**
   * ���� ó�� http;//localhost:9090/tema2/answer/update.do
   * @param answerVO
   * @return
   */
  @RequestMapping(value = "/answer/update.do", method = RequestMethod.POST)
  public ModelAndView update(AnswerVO answerVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.answerProc.update(answerVO); // ��� ó��
    mav.addObject("cnt", cnt);

    mav.setViewName("/answer/update_msg"); // /webapp/answer/update_msg.jsp
    
    return mav; // forward
  }
  
  // http://localhost:9090/team2/qna/delete.do
  /**
   * ���� ��
   * @return
   */
  @RequestMapping(value="/answer/read_delete.do", method=RequestMethod.GET )
  public ModelAndView read_delete(int answer_no) {
    ModelAndView mav = new ModelAndView();
    
    AnswerVO answerVO = this.answerProc.read(answer_no);
    mav.addObject("answerVO", answerVO);
    
    mav.setViewName("/answer/read_delete"); // webapp/answer/read_delete.jsp
    
    return mav;
  }
  
  /**
   * ���� ó��
   * @param answer_no
   * @return
   */
  @RequestMapping(value = "/answer/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int answer_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.answerProc.delete(answer_no);
    mav.addObject("cnt", cnt); // request�� ����

    mav.setViewName("/answer/delete_msg"); // webapp/answer/delete_msg.jsp

    return mav;
  }
  
  
  /**
   * ���� �̹��� ����� http;//localhost:9090/team2/answer/img_create.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/img_create.do", method = RequestMethod.GET)
  public ModelAndView img_create(int answer_no) {
    ModelAndView mav = new ModelAndView();    
    mav.setViewName("/answer/img_create"); // /webapp/answer/img_create.jsp
    
    AnswerVO answerVO = this.answerProc.read(answer_no);
    mav.addObject("answerVO", answerVO);
    
    QnaVO qnaVO = this.qnaProc.read(answerVO.getQna_no());
    mav.addObject("qnaVO", qnaVO); 
    
    return mav; // forward
  }
  
  /**
   * ���� �̹��� ��� ó�� http;//localhost:9090/team2/answer/img_create.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, AnswerVO answerVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("answer_no", answerVO.getAnswer_no());
    hashMap.put("answer_passwd", answerVO.getAnswer_passwd());
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.answerProc.passwd_check(hashMap);
    
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
      MultipartFile mf = answerVO.getFile1MF();
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
      
      answerVO.setFile1(file1);
      answerVO.setThumb1(thumb1);
      answerVO.setSize1(size1);
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
     
      mav.setViewName("redirect:/answer/read.do?answer_no=" + answerVO.getAnswer_no()); // /webapp/answer/create_msg.jsp

      cnt = this.answerProc.img_create(answerVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/answer/update_msg"); // webapp/contents/update_msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
        
    return mav;
  }
  
  /**
   * ���� �̹��� ����/���� �� http;//localhost:9090/team2/answer/img_update.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/img_update.do", method = RequestMethod.GET)
  public ModelAndView img_update(int answer_no) {
    ModelAndView mav = new ModelAndView();    
    mav.setViewName("/answer/img_update"); // /webapp/answer/img_update.jsp
    
    AnswerVO answerVO = this.answerProc.read(answer_no);
    mav.addObject("answerVO", answerVO);
    
    QnaVO qnaVO = this.qnaProc.read(answerVO.getQna_no());
    mav.addObject("qnaVO", qnaVO); 
    
    return mav; // forward
  }

  /**
   * ���� �̹��� ���� ó�� http;//localhost:9090/team2/answer/img_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/answer/img_delete.do", method = RequestMethod.POST)
  public ModelAndView img_delete(HttpServletRequest request,
                                             int answer_no, int qna_no, String answer_passwd) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("answer_no", answer_no);
    hashMap.put("answer_passwd", answer_passwd);
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.answerProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      AnswerVO answerVO = answerProc.read(answer_no);
      // System.out.println("file1: " + answerVO.getFile1());
      
      String file1 = answerVO.getFile1().trim();
      String thumb1 = answerVO.getThumb1().trim();
      long size1 = answerVO.getSize1();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/contents/storage/main_images"); // ���� ���
      sw = Tool.deleteFile(upDir, answerVO.getFile1());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, answerVO.getThumb1());  // Folder���� 1���� ���� ����
      // System.out.println("sw: " + sw);
      
      file1 = "";
      thumb1 = "";
      size1 = 0;
      
      answerVO.setFile1(file1);
      answerVO.setThumb1(thumb1);
      answerVO.setSize1(size1);
      // -------------------------------------------------------------------
      // ���� ���� ���� ����
      // -------------------------------------------------------------------
     
      mav.setViewName("redirect:/answer/read.do?answer_no=" + answer_no);
      
      cnt = this.answerProc.img_delete(answerVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/answer/update_msg"); // webapp/answer/update_msg.jsp
      
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
            
    return mav;    
  }
  
  /**
   * ���� �̹��� ���� ó�� http;//localhost:9090/team2/answer/img_update.do
   * ���� �̹��� ���� �� ���ο� �̹��� ���(���� ó��)
   * @return
   */
  @RequestMapping(value = "/answer/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, AnswerVO answerVO) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("answer_no", answerVO.getAnswer_no());
    hashMap.put("answer_passwd", answerVO.getAnswer_passwd());
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;             // ������ ���ڵ� ���� 
    
    passwd_cnt = this.answerProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      AnswerVO vo = answerProc.read(answerVO.getAnswer_no());
      // System.out.println("file1: " + answerVO.getFile1());
      
      String file1 = vo.getFile1().trim();
      String thumb1 = vo.getThumb1().trim();
      long size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/answer/storage/main_images"); // ���� ���

      sw = Tool.deleteFile(upDir, answerVO.getFile1());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, answerVO.getThumb1());  // Folder���� 1���� ���� ����
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
      MultipartFile mf = answerVO.getFile1MF();
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
      
      answerVO.setFile1(file1);
      answerVO.setThumb1(thumb1);
      answerVO.setSize1(size1);
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      
      mav.setViewName("redirect:/answer/read.do?answer_no=" + answerVO.getAnswer_no()); 

      cnt = this.answerProc.img_create(answerVO);
      // mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
    } else {
      mav.setViewName("/answer/update_msg"); // webapp/answer/update_msg.jsp
    }
    
    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
        
    return mav;
  }
  
  
}
