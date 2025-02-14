package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.log4j.Category;



public class CapturaCierreSesion implements HttpSessionListener {

	private Category cat = Category.getInstance(CapturaCierreSesion.class);
	public void sessionCreated(HttpSessionEvent arg0) {
		

	}
	public void sessionDestroyed(HttpSessionEvent arg0) {
		/*DireccionDelegate delegate = DireccionDelegate.getInstance();
		try{
			ServletContext contexto = arg0.getSession().getServletContext();
			HttpSession session = arg0.getSession();
			synchronized (contexto) {
				DireccionNegocioDTO[] direccionNegocioDTOs = 
					(DireccionNegocioDTO[])session.getAttribute("direccionesReg");
				if (direccionNegocioDTOs != null) {
					for (int i=0;i<direccionNegocioDTOs.length;i++){
						if (direccionNegocioDTOs[i]!=null){
							//delegate.eliminaDireccion(direccionNegocioDTOs[i]);
						}
					}
				}
					
			}
			
		}/*catch(DireccionException e){
			cat.debug("sessionDestroyed():end");
			cat.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
		}		*/
		/*catch (Exception e) {
			cat.debug("sessionDestroyed():end");
			cat.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
		}*/
	
	}
	
}

