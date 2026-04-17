package com.kedu.controllers;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.CompletableFuture;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.kedu.dao.AuthDAO;
import com.kedu.dto.AuthDTO;

@Controller
@RequestMapping("/auth")
public class AuthController {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private Gson gson;

	@Autowired
	private AuthDAO dao;

	// 인증번호 발송 요청
	@RequestMapping(value = "/mailCheck", method = RequestMethod.POST)
	@ResponseBody
	public String mailCheck(@RequestParam("email") String email, @RequestParam("auth_type") int auth_type
							,@RequestParam(value = "mem_id", required = false)String id) {

		// 이메일 존재 여부 확인
		if (auth_type == 1 && (dao.isEmailExists(email) > 0)) {
			return "duplicate";
		}
		if (auth_type == 2 && (dao.isEmailExists(email) == 0)) {
			return "empty";
		}
		if (auth_type == 3) {
			if (dao.isEmailExists(email) == 0) {
	            return "empty";
	        }
	        if (id == null || dao.isIdEmailExists(id, email) == 0) {
	            return "failEmail";
	        }
		}
		

		// 6자리 랜덤번호 생성
		String authCode = String.valueOf(new Random().nextInt(888888) + 111111);

		CompletableFuture.runAsync(() -> {
			try {
				// 메일 발송 로직
				MimeMessage mail = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mail, true, "utf-8");
				String htmlContent = "<div style='background-color: #fbe5c0; padding: 40px; font-family: GMarketSans, sans-serif;width: 700px; margin: auto;'>"
						+ "<div style='background-color: #ffffff; padding: 20px; border-radius: 10px; border: 2px solid #A66A3F; text-align: center;'>"
						+ "  <h2 style='color: #A66A3F;'>🏠 우리동네.zip 회원가입 인증</h2>"
						+ "  <p style='color: #5e361a;'>안녕하세요! 동네의 모든 것을 담는 Local_Zip입니다.</p>"
						+ "  <p style='color: #5e361a;'>아래 인증번호를 입력하여 회원가입을 완료해 주세요.</p>"
						+ "  <div style='background-color: #F2D3A2; padding: 15px; font-size: 24px; font-weight: bold; color: #A66A3F; margin: 20px 0;'>"
						+ authCode + "  </div>"
						+ "  <p style='font-size: 12px; color: #888;'>본 메일은 발신 전용입니다. 문의사항은 고객센터를 이용해 주세요.</p>"
						+ "</div>" + "</div>";
				helper.setTo(email);
				helper.setSubject("[우리 동네.zip] 이메일 인증번호 안내");
				helper.setText(htmlContent, true);
				mailSender.send(mail);
				// db에 저장
				dao.saveAuth(new AuthDTO(email, authCode, auth_type, 0, "0"));

			} catch (Exception e) {
				e.printStackTrace();
			}
		});
		return "success";

	}

	// 인증번호 확인
	@RequestMapping(value = "/verify", method = RequestMethod.POST)
	@ResponseBody
	public String verify(@RequestParam("email") String email, @RequestParam("auth_code") String auth_code) {

		if (dao.checkAuth(email, auth_code) > 0) {
			dao.updateVerified(email);
			return "success";
		}
		return "fail";
	}

	// 최종 가입전에 인증확인
	@RequestMapping(value = "/isVerified", method = RequestMethod.POST)
	@ResponseBody
	public String isVerified(@RequestParam("email") String email) {

		int result = dao.isVerified(email);

		return result + "";
	}

	// 아이디 찾기
	@RequestMapping(value = "/findMyId", method = RequestMethod.POST)
	@ResponseBody
	public String findMyId(@RequestParam("email") String email, @RequestParam("auth_code") String auth_code) {

		if (dao.checkAuth(email, auth_code) > 0) {
			dao.updateVerified(email);

			String myId = dao.findIdByEmail(email);

			Map<String, Object> result = new HashMap<>();
			if (myId != null) {
				result.put("status", "success");
				result.put("myId", myId);
			} else {
				result.put("status", "fail");
				result.put("msg", "해당 이메일로 가입된 정보가 없습니다.");
			}
			return gson.toJson(result); // Gson으로 직렬화하여 반환
		}
		return gson.toJson(Collections.singletonMap("status", "wrong_code"));
	}

	// 새 비밀번호 생성
	@RequestMapping(value = "/updateMyPw", method = RequestMethod.POST)
	public String updateMyPw(@RequestParam("mem_id") String id, @RequestParam("pw") String pw,
			@RequestParam("email") String email, RedirectAttributes rttr) throws Exception{
		// 인증상태확인
		if (dao.isVerified(email) <= 0 || dao.updatePwById(id, pw) <= 0) {
			rttr.addFlashAttribute("pwMsg", "인증 정보가 만료되었거나 변경에 실패했습니다.");
			return "redirect:/find/toFindPw";
		}
		rttr.addFlashAttribute("pwMsg", "비밀번호 변경에 성공하셨습니다.");
		return "redirect:/members/loginUi";
	}
	
	@ExceptionHandler(Exception.class)
	   public String exceptionHandler(Exception e) {
	      e.printStackTrace();
	      return "error";
	}
}