<%@page import="soju.vo.ManagerVO"%>
<%@page import="soju.vo.AgencyVO"%>
<%@page import="soju.vo.ArtistVO"%>
<%@page import="soju.vo.MemberVO"%>
<%@page import="soju.vo.ReplyVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<script src="<%= request.getContextPath() %>/js/feed/feed.js"></script>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/feed/feed.css">

<%

	int type = (Integer)session.getAttribute("type");
	int artnum = (Integer)session.getAttribute("art_num");
	
	
	
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
	
	name = $(t).attr('name');
	if(name=="feed"){
		location.href = '<%= request.getContextPath() %>/jsp/feed/feed0.jsp?art_num=<%= artnum %>&cate_name=' + name;
	}else if(name=="artist"){
		location.href = '<%= request.getContextPath() %>/jsp/artist/artist.jsp?art_num=<%= artnum %>&cate_name=' + name;
	}else if(name=="media"){
		location.href = '<%= request.getContextPath() %>/jsp/media/mediaMain.jsp?art_num=<%= artnum %>&cate_name=' + name;
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
cate_name = "artist";
cate_num = 0;
reply = {} 
mreply= {}
 	$(function () {
 		
 		getArtist();
 		
 		//?????? ?????????????????? ?????? ????????? ?????? ??????
		$('.content').on('keyup', function () {
				con = $('.content').html().trim();
				if(con.length<1){
 					$('.complete').prop('disabled', true)
 					
				}else{
				$('.complete').prop('disabled', false)
//				$('.complete').css("cursor", "pointer")
				}
		})
	
		//??????????????? ????????? form????????? ????????? ??????????????? ??????
		$('.postbtn').on('click', function () {
//			fdata = $('.fbox form').serializeArray();
			$('#form').submit();
//			feedUpload();
//			fileUpload(); ?????? ?????????...
		})
		
 		$('.start').on('click', '.sbut', function () {
			idx = $(this).attr('idx');
			name = $(this).attr('name');
			
			if(name=="dele"){//????????? ??????
				if(confirm("?????? ?????????????????????????") == true){
					deleteContent();
				}	
			}else if(name == "modi"){//????????? ??????
				//???????????? ????????? ????????? ????????????
				post = $(this).parents('.post');
				cont = $(post).find('#cont1').html();
				content = cont.replace(/<br>/g, "\n").replace(/""/g, "\r");
				
				//???????????? ????????? ?????? ????????????
				$("#modifymodal").find(".marea").val(content);
				
			}else if(name == "replyupload"){//???????????? 
				//alert(idx +"??? ????????????")
				text = $(this).prev().val(); //?????? ??????
				//console.log(text);
				
				//????????? ???????????? ????????? ??????
				// ??????DB??? ??? ??????
				reply.bd_num = idx;
				reply.rp_cont = text;
				reply.rp_id = "<%= userId %>";
				reply.rp_nick = "<%= userNick %>";
				reply.rp_profile = "<%= userPhoto %>";
				
				insertReply(this); //?????? ?????? ??????????????? ???????????? ??????
			}else if(name == "list"){
				replyList();
			}else if(name == "rdele"){
				if(confirm("?????? ?????????????????????????") == true){
					deleteReply(this);
				}
			}
/* 			else if(name == "rmodi"){
				//???????????? ????????? ????????? ????????????
				reply = $(this).parents('#rep');
				cont = $(reply).find('span.rcon').html();
				oldtext = cont.replace(/<br>/g, "\n").replace(/""/g, "\r");
				
				//?????? ?????? ?????? ?????????
				$(this).parents('#rep').find('.rcon').empty();
				
				//?????? ????????? ????????? 
				$('#rmodifymodal').show();
				
				//???????????? ????????? ?????? ????????????
				$("#rmodifymodal").find(".mrarea").val(oldtext);
			} */
			
		})
		
 		// ??? ?????? ????????? ?????? ??? ???????????? ??????
		$('.mbut').on('click', function () {
			//????????? ?????? ???????????? 
			modicon = $('.marea').val();
			//????????? ?????? ajax
			modifyContent();
		})
		
/*		
		// ???????????? ????????? ????????????
		$('.close').on('click', function () {
			//?????? ????????? ?????? ????????? ?????? ??? ?????????
			$('.'+ idx).html(oldtext);
		})
		
		//?????? ??????????????? ???????????? ??????
		$('.mrbut').on('click', function () {
			rnum = $('.rmodify').attr('idx');
			//textarea?????? ????????? ????????? ???????????? -\r\n -> <br>
			oldtext = $('#rmodifymodal textarea').val();
			newtext = oldtext.replace(/\r/g, "").replace(/\n/g, "<br>");
			
			$('.'+ idx).html(newtext);
			
			//????????? ??????
			$('#rmodifymodal').modal('hide');
		
			//db????????? ?????? ajax???????????? - oldtext, rp_num=idx
			mreply.rp_cont = newtext;
			mreply.rp_num = rnum;
			
			modifyReply(); 
			

		})*/
		
		//?????????
		$(document).on("click", ".reactLikeCheck", function(){
		      b = $(this).prop('checked');
		      ltype = $(this).attr('name');
		      
		      if(b==true){
		    	  $(this).next().attr('class','likeBtn');
					 if(ltype=="bdlike"){
						 bn = $(this).parents('.post').attr('idx');
			        	 bd_likeD(this)
			         }else if(ltype=="rplike"){
			        	 rn = $(this).parents('#rb').find('.rcon').attr('idx');
			        	 rp_likeD(this)
			         }
		      }else{
				 $(this).next().attr('class','likeBtn on');
		         if(ltype=="bdlike"){
		        	 bn = $(this).parents('.post').attr('idx');
		        	 bd_like(this)
		         }else if(ltype=="rplike"){
		        	 rn = $(this).parents('#rb').find('.rcon').attr('idx');
		        	 rp_like(this)
		         }
		      }
		      
		   });
 		
 		
 		// ????????? ???????????? ?????? ????????? 
 		$(document).on("click", "#cont1", function(){
 			idx = $(this).attr("idx");
 			
			$('#largemodal').modal('show');
			
			w=$('#writer').text();
			$('.dtwr').text(w);
			
	        d = $('.date').first().text();
	        $('.dtdate').text(d);
			
	        c= $(this).html();
	        $('.dtcon').html(c);
	        


//  			detailFeed()
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
						<a href="<%= request.getContextPath() %>/jsp/main/mypage.jsp">
							<img class="my1" src="<%= request.getContextPath() %>/images/user.png" alt="my1" width="24" >
						</a>
						
						<div class="dropdown2">
							<button onclick="myFunction2()" class="dropbtn2">
								<img class="bell" src="<%= request.getContextPath() %>/images/bell.png" alt="bell" width="24" >
							</button>
							<div id="myDropdown2" class="dropdown-content2">
								<h5 style="text-align: center;">???????????????...</h5>
							</div>
						</div>
						
						
						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/main/alarm.jsp">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/notice.jsp">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/qna.jsp">??????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/tiket.jsp">???????????????</a>
						  	</div>
						</div>
						<!-- ???????????? -->
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
								<h5 style="text-align: center;">???????????????...</h5>
							</div>
						</div>
						
						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/main/notice.jsp">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/qna.jsp">??????</a>
						  	</div>
						</div>
						<!-- ????????? -->
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
								<h5 style="text-align: center;">???????????????...</h5>
							</div>
						</div>
						
						<div class="dropdown">
	  						<button class="dropbtn">
	  							<img class="more" src="<%= request.getContextPath() %>/images/down-arrow.png" alt="more" width="24" >
	  						</button>
	  						<div class="dropdown-content">
								  <a href="<%= request.getContextPath() %>/jsp/calendar/schedule.jsp" target="_self">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/notice.jsp">????????????</a>
								  <a href="<%= request.getContextPath() %>/jsp/main/qna.jsp">??????</a>
						  	</div>
						</div>
<%
		break;
	case 4:
%>
						<!-- ????????? -->
						<div class="dropdown2">
							<button class="logout">
								<a href="<%=request.getContextPath() %>/Logout.do" target="_top">????????????</a>
							</button>
						</div>
						
						<div class="dropdown2">
							<button onclick="myFunction2()" class="dropbtn2">
								<img class="bell" src="<%= request.getContextPath() %>/images/bell.png" alt="bell" width="24" >
							</button>
							<div id="myDropdown2" class="dropdown-content2">
								<h5 style="text-align: center;">???????????????...</h5>
							</div>
						</div>
						
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
				<section class="content">
					<div style="position: relative;">
						<div style="overflow: visible; width: 0px;">
							<div class="one">
								<div class="two">
									<div class="three">
										<article class="arti">
<%
	if(type == 2){
%>
											<div class="fpost">
												<div class="fbox">
													<h4>????????? ??????</h4><br>
													<div class="myprofile">
														<img src="<%=request.getContextPath() %>/profile.do?fileName=<%= userPhoto %>">
													</div>
													<form enctype="multipart/form-data" id="form" method="post" action="<%= request.getContextPath() %>/FileUploadA.do">
													<div style="display: inline-block">
													<textarea name="bd_cont" class="content pwrite" placeholder="????????? ????????? ??????????????????."></textarea><br>
													<input name="bd_id" value="<%= userId %>" type="hidden">
													<input name="bd_nick" value="<%= userNick %>" type="hidden">
													<input type="hidden" value="<%= userPhoto %>" name="bd_profile">
													<input type="hidden" value="" name="cate_num">
													<input type="hidden" value="feed" name="bd_title">
													</div>
													<br>
														<div style="float: right;">
															<label for="fup" style="cursor: pointer;"><img class="fimg" src="<%= request.getContextPath() %>/images/upload.png"></label>
															<input id="fup" name="inf" type="file" accept="image/*" multiple style="display: none;">
														</div><br><hr>
														<div>
															<button type="button" class="complete postbtn" disabled>??????</button>
														</div>
													</form>
												</div>
											</div>
<%
	}
%>
											
											<div class="start">
												
											</div>
																						
										</article>
									</div>
								</div>
							</div>
						</div>
					</div>
				</section>
			</section>
			<footer class="footer">
				<div class="sc-pYNsO cNiiyt">
					<div class="ftitle">
						<table class="fan">
							<tr>
								<td rowspan="2" class="fprofile">
									<div>
										<img src="<%=request.getContextPath() %>/profile.do?fileName=<%= userPhoto %>" alt="profile">
									</div>
								</td>
			          			<td class="rtd">
			            			<div class="nickname">
			              				<p class="fn"><%= userNick %></p>
			            			</div>
			            			
			            			<div class="userId">
			              				<p class="fn">(<%= userId %>)</p>
			           	 			</div>
			          			</td>
			        		</tr>
			      		</table>
					</div>
				</div>
			</footer>
		</section>	
		
	</div>
</div>
<!-- ?????? ?????? Modal -->
  <div class="modal fade" id="modifymodal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">????????? ??????</h4>
        </div>
        <div class="modal-body"><br>
	        <div class="profile">
				<img src="">
			</div>
			<div style="display: inline-block;">
          		<textarea class="content marea"></textarea>
          		<input type="button" value="??????" class="complete mbut">
        	</div>	
        </div>
        <div class="modal-footer">
          	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>

</body>
</html>