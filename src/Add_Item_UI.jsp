<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DnF.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String 플레이어id = request.getParameter("playerId");
	String 아이템명 = request.getParameter("itemName");
	String 타입 = request.getParameter("itemType");
	String valueStr = request.getParameter("itemValue");

	캐릭터 character = (캐릭터) session.getAttribute("myDnFCharacter");
	String 결과메시지 = "";
	boolean isSubmitted = (플레이어id != null && !플레이어id.isEmpty());

	if (isSubmitted) {
		int 가치 = 0;
		if (valueStr != null && !valueStr.isEmpty()) {
			가치 = Integer.parseInt(valueStr);
		}
		전투 battle = new 전투();
		결과메시지 = battle.아이템획득(플레이어id, character, 아이템명, 타입, 가치);
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>DnF Battle - 아이템 획득</title>
<style>
body {
	font-family: 'Malgun Gothic', sans-serif;
	background-color: #f4f6f9;
	color: #333333;
	padding: 40px 20px;
	display: flex;
	flex-direction: column;
	align-items: center;
}

.box {
	background-color: #ffffff;
	border: 1px solid #e1e4e6;
	padding: 30px;
	border-radius: 12px;
	width: 100%;
	max-width: 480px;
	margin-bottom: 25px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
	box-sizing: border-box;
}

h3 {
	font-size: 1.4rem;
	color: #222222;
	font-weight: 700;
	margin-top: 0;
	margin-bottom: 20px;
	border-bottom: 2px solid #10b981;
	padding-bottom: 10px;
}

.form-group {
	margin-bottom: 20px;
}

label {
	display: block;
	font-weight: 600;
	color: #4b5563;
	margin-bottom: 8px;
	font-size: 0.95rem;
}

input[type="text"], input[type="number"], select {
	background-color: #f9fafb;
	color: #111827;
	border: 1px solid #d1d5db;
	padding: 10px 14px;
	border-radius: 8px;
	width: 100%;
	font-size: 0.95rem;
	box-sizing: border-box;
}

.btn {
	background-color: #10b981;
	color: white;
	border: none;
	padding: 12px 20px;
	border-radius: 8px;
	cursor: pointer;
	font-weight: bold;
	font-size: 1rem;
	width: 100%;
	transition: background-color 0.2s;
}

.btn:hover {
	background-color: #059669;
}

.result-p {
	font-size: 1.05rem;
	line-height: 1.6;
	color: #1f2937;
	margin: 10px 0;
	background-color: #f0fdf4;
	padding: 15px;
	border-radius: 8px;
	border: 1px dashed #6ee7b7;
}

.info-p {
	background-color: #f3f4f6;
	padding: 12px;
	border-radius: 8px;
	font-size: 0.95rem;
}

a.btn-link {
	color: #ffffff;
	background-color: #3b82f6;
	text-decoration: none;
	font-weight: bold;
	display: block;
	text-align: center;
	padding: 12px;
	border-radius: 8px;
	margin-top: 15px;
}
</style>
</head>
<body>
	<div class="box">
		<h3>🎁 신규 기능: 아이템 획득</h3>
		<%
			if (character == null) {
		%>
		<p class="result-p"
			style="background-color: #fef2f2; border-color: #fca5a5; color: #ef4444;">
			❌ 생성된 캐릭터 세션이 없습니다. 캐릭터 생성을 먼저 완료해주세요.</p>
		<a href="Create_Character_UI.jsp" class="btn-link">캐릭터 생성하러 가기</a>
		<%
			} else {
		%>
		<p class="info-p">
			👤 <b>현재 캐릭터:</b>
			<%=character.get캐릭터명()%>
			(<%=character.getClass().getSimpleName()%>)<br> 🎒 <b>인벤토리
				현황:</b>
			<%=character.인벤토리가져오기().get현재수량()%>
			/ 10 칸
		</p>
		<form method="POST" action="Add_Item_UI.jsp">
			<div class="form-group">
				<label>플레이어 ID</label> <input type="text" name="playerId"
					value="hero" required>
			</div>
			<div class="form-group">
				<label>아이템명</label> <input type="text" name="itemName"
					placeholder="예: 집행자의 대검" required>
			</div>
			<div class="form-group">
				<label>아이템 타입</label> <select name="itemType">
					<option value="무기">무기</option>
					<option value="방어구">방어구</option>
					<option value="물약">물약</option>
				</select>
			</div>
			<div class="form-group">
				<label>아이템 가치 (등급 산정용)</label> <input type="number" name="itemValue"
					value="600" min="1" required>
			</div>
			<button type="submit" class="btn">아이템 루팅하기</button>
		</form>
		<%
			}
		%>
	</div>

	<%
		if (isSubmitted && character != null) {
	%>
	<div class="box" style="border-top: 5px solid #10b981;">
		<h3 style="color: #10b981; border-bottom: none; margin-bottom: 10px;">📊
			인벤토리 처리 로그</h3>
		<p class="result-p"><%=결과메시지%></p>

		<h4>현재 인벤토리 보관 리스트</h4>
		<%
			if (character.인벤토리가져오기().get현재수량() == 0) {
		%>
		<p>인벤토리가 비어있습니다.</p>
		<%
			} else {
					for (아이템 item : character.인벤토리가져오기().get아이템리스트()) {
		%>
		<div
			style="padding: 6px 10px; background: #f9fafb; margin-bottom: 4px; border-radius: 6px; font-size: 0.9rem;">
			• <b><%=item.get아이템명()%></b> (<%=item.get타입()%>) - <span
				style="color: #059669;"><%=item.get등급()%></span>
		</div>
		<%
			}
				}
		%>
		<a href="Join_Guild_UI.jsp" class="btn-link"
			style="background-color: #8b5cf6;">🏰 다음 단계 (길드 가입하기)</a>
	</div>
	<%
		}
	%>
</body>
</html>