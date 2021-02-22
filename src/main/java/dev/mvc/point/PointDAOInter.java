package dev.mvc.point;

import java.util.List;

public interface PointDAOInter {
  /**
   * ���
   * @param pointVO
   * @return
   */
  public int create(PointVO pointVO);

  /**
   * ���
   * @return
   */
  public List<PointVO> list_point_desc();
  
  /**
   * ��ȸ
   * @param point_no
   * @return
   */
  public PointVO read(int point_no);
  
  /**
   * ����
   * @param pointVO
   * @return
   */
  public int update(PointVO pointVO);
  
  /**
   * ����
   * @param point_no
   * @return
   */
  public int delete(int point_no);
  
  /**
   * Ajax ����Ʈ ȣ�� ���(�����κ�)
   * @return
   */
  public PointVO read_point(int member_no);
  
}
