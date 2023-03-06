<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="pagination" value="${map.pagination}" />
<c:set var="memberList" value="${map.memberList}" />
<c:set var="memberListCount" value="${map.memberListCount}" />

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>회원 관리</title>
        <link rel="stylesheet" href="/resources/css/common/header-style.css">
        <link rel="stylesheet" href="/resources/css/admin/adminNav-style.css">
        <link rel="stylesheet" href="/resources/css/admin/adminMember-style.css" />
        <link rel="stylesheet" href="/resources/css/admin/adminModal-style.css" />
        <link rel="stylesheet" href="/resources/css/common/modal/commonModal-style.css" />

        <script src="https://kit.fontawesome.com/d4fbceca97.js" crossorigin="anonymous"></script>

    </head>
    <body>
        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp"/>  

        <main>
            <!--nav-->
            <jsp:include page="/WEB-INF/views/admin/adminNav.jsp"/> 
            

            <!-- 오른쪽 -->
            <section class="admin-content-section">
                <div class="page-title" id="pageTitle">
                    <p>회원 관리</p>
                </div>
                <div class="upper-board">
                    <div class="title-div">
                        <span class="member-select-title">회원 조회</span>
                        <span class="member-search"> 
                            <input type="text" name="adminMemberkeyword" id="adminMemberkeyword" placeholder="회원번호, 아이디, 닉네임" 
                                                                spellcheck="false" autocomplete="off">
                            <button type="button" id="memberSearchBtn"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </span>
                    </div>

                    <div class="member-select" id="memberSelectDiv">
                        <table class="member-select-table" id="memberSelectTable">
                            <thead>
                                <tr class="member-first-row">
                                    <th>NO</th>
                                    <th>회원번호</th>
                                    <th>아이디</th>
                                    <th>닉네임</th>
                                    <th>주소</th>
                                    <th>가입일</th>
                                    <th id="sellerAuth"><span id="dropBtn1"><span id="dropBtn1Text">판매자 등록</span>
                                        <i class="fa-solid fa-caret-down caret-icon" class="select-filter"></i></span>
                                        <div class="drop-menu1" id="dropMenu1">
                                            <ul class="drop-ul" id="dropUl1">
                                                <li class="authFilter" id="a0">전체</li>
                                                <li class="authFilter" id="a1">미등록</li>
                                                <li class="authFilter" id="a2">판매자</li>
                                                <li class="authFilter" id="a3">인증 대기</li>
                                                <li class="authFilter" id="a4">인증 보류</li>
                                            </ul>
                                        </div>
                                    </th>
                                    
                                    <th id="memberStatus"><span id="dropBtn2"><span id="dropBtn2Text">상태</span>
                                        <i class="fa-solid fa-caret-down caret-icon" class="select-filter" id="dropBtn2"></i></span>
                                        <div class="drop-menu2" id="dropMenu2">
                                            <ul class="drop-ul" id="dropUl2">
                                                <li class="statFilter" id="s0">전체</li>
                                                <li class="statFilter" id="s1">활동중</li>
                                                <li class="statFilter" id="s2">신고접수</li>
                                                <li class="statFilter" id="s3">정지</li>
                                                <li class="statFilter" id="s4">탈퇴</li>
                                            </ul>
                                        </div>
                                    </th>
                                </tr>
                            </thead>

                            <tbody id="tbody">
                                <!-- 한 행 반복 -->
                                <c:forEach var="member" items="${memberList}">
                                    <c:set var="i" value="${i+1}" />
                                    <tr class="member-select-row" id="memberSelectRow"> 
                                        
                                        <td class="member-seq">${i}</td>
                                        <td>${member.memberNo}</td>
                                        <td class="mId">${member.memberId}</td>
                                        <td class="mNickname">${member.memberNickname}</td>

                                        <td class="mAddress">${member.memberAddress}</td>
                                        <td>${member.signUpDate}</td> 

                                        <%-- 판매자 인증 --%>
                                        <c:if test="${not empty member.authority}">
                                            <c:if test="${member.authority == 0}">
                                                <td>미등록</td>
                                            </c:if>
                                            <c:if test="${member.authority == 1}">
                                                <td>판매자</td>
                                            </c:if>
                                            <c:if test="${member.authority == 3}">
                                                <td>인증 대기</td>
                                            </c:if>
                                            <c:if test="${member.authority == 4}">
                                                <td>인증 보류</td>
                                            </c:if>
                                        </c:if> 

                                        <%-- 상태 --%>
                                        <c:if test="${member.memberDelFl eq 'N'}">
                                            <c:if test="${empty member.reportType}">
                                                <td>활동중</td>
                                            </c:if>

                                            <c:if test="${not empty member.reportType}">
                                                <c:if test="${empty member.reportPenalty}">
                                                    <td>신고접수</td>
                                                </c:if>
                                                <c:if test="${member.reportPenalty eq 'N' || member.reportPenalty eq 'A'}">
                                                    <td>활동중</td>
                                                </c:if>
                                                <c:if test="${member.reportPenalty eq 'Y'&& member.memberDelFl eq 'N'}">
                                                    <td>정지</td>
                                                </c:if>
                                            </c:if>
                                        </c:if>

                                        <c:if test="${member.memberDelFl eq 'Y'}">
                                            <td>탈퇴</td>
                                        </c:if>



                                        <!-- <input type="hidden" class="hidden-memberId" name="hiddenId" id="hiddenMemberId" value="${member.memberId}"> -->
                                        <input type="hidden" class="hidden-memberNo" name="hiddenNo" id="hiddenMemberNo" value="${member.memberNo}">
                                    </tr>
                                    
                                </c:forEach>
                            </tbody>
                            
                        </table>
                    </div>

                    <!-- todo: 페이지네이션 반복문 -->
                    <div class="admin-pagination-area" id="adminPaginationArea">
                        <ul class="admin-pagination">
                            <li id="1" class="page-box">  
                                <i class="fa-solid fa-angles-left"></i>
                            </li>
                            <li id="${pagination.prevPage}" class="page-box"> 
                                <i class="fa-solid fa-angle-left"></i>
                            </li> 

                            <c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}" step="1">
                                <c:choose>
                                    <c:when test="${i == pagination.currentPage}">
                                        <li class="current-page-box">
                                            ${i}
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <li id="${i}" class="page-box">
                                            ${i}
                                        </li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <li id="${pagination.nextPage}" class="page-box">
                                <i class="fa-solid fa-angle-right"></i>
                            </li>
                            <li id="${pagination.endPage}" class="page-box">
                                <i class="fa-solid fa-angles-right"></i>
                            </li> 
                        </ul>
                    </div>
                </div>

                <div class="middle-board" id="middleBoard">
                    <div class="middle-detail">
                        <span class="member-detail-title line">회원 상세 정보</span>
                        <span class="member-detail" id="detailSpan">
                            <!-- todo: el쓰는부분 ajax로 -->
                            <table class="member-detail-table" id="detailTable">

                                <%-- <tr>
                                    <td rowspan="6" class="detail-profileImg" id="detailMemberImg">
                                        <!-- <img src="/resources/images/member/user.png" alt=""> -->
                                    </td>
                                    <td class="detail-bold" width="90px" id="detailMemberNo">회원번호</td>
                                    <!-- <td width="120px">12345</td> -->
                                    <td class="detail-bold" width="90px" id="detailMemberTel">연락처</td>
                                    <!-- <td width="175px">010-1234-7894</td> -->
                                </tr>
                                <tr>
                                    <td class="detail-bold" id="detailMemberId">아이디</td>
                                    <!-- <input type="hidden" id="inputMemberId" value="${map.memberDetail.memberId}"> -->
                                    <!-- <td>USER01</td> -->
                                    <td class="detail-bold" id="detailMemberBirth">생년월일</td>
                                    <!-- <td>1900-01-01</td> -->
                                </tr>
                                <tr>
                                    <td class="detail-bold" id="detailMemberName">성명</td>
                                    <!-- <td>이은지</td> -->
                                    <td class="detail-bold" id="detailSellerAuth">판매자 인증</td>
                                    <!-- <td>2022-12-19</td> -->
                                </tr>
                                <tr>
                                    <td class="detail-bold" id="detailMemberNickname">닉네임</td>
                                    <!-- <td>은지농장</td> -->
                                    <td class="detail-bold" id="detailMemberStatus">상태</td>
                                    <!-- <td class="status-bold">활동중/계정정지/신고접수중?</td> -->
                                </tr>
                                <tr>
                                    <td class="detail-bold" id="detailSignUpDate">가입일</td>
                                    <!-- <td>2022-12-14</td> -->
                                    <td class="detail-bold" id="detailReportReason">신고 사유</td>
                                    <!-- <td>있으면 나오고 없으면 안 나오고</td> -->
                                </tr>
                                <tr>
                                    <td class="detail-bold" id="detailMemberAddress">주소</td>
                                    <!-- <td colspan="3">서울 중구 남대문로 120 무슨빌딩 2층 kh정보교육원</td> -->
                                </tr> --%>
                            </table>
                        </span>

                        <span class="member-history-title line">계정 상태</span>
                        <span class="member-history">
                            <table class="member-history-table" id="historyTable">
                                <%--
                                    <thead>
                                        <tr class="member-history-row">
                                        <th width="160px">일자</th>
                                        <th width="130px">상태</th>
                                        <th width="150px">사유</th>
                                    </thead> 
                                </tr> --%>

                                <%-- <tr id="row2" class="row2"> 
                                    <td>2022-12-14</td>
                                    <td>가입</td>
                                    <td></td>
                                </tr> --%>

                                <%-- 
                                <tbody>
                                    <tr id="row3">
                                    <td>2022-12-14</td>
                                    <td>계정 정지</td>
                                    <td>불법 사기 계좌 운용</td> 
                                </tr>
                                </tbody>--%>
                            </table>
                        </span>
                        <button id="adminDelBtn">강제 탈퇴</button>
                    </div>   
                </div>
            </section>
        </main>


        <!-- //TODO: 강제 탈퇴 모달 -->
        <div class="adminModal-container" id="adminModalContainer">
            <div class="admin-modal">
    
                <span class="adminModal-title"> 
                    정말 탈퇴시키겠습니까?
                </span>
                
                <div class="adminModal-form-div">
                    <div class="adminModal-form">
                        <button id="cancelBtn">취소</button>
                        <button id="adminDelSubmitBtn">강제 탈퇴</button>
                    </div>
                </div>
            </div>
        </div>

            
        <jsp:include page="/WEB-INF/views/common/modal/message.jsp"/> 

        <script>
            var authFilter = 0;  /* 판매자등록 필터  0: 전체 조회 */
            var statFilter = 0;  /* 상태 필터 0: 전체 조회  */
            var cp = 1;  // cp 선언해야 필터 가능
        </script>

        <%-- jquery --%>
        <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
        
        <script src="/resources/js/admin/adminMember.js"></script> 
        <script src="/resources/js/admin/adminModal.js"></script> 
        <script src="/resources/js/common/common.js"></script> 
    </body>
</html>