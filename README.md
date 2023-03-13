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

</br></br>

## 개발 동기 & 기획 의도

최근 귀농, 숲세권 등 바쁜 현대 사회에서 벗어나 자연과 가까워지고싶은 욕구의 증가로 인하여 <br>
작게는 집 베란다 화분에서부터 더 나아가 주말 농장, 텃밭 등을 찾는 수요가 늘고있다.<br>
또한 팬데믹으로 인해 건강에 관한 관심이 증가함에 따라 점점 바른 먹거리, 깨끗한 농산물을 찾는 수요가 늘어나면서<br>
수요자와 생산자 모두를 위한 사이트의 필요성을 자각하였다.
<br>

팜팜은 이러한 수요를 접목하면서 시작되었다.<br>
건강한 먹거리를 사고파는 플랫폼이면서 먹거리를 직접 기르는 데 도움을 받을 수 있는 플랫폼.<br><br>
팜팜은 소비자가 판매자가 되어 자신이 기른 농작물을 직접 판매할 수 있고,<br>
농사에 필요한 물품을 사이트에서 직접 구매할 수 있으며
커뮤니티를 통해 정보를 주고 받을 수 있는
All in One 거래 중개 복합 플랫폼이다.
<br>
<br>    <br>

## 1. 제작 기간 & 참여 인원 & 역할
- 제작 기간: 2022년 12월 12일부터 2023년 1월 11일까지
- 참여 인원: 6명 (팀 프로젝트)
- 역할: 팀원 (백엔드, 프론트엔드)
- 구현 기능 및 기여:
	- 전체 프로젝트 기획 및 개발 참여
	- DB 설계 단계에서 구조 설계 및 정규화 과정 주도
	- 페이지 로딩 속도 저하에 대한 해결책으로 비동기 페이지네이션을 이용하여 마이페이지를 구현
	- 후기 작성/수정/삭제 기능을 비동기로 구현하여 사용자 경험 향상
	- 아임포트 API를 활용한 카카오페이 결제/결제 취소 기능 구현
	- 웹소켓을 이용하여 실시간 상담 기능 구현
	- 오라클 클라우드 환경에 프로젝트 배포
- 성과:
	- 온라인 쇼핑몰 프로토타입 완성
	- 교육원 내 프로젝트 최우수상 수상
	- WBS에 계획한 일정에 맞춰 프로젝트 구현

</br>

-  프로젝트 구조
<img src="/project.png" />
	
</br></br></br></br></br></br>
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

</br></br></br></br></br></br></br></br></br>

## 3. ERD 설계
> [팜팜 ERD cloud ](https://www.erdcloud.com/d/xpKBdcyyrs6Ef2k9F)
<img src="/FarmFarm ERD-min.png" />

</br></br></br></br></br></br></br></br></br>

## 4. 핵심 기능


이 서비스의 핵심 기능은 상품 결제 취소 기능입니다. 아임 포트 API를 이용하여 구현하였습니다.

![팜팜_스토리보드-포함_-_-최종-028](https://user-images.githubusercontent.com/101784680/221081115-cdb0b286-e471-4832-8be3-5c57b6def7d8.png)

</br></br>

## :point_down::point_down::point_down:

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



</br></br></br></br></br></br></br></br></br></br></br></br>

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



</br></br></br></br></br></br></br></br></br></br>

## 6. 그 외 트러블 슈팅
[요청 방식 및 요청 주소의 RestfulAPI화](https://github.com/nanazzoo/FarmFarm/issues/1)

</br></br></br>

