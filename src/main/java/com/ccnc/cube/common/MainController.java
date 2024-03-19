package com.ccnc.cube.common;

import java.time.DayOfWeek;
import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.ccnc.cube.attendance.Attendance;
import com.ccnc.cube.attendance.AttendanceService;
import com.ccnc.cube.board.Board;
import com.ccnc.cube.board.BoardService;
import com.ccnc.cube.board.NoticeBoard;
import com.ccnc.cube.board.NoticeBoardService;
import com.ccnc.cube.common.CommonEnum.AType;
import com.ccnc.cube.common.CommonEnum.MailImportant;
import com.ccnc.cube.common.CommonEnum.MailIsDelete;
import com.ccnc.cube.common.CommonEnum.MailReadStatus;
import com.ccnc.cube.common.CommonEnum.UserPosition;
import com.ccnc.cube.mail.MailService;
import com.ccnc.cube.mail.ReceiveMail;
import com.ccnc.cube.reservation.CarReservationService;
import com.ccnc.cube.reservation.ReservationService;
import com.ccnc.cube.user.UserService;
import com.ccnc.cube.user.Users;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	TeamService teamService;

	@Autowired
	UserService userService;

	@Autowired
	NoticeBoardService noticeBoardService;

	@Autowired
	BoardService boardService;

	@Autowired
	MailService mailService;
	
	@Autowired
	CarReservationService carReservationService;
	
	@Autowired
	ReservationService reservationService;

	@Autowired
	AttendanceService attendanceService;
	
	@GetMapping("/index")
	public String index(Model model, HttpSession session) {
		Users user = (Users) session.getAttribute("login_user");
		// 공지사항
		List<NoticeBoard> nList = noticeBoardService.getListNoticeBoard();
		List<NoticeBoard> nBoardList = new ArrayList<>();
		Collections.reverse(nList);
		for (int i = 0; i < 5; i++) {
			if (nList.size() - 1 >= i) {
				nBoardList.add(nList.get(i));
			}
		}

		// 팀게시판
		List<Board> getTeamBoardList = boardService.findByTeamId(user.getUserTeamId());
		List<Board> teamBoardList = new ArrayList<>();
		Collections.reverse(getTeamBoardList);
		for (int i = 0; i < 5; i++) {
			if (getTeamBoardList.size() - 1 >= i) {
				teamBoardList.add(getTeamBoardList.get(i));
			}
		}

		// 받은 메일함
		List<ReceiveMail> receivedMailList = mailService.receivedMailBoxList(user.getUserEmail(), MailIsDelete.존재,MailImportant.기본);
		List<ReceiveMail> filteredMailList = receivedMailList.stream()
				.filter(mail -> mail.getReceiveMailReservationDate() == null
						|| LocalDateTime.now().isAfter(mail.getReceiveMailReservationDate())
						|| LocalDateTime.now().isEqual(mail.getReceiveMailReservationDate()))
				.collect(Collectors.toList());
		List<ReceiveMail> receivedMail = new ArrayList<>();
		Collections.reverse(filteredMailList);
		for (int i = 0; i < 5; i++) {
			if (filteredMailList.size() - 1 >= i) {
				if(filteredMailList.get(i).getReceiveMailReadStatus().equals(MailReadStatus.읽지않음)) {
					receivedMail.add(filteredMailList.get(i));
				}
			}
		}
		//팀 출력
		List<Users> userTeamList = userService.findByTeamId(user.getUserTeamId());
		List<Users> team = new ArrayList<>();
		Users leader = null;
		for(Users teamUser : userTeamList) {
			if(teamUser.getUserPosition().equals(UserPosition.팀장)) {
				leader = teamUser;
			}else {
				team.add(teamUser);
			}
		}
		
		
		//근태 시스템
		List<Attendance> attList = attendanceService.attList(user);
		List<Attendance> thisAttList = new ArrayList<>();
		for(Attendance att: attList) {
			if(att.getAttDate().getMonthValue() == LocalDate.now().getMonthValue()) { //이번달 근태만
				thisAttList.add(att);
			}
		}
		int work = 0;
		int ot = 0;
		int va = 0;
		int notWork = 0;
		int last = LocalDate.now().lengthOfMonth();
		int lastDay = 0;
		for(int i = 1; i <= last; i++) {
			 LocalDate date = LocalDate.of(LocalDate.now().getYear(), LocalDate.now().getMonthValue(), i); // year와 month는 해당 월의 연도와 월을 나타냅니다.
			    DayOfWeek dayOfWeek = date.getDayOfWeek();
			    if (dayOfWeek != DayOfWeek.SATURDAY && dayOfWeek != DayOfWeek.SUNDAY) {
			        lastDay++;
			    }
		}
		int totalTime = (lastDay * 720);
		int nomal = 0;
		int hoil = 0;
		double halfHoil = 0;
		int notWorkDay = 0;
		
		List<Integer> attTypeList = new ArrayList<>();
		List<Double> dayTypeList = new ArrayList<>();
		for(Attendance att: thisAttList) {
			if(att.getAttOtStart() != null || att.getAttOtEnd() != null) { //초과근무
				Duration duration = Duration.between(att.getAttOtStart(), att.getAttOtEnd());
				int time = (int)((duration.toHoursPart() * 60) + duration.toMinutesPart());
				ot += time;
			}
			//정상근무
			if(att.getAttType().equals(AType.정상근무) || att.getAttType().equals(AType.오후반차) || att.getAttType().equals(AType.오전반차) || att.getAttType().equals(AType.지각)) {
				Duration duration = Duration.between(att.getAttStart(), att.getAttEnd());
				int time = (duration.toHoursPart() * 60) + duration.toMinutesPart();
				work += time;
				if(att.getAttType().equals(AType.오전반차) || att.getAttType().equals(AType.오후반차)) {
					va += 240;
					halfHoil = 0.5;
				}else {
					nomal ++;
				}
			}else if(att.getAttType().equals(AType.연차)) {
				va += 480;
				hoil ++;
			}else if(att.getAttType().equals(AType.공가)){
				notWork += 480;
				notWorkDay++;
			}
		}
		attTypeList.add(work);
		attTypeList.add(va);
		attTypeList.add(notWork);
		attTypeList.add(ot);
		attTypeList.add(totalTime-work-ot-va-notWork);
		dayTypeList.add((double)nomal);
		dayTypeList.add((double)hoil);
		dayTypeList.add((double)notWorkDay);
		dayTypeList.add(halfHoil);
		dayTypeList.add(lastDay-nomal-hoil-notWorkDay-halfHoil);
		model.addAttribute("lastDay", lastDay);
		model.addAttribute("dayTypeList", dayTypeList);
		model.addAttribute("attTypeList", attTypeList);
		model.addAttribute("thisAttList", thisAttList);
		model.addAttribute("team", team);
		model.addAttribute("leader", leader);
		model.addAttribute("receivedMail", receivedMail);
		model.addAttribute("teamBoardList", teamBoardList);
		model.addAttribute("nBoardList", nBoardList);
		model.addAttribute("asidePage", "./layout/aside.jsp");
		model.addAttribute("mainPage", "./layout/main.jsp");
		return "index";
	}
}
