package com.tmmas.cl;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionServlet;

public class PostServlet extends ActionServlet {
	private static final long serialVersionUID = 1L;
	
	public void doGet(HttpServletRequest arg0, HttpServletResponse arg1) throws IOException, ServletException {
		System.out.println("Recibo por GET");
		arg1.sendError(401);
	//	super.doGet(arg0, arg1);
	}
	
	public void doPost(HttpServletRequest arg0, HttpServletResponse arg1) throws IOException, ServletException {
		System.out.println("Recibo por POST");
		super.doPost(arg0, arg1);
	}
	
}
