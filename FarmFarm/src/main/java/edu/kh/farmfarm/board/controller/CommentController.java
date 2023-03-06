package edu.kh.farmfarm.board.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;

import edu.kh.farmfarm.board.model.service.CommentService;
import edu.kh.farmfarm.mypage.model.vo.Comment;

@RestController
@Controller
public class CommentController {
	
	@Autowired
	private CommentService serivce;
	
	
	// 댓글 불러오기~
	@GetMapping("/board/comment/list")
	public String commentList( int boardNo) {
		List<Comment> coList = serivce.commentList(boardNo);
		return new Gson().toJson(coList);
	}
	
	
	// 댓글 추가하기~
	@PostMapping("/board/comment/insert")
	public int commentWrite(Comment comment,
			@RequestParam(value="checkok", required = false, defaultValue="0") int checkok) {
		
		if(checkok != 0) { // 비밀 댓글인 경우
			comment.setCommentDelFl("S");
		}else {
			comment.setCommentDelFl("N");
		}
		
		return serivce.commentWrite(comment);
	}
	
	
	// 댓글을 수정해볼까??
	@PostMapping("/board/comment/update")
	public int commentUpdate(Comment comment) {
		return serivce.commentUpdate(comment);
	}
	
	
	
	// 댓글을 삭제해봅시다!!
	@GetMapping("/board/comment/delete")
	public int commentDelete(Comment comment) {
		return serivce.commentDelete(comment);
	}

}
