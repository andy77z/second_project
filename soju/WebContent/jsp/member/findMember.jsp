<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<style>
*{
/*border : 1px solid blue;*/
}
.container{
	/*border : 1px solid blue;*/
	max-width : 680px;
	width : 500px;
	margin-top: 10px;
}
.container h3{
	margin-left: 80px;
    margin-bottom: 30px;
    display: block;
    width: 400px;
}
.container h4{
	margin-left: 80px;
    margin-bottom: 10px;
}
.container input{
	width: 200px;
	
}
.form-group input{
	display: block;
	width: 200px;
	float: left;
}
.form-group label{
	display: block;
	width: 100px;
	margin-left: 10px;
	float: left;
	text-align: center;
}
#findid, #pwmail{
	display: block;
	margin-left: 10px;
	float: left;
}
#logo{
	margin-top: 20px;
}
#resid, #pmail{
	display: block;
	margin-left: 10px;
	float: left;
	color: red;
}
</style>
<html lang="kr">
<head>
  <title>회원 ID찾기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/jquery.serializejson.min.js"></script>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <script>

  $(function(){
	//사용할 변수 생성
	nameval = "";
  	mailval = "";
  	idval = "";
  	memid="";
	temppass = "";
	
  	//이름과 이메일로 아이디 받아오기
  	$('#findid').on('click',function(){
  		
  		nameval = $('#name').val().trim();
  		mailval = $('#mail').val().trim();
  		
  		$.ajax({
  	  		url : '/soju/findId.do',
  	  		data : {"name" : nameval,
  	  				"mail" : mailval
  	  				},
  	  		type : 'post',
  	  		success: function(res){
  	  			if(res.id==undefined){
  	  			$('#resid').html("등록되지 않은 ID입니다.");
  	  			}else{
  	  			$('#resid').html("회원님의 ID는 "+res.id+"입니다.");
  	  			memid = res.id;
  	  			//opener.location.href="/team3/main/loginMain.jsp";
  	  			//window.close();
  	  			}
  	  		},
  	  		error : function(xhr){
  	  			alert("상태 : "+xhr.status);
  	  		},
  	  		dataType: 'json'
  		})
  	})
  	
  	$('#pwmail').on('click', function(){
  		idval = $('#memid').val().trim();
  		//alert(memid);
  		
  		// MailSnd로 이메일 주소전송+MailSnd에서 난수 발생 후 메일전송
  		// +난수를 Ajax의 응답으로 받아오기
		if(idval==memid){
			//alert(mailval);
			$.ajax({
				url : '/soju/MailSnd.do',
				data : {"mail" : mailval,
						"memId" : memid	
				},
				type : 'get',
				success : function(res){
					str=res.sw+"<br>다시 로그인해 주세요"
					$('#pmail').html(str).css('color','red');
					temppass = res.tpw;
					//alert(temppass);
				},
				error : function(xhr){
					alert("상태 :"+xhr.status);
				},
				dataType : 'json'
			})  //ajax
			
		}  //if	
  	})//#pwmail').on('click'
  	
  	
  })

  </script>
  
</head>
<body>

<div class="container">
  <div class="head">
  	<img src="/soju/images/logosample.png" alt="So? Would You?" id="logo">
  	<h3>아이디 찾기 / 임시 비밀번호 받기 </h3>
  </div>
  <div class="w3-container">
  <div class="w3-panel w3-border w3-light-grey w3-round-large">
    <form class="form-horizontal" onsubmit="return false">
      <h5>아이디 찾기</h5>
      <p>가입 시 입력한 정보를 입력해주세요</p>
    <div class="form-group">
      <label class="control-label col-sm-2" for="name">이    름:</label>
        <input type="text" class="form-control" id="name" placeholder="Enter name" name="mem_name">
    </div>
    
    <div class="form-group mdata">
      <label class="control-label col-sm-2" for="mail">메일주소:</label>
        <input type="text" class="form-control" id="mail" placeholder="Enter email" name="mem_mail">
        <br>
    </div>
       
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-5">
        <button id="findid" type="submit" class="btn btn-primary">ID찾기</button>
      </div>
      <div><span id="resid"></span></div>
    </div>
  </form>
  </div>
</div>
  
<div class="w3-container">
  <div class="w3-panel w3-border w3-light-grey w3-round-large">
    <form class="form-horizontal" onsubmit="return false">
      <h5>임시 비밀번호 받기</h5>
      <p>회원ID를 입력해주세요</p>
    <div class="form-group">
      <label class="control-label col-sm-2" for="memid">회원ID:</label>
        <input type="text" class="form-control" id="memid" placeholder="Enter Id" name="mem_id">
    </div>
       
    <div class="form-group">        
      <div class="col-sm-offset-2 col-sm-5">
        <button id="pwmail" type="submit" class="btn btn-primary">받기</button>
      </div>
      <div><span id="pmail"></span></div>
    </div>
  </form>
  </div>
</div>  
  
</div>
</div>

</body>
</html>
    