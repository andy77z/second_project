<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
<head>
  <title>calendar</title>
  <meta charset='utf-8' />
  <!-- 화면 해상도에 따라 글자 크기 대응(모바일 대응) -->
  <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
  <script src="/soju/js/jquery-3.6.0.min.js"></script>
  <link href='/soju/js/calendar/fullcalendar-5.10.1.main.min.css' rel='stylesheet' />
  <script src="/soju/js/calendar/fullcalendar-5.10.1.main.min.js"></script>
  <script src="/soju/js/calendar/fullcalendar-5.10.1.locales-all.min.js"></script>
  
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

  <!-- jquery CDN 
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.css' rel='stylesheet' />
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/main.min.js'></script>
  <script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.8.0/locales-all.min.js'></script> -->
  
  <style>
  /* body 스타일 */
  html, body {
    overflow: hidden;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
  }
  /* 캘린더 위의 해더 스타일(날짜가 있는 부분) */
  .fc-header-toolbar {
    padding-top: 1em;
    padding-left: 1em;
    padding-right: 1em;
  }
.swal-modal {
  background-color: #F9FFFF;
  border: 2px solid #00008C;
}
.swal-title {
  margin: 0px;
  font-size: 16px;
  font-weight: bold;
  box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.21);
  margin-bottom: 28px;
  color : black;
}
.swal-text {
  text-align: center;
  color: black;
}
.swal-button {
  padding: 7px 19px;
  border-radius: 2px;
  background-color: #4962B3;
  font-size: 12px;
  border: 1px solid #3e549a;
  text-shadow: 0px -1px 0px rgba(0, 0, 0, 0.3);
}
</style>
<%
	int artnum = (Integer)session.getAttribute("art_num");
%>
 <script>
    $(function(){
		 
    	 var vEvents = [];
    	 $.ajax({
    		 data : {"artNum" : "<%=artnum%>"},
    		 type: 'post',
    		 dataType: 'json',
    		 url: '/soju/calendar.do',
    		 async: false,
    		 success: function(data){
    			// $.each(data, function(i,v){
    			//	v['end'] = v['end'].split('t')[0];
    			//	v['start'] = v['start'].split('t')[0];
    			// });
    			 vEvents = data;
    			 //alert(data);
    			 
    		 },
    		 error : function(xhr){
    			 alert("상태:"+xhr.status);
    		 }
    	 
    	 });
    	 console.log(vEvents);
      // calendar element 취득
      var calendarEl = $('#calendar')[0];
      // full-calendar 생성하기
      var calendar = new FullCalendar.Calendar(calendarEl, {
        height: '700px', // calendar 높이 설정
        expandRows: true, // 화면에 맞게 높이 재설정
        slotMinTime: '08:00', // Day 캘린더에서 시작 시간
        slotMaxTime: '22:00', // Day 캘린더에서 종료 시간
        // 해더에 표시할 툴바
        headerToolbar: {
          left: 'prev,next today',
          center: 'title',
          right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
        //initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
        navLinks: true, // 날짜를 선택하면 Day 캘린더나 Week 캘린더로 링크
        editable: true, // 수정 가능?
        selectable: true, // 달력 일자 드래그 설정가능
        nowIndicator: true, // 현재 시간 마크
        dayMaxEvents: true, // 이벤트가 오버되면 높이 제한 (+ 몇 개식으로 표현)
        locale: 'ko', // 한국어 설정
        /*
        eventAdd: function(obj) { // 이벤트가 추가되면 발생하는 이벤트
          console.log(obj);
        },
        eventChange: function(obj) { // 이벤트가 수정되면 발생하는 이벤트
          console.log(obj);
        },
        eventRemove: function(obj){ // 이벤트가 삭제되면 발생하는 이벤트
          console.log(obj);
        },
        */
     	// 이벤트명 : function(){} : 각 날짜에 대한 이벤트를 통해 처리할 내용.. 
        // (캘린더에서 드래그로 이벤트를 생성할 수 있다.)
     	select: function(arg) { 
     	  console.log(arg); 
     	  var title = prompt('입력할 일정:');
     	// title 값이 있을때, 화면에 calendar.addEvent() json형식으로 일정을 추가  
          if (title) {
            calendar.addEvent({
              title: title,
              start: arg.start,
              end: arg.end,
              allDay: arg.allDay,
              backgroundColor:"yellow", 
			  textColor:"blue" 
            })
          }
          calendar.unselect();
        },
        eventClick: function(arg) { 	// 있는 일정 클릭시, 
        	//console.log(arg.event); 
        	//alert(arg.event.extendedProps.content);
        	con=arg.event.extendedProps.content;
        	swal({
     		   title: "일정 상세",
    		   text: con,
    		 });
        	
        	//window.open("../member/member.jsp","_blank","width=700 height=800")
        	/* console.log("#등록된 일정 클릭#"); 
			console.log(arg.event); 
		if (confirm('Are you sure you want to delete this event?')) {
			arg.event.remove();
			}  */
		}, 
		
		// 이벤트 
		events: vEvents
		
		/* 참고1 : 참조블로그 적용 전 내용
		events: function(info, successCallback, failureCallback){ 
			// ajax 처리로 데이터를 로딩 시킨다. 
			$.ajax({ type:"get", 
					 url:"${path}/calendar.do?method=data",
					 dataType:"json" 
					 }); 
			}
		*/
       //참고2: db연동 안하는 경우
       /* 
       events: [
           {
             title: 'All Day Event',
             start: '2021-07-01',
           },
           {
             title: 'Long Event',
             start: '2021-07-07',
             end: '2021-07-10'
           }
         ]*/
      });
      // 캘린더 랜더링
      calendar.render();
    });
    
</script>
</head>
<body style="padding:30px;">
  <!-- calendar 태그 -->
  <div id='calendar-container'>
    <div id='calendar'></div>
  </div>

</body>

</html>