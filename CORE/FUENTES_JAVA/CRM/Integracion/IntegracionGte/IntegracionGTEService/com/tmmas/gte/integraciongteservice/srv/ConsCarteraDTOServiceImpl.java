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
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.CarteraDTO;
import com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class ConsCarteraDTOServiceImpl implements ConsCarteraDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ConsCarteraDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.ConsAbonadoPospagoDTODAO consAbonadoPospagoDTODAO  	= new com.tmmas.gte.integraciongtebo.dao.ConsAbonadoPospagoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.CarteraDTODAO 			consCarteraDTODAO 			= new com.tmmas.gte.integraciongtebo.dao.CarteraDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 			auditoriaDAO				= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	
	public ConsCarteraDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}


	public com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO consultarSaldoCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		NumeroTelefonoDTO	 	numeroTelefonoIn 	= new NumeroTelefonoDTO();
		AbonadoPospagoOutDTO	datosClienteOut 	= new AbonadoPospagoOutDTO();
		CodClienteDTO			codigoClienteIn		= new CodClienteDTO();
		CarteraResponseDTO		outParam0			= new CarteraResponseDTO();
		RespuestaDTO			respuesta			= new RespuestaDTO();
		CarteraResponseDTO		saldoCliente		= new CarteraResponseDTO();
		
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();

		logger.info("consultarSaldoCliente:start()");
		logger.info("consultarSaldoCliente:antes()");
		numeroTelefonoIn.setNumeroTelefono(inParam0.getNumeroTelefono());
		
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
				saldoCliente.setRespuesta(respuesta);
				return saldoCliente;
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
					saldoCliente.setRespuesta(aplicacionValidada);
					return saldoCliente;
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
				saldoCliente.setRespuesta(servicioValidado);
				return saldoCliente;
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
				saldoCliente.setRespuesta(usuarioValidado);
				return saldoCliente;
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
					saldoCliente.setRespuesta(respuesta);
					return saldoCliente;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			saldoCliente.setRespuesta(respuesta);
			return saldoCliente;
		}
		//Fin de Registro de auditoría 				

		
		/**
		* Retorna numAbonado y codCliente a partir de un numero Telefono
		*/
		logger.info("consultarCliePospago:start()");
		logger.info("consultarCliePospago:antes()");
		datosClienteOut = consAbonadoPospagoDTODAO.consultarAbonadoPospago(numeroTelefonoIn);
		logger.info("consultarCliePospago:despues()");
		logger.info("consultarCliePospago:end()");
		
		if (datosClienteOut != null && datosClienteOut.getRespuesta()!= null &&  datosClienteOut.getRespuesta().getCodigoError()==0 ){
			if (datosClienteOut.getListadoClientes().length > 0 ){
				codigoClienteIn.setCodCliente(datosClienteOut.getListadoClientes()[0].getCodCliente());
				
				/**
				* Retorna Saldo Total de un Cliente a partir de un codCliente
				*/
				logger.info("obtenerSaldoCliente:start()");
				logger.info("obtenerSaldoCliente:antes()");
				outParam0 = consCarteraDTODAO.obtenerSaldoCliente(codigoClienteIn);
				logger.info("obtenerSaldoCliente:despues()");
				logger.info("obtenerSaldoCliente:end()");
				
				if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
					CarteraDTO cartera = new CarteraDTO();
					cartera.setSaldoCliente(outParam0.getCarteraCliente().getSaldoCliente());
					saldoCliente.setCarteraCliente(cartera);
					respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
					respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
					saldoCliente.setRespuesta(respuesta);
				}else{
					respuesta.setCodigoError(-1);
					respuesta.setMensajeError("No fue posible obtener el saldo total del cliente");
					respuesta.setNumeroEvento(0);
					saldoCliente.setRespuesta(respuesta);
				}
				
			}else {
				respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
				respuesta.setMensajeError("No fue posible obtener el saldo total del cliente");
				respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
				saldoCliente.setRespuesta(respuesta);
			}
		}else {
			respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
			respuesta.setMensajeError("No fue posible obtener el saldo total del cliente");
			respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
			saldoCliente.setRespuesta(respuesta);
		}
		logger.info("consultarSaldoCliente:despues()");
		logger.info("consultarSaldoCliente:end()");
		return saldoCliente;
	}
}