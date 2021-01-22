package dev.mvc.qna;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.qna.QnaProc")
public class QnaProc implements QnaProcInter {
  @Autowired
  private QnaDAOInter qnaDAO;

  public QnaProc() {
    System.out.println("--> QnaProc created");
  }

  @Override
  public int create(QnaVO qnaVO) {
    int cnt = this.qnaDAO.create(qnaVO);
    return cnt;
  }

  @Override
  public List<QnaVO> list_qnano_asc() {
    List<QnaVO> list = this.qnaDAO.list_qnano_asc();
    return list;
  }

  @Override
  public List<QnaMemberVO> list_member_join() {
    List<QnaMemberVO> list = this.qnaDAO.list_member_join();
    
    // Ư�� ���� ����
    for (QnaMemberVO qnaMemberVO:list) {
      String content = qnaMemberVO.getQna_content();
      content = Tool.convertChar(content);
      qnaMemberVO.setQna_content(content);
    }
    
    return list;
  }
  
  @Override
  public QnaVO read(int qna_no) {
    QnaVO qnaVO = this.qnaDAO.read(qna_no);
    
    String title = qnaVO.getQna_title();
    String content = qnaVO.getQna_content();
    
    title = Tool.convertChar(title); // Ư�� ���� ó��
    content = Tool.convertChar(content);
    
    qnaVO.setQna_title(title);
    qnaVO.setQna_content(content);
    
    return qnaVO;
  }

//  @Override
//  public QnaMemberVO read_member(int qna_no) {
//    QnaMemberVO qnamemberVO = this.qnaDAO.read_member(qna_no);
//    return qnamemberVO;
//  }
  
  @Override
  public QnaVO read_update(int qna_no) {
    QnaVO qnaVO = this.qnaDAO.read(qna_no);
    return qnaVO;
  }
  
  @Override
  public int update(QnaVO qnaVO) {
    int cnt = this.qnaDAO.update(qnaVO);
    return cnt;
  }
  
  @Override
  public int passwd_check(HashMap hashMap) {
    int passwd_cnt = this.qnaDAO.passwd_check(hashMap);
    return passwd_cnt;
  }

  @Override
  public int delete(int qna_no) {
    int cnt = this.qnaDAO.delete(qna_no);
    return cnt;
  }

  @Override
  public int update_visible(QnaVO qnaVO) {
    if (qnaVO.getQna_visible().equalsIgnoreCase("Y")) {
      qnaVO.setQna_visible("N");
    } else {
      qnaVO.setQna_visible("Y");
    }

    int cnt = this.qnaDAO.update_visible(qnaVO);
    return cnt;
  }

  @Override
  public int img_create(QnaVO qnaVO) {
    int cnt = this.qnaDAO.update_img(qnaVO);
    return cnt;
  }

  @Override
  public int img_update(QnaVO qnaVO) {
    int cnt = this.qnaDAO.update_img(qnaVO);
    return cnt;
  }

  @Override
  public int img_delete(QnaVO qnaVO) {
    int cnt = this.qnaDAO.update_img(qnaVO);
    return cnt;
  }
  
  @Override
  public List<QnaVO> list_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������ ���� rownum: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������ ���� rownum: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������ ���� rownum: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)map.get("nowPage") - 1) * Contents.RECORD_PER_PAGE;
   
    // ���� rownum ����
    // 1 ������ = 0 + 1, 2 ������ = 10 + 1, 3 ������ = 20 + 1 
    int startNum = beginOfPage + 1;
    
    //  ���� rownum
    // 1 ������ = 0 + 10, 2 ������ = 0 + 20, 3 ������ = 0 + 30
    int endNum = beginOfPage + Contents.RECORD_PER_PAGE;   
    /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
   
    List<QnaVO> list = this.qnaDAO.list_search_paging(map);
    
    return list;
  }
  
  @Override
  public List<QnaMemberVO> list_search_paging_join(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������ ���� rownum: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������ ���� rownum: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������ ���� rownum: nowPage = 3, (3 - 1) * 10 --> 20
    */
    int beginOfPage = ((Integer)map.get("nowPage") - 1) * Contents.RECORD_PER_PAGE;
   
    // ���� rownum ����
    // 1 ������ = 0 + 1, 2 ������ = 10 + 1, 3 ������ = 20 + 1 
    int startNum = beginOfPage + 1;
    
    //  ���� rownum 
    // 1 ������ = 0 + 10, 2 ������ = 0 + 20, 3 ������ = 0 + 30
    int endNum = beginOfPage + Contents.RECORD_PER_PAGE;   
    /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
    map.put("startNum", startNum);
    map.put("endNum", endNum);
   
    List<QnaMemberVO> list = this.qnaDAO.list_search_paging_join(map);
    
    return list;
  }
  
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param listFile ��� ���ϸ� 
   * @param community_no Ŀ�´�Ƽ ��ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param qna_word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String pagingBox(String listFile, int community_no, int search_count, int nowPage, String qna_word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Contents.RECORD_PER_PAGE)); // ��ü ������  
    
    int totalGrp = (int)(Math.ceil((double)totalPage/Contents.PAGE_PER_BLOCK));// ��ü �׷� 
    
    int nowGrp = (int)(Math.ceil((double)nowPage/Contents.PAGE_PER_BLOCK));    // ���� �׷� 
    
    int startPage = ((nowGrp - 1) * Contents.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    
    int endPage = (nowGrp * Contents.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page)
    // nowGrp: 2 (11 ~ 20 page)
    // nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� ������ ������ 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� ������ ������ 20
    int _nowPage = (nowGrp-1) * Contents.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&word="+qna_word+"&nowPage="+_nowPage+"&community_no="+community_no+"'>����</A></span>"); 
    } 
 
    // �߾��� ������ ���
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ // ������ �������� �Ѿ�ٸ� ���� ��� ����
        break; 
      } 
  
      if (nowPage == i){ // �������� ������������ ���ٸ� CSS ����(������ ��)
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� �������� �̵��� �����ϵ��� ��ũ�� ����
        str.append("<span class='span_box_1'><A href='"+listFile+"?word="+qna_word+"&nowPage="+i+"&community_no="+community_no+"'>"+i+"</A></span>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� ���������� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� ���������� 21
    _nowPage = (nowGrp * Contents.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='"+listFile+"?&word="+qna_word+"&nowPage="+_nowPage+"&community_no="+community_no+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }

  @Override
  public int search_count(HashMap<String, Object> hashMap) {
    int count = qnaDAO.search_count(hashMap);
    return count;
  }

  @Override
  public int increaseAnsnum(HashMap<String, Object> map) {
    int cnt = qnaDAO.increaseAnsnum(map);
    return cnt;
  }
  
  @Override
  public int reply(QnaVO qnaVO) {
    int cnt = qnaDAO.reply(qnaVO);
    return cnt;
  }


  
  


}
