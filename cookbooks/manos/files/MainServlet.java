package biz.calavera;

//package test;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class MainServlet extends HttpServlet {
	// Import required java libraries
	 
	  private String message;

	  public void init() throws ServletException
	  {
	      // Edit this message, save the file, and rebuild with Ant
              // to see it reflected on the Web page at http://localhost:8081/MainServlet
	      message = "This is a skeleton application-- to explore the end to end Calavera delivery framework.";
	  }

	  public void doGet(HttpServletRequest request,
	                    HttpServletResponse response)
	            throws ServletException, IOException
	  {
	      // Set response content type
	      response.setContentType("text/html");

	      // Actual logic goes here.
	      PrintWriter out = response.getWriter();
	      
              Class1 oResp = new Class1(message);
	      out.println(oResp.webMessage());
	      
	  }
	  
	  public void destroy()
	  {
	      // do nothing.
	  }
	}


