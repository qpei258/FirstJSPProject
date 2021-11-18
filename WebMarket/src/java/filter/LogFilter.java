package filter;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

public class LogFilter implements Filter {
	
	public void init(FilterConfig config) throws ServletException {
		System.out.println("WebMarket 초기화...");
	}
	
	public void doFilter(ServletRequest requset, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		System.out.println("접속한 클라이언트 IP : " + requset.getRemoteAddr());
		long start = System.currentTimeMillis();
		System.out.println("접근한 URL 경로 :" + getURLPath(requset));
		System.out.println("요청 처리 시작 시각 : " + getCurrentTIme());
		chain.doFilter(requset, response);
		
		long end = System.currentTimeMillis();
		System.out.println("요청 처리 종료 시각 : " + getCurrentTIme());
		System.out.println("요청 처리 소요 시간: " + (end-start) + "ms ");
		System.out.println("============================================");
	}

	public void destroy() {
		
	}
	
	private String getCurrentTIme() {
		DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}

	private String getURLPath(ServletRequest requset) {
		HttpServletRequest req;
		String currentPath="";
		String queryString="";
		
		if(requset instanceof HttpServletRequest) {
			req = (HttpServletRequest)requset;
			currentPath = req.getRequestURI();
			queryString = req.getQueryString();
			queryString = queryString == null ? " " : "?" + queryString;
		}
		return currentPath+queryString;
	}

}
