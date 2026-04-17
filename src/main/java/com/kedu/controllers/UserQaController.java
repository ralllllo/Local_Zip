package com.kedu.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kedu.dao.UserQaDAO;
import com.kedu.dto.QaDTO;

@Controller
@RequestMapping("/qa")
public class UserQaController {
	
	@Autowired
	private UserQaDAO uDAO;

	@RequestMapping("/toQa")
	public String toQa(Model model,int cPage, HttpSession session) throws Exception{
		
		String mem_id = (String)session.getAttribute("loginId");
		
		//5개씩 가져오기(recordcountperpage)
		int start = (cPage-1)*5+1;
		int end = cPage*5;
		List<QaDTO> list = uDAO.getPostList(mem_id,start,end);
		//게시글 전체 개수 가져오기
		int totalCount = uDAO.getTotalCount(mem_id);
		model.addAttribute("list", list);
		model.addAttribute("cPage",cPage);
		model.addAttribute("totalCount", totalCount);
		return "/qa/qa";
	}
	
	@RequestMapping("/toWrite")
	public String toWrite(int cPage,Model model) throws Exception{
		model.addAttribute("cPage",cPage);
		return "/qa/qaWrite";
	}
	
	//DB에 게시글 저장
	@PostMapping("/insert")
	public String insert(@RequestParam("post_title")String title,@RequestParam("post_category")int category
						,@RequestParam("post_contents")String contents,HttpSession session) throws Exception{
		String id = (String)session.getAttribute("loginId");
		if (id == null) {
	        return "redirect:/members/login"; // 로그인 페이지로 튕기기
	    }
		
		uDAO.insert(new QaDTO(0,id,title,contents,category,"",0,"","",""));
		
		
		return "redirect:/qa/toQa?cPage=1";
	}
	
	@PostMapping("update")
	@ResponseBody
	public String update(@RequestParam("qa_seq")int seq,@RequestParam("qa_title")String title
						,@RequestParam("qa_contents")String contents) {
		uDAO.updateBySeq(seq,title,contents);
			return "success";
	}
	
	@PostMapping("delete")
	@ResponseBody
	public String delete(@RequestParam("qa_seq")int seq) {
		int result =uDAO.deleteBySeq(seq);
		if(result>0) {
			return "successDel";	
		}
		return "fail";
	}
	
	@ExceptionHandler(Exception.class)
	   public String exceptionHandler(Exception e) {
	      e.printStackTrace();
	      return "error";
	   }
}