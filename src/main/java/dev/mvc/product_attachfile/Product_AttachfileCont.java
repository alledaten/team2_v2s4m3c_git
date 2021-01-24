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

  public Product_AttachfileCont() {
    System.out.println("--> AttachfileCont created.");
  }


  @RequestMapping(value = "/product_attachfile/create.do", method = RequestMethod.GET)
  public ModelAndView create(int product_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product_attachfile/create"); // webapp/attachfile/create.jsp

    return mav;
  }

  /**
   * ��� ó��
   * 
   * @param ra
   * @param request
   * @param attachfileVO
   * @param categrpno
   * @return
   */
  @RequestMapping(value = "/product_attachfile/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, Product_AttachfileVO product_attachfileVO, int productgrp_no) {

    ModelAndView mav = new ModelAndView();

    int product_no = product_attachfileVO.getProduct_no();
    String product_attachfile_fname = "";
    String product_attachfile_fupname = ""; // ���ε�� ���ϸ�
    long product_attachfile_fsize = 0; // ���� ������
    String product_attachfile_thumb = ""; // Preview �̹���
    int upload_count = 0; // ����ó���� ���ڵ� ����

    String upDir = Tool.getRealPath(request, "/product_attachfile/storage");

    // ���� ������ ����� fnamesMF ��ü�� ������.
    List<MultipartFile> fnamesMF = product_attachfileVO.getFnamesMF();

    int count = fnamesMF.size(); // ���� ���� ����
    if (count > 0) {
      for (MultipartFile multipartFile : fnamesMF) { // ���� ����, 1���̻� ���� ó��
        product_attachfile_fsize = multipartFile.getSize(); // ���� ũ��
        if (product_attachfile_fsize > 0) { // ���� ũ�� üũ
          product_attachfile_fname = multipartFile.getOriginalFilename(); // ���� ���ϸ�
          product_attachfile_fupname = Upload.saveFileSpring(multipartFile, upDir); // ���� ����, ���ε�� ���ϸ�

          if (Tool.isImage(product_attachfile_fname)) { // �̹������� �˻�
            product_attachfile_thumb = Tool.preview(upDir, product_attachfile_fupname, 200, 150); // thumb �̹��� ����
          }
        }
        Product_AttachfileVO vo = new Product_AttachfileVO();
        vo.setProduct_no(product_no);
        vo.setProduct_attachfile_fname(product_attachfile_fname);
        vo.setProduct_attachfile_fupname(product_attachfile_fupname);
        vo.setProduct_attachfile_thumb(product_attachfile_thumb);
        vo.setProduct_attachfile_fsize(product_attachfile_fsize);

        // ���� 1�� ��� ���� dbms ����, ������ 20���̸� 20���� record insert.
        upload_count = upload_count + product_attachfileProc.create(vo);
      }
    }
    // -----------------------------------------------------
    // ���� ���� �ڵ� ����
    // -----------------------------------------------------

    mav.addObject("product_no", product_no); // redirect parameter ����
    mav.addObject("productgrp_no", productgrp_no); // redirect parameter ����
    mav.addObject("upload_count", upload_count); // redirect parameter ����
    mav.addObject("url", "create_msg"); // create_msg.jsp, redirect parameter ����

    mav.setViewName("redirect:/product_attachfile/msg.do"); // ���ΰ�ħ ����

    return mav;
  }

  /**
   * ���ΰ�ħ�� �����ϴ� �޽��� ���
   * 
   * @param memberno
   * @return
   */
  @RequestMapping(value = "/product_attachfile/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    // ��� ó�� �޽���: create_msg --> /attachfile/create_msg.jsp
    // ���� ó�� �޽���: update_msg --> /attachfile/update_msg.jsp
    // ���� ó�� �޽���: delete_msg --> /attachfile/delete_msg.jsp
    mav.setViewName("/product_attachfile/" + url); // forward

    return mav; // forward
  }

  /**
   * ��� http://localhost:9090/ojt/attachfile/list.do
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
   * �ϳ��� contentsno�� ��� http://localhost:9090/ojt/attachfile/list_by_contentsno.do
   * 
   * @return
   */
  @RequestMapping(value = "/product_attachfile/list_by_product_no.do", method = RequestMethod.GET)
  public ModelAndView list_by_product_no(int product_no) {
    ModelAndView mav = new ModelAndView();

    List<Product_AttachfileVO> list = product_attachfileProc.list_by_product_no(product_no);
    mav.addObject("list", list);

    ProductVO productVO = this.productProc.read(product_no);
    // System.out.println("--> title: " + contentsVO.getTitle());

    // mav.addObject("title", contentsVO.getTitle());
    mav.addObject("productVO", productVO);

    mav.setViewName("/product_attachfile/list_by_product_no"); // list_by_contentsno.jsp

    return mav;
  }

  /**
   * ÷�� ���� 1�� ���� ó��
   * 
   * @return
   */
  @RequestMapping(value = "/product_attachfile/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(HttpServletRequest request, int product_attachfile_no,
      @RequestParam(value = "product_no", defaultValue = "0") int product_no, String rurl) {
    ModelAndView mav = new ModelAndView();

    // ������ ���� ������ �о��.
    Product_AttachfileVO product_attachfileVO = product_attachfileProc.read(product_attachfile_no);

    String upDir = Tool.getRealPath(request, "/product_attachfile/storage"); // ���� ���
    Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_fupname()); // Folder���� 1���� ���� ����
    Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_thumb()); // 1���� Thumb ���� ����

    // DBMS���� 1���� ���� ����
    product_attachfileProc.delete(product_attachfile_no);

    List<Product_AttachfileVO> list = product_attachfileProc.list(); // ��� ���� ��ħ
    mav.addObject("list", list);

    mav.addObject("product_no", product_no);

    mav.setViewName("redirect:/product_attachfile/" + rurl);

    return mav;
  }

  // http://localhost:9090/resort/attachfile/count_by_contentsno.do?contentsno=14
  /**
   * �θ�Ű�� ���� ����
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

  // http://localhost:9090/resort/attachfile/delete_by_contentsno.do?contentsno=13
  /**
   * FK�� ����� ���ڵ� ����
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
    int cnt = 0; // ������ ���ڵ� ����

    String upDir = Tool.getRealPath(request, "/product_attachfile/storage"); // ���� ���
    
    for (Product_AttachfileVO product_attachfileVO: list) { // ���� ������ŭ ��ȯ
      Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_fupname()); // Folder���� 1���� ���� ����
      Tool.deleteFile(upDir, product_attachfileVO.getProduct_attachfile_thumb()); // 1���� Thumb ���� ����
    
      product_attachfileProc.delete(product_attachfileVO.getProduct_attachfile_no());  // DBMS���� 1���� ���� ����
      cnt = cnt + 1;

    }
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
  
}








