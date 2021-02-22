package dev.mvc.coupon;

import java.util.List;

import dev.mvc.point.PointVO;

public interface CouponDAOInter {
  /**
   * ���
   * @param couponVO
   * @return
   */
  public int create(CouponVO couponVO);

  /**
   * ���
   * @return
   */
  public List<CouponVO> list_coupon_desc();
  
  /**
   * ��ȸ
   * @param coupon_no
   * @return
   */
  public CouponVO read(int coupon_no);
  
  /**
   * ����
   * @param couponVO
   * @return
   */
  public int update(CouponVO couponVO);
  
  /**
   * ����
   * @param coupon_no
   * @return
   */
  public int delete(int coupon_no);
  
  /**
   * Ajax ���� ȣ�� ���(�����κ�)
   * @return
   */
  public CouponVO read_coupon(int member_no);
  
}
