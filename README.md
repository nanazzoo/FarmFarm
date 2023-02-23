![header](https://capsule-render.vercel.app/api?type=Slice&color=auto&height=150&section=header)

<div align="center">
<img width="20%" src="https://user-images.githubusercontent.com/110653581/211257489-34757022-4c71-443f-afe7-94d240788288.png" />
<h2>팜팜</h2>
<h3>내 손으로 키운 작물, 손쉽게 거래하세요.</h3>
</div>
  <br>



# :pushpin: FarmFarm
> **농산물 직거래 플랫폼 및 농사 용품 판매 쇼핑몰**
> 
> **[FarmFarm 바로가기](http://129.154.53.250:8080) (Test ID: user02 PW: pass01! | Admin ID: admin PW: admin01!)**

</br>

## 1. 제작 기간 & 참여 인원 & 역할
- 제작 기간: 2022년 12월 12일부터 2023년 1월 11일까지
- 참여 인원: 6명 (팀 프로젝트)
- 역할: 팀원 (백엔드, 프론트엔드)
- 구현 기능:
	- 아임포트 API를 이용한 주문 결제, 취소
	- 마이페이지: 프로필 관리, 후기 관리, 게시글 관리, 댓글 관리
	- 웹소켓을 이용한 1:1 상담: 채팅 기능
	- 주문 내역 관리: 비동기 결제 취소, 반품 신청, 비동기 후기 작성 등
	- 이미지 삭제 스케줄러
	- 오라클 클라우드 호스팅
	
- 기여도: DB 설계 단계에서 적극적으로 참여 및 주도하여 기획 단계에서 원활한 진행을 도왔고, 맡은 기능을 정해진 기간 내에 모두 구현했습니다. 또한 프로젝트 제작이 완료된 후, 호스팅을 맡아 오라클 클라우드에 성공적으로 배포하였습니다.
- 성과:
	- API를 활용하여 결제, 취소 기능을 구현할 수 있습니다.
- 프로젝트 구조
<img src="/project.png" />
	

</br>

## 2. 사용 기술

<div align="center">
  
### **Back-end**
<img src="https://img.shields.io/badge/Java11-007396?style=for-the-badge&logo=java&logoColor=white"> 
  <img src="https://img.shields.io/badge/Spring5.3.14-6DB33F?style=for-the-badge&logo=spring&logoColor=white">
  <img src="https://img.shields.io/badge/Oracle21C-F80000?style=for-the-badge&logo=oracle&logoColor=white">
  <br>
  <img src="https://img.shields.io/badge/Apache Tomcat9.0-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white">
    <img src="https://img.shields.io/badge/Apache Maven-C71A36?style=for-the-badge&logo=ApacheMaven&logoColor=white">
    <img src="https://img.shields.io/badge/Spring Sequrity-6DB33F?style=for-the-badge&logo=SpringSecurity&logoColor=white">

### **Front-end**
  <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"> 
  <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white"> 
  <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> 

</div>

</br></br>

## 3. ERD 설계
> [팜팜 ERD cloud ](https://www.erdcloud.com/d/xpKBdcyyrs6Ef2k9F)
<img src="/FarmFarm ERD-min.png" />

</br></br>

## 4. 핵심 기능


이 서비스의 핵심 기능은 상품 결제 취소 기능입니다. 아임 포트 API를 이용하여 구현하였습니다.



<details>
<summary><b>핵심 기능 설명 펼치기</b></summary>
<div markdown="1">


### 4.1. 전체 흐름

<img src="/spring.png">
	
</br>

### 4.2. 사용자 요청

- 사용자는 주문 내역에서 아직 배송 되지 않은 상품에 대해서 결제 취소를 요청할 수 있습니다.
- 사용자가 결제 취소 버튼을 클릭하면 결제 취소 요청이 컨트롤러로 전송됩니다.

</br>

### 4.3. Controller

~~~java
	/** 주문 취소
	 * @param orderNo
	 * @return result
	 * @throws IOException
	 */
	@GetMapping("/order/cancel")
	@ResponseBody
	public int orderCancel(int orderNo) throws IOException {
				
//		IMP_UID가 담긴 주문 정보 조회
		Order order = service.selectImpUid(orderNo);
		
        // 아임 포트에서 token 얻어오기
		String token = service.getToken();
		System.out.println(token);
		
//		imp_uid 이용해서 환불 요청하기
		int result = service.paymentCancel(token, order);
		
        // 환불 성공 시 DB에 취소 내역 저장
		if(result > 0) {
			result = service.orderCancel(orderNo);
		}
		return result;
	}
	
~~~

- **요청 처리** 

  - Controller에서는 요청을 화면 단에서 넘어온 요청을 받고, Service 계층에 로직 처리를 위임합니다.

- **결과 응답**

  - 취소 결과가 Insert 되면 1, 실패 시 0을 반환합니다.

</br>  

### 4.4. Service

~~~java
	/* 결제 토큰 얻어오기 */
	@SuppressWarnings("unchecked")
	@Override
	public String getToken() throws IOException {

		// 아임포트에 imp_key와 imp_secret을 담은 요청 전송
		headers.setContentType(MediaType.APPLICATION_JSON);
		JSONObject body = new JSONObject();
		body.put("imp_key", "아임포트에서 제공하는 imp_key");
		body.put("imp_secret", "아임포트에서 제공하는 RESTAPI 번호");
		
		String token = null;

		try {
			// 요청 성공 시 ImpToken 객체에 res 데이터를 담음
			HttpEntity<JSONObject> entity = new HttpEntity<>(body , headers);
			ImpToken impToken = restTemplate.postForObject("https://api.iamport.kr/users/getToken", entity, ImpToken.class);
			
			// ImpToken 객체에서 token 정보만 가져오기
			token = impToken.getResponse().get("access_token").toString();
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getTokenError");
		} finally {
			headers.clear();
			body.clear();
		}
		
		return token;
	}
	
~~~



- **아임 포트에서 토큰 얻어오기**

  - 아임 포트 측에 요청 정보를 전송하여 결제 취소를 위한 토큰을 얻어옵니다.

  

~~~java
	/** 아임포트에 환불 요청
	 * @throws IOException 
	 *
	 */
	@SuppressWarnings("unchecked")
	@Override
	public int paymentCancel(String token, Order order) throws IOException {
		
		// 주문 취소 정보를 담은 요청 전송
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.add("Authorization", token);
		JSONObject body = new JSONObject();
		body.put("reason", "주문 취소");
		body.put("imp_uid", order.getImpUid());
		body.put("amount", order.getOrderPrice());
		body.put("checksum", order.getOrderPrice());
		
		try {
			HttpEntity<JSONObject> entity = new HttpEntity<>(body , headers);
			ImpToken impToken = restTemplate.postForObject("https://api.iamport.kr/payments/cancel", entity, ImpToken.class);
			
			System.out.println(impToken.toString());
			return 1;
				
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getBuyerInfo Error");
			
			throw new RuntimeException("환불 실패");
		}
		
		
	}
~~~



- **아임 포트에 결제 취소 요청**
  - 아임 포트에서 요구하는 결제 취소 정보가 담긴 요청을 전송합니다.
  - 요청 성공 시 결제 취소 정보가 담긴 데이터를 미리 만들어둔 객체에 담아주고 console에 출력해주었습니다.
  - 결제 취소가 성공하면 1을 반환하고 Repository 계층에서 DB에 취소 정보를 저장합니다.

</br>

### 4.5. Repository

~~~java
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
~~~



- **취소 내역 저장** :pushpin: 
  - 취소가 완료된 주문에 대하여 주문 상태를 '주문 취소'로 수정합니다.
- **주문 상품 목록 조회**
  - 취소한 주문의 상품 내역을 모두 조회해옵니다.
- **취소 내역 추가**
  - 취소한 주문의 모든 상품에 대해 주문 취소 내역을 추가합니다.
  - 트리거를 이용하여 자동으로 취소된 상품의 재고가 복귀됩니다.

</div>
</details>



</br></br>

## 5. 핵심 트러블 슈팅

### 5.1. Oracle Cloud 호스팅 중 예외 발생

- Oracle Cloud를 통해 제작한 FarmFarm 프로젝트 파일을 호스팅 하였는데 **예상치 못한 예외가 발생**하였습니다.
- DB에서 질의문 수행 도중 발생하는 오류였습니다. **로컬에서 서버를 돌렸을 시 문제없이 진행**되었기 때문에 팀원 모두 바로 원인을 찾지 못했습니다.
- 원인은 Chart.js를 위한 주문 내역을 가지고 오는 **SQL문의 WHERE 절**에 있었습니다.

</br></br>

<details>
<summary><b>기존 코드</b></summary>
<div markdown="1">

~~~xml
  <select id="selectOrderGraph" resultMap="graph_rm">
	  SELECT TO_CHAR(b.OD, 'MM-DD') AS ORDER_DATE
	    	 , NVL(SUM(a.cnt), 0) AS ORDER_COUNT
		FROM ( SELECT TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') AS ORDER_DATE
		              ,COUNT(*) cnt
		        FROM "ORDER"
		        WHERE ORDER_DATE BETWEEN SYSDATE-31
		                             AND SYSDATE
		        GROUP BY ORDER_DATE
		        ) a
		      , (SELECT (TO_DATE(SYSDATE-30,'YY-MM-DD') + LEVEL) AS OD
				FROM dual 
				<![CDATA[CONNECT BY LEVEL <= 31]]>) b
		WHERE b.OD = a.ORDER_DATE(+)
		GROUP BY b.OD
		ORDER BY b.OD
  </select>
~~~

</div>
</details>

</br>

- 기존 코드의 WHERE절을 보면 **CHAR 타입 데이터와 DATE 타입 데이터를 형변환 없이 비교**하고 있음을 알 수 있었습니다.
- 로컬에서 실행할 때는 타입이 다른 날짜 데이터의 비교가 가능했지만 linux 환경에서 실행되는 Oracle Cloud 에 호스팅 된 페이지에서는 두 데이터의 **타입이 서로 달라 예외가 발생**했던 것이었습니다.
- 여기서 타입만 수정해도 문제를 해결할 수는 있었겠지만, 더 빠르고 좋은 코드는 없을까 하는 고민을 하게 되었고 아래와 같이 **코드를 개선**하였습니다.

</br></br>

<details>
<summary><b>개선된 코드</b></summary>
<div markdown="1">

~~~xml
  <select id="selectOrderGraph" resultMap="graph_rm">
	  <![CDATA[
		SELECT ORDER_DATE, 
            (SELECT COUNT(*) 
            FROM "ORDER" o 
            WHERE TO_CHAR(o.ORDER_DATE , 'YYYY-MM-DD') = a.ORDER_DATE) ORDER_COUNT
	 	FROM (SELECT TO_CHAR(SYSDATE - 31 + LEVEL, 'YYYY-MM-DD') ORDER_DATE 
		FROM DUAL CONNECT BY LEVEL <=31) a]]>
  </select>
~~~

</div>
</details>



</br></br>

## 6. 그 외 트러블 슈팅

    
</br>

