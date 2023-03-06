package edu.kh.farmfarm.admin.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import edu.kh.farmfarm.admin.model.service.AdminProcessService;
import edu.kh.farmfarm.member.model.VO.Member;

@Controller
public class AdminProcessController {
	
	@Autowired
	private AdminProcessService service;
	
	// 회원 관리 - 강제 탈퇴 (신고 내역 없어도 가능)
	@PutMapping("/admin/member/{memberNo}/kickout")
	@ResponseBody
	public int memberKickout(@PathVariable("memberNo") int hiddenNo) {
		return service.memberKickout(hiddenNo);
	}
	
	
	// 관리자페이지 - 신고 처리
	/*
	  계정 - 강제 탈퇴, 정지, 반려
	  게시글 - 삭제, 반려
	  admin-mapper 그대로 사용
	 */
	
	
	// 신고 계정 - 강제탈퇴  // 신고된 회원 강제 탈퇴 + REPORT 테이블 변경하기 + 판매자면 판매상품 지우기
	@PutMapping("/report/M/{memberNo}/kickout")
	@ResponseBody
	public int reportMemberKickout(@PathVariable("memberNo") int hiddenNo, 
									@RequestParam(value="authority", required=false, defaultValue="0") int authority) {
		return service.reportMemberKickout(hiddenNo, authority);
	}
	
	
	// 신고 계정 - 정지   // 스케쥴러로 7일 뒤에 풀기
	@PutMapping("/report/M/{memberNo}/suspension")
	@ResponseBody
	public int reportMemberBanned(@PathVariable("memberNo") int hiddenNo) {
			
		return service.reportMemberBanned(hiddenNo);
	}
	
	
	
	
	// 신고 계정 - 반려
	@PutMapping("/report/M/{memberNo}/hold")
	@ResponseBody
	public int reportMemberLeave(@PathVariable("memberNo") int hiddenNo) {
		return service.reportMemberLeave(hiddenNo);
	}
	
	
	
	
	// 신고 게시글(판매글, 커뮤니티 게시글, 커뮤니티 댓글) - 삭제
	@PutMapping("/report/{reportType}/{contentNo}/delete")
	@ResponseBody
	public int reportDeleteContent(@PathVariable("contentNo") int hiddenContentNo, 
									@PathVariable("reportType")	String reportType) {
		return service.reportDeleteContent(hiddenContentNo, reportType);
	}
	

	
	// 신고 게시글 - 반려
	@PutMapping("/report/{reportType}/{contentNo}/hold")
	@ResponseBody
	public int reportLeaveContent(@PathVariable("contentNo") int hiddenContentNo, 
									@PathVariable("reportType")	String reportType) {
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("hiddenContentNo", hiddenContentNo);
		paramMap.put("reportType", reportType);
			
		return service.reportLeaveContent(paramMap);
	}
	

}
