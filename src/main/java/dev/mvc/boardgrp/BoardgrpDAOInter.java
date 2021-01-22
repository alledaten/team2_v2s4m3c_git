package dev.mvc.boardgrp;

import java.util.List;

// MyBATIS�� <mapper namespace="dev.mvc.categrp.CategrpDAOInter">�� ���� 
public interface BoardgrpDAOInter {
	// ���ۿ� ���� �޼ҵ���� MyBATIS�� XML ���Ͼ��� id�� �����ؾ��մϴ�.

	/**
	 * <Xmp> ī�װ� �׷� ��� <insert id="create" parameterType="CategrpVO"> </Xmp>
	 * 
	 * @param categrpVO
	 * @return ó���� ���ڵ� ����
	 */
	public int create(BoardgrpVO boardgrpVO);

	/**
	 * ��� <xmp> <select id="list_boardgrpno_asc" resultType="BoardgrpVO"> </xmp>
	 * 
	 * @return ���ڵ� ���
	 */
	public List<BoardgrpVO> list_boardgrp_no_asc();

	/**
	 * ��ȸ <xmp> <select id="read" resultType="BoardgrpVO" parameterType="int">
	 * </xmp>
	 * 
	 * @param boardgrpno
	 * @return
	 */
	public BoardgrpVO read(int boardgrp_no);

	/**
	 * ���� ó�� <xmp> <update id="update" parameterType="BoardgrpVO"> </xmp>
	 * 
	 * @param boardgrpVO
	 * @return ó���� ���ڵ� ����
	 */
	public int update(BoardgrpVO boardgrpVO);

	/**
	 * ���� ó�� <xmp> <delete id="delete" parameterType="int"> </xmp>
	 * 
	 * @param boardgrp_no
	 * @return ó���� ���ڵ� ����
	 */
	public int delete(int boardgrp_no);

	/**
	 * ��� <xmp> <select id="list_board_seqno_asc" resultType="BoardgrpVO"> </xmp>
	 * 
	 * @return
	 */
	public List<BoardgrpVO> list_boardgrp_seqno_asc();

	/**
	 * ��� ���� ���� <xmp> <update id="update_board_seqno_up" parameterType="int"> </xmp>
	 * 
	 * @param boardgrp_no
	 * @return ó���� ���ڵ� ����
	 */
	public int update_boardgrp_seqno_up(int boardgrp_no);

	/**
	 * ��� ���� ���� <xmp> <update id="update_board_seqno_down" parameterType="int">
	 * </xmp>
	 * 
	 * @param boardgrp_no
	 * @return ó���� ���ڵ� ����
	 */
	public int update_boardgrp_seqno_down(int boardgrp_no);

	/**
	 * visible ����
	 * 
	 * @param boardgrpVO
	 * @return
	 */
	public int update_boardgrp_visible(BoardgrpVO boardgrpVO);

}
