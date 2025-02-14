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
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribPedidoDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class DistribuidorDTOServiceImpl implements DistribuidorDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(DistribuidorDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.DistribuidorDTODAO distribuidorDTODAO = new com.tmmas.gte.integraciongtebo.dao.DistribuidorDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	
	public DistribuidorDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	
	/**
	* Retorna los Datos del Distribuidor asociado al Código de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consultarDatosDistribuidor(com.tmmas.gte.integraciongtecommon.dto.ConsDistribuidorInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		DistribuidorDTO distribuidorIn 			= new DistribuidorDTO();
		DistribuidorResponseDTO respDistrib		= new DistribuidorResponseDTO();
		RespuestaDTO 	respuesta 				= new RespuestaDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consDatosDistrib:start()");
		logger.info("consDatosDistrib:antes()");
		
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
				respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
				respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
				respDistrib.setRespuesta(respuesta);
				return respDistrib;
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
					respDistrib.setRespuesta(aplicacionValidada);
					return respDistrib;
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
				respDistrib.setRespuesta(servicioValidado);
				return respDistrib;
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
				respDistrib.setRespuesta(usuarioValidado);
				return respDistrib;
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
						respuesta.setCodigoError(servicio.getCodigoError());
						respuesta.setMensajeError(servicio.getMensajeError());
						respuesta.setNumeroEvento(servicio.getNumeroEvento());
						respDistrib.setRespuesta(respuesta);
						return respDistrib;
					}
		        }	
			}else
			{
				respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
				respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
				respDistrib.setRespuesta(respuesta);
				return respDistrib;
			}
		//Fin de Registro de auditoría 		
		
		distribuidorIn.setCodDistribuidor(inParam0.getCodDistribuidor());
		com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO outParam0 = distribuidorDTODAO.consDatosDistrib(distribuidorIn);
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			respDistrib.setNomVendedor(outParam0.getNomVendedor());
			respDistrib.setCodTipident(outParam0.getCodTipident());
			respDistrib.setDesTipident(outParam0.getDesTipident());
			respDistrib.setNumIdent(outParam0.getNumIdent());
			respDistrib.setCodTipContrato(outParam0.getCodTipContrato());
			respDistrib.setDesTipContrato(outParam0.getDesTipContrato());
			respDistrib.setNumContrato(outParam0.getNumContrato());
			respDistrib.setNumAnexo(outParam0.getNumAnexo());
			respDistrib.setFecContrato(outParam0.getFecContrato());
			respDistrib.setCodCliente(outParam0.getCodCliente());
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			respDistrib.setRespuesta(respuesta);
			
			logger.info("consBodegasDistrib:start()");
			logger.info("consBodegasDistrib:antes()");
			com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO outParam1 = distribuidorDTODAO.consBodegasDistrib(distribuidorIn);
			logger.info("consBodegasDistrib:despues()");
			logger.info("consBodegasDistrib:end()");
			
			if (outParam1 != null && outParam1.getRespuesta()!= null &&  outParam1.getRespuesta().getCodigoError()==0  ){
				if ( outParam1.getListBodegas() != null && outParam1.getListBodegas().length > 0){
					respDistrib.setBodegasList(outParam1.getListBodegas());
				}else{
					DistribuidorResponseDTO resp = new DistribuidorResponseDTO();
					respuesta.setCodigoError(outParam1.getRespuesta().getCodigoError());
					respuesta.setMensajeError(outParam1.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(outParam1.getRespuesta().getNumeroEvento());
					resp.setRespuesta(respuesta);
					return resp;
				}
			}else{
				DistribuidorResponseDTO resp = new DistribuidorResponseDTO();
				respuesta.setCodigoError(outParam1.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam1.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam1.getRespuesta().getNumeroEvento());
				resp.setRespuesta(respuesta);
				return resp;
			}
		}else{
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			respDistrib.setRespuesta(respuesta);
			return respDistrib;
		}
		logger.info("consDatosDistrib:despues()");
		logger.info("consDatosDistrib:end()");
		return respDistrib;
	}


	/**
	* Retorna los Datos del Distribuidor y datos del Pedido asociados al Código de Distribuidor y Código de Pedido ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consultarDatosDistribuidor(com.tmmas.gte.integraciongtecommon.dto.DistribPedidoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		DistribuidorDTO distribuidorIn 			= new DistribuidorDTO();
		DistribuidorResponseDTO respDistrib		= new DistribuidorResponseDTO();
		DistribPedidoDTO datosPedido			= new DistribPedidoDTO();
		RespuestaDTO 	respuesta 				= new RespuestaDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consDatosDistrib:start()");
		logger.info("consDatosDistrib:antes()");
		
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
				respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
				respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
				respDistrib.setRespuesta(respuesta);
				return respDistrib;
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
					respDistrib.setRespuesta(aplicacionValidada);
					return respDistrib;
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
				respDistrib.setRespuesta(servicioValidado);
				return respDistrib;
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
				respDistrib.setRespuesta(usuarioValidado);
				return respDistrib;
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
						respuesta.setCodigoError(servicio.getCodigoError());
						respuesta.setMensajeError(servicio.getMensajeError());
						respuesta.setNumeroEvento(servicio.getNumeroEvento());
						respDistrib.setRespuesta(respuesta);
						return respDistrib;
					}
		        }	
			}else
			{
				respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
				respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
				respDistrib.setRespuesta(respuesta);
				return respDistrib;
			}
		//Fin de Registro de auditoría 		
		
		distribuidorIn.setCodDistribuidor(inParam0.getCodDistribuidor());
		com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO outParam0 = distribuidorDTODAO.consDatosDistrib(distribuidorIn);
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			respDistrib.setNomVendedor(outParam0.getNomVendedor());
			respDistrib.setCodTipident(outParam0.getCodTipident());
			respDistrib.setDesTipident(outParam0.getDesTipident());
			respDistrib.setNumIdent(outParam0.getNumIdent());
			respDistrib.setCodTipContrato(outParam0.getCodTipContrato());
			respDistrib.setDesTipContrato(outParam0.getDesTipContrato());
			respDistrib.setNumContrato(outParam0.getNumContrato());
			respDistrib.setNumAnexo(outParam0.getNumAnexo());
			respDistrib.setCodCliente(outParam0.getCodCliente());
			respDistrib.setFecContrato(outParam0.getFecContrato());
			distribuidorIn.setCodClienteDistrib(Long.parseLong(outParam0.getCodCliente()));
			distribuidorIn.setCodPedido(inParam0.getCodPedido());
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			respDistrib.setRespuesta(respuesta);
			
			logger.info("consBodegasDistrib:start()");
			logger.info("consBodegasDistrib:antes()");
			com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO outParam1 = distribuidorDTODAO.consBodegasDistrib(distribuidorIn);
			logger.info("consBodegasDistrib:despues()");
			logger.info("consBodegasDistrib:end()");
			
			if (outParam1 != null && outParam1.getRespuesta()!= null &&  outParam1.getRespuesta().getCodigoError()==0  ){
				if ( outParam1.getListBodegas() != null && outParam1.getListBodegas().length > 0){
					respDistrib.setBodegasList(outParam1.getListBodegas());
					
					logger.info("consPedidoDistrib:start()");
					logger.info("consPedidoDistrib:antes()");
					com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO outParam2 = distribuidorDTODAO.consPedidoDistrib(distribuidorIn);
					logger.info("consPedidoDistrib:despues()");
					logger.info("consPedidoDistrib:end()");
					
					if (outParam2 != null && outParam2.getRespuesta()!= null &&  outParam2.getRespuesta().getCodigoError()==0  ){
						datosPedido.setMtoNetoPedido(outParam2.getDatosPedido().getMtoNetoPedido());
						datosPedido.setCantTotalPedido(outParam2.getDatosPedido().getCantTotalPedido());
						datosPedido.setMtoTotalPedido(outParam2.getDatosPedido().getMtoTotalPedido());
						datosPedido.setCodBodega(outParam2.getDatosPedido().getCodBodega());
						datosPedido.setDesBodega(outParam2.getDatosPedido().getDesBodega());
						respDistrib.setDatosPedido(datosPedido);
					}else{
						DistribuidorResponseDTO resp = new DistribuidorResponseDTO();
						respuesta.setCodigoError(outParam2.getRespuesta().getCodigoError());
						respuesta.setMensajeError(outParam2.getRespuesta().getMensajeError());
						respuesta.setNumeroEvento(outParam2.getRespuesta().getNumeroEvento());
						resp.setRespuesta(respuesta);
						return resp;
					}
				}else{
					DistribuidorResponseDTO resp = new DistribuidorResponseDTO();
					respuesta.setCodigoError(outParam1.getRespuesta().getCodigoError());
					respuesta.setMensajeError(outParam1.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(outParam1.getRespuesta().getNumeroEvento());
					resp.setRespuesta(respuesta);
					return resp;
				}
			}else{
				DistribuidorResponseDTO resp = new DistribuidorResponseDTO();
				respuesta.setCodigoError(outParam1.getRespuesta().getCodigoError());
				respuesta.setMensajeError(outParam1.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(outParam1.getRespuesta().getNumeroEvento());
				resp.setRespuesta(respuesta);
				return resp;
			}
		}else{
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			respDistrib.setRespuesta(respuesta);
			return respDistrib;
		}
		logger.info("consDatosDistrib:despues()");
		logger.info("consDatosDistrib:end()");
		return respDistrib;
	}

}