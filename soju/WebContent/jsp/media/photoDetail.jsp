<%@page import="soju.vo.ManagerVO"%>
<%@page import="soju.vo.AgencyVO"%>
<%@page import="soju.vo.ArtistVO"%>
<%@page import="soju.vo.MemberVO"%>
<%@page import="soju.vo.ReplyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>So? Would You?</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/media/photoDetail2.css">
<script src="<%= request.getContextPath() %>/js/media/media.js"></script>

<%

	int type = (Integer)session.getAttribute("type");
	int artnum = (Integer)session.getAttribute("art_num");
	int media_num = (Integer)session.getAttribute("media_num");
	
	
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
		userEmail = "?????????";
		userPhoto = "????????????.png";
		break;
	}
	
	
%>

<script>
function proc1(t){
	//event.preventDefault();
	
	
	if($('.amenu a').hasClass('fcolor')){
		
		$('.amenu a').removeClass('fcolor');
	}
	$(t).addClass('fcolor');
	
	cate_name = $(t).attr('name');
	if(cate_name=="feed"){
		location.href = '<%= request.getContextPath() %>/jsp/feed/feed0.jsp?art_num=<%= artnum %>&cate_name=' + cate_name;
	}else if(cate_name=="artist"){
		location.href = '<%= request.getContextPath() %>/jsp/artist/artist.jsp?art_num=<%= artnum %>&cate_name=' + cate_name;
	}else if(cate_name=="media"){
		location.href = '<%= request.getContextPath() %>/jsp/media/mediaMain.jsp?art_num=<%= artnum %>&cate_name=' + cate_name;
	}else if(name=="chatting"){
		<% if(type==1){
			%>
			location.href = '<%= request.getContextPath() %>/jsp/ticket/buyTicket.jsp';
			<%
		}else{
			%>
			location.href = '<%= request.getContextPath() %>/jsp/chatting/webSocketGroupMutiChatting.jsp';
			<%
		} %>
	}else if(name=="calendar"){
		location.href = '<%= request.getContextPath() %>/jsp/calendar/calenderIndex.jsp?art_num=<%= artnum %>'
	}
}
</script>
<script>
	art_num = <%= artnum %>;
	user_profile = "<%= userPhoto %>";
	user_id = "<%= userId %>";
	reply = {};
	num = <%= media_num %>;
$(function(){
	getArtistDP();
	
	$('input[name=bd_num]').val(num);
	
	$('.delete').on('click', function(){
		deletePhoto();
	})
	
	$(document).on('click', '.modify', function(){
		title = $('.title').text();
		$('input[name=bd_title]').val(title);
		content = $('.content').html();
		content = content.replace(/""/g, "\r").replace(/"<br>"/g, "\n")
		$('.modibox').val(content);
	})
	
	$('.submit').on('click',function(){
		data = $('form').serializeArray();
		updateBoard();
	})
	
	$('.insert').on('click',function(){
		reply.bd_num = num;
		reply.rp_nick = "<%= userNick %>"; // ???????????? ????????? ????????????
		reply.rp_id = "<%= userId %>";
		reply.rp_profile = "<%= userPhoto %>"; // ???????????? ??????????????? ????????????
		reply.rp_cont = $('.textbox').val();
		
		insertPhotoReply();
	})
	
	$(document).on('click', '.rdelete', function(){
		idx = $(this).attr('idx');
		if(confirm("?????? ?????????????????????????") == true){
			deleteReply(this);
		}
	})
	
	$(document).on("click", ".reactLikeCheck", function(){
	      b = $(this).prop('checked');
	      ltype = $(this).attr('name');
	      
	      if(b==true){
	    	  $(this).next().attr('class','likeBtn');
				 if(ltype=="bdlike"){
					 bn = num;
		        	 bd_likeD(this)
		         }else if(ltype=="rplike"){
		        	 rn = $(this).parents('.one-reply').attr('idx');
		        	 rp_likeD(this)
		         }
	      }else{
			 $(this).next().attr('class','likeBtn on');
	         if(ltype=="bdlike"){
	        	 bn = num;
	        	 bd_like(this)
	         }else if(ltype=="rplike"){
	        	 rn = $(this).parents('.one-reply').attr('idx');
	        	 rp_like(this)
	         }
	      }
	      
	   });
	
})
</script>
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
						<!-- ??? ?????? -->
						<a href="<%= request.getContextPath() %>/jsp/main/mypage.jsp" target="main">
							<img class="my1" src="<%= request.getContextPath() %>/images/user.png" alt="my1" width="24" >
						</a>
						
						<div class="dropdown2">
							<button onclick="myFunction2()" class="dropbtn2">
								<img class="bell" src="<%= request.getContextPath() %>/images/bell.png" alt="bell" width="24" >
							</button>
							<div id="myDropdown2" class="dropdown-content2">
								<h5>???????????????????????????</h5>
								
							</div>
						</div>
						
						
						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/main/alarm.jsp" target="_self">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/notice.jsp" target="_self">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/qna.jsp" target="_self">??????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/tiket.jsp" target="_self">???????????????</a>
						  	</div>
						</div>
						<!-- ???????????? -->
<%
		break;
	case 2:
%>						
						
						
						<!-- ????????? -->
<%
		break;
	case 3:
%>						
						

<%
		break;
	case 4:
%>
						<!-- ????????? -->
						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/main/adminMember.jsp" target="_self">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/adminTiket.jsp" target="_self">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/adminQna.jsp" target="_self">????????????</a>
						  	</div>
						</div>
<%
		break;
	}
%>		
			</div><!-- header11 -->
		</header><!-- header1 -->
		
		<section class="big">
			<aside class="left">
				<div class="atitle">
		  			<a href="">
		    			<div class="aname"><p></p></div>
		    		</a>
		    		<div class="wever"></div>
		    		<div class="aprofile"><img src="" alt="banner"></div>
		  		
			  		<div class="artistmenu">
			    		<nav class="amenu">
			      			<a aria-current="page" name="feed" class="active" onclick="proc1(this)">Feed</a>
			    		</nav>
			    		<nav class="amenu">
			      			<a name="artist" onclick="proc1(this)">Artist</a>
			   			</nav>
			    		<nav class="amenu">
			      			<a name="media" onclick="proc1(this)">Media</a>
			    		</nav>
			    		<nav class="amenu">
			      			<a name="chatting" onclick="proc1(this)">Chatting</a>
			    		</nav>
			    		<nav class="amenu">
			      			<a name="calendar" onclick="proc1(this)">Calendar</a>
			    		</nav>
			  		</div>
			  	</div>
			</aside>
			<section class="center">
				<div class="outer">
					<section class="inner">
					<div class="title-box">
						<h2 class="title" bd_num=""></h2>
						<div class="writer" id=""></div>
						<div class="date">
							<span></span>
						</div>

					</div>
					<div class="content-box">
						<div class="content"></div>
					</div>
					<div class="image-box">
						
					</div>
					<div class="reply-section">
						<div class="count-box">
							
						</div>
						<div class="insert-reply">
							<p>?????? ??????</p>
							<textarea class="textbox" rows="3" cols="100"></textarea>
							<button type="button" class="btn btn btn-sm insert">
							??????</button>
						</div>
						
						<div class="reply-list">						
							
						</div>
					</div>
				</section>
				</div>
				<div class="footer">
					<div class="footer fout">
						<div class="footer fin">???So? Would You? Team.Any Question?</div>
					</div>
				</div>
			</section>			
		</section>
	</div>
</div>
	<!-- ?????? ?????? -->
	<div id="modifydetail" class="modal fade" role="dialog">
	  <div class="modal-dialog modal-lg">
	
	    <!-- content -->
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	        <h4 class="modal-title">?????? ??????</h4>
	      </div>
      	<form>
	      <div class="modal-body">
			  <div class="form-group">
			    <label for="title">??????:</label>
			    <input type="text" class="form-control" name="bd_title">
			  </div>
			  <div class="form-group">
			    <label for="content">??????:</label>
			    <textarea class="form-control modibox" name="bd_cont"></textarea>
			  </div>
              <input type="hidden" name="bd_num">
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default submit">??????</button>
	      </div>
		</form>
	    </div>
	
	  </div>
	</div>

</body>


</body>
</html>