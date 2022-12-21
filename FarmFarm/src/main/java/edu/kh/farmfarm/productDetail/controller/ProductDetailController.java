package edu.kh.farmfarm.productDetail.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.SessionAttribute;

import edu.kh.farmfarm.member.model.VO.Member;
import edu.kh.farmfarm.productDetail.model.service.ProductDetailService;
import edu.kh.farmfarm.productDetail.model.vo.Product;

@Controller
public class ProductDetailController {
	
	@Autowired
	private ProductDetailService service;
	
	@GetMapping("/product/{productNo}")
	public String myPageReview(
//			@SessionAttribute("loginMember") Member loginMember,
			@PathVariable("productNo") int productNo,
			Model model) {
		
		// 임시 회원 번호 할당
		int memberNo = 2;
		
//		파라미터 담을 객체 생성
		Product param = new Product();
		
		param.setProductNo(productNo);
		param.setMemberNo(memberNo);
		
//		상품, 상품 상세 이미지, 리뷰 목록, 리뷰 이미지 조회
		Map<String, Object> map = service.selectProduct(param);
		
//		모델에 저장
		model.addAttribute("map", map);
		
		return "productDetail/productDetail";
	}
	

}
