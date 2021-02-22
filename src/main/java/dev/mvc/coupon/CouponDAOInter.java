package dev.mvc.coupon;

import java.util.List;

import dev.mvc.point.PointVO;

public interface CouponDAOInter {
  /**
   * 등록
   * @param couponVO
   * @return
   */
  public int create(CouponVO couponVO);

  /**
   * 목록
   * @return
   */
  public List<CouponVO> list_coupon_desc();
  
  /**
   * 조회
   * @param coupon_no
   * @return
   */
  public CouponVO read(int coupon_no);
  
  /**
   * 수정
   * @param couponVO
   * @return
   */
  public int update(CouponVO couponVO);
  
  /**
   * 삭제
   * @param coupon_no
   * @return
   */
  public int delete(int coupon_no);
  
  /**
   * Ajax 쿠폰 호출 목록(결제부분)
   * @return
   */
  public CouponVO read_coupon(int member_no);
  
}
