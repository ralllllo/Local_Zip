package com.kedu.controllers;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/attach")
public class AttachmentController {

	// 파일 다운로드
	@GetMapping("/download")
	public void download(HttpServletResponse response, @RequestParam("ori_name") String ori_name,
			@RequestParam("sys_name") String sys_name) throws Exception {
		File target = new File("c:/files/" + sys_name);

		ori_name = new String(ori_name.getBytes("utf8"), "ISO-8859-1");
		response.setHeader("content-disposition", "attachment;filename=" + ori_name);

		try (DataInputStream dis = new DataInputStream(new FileInputStream(target));
				DataOutputStream dos = new DataOutputStream(response.getOutputStream());) {
			byte[] fileContents = dis.readAllBytes();

			dos.write(fileContents);
			dos.flush();
		}
	}

	@ExceptionHandler(Exception.class)
	public String exceptionHandler(Exception e) {
		e.printStackTrace();
		return "error";
	}
}