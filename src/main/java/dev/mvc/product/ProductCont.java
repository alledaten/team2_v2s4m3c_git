package dev.mvc.product;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import dev.mvc.member.MemberProcInter;
import dev.mvc.product_attachfile.Product_AttachfileProcInter;
import dev.mvc.product_attachfile.Product_AttachfileVO;
import dev.mvc.productgrp.ProductgrpProcInter;
import dev.mvc.productgrp.ProductgrpVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class ProductCont {
  @Autowired
  @Qualifier("dev.mvc.productgrp.ProductgrpProc")
  private ProductgrpProcInter productgrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;
  
  @Autowired
  @Qualifier("dev.mvc.product_attachfile.Product_AttachfileProc")
  private Product_AttachfileProcInter product_attachfileProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc = null;
  
  public ProductCont() {
    System.out.println("--> ProductCont created.");
  }
  

  @RequestMapping(value = "/product/create.do", method = RequestMethod.GET)
  public ModelAndView create(int productgrp_no) {
    ModelAndView mav = new ModelAndView();
    
    ProductgrpVO productgrpVO = this.productgrpProc.read(productgrp_no);
    
    mav.addObject("productgrpVO", productgrpVO);
    
    mav.setViewName("/product/create"); 

    return mav; // forward
  }
  
  
  @RequestMapping(value = "/product/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, ProductVO productVO) {

    ModelAndView mav = new ModelAndView();

    String product_file1 = "";     // main image
    String product_thumb1 = ""; // preview image
        
    String upDir = Tool.getRealPath(request, "/product/storage/main_images");
    
    MultipartFile mf = productVO.getFile1MF();
    
    long product_size1 = mf.getSize();
    if (product_size1 > 0) { 
      product_file1 = Upload.saveFileSpring(mf, upDir); 
      
      if (Tool.isImage(product_file1)) { 
        product_thumb1 = Tool.preview(upDir, product_file1, 200, 150); 
      }
      
    }    
    
    productVO.setProduct_file1(product_file1);
    productVO.setProduct_thumb1(product_thumb1);
    productVO.setProduct_size1(product_size1);

    int cnt = this.productProc.create(productVO); 
    
    System.out.println("--> product_no: " + productVO.getProduct_no());
    mav.addObject("product_no", productVO.getProduct_no()); // redirect parameter ����
    
    if (cnt == 1) {
      productgrpProc.increaseCnt(productVO.getProductgrp_no());
    }
    
    mav.addObject("cnt", cnt); 

    mav.addObject("productgrp_no", productVO.getProductgrp_no());
    mav.addObject("url", "create_continue"); 
    mav.setViewName("redirect:/product/msg.do"); 
    
    return mav; // forward
  }
  
  @RequestMapping(value = "/product/list_all.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/list_all"); 

    List<ProductVO> list = this.productProc.list_all();
    mav.addObject("list", list);

    return mav; // forward
  }

  
  @RequestMapping(value = "/product/list.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_cateno_search_paging(
      @RequestParam(value="productgrp_no", defaultValue="1") int productgrp_no,
      @RequestParam(value="product_word", defaultValue="") String product_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();

    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("productgrp_no", productgrp_no);
    map.put("product_word", product_word);
    map.put("nowPage", nowPage);     
    
    List<Product_MemberVO> list = productProc.list_by_productgrp_no_search_paging_join(map);
    mav.addObject("list", list);
    
    int search_count = productProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    ProductgrpVO productgrpVO = productgrpProc.read(productgrp_no);
    mav.addObject("productgrpVO", productgrpVO);
    
    String paging = productProc.pagingBox("list.do", productgrp_no, search_count, nowPage, product_word);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);

    mav.setViewName("/product/list_by_productgrp_no_table_img1_search_paging_join");   
    
    return mav;
  }    
 
  @RequestMapping(value = "/product/list_by_productgrp_no_grid1.do", method = RequestMethod.GET)
  public ModelAndView list_by_productgrp_no_grid1(int productgrp_no) {
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/product/list_by_productgrp_no_grid1");

    ProductgrpVO productgrpVO = this.productgrpProc.read(productgrp_no);
    mav.addObject("productgrpVO", productgrpVO);
    
    List<ProductVO> list = this.productProc.list_by_productgrp_no(productgrp_no);
    mav.addObject("list", list);

    return mav; // forward
  }
  
  @RequestMapping(value="/product/read.do", method=RequestMethod.GET )
  public ModelAndView read(int product_no) {
    ModelAndView mav = new ModelAndView();

    ProductVO productVO = this.productProc.read(product_no);
    mav.addObject("productVO", productVO);

    ProductgrpVO productgrpVO = this.productgrpProc.read(productVO.getProductgrp_no());
    mav.addObject("productgrpVO", productgrpVO);

    List<Product_AttachfileVO> product_attachfile_list = this.product_attachfileProc.list_by_product_no(product_no);
    mav.addObject("product_attachfile_list", product_attachfile_list);
    System.out.println("--> ÷�� ���� ����: " + product_attachfile_list.size());
    
    mav.setViewName("/product/read_img_attachfile_reply_add_pg"); // /webapp/contents/read_img_attachfile_reply_add_pg.jsp
    
    return mav;
  }
  
  @RequestMapping(value="/product/update.do", method=RequestMethod.GET )
  public ModelAndView update(int product_no) {
    ModelAndView mav = new ModelAndView();
    
    ProductVO productVO = this.productProc.read_update(product_no);
    mav.addObject("productVO", productVO); 
    
    mav.setViewName("/product/update");
    
    return mav;
  }
  
  @RequestMapping(value="/product/update.do", method=RequestMethod.POST )
  public ModelAndView update(ProductVO productVO) {
    ModelAndView mav = new ModelAndView();
    
    ProductgrpVO productgrpVO = this.productgrpProc.read(productVO.getProductgrp_no());
    mav.addObject("productgrp_name", productgrpVO.getProductgrp_name());
    mav.addObject("productgrp_no", productgrpVO.getProductgrp_no());
   
    mav.addObject("product_no", productVO.getProduct_no());
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("product_no", productVO.getProduct_no());
    hashMap.put("product_passwd", productVO.getProduct_passwd());
    
    int passwd_cnt = 0;
    int cnt = 0;
    
    passwd_cnt = this.productProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) {
      cnt = this.productProc.update(productVO);
    }

    mav.addObject("cnt", cnt);
    mav.addObject("passwd_cnt", passwd_cnt);
        
    mav.setViewName("/product/update_msg");
    
    return mav;
  }

  @RequestMapping(value="/product/delete.do", method=RequestMethod.GET )
  public ModelAndView delete(HttpSession session, int product_no) {
    ModelAndView mav = new ModelAndView();
    
    int member_no = (int)session.getAttribute("member_no");
    
    if (member_no == this.productProc.read(product_no).getMember_no()) {
      ProductVO productVO = this.productProc.read_update(product_no);
      mav.addObject("productVO", productVO);
      
      mav.setViewName("/product/delete");
    } else {
      mav.setViewName("redirect:/member/mconfirm_fail_msg.jsp");
    }
    
    return mav;
  }
  
  @RequestMapping(value="/product/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(HttpServletRequest request,
                                           int productgrp_no, 
                                           int product_no, 
                                           String product_passwd,
                                           @RequestParam(value="product_word", defaultValue="") String product_word,
                                           @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
   
    ProductVO productVO = this.productProc.read(product_no);
    String product_name = productVO.getProduct_name();
    mav.addObject("product_name", product_name);
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("product_no", product_no);
    hashMap.put("product_passwd", product_passwd);
    
    int passwd_cnt = 0;
    int cnt = 0;
    
    passwd_cnt = this.productProc.passwd_check(hashMap);
    boolean sw = false;
    
    if (passwd_cnt == 1) {
      cnt = this.productProc.delete(product_no);
      if (cnt == 1) {

        HashMap<String, Object> map = new HashMap<String, Object>();
        map.put("productgrp_no", productgrp_no);
        map.put("product_word", product_word);
        if (productProc.search_count(map) % Product.RECORD_PER_PAGE == 0) {
          nowPage = nowPage - 1;
          if (nowPage < 1) {
            nowPage = 1; // ���� ������
          }
        }
        // -------------------------------------------------------------------------------------
      }
      
      String upDir = Tool.getRealPath(request, "/product/storage/main_images");
      sw = Tool.deleteFile(upDir, productVO.getProduct_file1());
      sw = Tool.deleteFile(upDir, productVO.getProduct_thumb1());

    }

    mav.addObject("cnt", cnt); // request
    mav.addObject("passwd_cnt", passwd_cnt); // request
    mav.addObject("nowPage", nowPage); // request
    
    mav.addObject("productgrp_no", productVO.getProductgrp_no());
    mav.addObject("url", "delete_msg"); // delete_msg.jsp, redirect parameter
    
    mav.setViewName("redirect:/product/msg.do"); 
    
    return mav;
  }

  @RequestMapping(value = "/product/img_create.do", method = RequestMethod.GET)
  public ModelAndView img_create(int product_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/img_create");

    ProductVO productVO = this.productProc.read(product_no);
    mav.addObject("productVO", productVO);
    
    ProductgrpVO productgrpVO = this.productgrpProc.read(productVO.getProductgrp_no());
    mav.addObject("productgrpVO", productgrpVO); 

    return mav; // forward
  }

  @RequestMapping(value = "/product/img_create.do", method = RequestMethod.POST)
  public ModelAndView img_create(HttpServletRequest request, 
                                    ProductVO productVO,
                                    @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("product_no", productVO.getProduct_no());
    hashMap.put("product_passwd", productVO.getProduct_passwd());
    
    int passwd_cnt = 0;
    int cnt = 0; 
    
    passwd_cnt = this.productProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { 
      String product_file1 = "";
      String product_thumb1 = "";
          
      String upDir = Tool.getRealPath(request, "/product/storage/main_images");
      MultipartFile mf = productVO.getFile1MF();
      long product_size1 = mf.getSize();
      if (product_size1 > 0) {
        product_file1 = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(product_file1)) {
          product_thumb1 = Tool.preview(upDir, product_file1, 200, 150); 
        }
      }    
      
      productVO.setProduct_file1(product_file1);
      productVO.setProduct_thumb1(product_thumb1);
      productVO.setProduct_size1(product_size1);
      
      mav.addObject("nowPage", nowPage);
      mav.addObject("product_no", productVO.getProduct_no());
      
      mav.setViewName("redirect:/product/read.do");
      
      cnt = this.productProc.img_create(productVO);
      
    } else {
      mav.setViewName("/product/update_msg");
      
    }

    mav.addObject("cnt", cnt);
    mav.addObject("passwd_cnt", passwd_cnt);
            
    return mav;    
  }

  @RequestMapping(value = "/product/img_update.do", method = RequestMethod.GET)
  public ModelAndView img_update(int product_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/product/img_update");

    ProductVO productVO = this.productProc.read(product_no);
    mav.addObject("productVO", productVO);
    
    ProductgrpVO productgrpVO = this.productgrpProc.read(productVO.getProductgrp_no());
    mav.addObject("productgrpVO", productgrpVO); 

    return mav; // forward
  }
  
  @RequestMapping(value = "/product/img_delete.do", method = RequestMethod.POST)
  public ModelAndView img_delete(HttpServletRequest request,
                                       int product_no, 
                                       int productgrp_no, 
                                       String product_passwd,
                                       @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("product_no", product_no);
    hashMap.put("product_passwd", product_passwd);
    
    int passwd_cnt = 0;
    int cnt = 0;
    
    passwd_cnt = this.productProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) { 
      ProductVO productVO = productProc.read(product_no);
      
      String product_file1 = productVO.getProduct_file1().trim();
      String product_thumb1 = productVO.getProduct_thumb1().trim();
      long product_size1 = productVO.getProduct_size1();
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/product/storage/main_images");
      sw = Tool.deleteFile(upDir, productVO.getProduct_file1());
      sw = Tool.deleteFile(upDir, productVO.getProduct_thumb1());
      
      product_file1 = "";
      product_thumb1 = "";
      product_size1 = 0;
      
      productVO.setProduct_file1(product_file1);
      productVO.setProduct_thumb1(product_thumb1);
      productVO.setProduct_size1(product_size1);
      
      mav.addObject("nowPage", nowPage);
      mav.addObject("product_no", product_no);
      mav.setViewName("redirect:/product/read.do");
      
      cnt = this.productProc.img_delete(productVO);
      
    } else {
      mav.setViewName("/product/update_msg");
      
    }

    mav.addObject("cnt", cnt); // request
    mav.addObject("passwd_cnt", passwd_cnt); // request
            
    return mav;    
  }
  
  @RequestMapping(value = "/product/img_update.do", method = RequestMethod.POST)
  public ModelAndView img_update(HttpServletRequest request, 
                                     ProductVO productVO,
                                     @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("product_no", productVO.getProduct_no());
    hashMap.put("product_passwd", productVO.getProduct_passwd());
    
    int passwd_cnt = 0;
    int cnt = 0; 
    
    passwd_cnt = this.productProc.passwd_check(hashMap);
    
    if (passwd_cnt == 1) {

      ProductVO vo = productProc.read(productVO.getProduct_no());
      
      String product_file1 = vo.getProduct_file1().trim();
      String product_thumb1 = vo.getProduct_thumb1().trim();
      long product_size1 = 0;
      boolean sw = false;
      
      String upDir = Tool.getRealPath(request, "/product/storage/main_images");
      sw = Tool.deleteFile(upDir, productVO.getProduct_file1());
      sw = Tool.deleteFile(upDir, productVO.getProduct_thumb1());

      MultipartFile mf = productVO.getFile1MF();
      product_size1 = mf.getSize();
      if (product_size1 > 0) {
        product_file1 = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(product_file1)) {
          product_thumb1 = Tool.preview(upDir, product_file1, 200, 150); 
        }
      }    
      
      productVO.setProduct_file1(product_file1);
      productVO.setProduct_thumb1(product_thumb1);
      productVO.setProduct_size1(product_size1);

      mav.addObject("nowPage", nowPage);
      mav.addObject("product_no", productVO.getProduct_no());
      mav.setViewName("redirect:/product/read.do");
      
      
      cnt = this.productProc.img_create(productVO);
      
    } else {
      mav.setViewName("/product/update_msg");
    }

    mav.addObject("cnt", cnt);
    mav.addObject("passwd_cnt", passwd_cnt);
            
    return mav;    
  }
  
  @RequestMapping(value="/product/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/product/" + url);
    
    return mav; 
  }
  
  @ResponseBody
  @RequestMapping(value="/product/passwd.do", method=RequestMethod.GET ,
                              produces = "text/plain;charset=UTF-8" )
  public String passwd(int product_no, String product_passwd) {
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("product_no", product_no);
    hashMap.put("product_passwd", product_passwd);
    
    int cnt = this.productProc.passwd_check(hashMap);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString(); 
  }

  @RequestMapping(value="/product/reply.do", method=RequestMethod.GET )
  public ModelAndView reply(int productgrp_no, int product_no) {
    ModelAndView mav = new ModelAndView();
    System.out.println("�亯 ���: " + product_no);
    
    ProductgrpVO productgrpVO = this.productgrpProc.read(productgrp_no);
    mav.addObject("productgtpVO", productgrpVO);

    mav.setViewName("/product/reply");
    
    return mav;
  }

  @RequestMapping(value="/product/reply.do", 
                              method=RequestMethod.POST )
  public ModelAndView reply(HttpServletRequest request, ProductVO productVO) {
    ModelAndView mav = new ModelAndView();

    String product_file1 = "";
    String product_thumb1 = "";
        
    String upDir = Tool.getRealPath(request, "/product/storage/main_images");
    MultipartFile mf = productVO.getFile1MF();
    long product_size1 = mf.getSize();
    if (product_size1 > 0) {
      product_file1 = Upload.saveFileSpring(mf, upDir); 
      
      if (Tool.isImage(product_file1)) {
        product_thumb1 = Tool.preview(upDir, product_file1, 250, 200); 
      }
      
    }    
    // PK return
    productVO.setProduct_file1(product_file1);
    productVO.setProduct_thumb1(product_thumb1);
    productVO.setProduct_size1(product_size1);
    
     ProductVO parentVO = productProc.read(productVO.getProduct_no());
     
     HashMap<String, Object> map = new HashMap<String, Object>();
     map.put("product_grpno", parentVO.getProduct_grpno());
     map.put("product_ansnum",  parentVO.getProduct_ansnum());

     productVO.setProduct_grpno(parentVO.getProduct_grpno());
     productVO.setProduct_indent(parentVO.getProduct_indent() + 1);
     productVO.setProduct_ansnum(parentVO.getProduct_ansnum() + 1);
     
    int cnt = this.productProc.reply(productVO);
    
    System.out.println("cnt: " + cnt);
    mav.addObject("cnt", cnt);
    
    int product_no = productVO.getProduct_no();
    System.out.println("product_no: " + product_no);
    mav.addObject("product_no", product_no);
    
    mav.addObject("productgrp_no", productVO.getProductgrp_no());
    mav.addObject("url", "reply_msg");
    
    mav.setViewName("redirect:/product/msg.do");
    
    return mav;
  }

}
