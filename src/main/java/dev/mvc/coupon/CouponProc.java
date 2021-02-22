package dev.mvc.coupon;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


@Controller("dev.mvc.coupon.CouponProc")
public class CouponProc implements CouponProcInter{
  @Autowired
  private CouponDAOInter couponDAO;
  
  public CouponProc() {
    System.out.println("--> CouponProc created");
  }
  
  @Override
  public int create(CouponVO couponVO) {
    int cnt = this.couponDAO.create(couponVO);
    return cnt;
  }

  @Override
  public List<CouponVO> list_coupon_desc() {
    List<CouponVO> list = this.couponDAO.list_coupon_desc();
    return list;
  }

  @Override
  public CouponVO read(int coupon_no) {
    CouponVO couponVO = this.couponDAO.read(coupon_no);
    return couponVO;
  }
  
  @Override
  public int update(CouponVO couponVO) {
    int cnt = this.couponDAO.update(couponVO);
    return cnt;
  }
  
  @Override
  public int delete(int coupon_no) {
    int cnt = this.couponDAO.delete(coupon_no);
    return cnt;
  }

  @Override
  public CouponVO read_coupon(int member_no) {
    CouponVO couponVO = this.couponDAO.read_coupon(member_no);
    return couponVO;
  }

  
}
