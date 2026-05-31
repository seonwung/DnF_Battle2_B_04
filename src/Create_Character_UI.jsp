<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="DnF.*"%>
<%
	// 한글 깨짐 방지
	request.setCharacterEncoding("UTF-8");

	// Form에서 넘어온 파라미터 받기
	String 플레이어id = request.getParameter("playerId");
	String 캐릭터명 = request.getParameter("charName");
	String 직업 = request.getParameter("job");
	String levelStr = request.getParameter("level");

	캐릭터 character = null;
	boolean isSubmitted = (플레이어id != null && !플레이어id.isEmpty()); // 폼 제출 여부 확인

	if (isSubmitted) {
		int 레벨 = 1;
		if (levelStr != null && !levelStr.isEmpty()) {
			레벨 = Integer.parseInt(levelStr);
		}

		전투 battle = new 전투();
		character = battle.캐릭터생성(플레이어id, 캐릭터명, 직업, 레벨);

		// 다음 페이지(몬스터공격)에서 사용하기 위해 세션에 저장
		if (character != null) {
			session.setAttribute("myDnFCharacter", character);
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>DnF Battle - 캐릭터 생성</title>
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
	border-bottom: 2px solid #3b82f6;
	padding-bottom: 10px;
}

h4 {
	font-size: 1.1rem;
	color: #4b5563;
	margin-top: 20px;
	margin-bottom: 10px;
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

input[type="text"], input[type="number"] {
	background-color: #f9fafb;
	color: #111827;
	border: 1px solid #d1d5db;
	padding: 10px 14px;
	border-radius: 8px;
	width: 100%;
	font-size: 0.95rem;
	box-sizing: border-box;
	transition: all 0.2s ease;
}

input[type="text"]:focus, input[type="number"]:focus {
	border-color: #3b82f6;
	background-color: #ffffff;
	box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.15);
	outline: none;
}

.toggle-group {
	display: flex;
	gap: 20px;
	margin-top: 5px;
}

.toggle-group label {
	display: flex;
	align-items: center;
	gap: 6px;
	cursor: pointer;
	color: #374151;
	font-weight: 500;
}

.toggle-group input[type="radio"] {
	margin: 0;
	accent-color: #3b82f6;
}

.btn {
	background-color: #3b82f6;
	color: white;
	border: none;
	padding: 12px 20px;
	border-radius: 8px;
	cursor: pointer;
	font-weight: bold;
	font-size: 1rem;
	width: 100%;
	transition: background-color 0.2s ease;
}

.btn:hover {
	background-color: #2563eb;
}

p {
	font-size: 0.95rem;
	line-height: 1.6;
	color: #4b5563;
	margin: 8px 0;
}

.info-label {
	font-weight: 600;
	color: #1f2937;
	display: inline-block;
	width: 100px;
}

a.btn-link {
	color: #ffffff;
	background-color: #10b981;
	text-decoration: none;
	font-weight: bold;
	display: block;
	text-align: center;
	padding: 12px;
	border-radius: 8px;
	margin-top: 20px;
	transition: background-color 0.2s ease;
}

a.btn-link:hover {
	background-color: #059669;
}
</style>
</head>
<body>
	<div class="box">
		<h3>⚔️ 던전 앤 파이터 모험가 생성</h3>
		<form method="POST" action="Create_Character_UI.jsp">
			<div class="form-group">
				<label>플레이어 ID</label> <input type="text" name="playerId"
					value="hero" required>
			</div>
			<div class="form-group">
				<label>캐릭터명 입력</label> <input type="text" name="charName"
					placeholder="예: 최강전사" required>
			</div>
			<div class="form-group">
				<label>직업 선택</label> <span class="toggle-group"> <label><input
						type="radio" name="job" value="전사" checked> 전사 </label> <label><input
						type="radio" name="job" value="마법사"> 마법사 </label>
				</span>
			</div>
			<div class="form-group">
				<label>시작 레벨</label> <input type="number" name="level" value="10"
					min="1" required>
			</div>
			<button type="submit" class="btn">새로운 캐릭터 생성하기</button>
		</form>
	</div>

	<%
		if (isSubmitted) {
	%>
	<div class="box" style="border-left: 5px solid #3b82f6;">
		<h3 style="color: #3b82f6; border-bottom: none; margin-bottom: 15px;">✨
			캐릭터 생성 정보 확인</h3>
		<p>
			<span class="info-label">• 플레이어 ID:</span>
			<%=플레이어id%></p>
		<p>
			<span class="info-label">• 캐릭터 이름:</span>
			<%=캐릭터명%></p>
		<p>
			<span class="info-label">• 선택한 직업:</span>
			<%=직업%></p>
		<p>
			<span class="info-label">• 현재 레벨:</span>
			<%=levelStr%>
			Lv
		</p>

		<%
			if (character != null) {
		%>
		<p
			style="color: #10b981; font-size: 1.1em; margin-top: 15px; font-weight: bold;">
			🎉 모험가 등록이 성공적으로 완료되었습니다!</p>
		<hr style="border: 0; border-top: 1px solid #e1e4e6; margin: 15px 0;">

		<h4>[ 생성 완료된 능력치 정보 ]</h4>
		<p>
			<span class="info-label">• 최대 HP:</span>
			<%=character.getHP()%></p>
		<p>
			<span class="info-label">• 기본 공격력:</span>
			<%=character.get공격력()%></p>

		<a href="Attack_Monster_UI.jsp" class="btn-link">⚔️ 던전 입장 (몬스터
			공격하기)</a>
		<%
			} else {
		%>
		<hr style="border: 0; border-top: 1px solid #e1e4e6; margin: 15px 0;">
		<p style="color: #ef4444; font-weight: bold;">❌ 캐릭터 생성에 실패했습니다.
			(플레이어 ID가 'hero'가 맞는지 확인해 주세요.)</p>
		<%
			}
		%>
	</div>
	<%
		}
	%>
</body>
</html>