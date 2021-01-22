package dev.mvc.boardgrp;

import java.util.List;

// MyBATIS의 <mapper namespace="dev.mvc.categrp.CategrpDAOInter">에 선언 
public interface BoardgrpDAOInter {
	// 매퍼에 들어가는 메소드명은 MyBATIS의 XML 파일안의 id와 동일해야합니다.

	/**
	 * <Xmp> 카테고리 그룹 등록 <insert id="create" parameterType="CategrpVO"> </Xmp>
	 * 
	 * @param categrpVO
	 * @return 처리된 레코드 갯수
	 */
	public int create(BoardgrpVO boardgrpVO);

	/**
	 * 목록 <xmp> <select id="list_boardgrpno_asc" resultType="BoardgrpVO"> </xmp>
	 * 
	 * @return 레코드 목록
	 */
	public List<BoardgrpVO> list_boardgrp_no_asc();

	/**
	 * 조회 <xmp> <select id="read" resultType="BoardgrpVO" parameterType="int">
	 * </xmp>
	 * 
	 * @param boardgrpno
	 * @return
	 */
	public BoardgrpVO read(int boardgrp_no);

	/**
	 * 수정 처리 <xmp> <update id="update" parameterType="BoardgrpVO"> </xmp>
	 * 
	 * @param boardgrpVO
	 * @return 처리된 레코드 갯수
	 */
	public int update(BoardgrpVO boardgrpVO);

	/**
	 * 삭제 처리 <xmp> <delete id="delete" parameterType="int"> </xmp>
	 * 
	 * @param boardgrp_no
	 * @return 처리된 레코드 갯수
	 */
	public int delete(int boardgrp_no);

	/**
	 * 목록 <xmp> <select id="list_board_seqno_asc" resultType="BoardgrpVO"> </xmp>
	 * 
	 * @return
	 */
	public List<BoardgrpVO> list_boardgrp_seqno_asc();

	/**
	 * 출력 순서 상향 <xmp> <update id="update_board_seqno_up" parameterType="int"> </xmp>
	 * 
	 * @param boardgrp_no
	 * @return 처리된 레코드 갯수
	 */
	public int update_boardgrp_seqno_up(int boardgrp_no);

	/**
	 * 출력 순서 하향 <xmp> <update id="update_board_seqno_down" parameterType="int">
	 * </xmp>
	 * 
	 * @param boardgrp_no
	 * @return 처리된 레코드 갯수
	 */
	public int update_boardgrp_seqno_down(int boardgrp_no);

	/**
	 * visible 수정
	 * 
	 * @param boardgrpVO
	 * @return
	 */
	public int update_boardgrp_visible(BoardgrpVO boardgrpVO);

}
