package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import uk.ltd.getahead.dwr.WebContextFactory;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ResultadoSolicitudVentaDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;

public class PlanesAdicionalesAJAX {
	
	private final Logger logger = Logger.getLogger(PlanesAdicionalesAJAX.class);

	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public RetornoValorAjaxDTO obtenerEstadoContratacionPA(){
		logger.debug("obtenerEstadoContratacionPA:inicio()");		
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		String estado = "";
		HttpSession session = WebContextFactory.get().getSession(false);
		if (!SessionHelper.validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		DatosVentaForm datosVentaForm=(DatosVentaForm)session.getAttribute("DatosVentaForm");
		
		try{
			estado = delegate.obtenerEstadoContratacionPA(new Long(datosVentaForm.getNumeroVenta()));
		}catch(VentasException e){
			logger.debug("[VentasException]");
	     	String mensaje = e.getDescripcionEvento()==null?" Ocurrió un error al obtener estado de contratación de planes adicionales":e.getDescripcionEvento(); 
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}catch(Exception e){
			logger.debug("[Exception]");
	     	String mensaje = e.getMessage()==null?" Ocurrió un error al obtener estado de contratación de planes adicionales":e.getMessage(); 
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);	     	
	    }
		retorno.setResultado(estado);	      
		logger.debug("obtenerEstadoContratacionPA:fin()");
		return retorno;	
	}
	
	public RetornoValorAjaxDTO contratarPlanesDefecto(){
		logger.debug("contratarPlanesDefecto:inicio()");		
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		
		HttpSession session = WebContextFactory.get().getSession(false);
		if (!SessionHelper.validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		DatosVentaForm datosVentaForm=(DatosVentaForm)session.getAttribute("DatosVentaForm");
		try{
			DatosVentaDTO datosVenta = new DatosVentaDTO();
			datosVenta.setNum_venta(String.valueOf(datosVentaForm.getNumeroVenta()));
			datosVenta.setCod_cliente(datosVentaForm.getCodCliente());
			datosVenta.setNum_transaccion(String.valueOf(datosVentaForm.getNumeroTransaccionVenta()));
			datosVenta.setNum_evento("0");
			String user = ((ParametrosGlobalesDTO)session.getAttribute("paramGlobal")).getCodUsuario();
			datosVenta.setCod_vendedor(user);
			datosVenta.setFlag_ciclo("0");
			datosVenta.setCod_proceso("VT");
			delegate.sendToQueueActivacionProductosPorDefecto(datosVenta);
		
		}catch(VentasException e){
			logger.debug("[VentasException]");
	     	String mensaje = e.getDescripcionEvento()==null?" Ocurrió un error al contratar planes por defecto":e.getDescripcionEvento(); 
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}catch(Exception e){
			logger.debug("[Exception]");
	     	String mensaje = e.getMessage()==null?" Ocurrió un error al contratar planes por defecto":e.getMessage(); 
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);	     	
	    }
			      
		logger.debug("contratarPlanesDefecto:fin()");
		return retorno;
		
	}
	
	public RetornoValorAjaxDTO recuperaSesionAnterior(String codUsuario,String codOperadora,String versionSistema,
			String tipoEjecucion,String formatoNIT,String codigoIdentificadorNIT,
			String numeroVenta,String codigoCliente,String numeroTransaccionVenta){
		logger.debug("recuperaSesionAnterior:inicio()");		
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		
		HttpSession session = WebContextFactory.get().getSession(false);
		if (!SessionHelper.validarSesion(session)){//sesion invalida se recupera informacion de cliente
			logger.debug("sesion invalida se recupera informacion de cliente");
			if (session == null) {
				logger.debug("Creando session...");
				session = WebContextFactory.get().getSession(true);
			}
			
			ParametrosGlobalesDTO paramGlobal = new ParametrosGlobalesDTO();
			DatosVentaForm datosVentaForm = new DatosVentaForm();
			
			logger.debug("codUsuario desde JS="+codUsuario);
			logger.debug("codOperadora desde JS="+codOperadora);
			logger.debug("versionSistema desde JS="+versionSistema);
			logger.debug("tipoEjecucion desde JS="+tipoEjecucion);
			logger.debug("formatoNIT desde JS="+formatoNIT);
			logger.debug("codigoIdentificadorNIT desde JS="+codigoIdentificadorNIT);
			logger.debug("numeroVenta desde JS="+numeroVenta);
			logger.debug("codigoCliente desde JS="+codigoCliente);
			logger.debug("numeroTransaccionVenta desde JS="+numeroTransaccionVenta);
			
    		paramGlobal.setCodUsuario(codUsuario);
      		paramGlobal.setCodOperadora(codOperadora);
      		paramGlobal.setVersionSistema(versionSistema);
      		paramGlobal.setTipoEjecucion(tipoEjecucion);
      		paramGlobal.setFormatoNIT(formatoNIT);
      		paramGlobal.setCodigoIdentificadorNIT(codigoIdentificadorNIT);
      		datosVentaForm.setNumeroVenta(Long.parseLong(numeroVenta));
      		datosVentaForm.setCodCliente(codigoCliente);
      		datosVentaForm.setNumeroTransaccionVenta(Long.parseLong(numeroTransaccionVenta));
      		
			ResultadoSolicitudVentaDTO resultadoSolVenta = new ResultadoSolicitudVentaDTO();
			resultadoSolVenta.setCodCliente(datosVentaForm.getCodCliente());
			resultadoSolVenta.setNumeroVenta(String.valueOf(datosVentaForm.getNumeroVenta()));

			session.setAttribute("paramGlobal", paramGlobal);
			session.setAttribute("DatosVentaForm", datosVentaForm);
			session.setAttribute("resultadoSolVenta", resultadoSolVenta);	
      		
		}
		logger.debug("recuperaSesionAnterior:fin()");
		return retorno;
	}
}
