<%@page import="soju.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/artistFrame.css">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script src="<%= request.getContextPath() %>/js/myPayment/paymentList.js"></script>
  <%
     MemberVO mvo = (MemberVO)session.getAttribute("loginUser"); 
     int memNum = mvo.getMem_num(); 
 %>
 
 <style>
/*   body *{ */
/*   border : 2px solid blue; */
/*   } */
  
  .maintr td{
  border: 2px solid gray;
  font-weight: bold;
  background: #2C7CE6;
  color: white;
  }
  
  td{
text-align: center;
width: 5%;
border: 2px solid lightgray;
height: 50px;
 }
 
 
 
 </style>
 
 
 <script>
 
//  memNum =2;
 memNum = <%= memNum %>;
 
 $(function(){
 	
	 myPaymentList();
 	
 });
 
 
 </script>
 
</head>
<body>

     <div class="paymentDiv">
<!--        <table> -->
<!--         <tr class="maintr"> -->
<!--          <td class="td_artist">아티스트</td> -->
<!--          <td class="td_payNum">결제번호</td> -->
<!--          <td class="td_price">가격</td> -->
<!--          <td class="td_payDate">결제일</td> -->
<!--          <td class="td_refund">환불여부</td> -->
<!--         </tr> -->
        
<!-- 	        <tr> -->
<!-- 	         <td class="pm_artist">블랙핑크</td> -->
<!-- 	         <td class="pm_payNum">A105652</td> -->
<!-- 	         <td class="pm_price">3,500원</td> -->
<!-- 	         <td class="pm_start">2021-12-23</td> -->
<!-- 	         <td class="pm_refundState">완료</td> -->
<!-- 	        </tr> -->
        
<!-- 		   <tr> -->
<!-- 	         <td class="pm_artist">블랙핑크</td> -->
<!-- 	         <td class="pm_payNum">A158056</td> -->
<!-- 	         <td class="pm_price">3,500원</td> -->
<!-- 	         <td class="pm_start">2021-12-23</td> -->
<!-- 	         <td class="pm_refundState"></td> -->
<!-- 	       </tr> -->
       
       </table>
     
        
        
     
     </div>

</body>
</html>