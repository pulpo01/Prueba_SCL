/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongteservice.srv;
import java.util.ArrayList;
import java.util.Iterator;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class BloqueoDTOServiceImpl implements BloqueoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(BloqueoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.BloqueoDTODAO bloqueoDTODAO = new com.tmmas.gte.integraciongtebo.dao.BloqueoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 			auditoriaDAO			= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();


	public BloqueoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO consultarBloqueoTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarBloqueoTelefono:start()");
		logger.info("consultarBloqueoTelefono:antes()");
		logger.info("declaracion de variables para el metodo consultarFacturasPorCliente");
		BloqueoInDTO bloqueoInDTO = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;         
		BloqueoResponseDTO  bloqueoResponseFinal = new BloqueoResponseDTO();
		RespuestaDTO nuevaRespuesta = null;
		Global global = Global.getInstance();
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		logger.info("fin de la declaraciones de variables para el metodo consultarFacturasPorCliente");
		// Realizando Proceso de Auditoria 
		// Validación de Punto Acceso
			codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
			logger.info("validarPuntoAcceso:start()");
			logger.info("validarPuntoAcceso:antes()");
			PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
			logger.info("validarPuntoAcceso:despues()");
			logger.info("validarPuntoAcceso:end()");
			if (puntoAcceso.getRespuesta().getCodigoError()!=0)
			{
				bloqueoResponseFinal.setRespuesta(puntoAcceso.getRespuesta());
				return bloqueoResponseFinal;
			}
		// Fin Validación de Punto Acceso
		// Validación de Cod. Aplicacion
			codAplicacionDto.setCodAplicacion(inParam0.getAuditoria().getCodAplicacion());
			if ((codAplicacionDto.getCodAplicacion()!=null)&&!(codAplicacionDto.getCodAplicacion()).equals(""))
			{
				logger.info("validarAplicacion:start()");
				logger.info("validarAplicacion:antes()");
				com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO aplicacionValidada =  auditoriaDAO.validarAplicacion(codAplicacionDto);
				logger.info("validarAplicacion:despues()");
				logger.info("validarAplicacion:end()");
				if (aplicacionValidada.getCodigoError()!=0)
				{
					bloqueoResponseFinal.setRespuesta(aplicacionValidada);
					return bloqueoResponseFinal;
				}
			}
		// Fin validación de Cod. Aplicacion
		// Validación de Cod. Servicio
			codServicioDto.setCodServicio(inParam0.getAuditoria().getCodServicio());
			logger.info("validarServicio:start()");
			logger.info("validarServicio:antes()");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO servicioValidado =  auditoriaDAO.validarServicio(codServicioDto);
			logger.info("validarServicio:despues()");
			logger.info("validarServicio:end()");
			if (servicioValidado.getCodigoError()!=0)
			{
				bloqueoResponseFinal.setRespuesta(servicioValidado);
				return bloqueoResponseFinal;
			}
		// Fin Validación de Cod. Servicio
		// Validación de nombre Usuario
			nombreUsuarioDto.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
			logger.info("validarNombreUsuario:start()");
			logger.info("validarNombreUsuario:antes()");
			com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO usuarioValidado =  auditoriaDAO.validarNombreUsuario(nombreUsuarioDto);
			logger.info("validarNombreUsuario:despues()");
			logger.info("validarNombreUsuario:end()");
			if (usuarioValidado.getCodigoError()!=0)
			{
				bloqueoResponseFinal.setRespuesta(usuarioValidado);
				return bloqueoResponseFinal;
			}
		// Fin Validación de nombre Usuario
			
		// Inicio de Registro de auditoría 		
		logger.info("insertarAuditoria:start()");
		logger.info("insertarAuditoria:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO  auditoria =  auditoriaDAO.insertarAuditoria(inParam0.getAuditoria());
		logger.info("insertarAuditoria:despues()");
		logger.info("insertarAuditoria:end()");
		if (auditoria != null && auditoria.getRespuesta()!= null &&  auditoria.getRespuesta().getCodigoError()==0  )
		{
			AuditoriaServicioDTO auditoriaServicioDTO = new AuditoriaServicioDTO();
			auditoriaServicioDTO.setCodAuditoria(auditoria.getCodAuditoria());
			auditoriaServicioDTO.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
			// Inicio de Obtención de Nombres de Campos del DTO de Entrada
			logger.info("ObtenerCampos.getAttributes:start()");
    		logger.info("ObtenerCampos.getAttributes:antes()");
			campos = ObtenerCampos.getAttributes(inParam0.getClass(),inParam0);
			logger.info("ObtenerCampos.getAttributes:despues()");
    		logger.info("ObtenerCampos.getAttributes:end()");
    		// Fin de Obtención de Nombres de Campos del DTO de Entrada
	        Iterator  i = campos.iterator();
	        //Recorrido del ArraylList(obtencion de nombres de Campos) 
	        while(i.hasNext())
	        {	
	        	NombreCamposDTO valorcampos = (NombreCamposDTO)i.next();
	        	
	        		auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        		auditoriaServicioDTO.setValParametro(valorcampos.getValorCampo());
	        		logger.info("insertarServicios:start()");
	        		logger.info("insertarServicios:antes()");
	        		RespuestaDTO servicio =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
	        		logger.info("insertarServicios:despues()");
	        		logger.info("insertarServicios:end()");
					if (servicio != null &&  servicio.getCodigoError()!=0  )
					{
						bloqueoResponseFinal.setRespuesta(servicio);
						return bloqueoResponseFinal;
					}
	       }
	        	       
		}else
		{
			bloqueoResponseFinal.setRespuesta(auditoria.getRespuesta());
			return bloqueoResponseFinal;
		}
		// Fin Proceso de Auditoria 
		
		
		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abanado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoClientes() != null 
		     	   && datosAbonados.getListadoClientes().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoClientes().length; i++){
			     			abonado = datosAbonados.getListadoClientes()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo :consultarAbonadoTelefono");
		logger.info("cerrando AbonadoImpl");		
		
		logger.info("construción para obtener los datos del Bloqueo");
		  if(abonado != null && abonado.getCodCliente()!=0 ){
			  bloqueoResponseFinal = new BloqueoResponseDTO();
			  if(abonado.getTipAbonado() != null && abonado.getTipAbonado().equals(global.getValor("factura.consultarFacturasPorCliente.tipPospago"))){ 
				 logger.info("construción para obtener los datos del Bloqueo de un abonado pospago");
				 bloqueoInDTO = new BloqueoInDTO();
				 bloqueoInDTO.setCodAbonado(abonado.getNumAbonado());
				 BloqueoDTO obtener = bloqueoDTODAO.consultarBloqueoTelefonoPospago(bloqueoInDTO);
				 logger.info("construción del objeto de respueta para le cliente");
				 if(obtener != null && obtener.getRespuesta() != null && obtener.getRespuesta().getCodigoError() == 0){
					 ArrayList listaPospago = new ArrayList();
					 listaPospago.add(obtener);
					 bloqueoResponseFinal.setLstListadoBloqueos((com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO[])
								com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaPospago.toArray(),
										com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO.class));
					 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
				 }else{
					 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
				 }
				 logger.info("construción del objeto de respueta para le cliente");
				 logger.info("termina de obtener los datos del Bloqueo de un abonado pospago");  
			  }else if(abonado.getTipAbonado() != null && abonado.getTipAbonado().equals(global.getValor("factura.consultarFacturasPorCliente.tipPrepago"))){
				 logger.info("construción para obtener los datos del Bloqueo de un abonado prepago");
				 bloqueoInDTO = new BloqueoInDTO();
				 bloqueoInDTO.setCodAbonado(abonado.getNumAbonado());
				 BloqueoDTO obtener = bloqueoDTODAO.consultarBloqueoTelefonoPrepago(bloqueoInDTO);
				 logger.info("construción del objeto de respueta para le cliente");
				 if(obtener != null && obtener.getRespuesta() != null && obtener.getRespuesta().getCodigoError() == 0){
					 ArrayList listaPospago = new ArrayList();
					 listaPospago.add(obtener);
					 bloqueoResponseFinal.setLstListadoBloqueos((com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO[])
								com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaPospago.toArray(),
										com.tmmas.gte.integraciongtecommon.dto.BloqueoDTO.class));
					 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
				 }else{
					 bloqueoResponseFinal.setRespuesta(obtener.getRespuesta());
				 }
				 logger.info("construción del objeto de respueta para le cliente");
				 logger.info("termina de obtener los datos del Bloqueo de un abonado prepago");  
			  }else{
					nuevaRespuesta = new RespuestaDTO();
					nuevaRespuesta.setCodigoError(-1);
					nuevaRespuesta.setMensajeError("El Número teléfono no es pospago ni prepago");
					if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() == -1 ){
					    nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
					}
					bloqueoResponseFinal.setRespuesta(nuevaRespuesta);				  
			  }
		  }else{
			    bloqueoResponseFinal = new BloqueoResponseDTO();
				nuevaRespuesta = new RespuestaDTO();
				nuevaRespuesta.setCodigoError(-1);
				nuevaRespuesta.setMensajeError("El Número teléfono no es pospago ni prepago");
				if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() == -1 ){
				    nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
				}
				bloqueoResponseFinal.setRespuesta(nuevaRespuesta);
		  }
		logger.info("terminar para obtener los datos del Bloqueo");
		
		
		logger.info("consultarBloqueoTelefono:despues()");
		logger.info("consultarBloqueoTelefono:end()");
		return bloqueoResponseFinal;
	}

}