package dev.mvc.answer;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;


@Component("dev.mvc.answer.AnswerProc")
public class AnswerProc implements AnswerProcInter{
  @Autowired
  private AnswerDAOInter answerDAO;

  public AnswerProc() {
    System.out.println("--> AnswerProc created");
  }

  @Override
  public int create(AnswerVO answerVO) {
    int cnt = this.answerDAO.create(answerVO);
    return cnt;
  }
  
  @Override
  public List<AnswerVO> list_answer_no_asc() {
    List<AnswerVO> list = this.answerDAO.list_answer_no_asc();
    return list;
  }

  @Override
  public List<AnswerVO> list_qnatitle_desc(int qna_no) {
    List<AnswerVO> list = this.answerDAO.list_qnatitle_desc(qna_no);
    return list;
  }
  
  @Override
  public AnswerVO read(int answer_no) {
    AnswerVO answerVO = this.answerDAO.read(answer_no);
    
    String content = answerVO.getAnswer_content();
    
    content = Tool.convertChar(content);
    
    answerVO.setAnswer_content(content);
    
    return answerVO;
  }

  @Override
  public AnswerVO read_update(int answer_no) {
    AnswerVO answerVO = this.answerDAO.read(answer_no);
    return answerVO;
  }
  
  @Override
  public int update(AnswerVO answerVO) {
    int cnt = this.answerDAO.update(answerVO);
    return cnt;
  }

  @Override
  public int delete(int answer_no) {
    int cnt = this.answerDAO.delete(answer_no);
    return cnt;
  }

  @Override
  public int passwd_check(HashMap hashMap) {
    int cnt = this.answerDAO.passwd_check(hashMap);
    return cnt;
  }
  
  @Override
  public int img_create(AnswerVO answerVO) {
    int cnt = this.answerDAO.update_img(answerVO);
    return cnt;
  }

  @Override
  public int img_update(AnswerVO answerVO) {
    int cnt = this.answerDAO.update_img(answerVO);
    return cnt;
  }

  @Override
  public int img_delete(AnswerVO answerVO) {
    int cnt = this.answerDAO.update_img(answerVO);
    return cnt;
  }








  
  
}
