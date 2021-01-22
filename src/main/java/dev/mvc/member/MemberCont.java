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
  * ID �ߺ� üũ, JSON ���
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
   * ����� http://localhost:9090/team2/cate/create.do
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
   * ���ó��
   * http://localhost:9090/team2/member/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/member/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, MemberVO memberVO) {
    ModelAndView mav = new ModelAndView();
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String file1 = "";     // main image
    String thumb1 = ""; // preview image
        
    String upDir = Tool.getRealPath(request, "/member/storage/profile_images"); // ���� ���
    // ���� ������ ����� fnamesMF ��ü�� ������.
    MultipartFile mf = memberVO.getFile1MF();
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
    
    memberVO.setMember_profilepic(file1);
    memberVO.setMember_profilethumb(thumb1);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    

    int cnt = this.memberProc.create(memberVO);
    mav.addObject("cnt", cnt);
    mav.addObject("url", "create_msg");

    mav.setViewName("/member/create_msg");
    return mav;
  }
  
  /**
   * ��� http://localhost:9090/team2/member/list.do
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
   * ��� + �˻� + ����¡ ����
   * http://localhost:9090/resort/contents/list.do
   * http://localhost:9090/resort/contents/list.do?cateno=1&word=������&nowPage=1
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
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);     // #{word}
    map.put("nowPage", nowPage);  // �������� ����� ���ڵ��� ������ �����ϱ����� ���     
    
    // �˻� ���
    List<MemberVO> list = memberProc.list_paging(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = memberProc.search_count(map);
    mav.addObject("search_count", search_count);

    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * 
     * @param listFile ��� ���ϸ� 
     * @param cateno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param word �˻���
     * @return ����¡ ���� ���ڿ�
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
   * ȸ������
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
   * ���� ��
   * @return
   */
  @RequestMapping(value="/member/update.do", method=RequestMethod.GET )
  public ModelAndView update(int member_no) {
    ModelAndView mav = new ModelAndView();
    
    MemberVO memberVO = this.memberProc.read_update(member_no); // ������ �б�
    mav.addObject("memberVO", memberVO); // request.setAttribute("memberVO", memberVO);
    
    mav.setViewName("/member/update"); // webapp/member/update.jsp
    
    return mav;
  }
  
  // http://localhost:9090/resort/member/update.do
  /**
   * ���� ó��
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
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;        // ������ ���ڵ� ���� 
    
    passwd_cnt = this.memberProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      
   // �н����尡 ��ġ�� ��� ���� ���ε�
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      MemberVO vo = memberProc.read(memberVO.getMember_no());
      // System.out.println("file1: " + contentsVO.getFile1());
      
      String file1 = vo.getMember_profilepic().trim();
      String thumb1 = vo.getMember_profilethumb().trim();
      long size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/member/storage/profile_images"); // ���� ���
      sw = Tool.deleteFile(upDir, memberVO.getMember_profilepic());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, memberVO.getMember_profilethumb());  // Folder���� 1���� ���� ����
      // System.out.println("sw: " + sw);
      // -------------------------------------------------------------------
      // ���� ���� ����
      // -------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ���� ������ ����� fnamesMF ��ü�� ������.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="���� ����" multiple="multiple">
      MultipartFile mf = memberVO.getFile1MF();
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
      
      memberVO.setMember_profilepic(file1);
      memberVO.setMember_profilethumb(thumb1);
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      
      cnt = this.memberProc.update(memberVO);
      
      mav.setViewName("/member/update_msg"); // webapp/member/update_msg.jsp
    }

    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
    
    return mav;
  }
  
  
  // http://localhost:9090/resort/member/update.do
  /**
   * ���� ��
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
   * ���� ó��
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
    
    int passwd_cnt = 0; // �н����� ��ġ ���ڵ� ����
    int cnt = 0;        // ������ ���ڵ� ���� 

    passwd_cnt = this.memberProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { // �н����尡 ��ġ�� ��� �� ����
      cnt = this.memberProc.delete(member_no);
      
      // -------------------------------------------------------------------------------------
      // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("word", word);
      // �ϳ��� �������� 3���� ���ڵ�� �����Ǵ� ��� ���� 9���� ���ڵ尡 ���� ������
      if (memberProc.search_count(map) % MemberPaging.RECORD_PER_PAGE == 0) {
        nowPage = nowPage - 1;
        if (nowPage < 1) {
          nowPage = 1; // ���� ������
        }
      }
      // -------------------------------------------------------------------------------------
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      // ������ ���� ������ �о��.
      String file1 = vo.getMember_profilepic().trim();
      String thumb1 = vo.getMember_profilethumb().trim();
      long size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/member/storage/profile_images"); // ���� ���
      sw = Tool.deleteFile(upDir, vo.getMember_profilepic());  // Folder���� 1���� ���� ����
      sw = Tool.deleteFile(upDir, vo.getMember_profilethumb());  // Folder���� 1���� ���� ����
      // System.out.println("sw: " + sw);
      // -------------------------------------------------------------------
      // ���� ���� ����
      // -------------------------------------------------------------------
      
    }
    
    mav.addObject("cnt", cnt); // request�� ����
    mav.addObject("passwd_cnt", passwd_cnt); // request�� ����
    
    mav.setViewName("/member/delete_msg"); // webapp/member/update_msg.jsp
    
    return mav;
  }
  
}

