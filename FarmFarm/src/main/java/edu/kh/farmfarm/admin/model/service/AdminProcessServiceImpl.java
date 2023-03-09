package edu.kh.farmfarm.admin.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.farmfarm.admin.model.dao.AdminProcessDAO;
import edu.kh.farmfarm.admin.model.vo.Admin;

@Service
public class AdminProcessServiceImpl implements AdminProcessService{
	
	@Autowired
	private AdminProcessDAO dao;
	
	
	// 관리자 필터
	// 관리자인지 확인
	@Override
	public int checkAdmin() {
		return dao.checkAdmin();
	}
	
	
	// 회원 강제 탈퇴 (회원관리, 신고내역x)
	@Override
	public int memberKickout(int memberNo) {
		return dao.memberKickout(memberNo);
	}

	
	// 신고된 회원 강제 탈퇴 (신고내역 O)
	@Override
	public int reportMemberKickout(int memberNo, int authority) {
		
		int result = 0;
		
		// 강제 탈퇴 시키고
		result = dao.memberKickout(memberNo);
		
		// 강제 탈퇴가 성공한다면
		if(result > 0) {
			// 신고 상태 변경, 신고 처리일자 추가
			result = dao.changeReportStatus(memberNo);
			
			// 판매자 강제 탈퇴 시, 판매글 삭제
			if(authority == 1) {
				result = dao.deletePostofSeller(memberNo);
			}
		}
		
		return result;
	}
	
	
	// 신고된 회원 계정 정지
	@Override
	public int reportMemberBanned(int memberNo) {
		return dao.reportMemberBanned(memberNo);
	}
	
	
	// 신고 계정 - 반려
	@Override
	public int reportMemberLeave(int memberNo) {
		return dao.reportMemberLeave(memberNo);
	}	
	
	
	
	// 신고 게시글 - 삭제
	@Override
	public int reportDeleteContent(int contentNo, String reportType) {
		
		int result = 0;
		
		// 커뮤니티 게시글 삭제
		if(reportType.equals("B")) {
			result = dao.reportDeleteBoard(contentNo);
		
		// 판매글 삭제
		} else if(reportType.equals("P")) {
			result = dao.reportDeletePost(contentNo);

		// 댓글
		} else if(reportType.equals("C")) {
			result = dao.reportDeleteComment(contentNo);
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("contentNo", contentNo);
		paramMap.put("reportType", reportType);
		
		// 삭제 후 신고 상태 변경, 처리 일자 추가
		if(result > 0) {
			result = dao.changeReportStatusCt(paramMap);
		}
		
		return result;
	}
	
	
	// 신고 게시글 - 반려
	@Override
	public int reportLeaveContent(Map<String, Object> paramMap) {
		return dao.reportLeaveContent(paramMap);
	}	
	
	
	//-----------------------------------------------
	
	// 정지된 계정 리스트 불러오기 (스케쥴링)
	@Override
	public List<Admin> selectBannedAccountList() {
		return dao.selectBannedAccountList();
	}
	

	// 정지된 계정 활성화 (스케쥴링)
	@Override
	public int activateAccount(int targetNo) {
		return dao.activateAccount(targetNo);
	}
	
	
}
