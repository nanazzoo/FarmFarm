package edu.kh.farmfarm.order.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.farmfarm.cart.model.vo.Cart;
import edu.kh.farmfarm.mypage.model.vo.Order;
import edu.kh.farmfarm.order.model.vo.Return;
import edu.kh.farmfarm.productDetail.model.vo.Product;

@Repository
public class OrderDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	/** 반품 등록
	 * @param returnInfo
	 * @return
	 */
	public int insertReturn(Return returnInfo) {
		
		int result = sqlSession.insert("orderMapper.insertReturn", returnInfo);
		
		if(result > 0) {
			result = returnInfo.getReturnNo();
		}
		
		return result;
	}

	/** 반품 상품 등록
	 * @param productList
	 * @return
	 */
	public int insertReturnProduct(List<Product> productList) {
		
		int result = 1;
		
			
		for(Product product : productList) {
			if(product.getProductNo() != 0) {
			
			sqlSession.insert("orderMapper.insertReturnProduct", product);
			sqlSession.update("orderMapper.updateProductStatus", product);
			}
			
		}
	
		return result;
	}

	/** 주문정보 삽입
	 * @param order
	 * @return
	 */
	public int insertOrder(Order order) {
		int orderNo = sqlSession.insert("orderMapper.insertOrder", order);
		
		if(orderNo > 0) {
			sqlSession.insert("orderMapper.insertOrderPayment", order);
		}
		
		orderNo = order.getOrderNo();
		
		return orderNo;	
	}

	/** 주문 상품 삽입
	 * @param pList
	 * @return
	 */
	public int insertProduct(List<Product> pList) {

		int result = 0;
		
		for(Product p : pList) {
			
			result = sqlSession.insert("orderMapper.insertProduct", p);
			result = sqlSession.insert("orderMapper.insertStockHistory", p);
		}
		
		return result;	 
	 
	}

	/** 주문 취소
	 * @param orderNo
	 * @return
	 */
	public int orderCancel(int orderNo) {
		// 주문 내역에 취소 정보 업데이트
		int result = sqlSession.update("orderMapper.orderCancel", orderNo);
		
		if(result > 0) {
			// 취소할 주문의 상품 목록 조회
			List<Product> productList = sqlSession.selectList("orderMapper.cancelProductList", orderNo);
			
			// 취소한 모든 상품에 대한 취소 내역 추가
			for(Product p : productList) {
				
				sqlSession.insert("orderMapper.cancelHistory", p);
			}
		}
		
		return result;
	}
	
	

	public Order selectImpUid(int orderNo) {
		return sqlSession.selectOne("orderMapper.selectImpUid", orderNo);
	}

	
	public int orderConfirm() {
		return sqlSession.update("orderMapper.orderConfirm");
	}

	/** 주문완료 시 장바구니 삭제
	 * @param cartList
	 * @return cartResult
	 */
	public int deleteCart(List<Cart> cartList) {
		int cartResult = 0;
		
		for(Cart c : cartList) {
			cartResult = sqlSession.delete("cartMapper.deleteCart", c);
		}
		
		return cartResult;
	}


	

}
