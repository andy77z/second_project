<%@page import="soju.vo.ManagerVO"%>
<%@page import="soju.vo.AgencyVO"%>
<%@page import="soju.vo.ArtistVO"%>
<%@page import="soju.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>So? Would You?</title>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>

<%
	int type = (Integer)session.getAttribute("type");

	String userId = "";
	String userName = "";
	String userNick = "";
	String userEmail = "";
	String userPhoto = "";
	
	switch(type){
	case 1:
		MemberVO mvo = (MemberVO)session.getAttribute("loginUser");
		userId = mvo.getMem_id();
		userName = mvo.getMem_name();
		userNick = mvo.getMem_nick();
		userEmail = mvo.getMem_mail();
		userPhoto = mvo.getMem_photo();
		break;
	case 2:
		ArtistVO avo = (ArtistVO)session.getAttribute("loginUser");
		userId = avo.getArt_id();
		userName = avo.getArt_name();
		userNick = avo.getArt_name();
		userEmail = avo.getArt_mail();
		userPhoto = avo.getArt_photo();
		break;
	case 3:
		AgencyVO gvo = (AgencyVO)session.getAttribute("loginUser");
		userId = gvo.getAgc_id();
		userName = gvo.getAgc_name();
		userNick = gvo.getAgc_name();
		userEmail = gvo.getAgc_mail();
		userPhoto = gvo.getAgc_photo();
		break;
	case 4:
		ManagerVO nvo = (ManagerVO)session.getAttribute("loginUser");
		userId = nvo.getMng_id();
		userName = nvo.getMng_name();
		userNick = nvo.getMng_name();
		userEmail = "관리자";
		break;
	}
%>
<script>
$(function(){
	
	var type = <%= type %>
	
	if(type == 2 || type == 3){
		$('.myinfomd').on('click', function(){
			window.open("<%= request.getContextPath() %>/jsp/member/MyinfoEditArtAgen.jsp", "_blank", "width=550 height=800");
		})
	}else if(type == 1){
		$('.myinfomd').on('click', function(){
			window.open("<%= request.getContextPath() %>/jsp/member/MyinfoEdit.jsp", "_blank", "width=550 height=800");
			//'.myinfomd').on('click'
		})
	}
})  //function()	


</script>
<script>
function myFunction() {
  document.getElementById("myDropdown").classList.toggle("show");
}

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("more");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

function myFunction2() {
  document.getElementById("myDropdown2").classList.toggle("show2");
}

window.onclick = function(event) {
  if (!event.target.matches('.dropbtn2')) {
    var dropdowns = document.getElementsByClassName("bell");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show2')) {
        openDropdown.classList.remove('show2');
      }
    }
  }
}
</script>

<style>
body{
	width : 100%;
	height : 100%;
}
.root1{
	position: relative;
	height: 100%
}
*, :after, :before {
    box-sizing: border-box;
}
div {
    display: block;
}
a{
	color: inherit;
	text-decoration: none;
}
img{
	vertical-align: middle;
}
button{
	padding: 0px;
	margin: 0px;
	appearance: none;
	background: none;
	border: none;
	cursor: pointer;
}
.header1{
	display: block;
	width: 100%;
	height: 75px;
}
.header11{
	position: fixed;
	display: flex;
	align-items: center;
	width: inherit;
	height: inherit;
	top: 0px;
	left: 0px;
	background-color: white;
	border-bottom: 1px solid lightgray;
	z-index: 1000;
	padding: 0px 32px 0px 26px; 
}
.header111{
	margin-right: auto;
	display: flex;
	align-items: center;
}
.mainlogo{
	margin-left: 16px;
	padding: 6px;
}
.header112{
	margin-left: auto;
	display: flex;
}
.header1122{
	position: relateve;
	margin: 0px 25px;
}


.bell{
	margin: 0px 25px;
}

.dropbtn2 {
  background-color: white;
  color: black;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropbtn2:hover, .dropbtn2:focus {
  background-color: none;
}

.dropdown2 {
  float: right;
  position: relative;
  display: inline-block;
}

.dropdown-content2 {
  display: none;
  position: absolute;
  background-color: white;
  min-width: 120px;
  overflow: auto;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  right: 0;
  z-index: 1;
  border-radius: 8px;
}

.dropdown-content2 a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown2 a:hover {background-color: #ddd;}

.show2 {display: block;}

.dropbtn {
  color: black;
  font-size: 16px;
  border: none;
  cursor: pointer;
}

.dropdown {
  position: relative;
  display: inline-block;
}

.dropdown-content {
  display: none;
  position: absolute;
  right: 0;
  background-color: white;
  min-width: 120px;
  box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
  z-index: 1;
  border-radius: 8px;
}

.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

.dropdown-content a:hover {background-color: none;}

.dropdown:hover .dropdown-content {
  display: block;
}

.dropdown:hover .dropbtn {
  background-color: none;
}
.myinfo1{
	padding: 40px 0px;
	border-bottom: 1px solid lightgray;
	background-color: white;
}
.myinfo2{
	width: 880px;
	margin : 0px auto;
}
.myinfo3{
	display: flex;
	-webkit-box-align: center;
	align-items: center;
}
.myinfo4{
	display: flex;
	flex-direction: column;
	flex: 1 1 0%;
}
.mynickname{
	font-size: 25px;
	line-height: 1.33;
	margin-bottom: 8px;
}
.myid{
	width:100px;
	font-size: 15px;
	line-height: 1.5;
	letter-spacing: -0.5px;
}

.logout, .myinfomd{
	height: 32px;
	border-radius: 18px;
	border: 1px solid #2C7CE6;
	background-color: white;
	font-size: 14px;
	font-weight: bold;
	text-align: center;
	color: #2C7CE6;
	padding: 0px 20px;
	margin-left: 10px;
	cursor: pointer;
}
.mypage1{
	width: 880px;
	margin: 40px auto;

}
.mypage2{
	display: flex;
	margin: 0px auto;

}
.mypagepost1{
	width: 520px;
	flex: 1 1 0%;
	margin-right: 40px;

}
.mypagepost2{
	display: flex;
	flex-direction: column;
	-webkit-box-pack: center;
	justify-content: center;
	-webkit-box-align: center;
	align-items: center;
	border-radius: 8px;
	border: 1px solid lightgray;
	height: 224px;
}

.goFeed{
	display: flex;
	flex-direction: column;
	-webkit-box-pack: center;
	jestify-content: center;
	-webkit-box-align: center;
	align-items: center;
	border-radius: 8px;
	border: 1px solid lightgray;
	height: 224px;
}
.wpostinfo{
	display: block;
	font-size: 14px;
	color: gray;
	margin-bottom: 8px;
}
.goFeed{
	display: inline-block;
	background-color: white;
	border-width: 1px;
	border-color: #2C7CE6;
	border-style: solid; 
	border-radius: 18px;
	color: #2C7CE6;
	padding: 5px 20px;
	font-size: 14px;
	font-weight: bold;
	height: 32px;
	text-align: center;
	transition: all 0.1ease-out 0s;
	cursor: pointer;
}
.mylist{
	width: 320px;
	align-items: flex-end;
}
.mylist2{
	background-color: white;
	padding: 20px;
	margin-bottom: 20px;
	border: 1px solid lightgray;
	border-radius: 8px;
}
.myArtist1{
	display: flex;
}
.myArtist2{
	padding: 0px;
	margin: 0px;
	font-size: 16px;
	line-height: 1.43;
	flex: 1 1 0%;
}
.myArtistAll{
	font-size: 14x;
	line-height: 1.67;
	color: gray;
}
</style>
</head>
<body>
	<div id="root">
		<div class="root1">
		
			<header class="header1">
				<div class="header11">
					<div class="header111">
						<a href="<%= request.getContextPath() %>/jsp/main/loginMain.jsp" class="mainlogo">
							<img src="<%= request.getContextPath() %>/images/logosample.png" alt="So? Would You?">
						</a>
					</div>

<%
	switch(type){
	case 1:
%>
						<!-- 팬 회원 -->
						<a href="<%= request.getContextPath() %>/jsp/main/mypage.jsp">
							<img class="my1" src="<%= request.getContextPath() %>/images/user.png" alt="my1" width="24" >
						</a>
						
						<div class="dropdown2">
							<button onclick="myFunction2()" class="dropbtn2">
								<img class="bell" src="<%= request.getContextPath() %>/images/bell.png" alt="bell" width="24" >
							</button>
							<div id="myDropdown2" class="dropdown-content2">
								<h5 style="text-align: center;">긴급점검중...</h5>
							</div>
						</div>
						
						
						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/main/alarm.jsp" target="_self">알림설정</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/notice.jsp" target="_self">공지사항</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/qna.jsp" target="_self">문의</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/tiket.jsp" target="_self">이용권관리</a>
						  	</div>
						</div>
						<!-- 아티스트 -->
<%
		break;
	case 2:
%>						
						<a href="<%= request.getContextPath() %>/jsp/main/mypage.jsp">
							<img class="my1" src="<%= request.getContextPath() %>/images/user.png" alt="my1" width="24" >
						</a>

						<div class="dropdown2">
							<button onclick="myFunction2()" class="dropbtn2">
								<img class="bell" src="<%= request.getContextPath() %>/images/bell.png" alt="bell" width="24" >
							</button>
							<div id="myDropdown2" class="dropdown-content2">
								<h5 style="text-align: center;">긴급점검중...</h5>
							</div>
						</div>

						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/main/notice.jsp">공지사항</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/qna.jsp">문의</a>
						  	</div>
						</div>
						<!-- 소속사 -->
<%
		break;
	case 3:
%>						
						<a href="<%= request.getContextPath() %>/jsp/main/mypage.jsp">
							<img class="my1" src="<%= request.getContextPath() %>/images/user.png" alt="my1" width="24" >
						</a>
						
						<div class="dropdown2">
							<button onclick="myFunction2()" class="dropbtn2">
								<img class="bell" src="<%= request.getContextPath() %>/images/bell.png" alt="bell" width="24" >
							</button>
							<div id="myDropdown2" class="dropdown-content2">
								<h5 style="text-align: center;">긴급점검중...</h5>
							</div>
						</div>

						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/calendar/schedule.jsp" target="_self">일정관리</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/notice.jsp">공지사항</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/qna.jsp">문의</a>
						  	</div>
						</div>
<%
		break;
	case 4:
%>
						<!-- 관리자 -->
						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/main/adminMember.jsp" target="_self">회원관리</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/adminTiket.jsp" target="_self">결제관리</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/adminQna.jsp" target="_self">고객지원</a>
						  	</div>
						</div>
<%
		break;
	}
%>						
				</div><!-- header11 -->
			</header><!-- header1 -->
			
			<div class="myinfo1">
				<div class="myinfo2">
					<div class="myinfo3">
						<div class="myinfo4">
							<div class="mynickname"><%= userNick %></div>
							<div class="myid" name="<%=userName%>">(<%= userId %>) (<%= userEmail %>)</div>
						</div>
						<div>
							<button type="button" class="myinfomd">내 정보 수정</button>
							<button class="logout">
								<a href="<%=request.getContextPath() %>/Logout.do" target="_top">로그아웃</a>
							</button>
						</div>
					</div>
				</div>
				
				<div class="mypage1">
					<div class="mypage2">
						<div class="mypagepost1">
							<div class="mypagepost2">
								<span class="wpostinfo">작성한 포스트가 없습니다.</span>
								<a href="">
								<button type="button" class="goFeed">Feed 보러가기</button>
								</a>
							</div>
						</div>
						<div class="mylist">
							<article class="mylist2">
								<div class="myArtist1">
									<h2 class="myArtist2">My Artist</h2>
									<span class="myArtistAll">
										<a href="">모두 보기</a>
									</span>
								</div>
								<ul class=""></ul>
							</article>	
							<article class="mylist2"></article>
							<article class="mylist2"></article>
							<article class="mylist2"></article>
						</div>
					</div>
				</div>
			</div>			
			
		</div>
	</div>

</body>
</html>