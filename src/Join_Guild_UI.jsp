<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DnF.*"%>
<%@ page import="java.util.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	String 플레이어id = request.getParameter("playerId");
	String 길드명 = request.getParameter("guildName");

	캐릭터 character = (캐릭터) session.getAttribute("myDnFCharacter");
	String 결과메시지 = "";
	boolean isSubmitted = (플레이어id != null && !플레이어id.isEmpty());

	// [Aggregation 구현] 서버 공용 메모리(application)에 길드들을 관리하여 정원 차는 것을 실습
	Map<String, 길드> 길드저장소 = (Map<String, 길드>) application.getAttribute("globalGuilds");
	if (길드저장소 == null) {
		길드저장소 = new HashMap<>();
		// 기본 테스트용 길드 미리 생성해두기
		길드저장소.put("아라드연합", new 길드("아라드연합"));
		길드저장소.put("토벌대", new 길드("토벌대"));
		application.setAttribute("globalGuilds", 길드저장소);
	}

	if (isSubmitted) {
		전투 battle = new 전투();
		길드 targetGuild = 길드저장소.get(길드명);

		if (targetGuild == null && 길드명 != null && !길드명.isEmpty()) {
			// 입력한 길드가 없으면 새로 생성해서 등록 (Aggregation 조건 충족)
			targetGuild = new 길드(길드명);
			길드저장소.put(길드명, targetGuild);
		}

		결과메시지 = battle.길드가입(플레이어id, character, targetGuild);
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>DnF Battle - 길드 가입</title>
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
	border-bottom: 2px solid #8b5cf6;
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

input[type="text"] {
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
	background-color: #8b5cf6;
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
	background-color: #7c3aed;
}

.result-p {
	font-size: 1.05rem;
	line-height: 1.6;
	color: #1f2937;
	margin: 10px 0;
	background-color: #f5f3ff;
	padding: 15px;
	border-radius: 8px;
	border: 1px dashed #c084fc;
}

.guild-card {
	background: #f9fafb;
	padding: 10px;
	border-radius: 6px;
	margin-bottom: 6px;
	font-size: 0.9rem;
	display: flex;
	justify-content: space-between;
}
</style>
</head>
<body>
	<div class="box">
		<h3>🏰 신규 기능: 길드 가입 신청</h3>
		<%
			if (character == null) {
		%>
		<p class="result-p"
			style="background-color: #fef2f2; border-color: #fca5a5; color: #ef4444;">
			❌ 캐릭터가 없습니다. 생성을 먼저 해주세요.</p>
		<%
			} else {
		%>
		<form method="POST" action="Join_Guild_UI.jsp">
			<div class="form-group">
				<label>플레이어 ID</label> <input type="text" name="playerId"
					value="hero" required>
			</div>
			<div class="form-group">
				<label>가입할 길드명 입력</label> <input type="text" name="guildName"
					placeholder="예: 아라드연합" required>
			</div>
			<button type="submit" class="btn">길드 가입 요청</button>
		</form>
		<%
			}
		%>
	</div>

	<div class="box" style="border-top: 5px solid #8b5cf6;">
		<h3>스마트 서버 길드 현황 (최대 5명 제한)</h3>
		<%
			for (String 명칭 : 길드저장소.keySet()) {
				길드 g = 길드저장소.get(명칭);
		%>
		<div class="guild-card">
			<span>🛡️ <b><%=g.get길드명()%></b></span> <span
				style="font-weight: bold; color: #7c3aed;"><%=g.get현재원()%>
				/ 5 명</span>
		</div>
		<%
			if (g.get현재원() > 0) {
		%>
		<div
			style="padding-left: 15px; margin-bottom: 10px; font-size: 0.85rem; color: #6b7280;">
			가입원:
			<%
			for (캐릭터 c : g.get캐릭터리스트()) {
		%>
			[<%=c.get캐릭터명()%>]
			<%
			}
		%>
		</div>
		<%
			}
		%>
		<%
			}
		%>

		<%
			if (isSubmitted && character != null) {
		%>
		<hr style="border: 0; border-top: 1px solid #e1e4e6; margin: 20px 0;">
		<h4>🔔 처리 결과 내역</h4>
		<p class="result-p"><%=결과메시지%></p>
		<%
			}
		%>
	</div>
</body>
</html>