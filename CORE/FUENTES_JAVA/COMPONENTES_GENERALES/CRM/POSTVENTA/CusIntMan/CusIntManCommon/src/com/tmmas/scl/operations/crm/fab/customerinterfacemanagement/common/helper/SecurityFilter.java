package com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper;

 

import java.io.IOException;
 
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import org.apache.log4j.Logger;
 
 
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
 
 
 
public class SecurityFilter implements Filter {
 
      private String errorPage = "";
 
      private String loginAction = "/LoginAction.do";
 
      private final Logger cat = Logger.getLogger(SecurityFilter.class);
 
      public void destroy() {
            cat.debug("destroy():start");
            cat.debug("destroy():end");
            // TODO Auto-generated method stub
 
      }
 
      public void doFilter(ServletRequest req, ServletResponse resp,
                  FilterChain chain) throws IOException, ServletException {
            cat.debug("doFilter():start");
            HttpServletRequest request = (HttpServletRequest) req;
            HttpServletResponse response = (HttpServletResponse) resp;
 
            // El recurso llamado es la pagina de error. Debo dejar procesarla
 
            String path = request.getServletPath();
            cat.debug("request[" + path + "]");
            if (path.equals(this.errorPage) || path.equals(this.loginAction)) {
                  chain.doFilter(request, response);
                  return;
            }
 
            HttpSession session = request.getSession(false);
            if (session == null) {
                  cat.debug("No existe sesion");
                  String pagina = this.errorPage;
                  cat.debug("Redireccionando a pagina de error[" + pagina + "]");
                  request.setAttribute("tituloError","La Sesión ha expirado");
                  request.setAttribute("descripcionError","Por motivos de seguridad la aplicación ha cancelado la sesión actual por inactividad."+
                		  								  "\nFavor cierre la ventana e intente nuevamente.");
                  request.getRequestDispatcher(pagina).forward(request,response);//context
                  return;
            } else {
                  cat.debug("Session existente");
                  /*
                  ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO) session
                             .getAttribute("ClienteOSSesionDTO");
                  */
                  ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO) session
                  .getAttribute("ClienteOOSS");
                  if (sessionData == null) {
                      String pagina = this.errorPage;
                      cat.debug("Redireccionando a pagina de error[" + pagina + "]");
                      request.setAttribute("tituloError","La Sesión ha expirado");
                      request.setAttribute("descripcionError","Por motivos de seguridad la aplicación ha cancelado la sesión actual por inactividad."+
                    		  								  "\nFavor cierre la ventana e intente nuevamente.");
                      request.getRequestDispatcher(pagina).forward(request,response);//context
                      return;
                  }
            }
 
            chain.doFilter(request, response);
            cat.debug("doFilter():end");
      }
 
      public void init(FilterConfig filterConfig) throws ServletException {
            cat.debug("init():start");
            this.errorPage = filterConfig.getInitParameter("errorPage");
            cat.debug("init():end");
      }
 
}
