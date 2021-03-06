<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>So? Would You?</title>
<style>

table{
	border-collapse: collapse;
	border-color: lightgray;
}
td{
	text-align : center;
	height : 50px;
	font-size: 15px;
}
.td1{
	width: 70px;
}
.td2{
	width: 120px;
}
.td3{
	width: 120px;
}
.td4{
	width: 200px;
}
.td5{
	width: 170px;
}
</style>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script>
$(function(){
	$.ajax({
		url: '<%= request.getContextPath() %>/AgencyList.do',
		type: 'post',
		success: function(res){
			str="<tr>";
			$.each(res, function(i, v){
				str += `<td class="td1">\${v.agc_num}</td>`;
				str += `<td class="td2">\${v.agc_id}</td>`;
				str += `<td class="td3">\${v.agc_name}</td>`;
				str += `<td class="td4">\${v.agc_mail}</td></tr>`;
			})
			$('.tab').html(str);
		},
		error : function(xhr){
			alert("상태 : " + xhr.status);
		},
		dataType: 'json'
	})
})

</script>
</head>
<body>
<h4>소속사 계정관리</h4>
	<div class="member">
		<table border="1">
			<tbody>
				<tr>
					<td class="td1">소속사<br>번호</td>
					<td class="td2">ID</td>
					<td class="td3">소속사명</td>
					<td class="td4">이메일</td>
				</tr>
				
			</tbody>
			</table>
			<table border="1" class="tab">
			</table>
		
		
	</div>
</body>
</html>