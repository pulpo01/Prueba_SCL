package com.tmmas.cl.scl.portalventas.web.helper;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.jdom.Element;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CabeceraArchivoDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.CargoDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.ParametrosSeleccionadosDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.RegCargosDTO;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.SolicitudAutorizacionDescuentoDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CargoXMLDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroCargosDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.DatosVentaDTO;

public class CargosAJAX {
	private final Logger logger = Logger.getLogger(CargosAJAX.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();
	
	public String consultaResultadoSolicitud() throws Exception {
		logger.debug("consultaResultadoSolicitud:inicio()");
		
		HttpSession session = WebContextFactory.get().getSession(false);
		
		if (!validarSesion(session)){
			return "-100";	
		}
		
		String resultado = (String)session.getAttribute("autorizacion");
		
		logger.debug("consultaResultadoSolicitud:fin()");
		return resultado;
	}
	
	public String grabaListadoDescuento(String xml) throws Exception{
		
		logger.debug("grabaListadoDescuento:inicio()");
		try {
			
			HttpSession session = WebContextFactory.get().getSession(false);
			
			if (!validarSesion(session)){
				return "-100";	
			}
			session.removeAttribute("textoXMLDescuento");
			session.setAttribute("textoXMLDescuento",xml);
			logger.debug("xml descuento:" + xml);
			
		} catch (Exception e) {
			logger.debug("grabaListadoDescuento():end");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}
		logger.debug("grabaListadoDescuento:fin()");		
		return xml;
	}
	
	public SolicitudAutorizacionDescuentoDTO generaSolicitud() throws Exception
	{
		logger.debug("generaSolicitud:start()");
		SolicitudAutorizacionDescuentoDTO resultado = null;
		try {
			
			HttpSession session = WebContextFactory.get().getSession(false);
			
			if (!validarSesion(session)){
				//resultado.setCodError("-100");
				//resultado.setMsgError("Su sesión ha expirado");
				resultado =  new SolicitudAutorizacionDescuentoDTO();
				resultado.setCodigoEstado("-100");
				return resultado;	
			}
			
			List listaCargosDescFueraRango = new ArrayList();
			String estadoSol = (String)session.getAttribute("autorizacion");
			
			String textoXML = (String)session.getAttribute("textoXMLDescuento");
			CargoXMLDTO[] cargosVenta =  (CargoXMLDTO[]) session.getAttribute("Cargos") ;
			
			TraspasoXMLDescuentoDTO manejoXML = new TraspasoXMLDescuentoDTO();
			CargoXMLDTO[] cargosVenta2 = manejoXML.retornaCamposDetalleFormatoSalidaXML(textoXML);
			
			if (estadoSol ==null || estadoSol.equals("OK")){
				logger.debug("entro estadoSol");
				if (cargosVenta !=null ){
					for (int i=0;i<cargosVenta.length;i++){
				    	if (cargosVenta2[i].getInfringeRangoDescuento().equals("true")){
				    		cargosVenta[i].setTipoDescuentoManual(cargosVenta2[i].getTipoDescuentoManual());
				    		cargosVenta[i].setMontoDescuentoManual(cargosVenta2[i].getMontoDescuentoManual());
				    		listaCargosDescFueraRango.add(cargosVenta[i]);
				    	}
				    }
				}
				
				CargoXMLDTO[] cargosDescFueraRango = null;
				CargoDTO[] cargosDescFueraRangoAux = null;
			    if (!listaCargosDescFueraRango.isEmpty()){
			    	cargosDescFueraRango =(CargoXMLDTO[])ArrayUtl.copiaArregloTipoEspecifico(listaCargosDescFueraRango.toArray(), CargoXMLDTO.class);
			    	
			    	cargosDescFueraRangoAux =  new CargoDTO[listaCargosDescFueraRango.size()];
			    	for(int i=0; i<cargosDescFueraRango.length;i++){
			    		CargoDTO cargoAux= new CargoDTO();
			    		cargoAux.setCodigoConceptoPrecio(cargosDescFueraRango[i].getCodigoConceptoPrecio());
			    		cargoAux.setMontoConceptoPrecio((new Float(cargosDescFueraRango[i].getMontoConceptoPrecio())).floatValue());
			    		cargoAux.setCodigoMoneda(cargosDescFueraRango[i].getCodigoMoneda());
			    		cargoAux.setCodigoDescuento(cargosDescFueraRango[i].getCodigoDescuento());
			    		cargoAux.setTipoDescuento(cargosDescFueraRango[i].getTipoDescuento());
			    		cargoAux.setMontoDescuento((new Float(cargosDescFueraRango[i].getMontoDescuento())).floatValue());
			    		cargoAux.setMontoDescuentoManual((new Float(cargosDescFueraRango[i].getMontoDescuentoManual())).floatValue());
			    		cargoAux.setTipoDescuentoManual(cargosDescFueraRango[i].getTipoDescuentoManual());
			    		cargoAux.setCantidad(cargosDescFueraRango[i].getCantidad());
			    		cargoAux.setNumCargo(cargosDescFueraRango[i].getNumCargo());
			    		
			    		cargosDescFueraRangoAux[i] = cargoAux;
			    	}
	                	 
	                
			    }
			    
			    RegCargosDTO regCargos = new RegCargosDTO();
			    CabeceraArchivoDTO cabecera = new CabeceraArchivoDTO();
			    
			    VentaAjaxDTO ventaAjaxDTO = (VentaAjaxDTO)session.getAttribute("ventaSel");
			    
			    //Obtener informacion de cabecera
			    if (ventaAjaxDTO !=null){
			    	cabecera.setNumeroVenta(Long.parseLong(ventaAjaxDTO.getNroVenta()));
			    	cabecera.setOficinaVendedor(ventaAjaxDTO.getCodOficina());
			    	cabecera.setCodigoVendedor(ventaAjaxDTO.getCodVendedor());
			    	cabecera.setIndicadorTipoVenta(ventaAjaxDTO.getIndTipoVenta());
			    	cabecera.setCodigoCliente(ventaAjaxDTO.getCodCliente());
			    	
				   	ParametrosSeleccionadosDTO param = new ParametrosSeleccionadosDTO();
					ModalidadPagoDTO modPago = new ModalidadPagoDTO();
					modPago.setCodigoModalidadPago(ventaAjaxDTO.getCodModVenta());
					param.setModalidadPagoDTO(modPago);
			    	cabecera.setParametros(param);// codigo de modalidad de pago
					String user = ((ParametrosGlobalesDTO)session.getAttribute("paramGlobal")).getCodUsuario();
			    	cabecera.setNombreUsuario(user);
			    	
			    }
			    
			    regCargos.setObjetoSesion(cabecera);
			    //regCargos.setCargos(cargosDescFueraRango);
			    regCargos.setCargos(cargosDescFueraRangoAux);
			    
			    session.removeAttribute("solicitudDTO");
			    SolicitudAutorizacionDescuentoDTO solicitud = delegate.solicitarAprobaciones(regCargos);
			    session.setAttribute("solicitudDTO",solicitud);
			    resultado = solicitud;
			    session.setAttribute("autorizacion","NOK");
			   
			}else{
				SolicitudAutorizacionDescuentoDTO solicitud = (SolicitudAutorizacionDescuentoDTO)session.getAttribute("solicitudDTO");
				session.setAttribute("solicitudDTO",solicitud);
				resultado = solicitud;
				
			}
			
		} catch (Exception e) {
			logger.debug("generaSolicitud():end");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}
		return resultado;
	}
	
	public SolicitudAutorizacionDescuentoDTO consultaEstadoSolicitud(String numeroAutorizacion) throws Exception
	{
		logger.debug("consultaEstadoSolicitud:inicio()");
		SolicitudAutorizacionDescuentoDTO solicitud = new  SolicitudAutorizacionDescuentoDTO();
		HttpSession session = WebContextFactory.get().getSession(false);
		if (!validarSesion(session)){
			solicitud.setCodigoEstado("-100");
			return solicitud;	
		}
		
		
		solicitud.setNumeroAutorizacion(numeroAutorizacion==null?0:Long.parseLong(numeroAutorizacion));
	
		try {
			solicitud = delegate.consultaEstadoSolicitud(solicitud);
			logger.debug("consultaEstadoSolicitud:end()");
			
			if (solicitud !=null){
				if (solicitud.getCodigoEstado()!=null && 
					solicitud.getCodigoEstado().equals("AU")){
					
					session.removeAttribute("autorizacion");
					session.setAttribute("autorizacion","OK");
				}
			}
			
		} catch (Exception e) {
			logger.debug("consultaEstadoSolicitud():end");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			
		}
		
		logger.debug("consultaEstadoSolicitud:fin()");
		
		return solicitud;
	}
	
	public void registrarCargosInstalacion(String importe,String numAbonado)throws Exception{
		logger.debug("registrarCargosInstalacion:inicio()");
		try{
			HttpSession session = WebContextFactory.get().getSession(false);
			if (!validarSesion(session)){
				return;	
			}
			RegistroCargosDTO cargosInstalacionDTO = new RegistroCargosDTO();
			cargosInstalacionDTO.setImporteCargo(Float.parseFloat(importe));
			cargosInstalacionDTO.setNum_abonado(Long.valueOf(numAbonado));
			VentaAjaxDTO ventaAjaxDTO= (VentaAjaxDTO)session.getAttribute("ventaSel");
			String user = ((ParametrosGlobalesDTO)session.getAttribute("paramGlobal")).getCodUsuario();
			cargosInstalacionDTO.setNombreUsuario(user);
			cargosInstalacionDTO.setCodigoCliente(ventaAjaxDTO.getCodCliente());
			cargosInstalacionDTO.setNumeroVenta(Long.parseLong(ventaAjaxDTO.getNroVenta()));
			cargosInstalacionDTO.setCodOficina(ventaAjaxDTO.getCodOficina());
			delegate.registrarCargosInstalacion(cargosInstalacionDTO);
		}
		catch(Exception e){
			logger.debug("registrarCargosInstalacion():Exception");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
		}
		logger.debug("registrarCargosInstalacion:fin()");
	}
	
	public RetornoValorAjaxDTO actualizarEstadoAbonado(long numAbonado, String codSituacion){
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		
		if (!validarSesion(sesion)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumAbonado(numAbonado);
		abonado.setCodSituacion(codSituacion);
		try{
			delegate.updCodigoSituacionAbo(abonado);
		}catch(VentasException e){
	     	String mensaje = e.getDescripcionEvento()==null?" Ocurrio un error al actualizar estado":e.getDescripcionEvento(); 
	     	logger.debug("[VentasException]"+mensaje );
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);	
		}catch(Exception e){
	     	String mensaje = e.getMessage()==null?" Ocurrio un error al actualizar estado":e.getMessage(); 
	     	logger.debug("[Exception]"+mensaje );	     	
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);		     	
	    }
		return retorno;
	}
	
	private boolean validarSesion(HttpSession sesion){

		if (sesion == null)	return false;
			
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal"); 
		if (sessionData == null) return false;
		
		return true;
	}	
	
	public RetornoValorAjaxDTO registrarWimaxMacAddress(String wimaxMacAddress,long numAbonado)throws Exception{
		logger.debug("registrarWimaxMacAddress:inicio");	
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);		
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		
		if (!validarSesion(session)){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;	
		}
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumAbonado(numAbonado);
		abonado.setWimaxMacAddress(wimaxMacAddress);
		try{
			delegate.updWimaxMacAddress(abonado);
		}catch(VentasException e){
	     	String mensaje = e.getDescripcionEvento()==null?" currió un error al actualizar la IP Mac Addrees (Wimax)":e.getDescripcionEvento(); 
	     	logger.debug("[VentasException]"+mensaje );	
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);	
		}catch(Exception e){
	     	String mensaje = e.getMessage()==null?" currió un error al actualizar la IP Mac Addrees (Wimax)":e.getMessage(); 
	     	logger.debug("[Exception]"+mensaje );	     	
        	retorno.setCodError("1");
			retorno.setMsgError(mensaje);			     	
	    }
		logger.debug("registrarWimaxMacAddress:fin");
		return retorno;
	}

}
