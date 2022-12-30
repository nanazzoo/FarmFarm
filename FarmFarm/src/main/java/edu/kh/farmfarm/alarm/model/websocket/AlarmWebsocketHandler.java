package edu.kh.farmfarm.alarm.model.websocket;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

import edu.kh.farmfarm.alarm.model.service.AlarmService;
import edu.kh.farmfarm.alarm.model.vo.Alarm;
import edu.kh.farmfarm.member.model.VO.Member;


public class AlarmWebsocketHandler extends TextWebSocketHandler {

	
	@Autowired
	private AlarmService service;
	
	private Set<WebSocketSession> sessions = Collections.synchronizedSet(new HashSet<WebSocketSession>());
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessions.add(session);
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		ObjectMapper alarmMapper = new ObjectMapper();
		
		// 연결된 페이지로부터 메세지를 받음
		Alarm alarm = alarmMapper.readValue(message.getPayload(), Alarm.class);
		
		// 알림을 해석해서 DB에 저장
		int result = service.insertNewAlarm(alarm);
		
		// DB에 잘 저장되었으면... 알림을 반환
		if(result > 0) {
			
			
			// 알림을 수신할 회원의 번호, 즉 대상 회원의 번호 targetNo
			int targetNo = alarm.getMemberNo();

			// 세션을 전부 확인
			for(WebSocketSession s : sessions) {
				
				// 현재 세션 s에 올라가있는 회원 번호를 loginMemberNo에 저장
				int loginMemberNo = ((Member)s.getAttributes().get("loginMember")).getMemberNo();
				
				// 해당 세션의 회원 번호 loginMemberNo가, 알림을 수신할 targetNo와 일치 시 알림을 전달
				if(loginMemberNo == targetNo) {
					s.sendMessage(new TextMessage(new Gson().toJson(alarm)));
				}
			}
		}
		
	}

	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessions.remove(session);
	}
	
	
	
	
}
