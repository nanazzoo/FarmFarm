package edu.kh.farmfarm.board.model.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import edu.kh.farmfarm.board.model.vo.Board;

public interface BoardDetailService {

	// 게시글 상세보기
	Board boardDetail(int boardNo);

	// 로그인 멤버가 좋아요 눌렀는지 확인
	int checkLike(Map<String, Object> likeMap);
	
	// 게시글 좋아요 취소
	int boardLikeDelete(Map<String, Object> likeMap);

	// 게시글 좋아요
	int boardLikeInsert(Map<String, Object> likeMap);

	// 조회수 증가
	int updateBoardView(int boardNo);

	// 게시글 삭제
	int boardDelete(int boardNo);

	// 게시글 수정
	int updateBoard(Board board, String deleteImgList, List<MultipartFile> imgList, String webPath, String folderPath) throws IOException;


}
