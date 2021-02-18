package dev.mvc.productgrp;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


@Controller
public class ProductgrpCont {
  @Autowired
  @Qualifier("dev.mvc.productgrp.ProductgrpProc")
  private ProductgrpProcInter productgrpProc;
  

  public ProductgrpCont() {
    System.out.println("--> ProductgrpCont created.");
  }

  /**
   * Ajax  http://localhost:9090/resort/categrp/create_ajax.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/productgrp/create_ajax.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8")
  public String create_ajax(ProductgrpVO productgrpVO) {
    try {
      Thread.sleep(3000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.productgrpProc.create(productgrpVO);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }

  /**
   * http://localhost:9090/resort/categrp/list.do
   * 
   * @return
   */
  @RequestMapping(value="/productgrp/list.do", method=RequestMethod.GET)
  public ModelAndView list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    

    List<ProductgrpVO> list = productgrpProc.list_productgrp_seqno_asc();
    
    mav.addObject("list", list);
    mav.setViewName("/productgrp/list_ajax"); 

    return mav;
  }
  
  /**
   * Ajax + read http://localhost:9090/resort/categrp/read_ajax.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/productgrp/read_ajax.do", method = RequestMethod.GET,
                          produces = "text/plain;charset=UTF-8")
  public String read_ajax(int productgrp_no) {
    try {
      Thread.sleep(3000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    ProductgrpVO productgrpVO = this.productgrpProc.read(productgrp_no);

    JSONObject json = new JSONObject();
    json.put("productgrp_no", productgrp_no);
    json.put("productgrp_name", productgrpVO.getProductgrp_name());
    json.put("productgrp_seqno", productgrpVO.getProductgrp_seqno());
    json.put("productgrp_visible", productgrpVO.getProductgrp_visible());

    return json.toString();
  }

  /**
   * Ajax http://localhost:9090/resort/categrp/update_ajax.do
   * 
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/productgrp/update_ajax.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8")
  public String update_ajax(ProductgrpVO productgrpVO) {
    try {
      Thread.sleep(3000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.productgrpProc.update(productgrpVO); // 占쏙옙占� 처占쏙옙
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);

    return json.toString();
  }
  
  /**
   * http://localhost:9090/team2/productgrp/read_delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/productgrp/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(int productgrp_no) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/productgrp/read_delete"); // /webapp/categrp/read_delete.jsp

    ProductgrpVO productgrpVO = this.productgrpProc.read(productgrp_no);
    mav.addObject("productgrpVO", productgrpVO);

    List<ProductgrpVO> list = this.productgrpProc.list_productgrp_seqno_asc();
    mav.addObject("list", list);

    return mav; // forward
  }
  

  /**
   * 
   * @param productgrpno
   * @return
   */
  @ResponseBody
  @RequestMapping(value = "/productgrp/delete_ajax.do", method = RequestMethod.POST,
                          produces = "text/plain;charset=UTF-8")
  public String delete_ajax(int productgrp_no) {
    try {
      Thread.sleep(3000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }
    
    int cnt = this.productgrpProc.delete(productgrp_no);
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt);
    
    return json.toString();
  }

  /**
   * 
   * 
   * @param categrpno 카占쌓곤옙 占쏙옙호
   * @return
   */
  @RequestMapping(value = "/productgrp/update_seqno_up.do",
                            method = RequestMethod.GET)
  public ModelAndView update_seqno_up(int productgrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.productgrpProc.update_seqno_up(productgrp_no);
    mav.addObject("cnt", cnt); // request占쏙옙 占쏙옙占쏙옙

    ProductgrpVO productgrpVO = this.productgrpProc.read(productgrp_no);
    mav.addObject("productgrpVO", productgrpVO);

    mav.setViewName("redirect:/productgrp/list.do"); // /categrp/update_seqno_up_msg.jsp

    return mav;
  }

  // http://localhost:9090/resort/categrp/update_seqno_down.do?categrpno=1
  // http://localhost:9090/resort/categrp/update_seqno_down.do?categrpno=1000
  /**
   * 
   * 
   * @param categrpno 카占쌓곤옙 占쏙옙호
   * @return
   */
  @RequestMapping(value = "/productgrp/update_seqno_down.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_down(int productgrp_no) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.productgrpProc.update_seqno_down(productgrp_no);
    mav.addObject("cnt", cnt); // request占쏙옙 占쏙옙占쏙옙

    ProductgrpVO productgrpVO = this.productgrpProc.read(productgrp_no);
    mav.addObject("productgrpVO", productgrpVO);

    mav.setViewName("redirect:/productgrp/list.do"); // /categrp/update_seqno_down_msg.jsp

    return mav;
  }

  @RequestMapping(value = "/productgrp/update_visible.do", method = RequestMethod.GET)
  public ModelAndView update_productgrp_visible(ProductgrpVO productgrpVO) {
    ModelAndView mav = new ModelAndView();

    int cnt = this.productgrpProc.update_productgrp_visible(productgrpVO);
    mav.addObject("cnt", cnt); // request占쏙옙 占쏙옙占쏙옙

    mav.setViewName("redirect:/productgrp/list.do"); //

    return mav;
  }
  
  /**
   * 
   * @return
   */
  @RequestMapping(value="/productgrp/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    
    mav.setViewName("/productgrp/" + url); // forward
    
    return mav; // forward
  }

}
