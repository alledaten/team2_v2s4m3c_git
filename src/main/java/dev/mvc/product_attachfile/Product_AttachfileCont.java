package dev.mvc.product_attachfile;


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

import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class Product_AttachfileCont {
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;

  @Autowired
  @Qualifier("dev.mvc.product_attachfile.Product_AttachfileProc")
  private Product_AttachfileProcInter product_attachfileProc;

  /**
   * 등록 폼 http://localhost:9090/team2/product_attachfile/create.do X
   * @param product_no
   * @return
   */
  @RequestMapping(value = "/product_attachfile/create.do", method = RequestMethod.GET)
  public ModelAndView create(int product_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product_attachfile/create"); // webapp/attachfile/create.jsp

    return mav;
  }

  /**
   * 등록 처리
   * @param ra
   * @param request
   * @param product_attachfileVO
   * @param productgrp_no
   * @return
   */
  @RequestMapping(value = "/product_attachfile/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, Product_AttachfileVO product_attachfileVO, int productgrp_no) {

    ModelAndView mav = new ModelAndView();
    // ---------------------------------------------------------------
    // 파일 전송 코드 시작
    // ---------------------------------------------------------------
    int product_no = product_attachfileVO.getProduct_no(); // 부모글 번호
    String product_attachfile_fname = "";  // 원본 파일명
    String product_attachfile_fupname = "";  // 업로드된 파일명
    long product_attachfile_fsize = 0;  // 파일 사이즈
    String product_attachfile_thumb = "";  // Preview 이미지
    int upload_count = 0;   // 정상처리된 레코드 갯수

    String upDir = Tool.getRealPath(request, "/product_attachfile/storage");

    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    List<MultipartFile> fnamesMF = product_attachfileVO.getFnamesMF();

    int count = fnamesMF.size(); // 전송 파일 갯수
    if (count > 0) {
      for (MultipartFile multipartFile : fnamesMF) {  // 파일 추출, 1개이상 파일 처리
        product_attachfile_fsize = multipartFile.getSize(); // 파일 크기
        if (product_attachfile_fsize > 0) { // 파일 크기 체크
          product_attachfile_fname = multipartFile.getOriginalFilename();  // 원본 파일명
          product_attachfile_fupname = Upload.saveFileSpring(multipartFile, upDir); // 파일 저장, 업로드된 파일명

          if (Tool.isImage(product_attachfile_fname)) {  // 이미지인지 검사
            product_attachfile_thumb = Tool.preview(upDir, product_attachfile_fupname, 200, 150); // thumb 이미지 생성
          }
        }
        Product_AttachfileVO vo = new Product_AttachfileVO();
        vo.setProduct_no(product_no);
        vo.setProduct_attachfile_fname(product_attachfile_fname);
        vo.setProduct_attachfile_fupname(product_attachfile_fupname);
        vo.setProduct_attachfile_thumb(product_attachfile_thumb);
        vo.setProduct_attachfile_fsize(product_attachfile_fsize);

     // 파일 1건 등록 정보 dbms 저장, 파일이 20개이면 20개의 record insert.
        upload_count = upload_count + product_attachfileProc.create(vo);
      }
    }
    // -----------------------------------------------------
    // 파일 전송 코드 종료
    // -----------------------------------------------------

    mav.addObject("product_no", product_no); // redirect parameter 占쏙옙占쏙옙
    mav.addObject("productgrp_no", productgrp_no); // redirect parameter 占쏙옙占쏙옙
    mav.addObject("upload_count", upload_count); // redirect parameter 占쏙옙占쏙옙
    mav.addObject("url", "create_msg"); // create_msg.jsp, redirect parameter 占쏙옙占쏙옙

    mav.setViewName("redirect:/product_attachfile/msg.do"); // 占쏙옙占싸곤옙침 占쏙옙占쏙옙

    return mav;
  }

  /**
   * 새로고침을 방지하는 메시지 출력
   * 
   * @param member_no
   * @return
   */
  @RequestMapping(value = "/product_attachfile/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    // 등록 처리 메시지: create_msg --> /product_attachfile/create_msg.jsp
    // 수정 처리 메시지: update_msg --> /product_attachfile/update_msg.jsp
    // 삭제 처리 메시지: delete_msg --> /product_attachfile/delete_msg.jsp
    mav.setViewName("/product_attachfile/" + url); // forward

    return mav; // forward
  }

  /**
   * 목록 http://localhost:9090/team2/product_attachfile/list.do
   * 
   * @return
   */
  @RequestMapping(value = "/product_attachfile/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();

    List<Product_AttachfileVO> list = product_attachfileProc.list();
    mav.addObject("list", list);

    mav.setViewName("/product_attachfile/list");

    return mav;
  }

  /**
   * http://localhost:9090/team2/product__attachfile/list_by_product__no.do?review_no=22
   * 
   * @return
   */
  @RequestMapping(value = "/product_attachfile/list_by_product_no.do", method = RequestMethod.GET)
  public ModelAndView list_by_product_no(int product_no) {
    ModelAndView mav = new ModelAndView();

    List<Product_AttachfileVO> list = product_attachfileProc.list_by_product_no(product_no);
    mav.addObject("list", list);

    ProductVO productVO = this.productProc.read(product_no);

    mav.addObject("productVO", productVO);

    mav.setViewName("/product_attachfile/list_by_product_no"); // list_by_contentsno.jsp

    return mav;
  }

  /**
   * 첨부 파일 1건 삭제 처리
   * 
   * @return
   */
  @RequestMapping(value = "/product_attachfile/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(HttpServletRequest request, int product_attachfile_no,
      @RequestParam(value = "product_no", defaultValue = "0") int product_no, String rurl) {
    ModelAndView mav = new ModelAndView();

    // 삭제할 파일 정보를 읽어옴.
    Product_AttachfileVO product_attachfileVO = product_attachfileProc.read(product_attachfile_no);

    String upDir = Tool.getRealPath(request, "/product_attachfile/storage"); // 절대 경로
    Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_fupname()); // Folder에서 1건의 파일 삭제
    Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_thumb()); // 1건의 Thumb 파일 삭제

    // DBMS에서 1건의 파일 삭제
    product_attachfileProc.delete(product_attachfile_no);

    List<Product_AttachfileVO> list = product_attachfileProc.list(); // 목록 새로 고침
    mav.addObject("list", list);

    mav.addObject("product_no", product_no);

    mav.setViewName("redirect:/product_attachfile/" + rurl);

    return mav;
  }


  // http://localhost:9090/resort/attachfile/delete_by_contentsno.do?contentsno=13
  /**
   * FK를 사용한 레코드 삭제
   * @param request
   * @param contentsno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_attachfile/delete_by_product_no.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8")
  public String delete_by_product_no(HttpServletRequest request,
                                              @RequestParam(value = "product_no", defaultValue = "0") int product_no) {
    try {
      Thread.sleep(3000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    List<Product_AttachfileVO> list = this.product_attachfileProc.list_by_product_no(product_no);
    int cnt = 0; // 삭제된 레코드 갯수

    String upDir = Tool.getRealPath(request, "/product_attachfile/storage"); // 절대 경로
    
    for (Product_AttachfileVO product_attachfileVO: list) { // 파일 갯수만큼 순환
      Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_fupname()); // Folder에서 1건의 파일 삭제
      Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_thumb()); // 1건의 Thumb 파일 삭제
    
      product_attachfileProc.delete(product_attachfileVO.getProduct_attachfile_no());  // DBMS에서 1건의 파일 삭제
      cnt = cnt + 1;

    }
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
  
  /**
   * 부모키별 갯수 산출
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/product_attachfile/count_by_product_no.do", method = RequestMethod.GET, 
                          produces = "text/plain;charset=UTF-8")
  public String count_by_product_no(int product_no) {
    try {
      Thread.sleep(3000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.product_attachfileProc.count_by_product_no(product_no);
 
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
  
}








