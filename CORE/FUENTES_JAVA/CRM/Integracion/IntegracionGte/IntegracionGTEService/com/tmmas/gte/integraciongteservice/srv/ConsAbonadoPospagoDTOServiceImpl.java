/**
* @author Alejandro Lorca
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
import com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsCicloFactDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsClieFacturableDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class ConsAbonadoPospagoDTOServiceImpl implements ConsAbonadoPospagoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ConsAbonadoPospagoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.ConsAbonadoPospagoDTODAO consAboPospagoDTODAO = new com.tmmas.gte.integraciongtebo.dao.ConsAbonadoPospagoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.FacturaDTODAO facturaDTODAO = new com.tmmas.gte.integraciongtebo.dao.FacturaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ClienteDTODAO clienteDTODAO = new com.tmmas.gte.integraciongtebo.dao.ClienteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	
	public ConsAbonadoPospagoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	
	/**
	* Valida Numero de Telefono Pospago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarNumPospago(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		NumeroTelefonoDTO 		numeroPospago 			= new NumeroTelefonoDTO();
		AbonadoPospagoOutDTO 	datosCliente			= new AbonadoPospagoOutDTO();
		ConsAbonadoPospagoDTO 	clientePospagoParametro = new ConsAbonadoPospagoDTO();
		CodClienteDTO 			consCodCiclo 			= new CodClienteDTO();
		ConsCicloFactDTO 		consCicloFact 			= new ConsCicloFactDTO();
		ConsClieFacturableDTO 	consClieFacturable 		= new ConsClieFacturableDTO();
		RespBooleanDTO 			respBoolean 			= new RespBooleanDTO();
		RespBooleanDTO			respuestaBoolean		= new RespBooleanDTO();
		RespuestaDTO 			respuesta 				= new RespuestaDTO();
		DatosLstCliCliDTO		codClienteDTO			= new DatosLstCliCliDTO();
		LstDatosCliNitDTO       codCicloDTO				= new LstDatosCliNitDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();
		
		logger.info("validarAbonadoPospago:start()");
		logger.info("validarAbonadoPospago:antes()");
		
		numeroPospago.setNumeroTelefono(inParam0.getNumeroTelefono());
		
		
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
				respBoolean.setRespuesta(respuesta);
				return respBoolean;
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
					respBoolean.setRespuesta(aplicacionValidada);
					return respBoolean;
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
				respBoolean.setRespuesta(servicioValidado);
				return respBoolean;
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
				respBoolean.setRespuesta(usuarioValidado);
				return respBoolean;
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
					respBoolean.setRespuesta(respuesta);
					return respBoolean;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			respBoolean.setRespuesta(respuesta);
			return respBoolean;
		}
		//Fin de Registro de auditoría 		
		
		/**
		* Retorna numAbonado y codCliente a partir de un numCelular pospago
		*/
		logger.info("consultarAbonadoPospago:start()");
		logger.info("consultarAbonadoPospago:antes()");
		datosCliente = consAboPospagoDTODAO.consultarAbonadoPospago(numeroPospago);
		logger.info("consultarAbonadoPospago:despues()");
		logger.info("consultarAbonadoPospago:end()");
		
		if (datosCliente != null && datosCliente.getRespuesta()!= null &&  datosCliente.getRespuesta().getCodigoError()==0  ){
			if (datosCliente.getListadoClientes()!=null&&datosCliente.getListadoClientes().length>0){
				consClieFacturable.setNumAbonado(datosCliente.getListadoClientes()[0].getNumAbonado());
				consClieFacturable.setCodCliente(datosCliente.getListadoClientes()[0].getCodCliente());	
				codClienteDTO.setCodCliente(consClieFacturable.getCodCliente());
								
				/**
				* Retorna codCiclo a partir de un codCliente pospago
				*/
				logger.info("consultarDatosCliente:start()");
				logger.info("consultarDatosCliente:antes()");
				codCicloDTO = clienteDTODAO.consultarDatosCliente(codClienteDTO);
				logger.info("consultarDatosCliente:despues()");
				logger.info("consultarDatosCliente:end()");
				if (codCicloDTO != null && codCicloDTO.getRespuesta()!= null &&  codCicloDTO.getRespuesta().getCodigoError()==0  ){
					consCicloFact.setCodCiclo(codCicloDTO.getListadoClientes()[0].getCodCiclo());
					/**
					* Retorna codCicloFact a partir de un codCiclo pospago
					*/
					logger.info("consultarCicloFact:start()");
					logger.info("consultarCicloFact:antes()");
					clientePospagoParametro = facturaDTODAO.consultarCicloFact(consCicloFact);
					logger.info("consultarCicloFact:despues()");
					logger.info("consultarCicloFact:end()");
					if (clientePospagoParametro != null && clientePospagoParametro.getRespuesta()!= null &&  clientePospagoParametro.getRespuesta().getCodigoError()==0  ){
						consClieFacturable.setCodCicloFact(clientePospagoParametro.getCodCicloFact());
						/**
						* Consulta si Cliente es Facturable
						*/
						logger.info("validarClieFacturable:start()");
						logger.info("validarClieFacturable:antes()");
						respuestaBoolean = clienteDTODAO.validarClieFacturable(consClieFacturable);
						logger.info("validarClieFacturable:despues()");
						logger.info("validarClieFacturable:end()");
						if (respuestaBoolean != null && respuestaBoolean.getRespuesta()!= null &&  respuestaBoolean.getRespuesta().getCodigoError()==0  ){
							respBoolean.setRespBoolean(true);
							respuesta.setCodigoError(respuestaBoolean.getRespuesta().getCodigoError());
							respuesta.setMensajeError(respuestaBoolean.getRespuesta().getMensajeError());
							respuesta.setNumeroEvento(respuestaBoolean.getRespuesta().getNumeroEvento());
							respBoolean.setRespuesta(respuesta);
						}else{
							respBoolean.setRespBoolean(false);
							respuesta.setMensajeError(respuestaBoolean.getRespuesta().getMensajeError());
							respuesta.setCodigoError(-1);
							respuesta.setNumeroEvento(respuestaBoolean.getRespuesta().getNumeroEvento());
							respBoolean.setRespuesta(respuesta);
						}
					}else{
						
						respBoolean.setRespBoolean(false);
						respuesta.setMensajeError(clientePospagoParametro.getRespuesta().getMensajeError());
						respuesta.setCodigoError(-1);
						respuesta.setNumeroEvento(clientePospagoParametro.getRespuesta().getNumeroEvento());
						respBoolean.setRespuesta(respuesta);
					}
				} else{
					respBoolean.setRespBoolean(false);
					respuesta.setMensajeError(clientePospagoParametro.getRespuesta().getMensajeError());
					respuesta.setCodigoError(-1);
					respuesta.setNumeroEvento(clientePospagoParametro.getRespuesta().getNumeroEvento());
					respBoolean.setRespuesta(respuesta);
				}
			}else{
				
				respBoolean.setRespBoolean(false);
				respuesta.setMensajeError(datosCliente.getRespuesta().getMensajeError());
				respuesta.setCodigoError(datosCliente.getRespuesta().getCodigoError());
				respuesta.setNumeroEvento(datosCliente.getRespuesta().getNumeroEvento());
				respBoolean.setRespuesta(respuesta);
			}	
		}else{
			respBoolean.setRespBoolean(false);
			respuesta.setMensajeError(datosCliente.getRespuesta().getMensajeError());
			respuesta.setCodigoError(datosCliente.getRespuesta().getCodigoError());
			respuesta.setNumeroEvento(datosCliente.getRespuesta().getNumeroEvento());
			respBoolean.setRespuesta(respuesta);
		}
		logger.info("validarAbonadoPospago:despues()");
		logger.info("validarAbonadoPospago:end()");
		return respBoolean;
	}

}