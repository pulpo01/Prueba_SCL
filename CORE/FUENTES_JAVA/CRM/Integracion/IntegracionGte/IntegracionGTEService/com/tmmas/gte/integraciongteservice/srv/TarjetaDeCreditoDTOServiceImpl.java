/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongteservice.srv;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Date;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;
import com.tmmas.gte.integraciongteservice.helper.Util;

public class TarjetaDeCreditoDTOServiceImpl implements TarjetaDeCreditoDTOService{
	private CompositeConfiguration config;
	public static final String FORMATO_FECHA_ESPAÑOL = "dd-MM-yyyy"; 
	public static final String FORMATO_FECHA_INGLES = "yyyyMMdd";	
	private static Logger logger = Logger.getLogger(TarjetaDeCreditoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 		auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.TarjetaDeCreditoDTODAO tarjetaDeCreditoDTODAO = new com.tmmas.gte.integraciongtebo.dao.TarjetaDeCreditoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDTODAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();

	public TarjetaDeCreditoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	

	/**
	* Servicio que permite el registro de los datos asociados a una tarjeta de crédito para el pago automático de cuentas
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO registrarDatosTarjCredito(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoInDTO inParam0)
			throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		RespBooleanDTO  respBoolean 		= new RespBooleanDTO();
		RespuestaDTO 	respuesta 			= new RespuestaDTO();
		EsTelefIgualClieDTO datosClienteIn  = new EsTelefIgualClieDTO();
		AbonadoOutDTO 	datosClienteOut		= new AbonadoOutDTO();
		TarjetaDeCreditoDTO datosTarjeta	= new TarjetaDeCreditoDTO();
		AuditoriaDTO	codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 		campos				= new ArrayList();
		Util			util				= new Util();
		Global global = Global.getInstance();
		
		logger.info("registrarDatosTarjCredito:start()");
		logger.info("registrarDatosTarjCredito:antes()");
		
		
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
		
		datosClienteIn.setNum_telefono1(inParam0.getNumTelefono());
		/**
		* Retorna numAbonado y codCliente a partir de un numero de Telefono
		*/
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		datosClienteOut = abonadoDTODAO.consultarAbonadoTelefono(datosClienteIn);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		
		if (datosClienteOut != null && datosClienteOut.getRespuesta()!= null &&  datosClienteOut.getRespuesta().getCodigoError()==0  ){
			if (datosClienteOut.getListadoAbonados()!=null&&datosClienteOut.getListadoAbonados().length>0){
				
				datosTarjeta.setCodTipTarjeta(inParam0.getCodTipTarjeta());
				datosTarjeta.setNumeroTarjeta(inParam0.getNumeroTarjeta());
				datosTarjeta.setCodCliente(datosClienteOut.getListadoAbonados()[0].getCodCliente());
				
				/**
				* Valida que el número de tarjeta de crédito que se ha ingresado sea un número válido
				*/
				logger.info("validarNumTarjCredito:start()");
				logger.info("validarNumTarjCredito:antes()");
				com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam0 = tarjetaDeCreditoDTODAO.validarNumTarjCredito(datosTarjeta);
				logger.info("validarNumTarjCredito:despues()");
				logger.info("validarNumTarjCredito:end()");
				
				if (outParam0 != null && outParam0.getCodigoError() == 0){
					
					Date fechaActual = new Date();
					
					String fechaString = util.fechaStringTOfechaString(TarjetaDeCreditoDTOServiceImpl.FORMATO_FECHA_INGLES, inParam0.getFechaVencTarjeta());
					String fechaActualString = util.fechaDateTOfechaString(TarjetaDeCreditoDTOServiceImpl.FORMATO_FECHA_INGLES, fechaActual);
					
					if (Long.parseLong(fechaActualString) > Long.parseLong(fechaString)){
						respBoolean.setRespBoolean(false);
						respuesta.setCodigoError(-10054);
						respuesta.setMensajeError("La fecha de vencimiento ingresada para la tarjeta de crédito es menor a la fecha actual.");
						respBoolean.setRespuesta(respuesta);
						return respBoolean;
					}
					logger.info("fechaTarjeta: " + fechaString);
					logger.info("fechaActual: " + fechaActualString);
					datosTarjeta.setIndicDebito(global.getValor("indicador.debito.automatico"));
					datosTarjeta.setCodTipTarjeta(inParam0.getCodTipTarjeta());
					datosTarjeta.setNumeroTarjeta(inParam0.getNumeroTarjeta());
					datosTarjeta.setFechaVencTarjeta(fechaString);
					datosTarjeta.setCodBancoTarjeta(inParam0.getCodBancoTarjeta());
					datosTarjeta.setNombreTitular(inParam0.getNombreTitular());
					datosTarjeta.setObservaciones(inParam0.getObservaciones());
					
					/**
					* Actualiza el registro de la tabla de clientes asociado al código de cliente del número ingresado
					*/
					logger.info("actualizarDatosClieTarjeta:start()");
					logger.info("actualizarDatosClieTarjeta:antes()");
					com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam1 = tarjetaDeCreditoDTODAO.actualizarDatosClieTarjeta(datosTarjeta);
					logger.info("actualizarDatosClieTarjeta:despues()");
					logger.info("actualizarDatosClieTarjeta:end()");
					
					if (outParam1 != null && outParam1.getCodigoError() == 0){
						

						datosTarjeta.setCodBcoi(Long.parseLong(global.getValor("codigo.bcoi")));
						datosTarjeta.setCodZona(global.getValor("codigo.zona"));
						datosTarjeta.setCodCentral(global.getValor("codigo.central"));
						datosTarjeta.setCodCliente(datosClienteOut.getListadoAbonados()[0].getCodCliente());
						datosTarjeta.setNumTelefono(inParam0.getNumTelefono());
						datosTarjeta.setCodBancoTarjeta(inParam0.getCodBancoTarjeta());
						/**
						* Actualiza la información de la tarjeta de crédito en el módulo de cobranza
						*/
						logger.info("insertarPagoAutomatico:start()");
						logger.info("insertarPagoAutomatico:antes()");
						com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO outParam2 = tarjetaDeCreditoDTODAO.insertarPagoAutomatico(datosTarjeta);
						logger.info("insertarPagoAutomatico:despues()");
						logger.info("insertarPagoAutomatico:end()");
						
						if (outParam2 != null && outParam2.getCodigoError() == 0){
							respBoolean.setRespBoolean(true);
							respuesta.setCodigoError(0);
							respuesta.setMensajeError("");
							respuesta.setNumeroEvento(0);
							respBoolean.setRespuesta(respuesta);
						}else{
							respBoolean.setRespBoolean(false);
							respuesta.setCodigoError(outParam2.getCodigoError());
							respuesta.setMensajeError("No ha sido posible registrar los datos asociados a la tarjeta de crédito");
							respuesta.setNumeroEvento(outParam2.getNumeroEvento());
							respBoolean.setRespuesta(respuesta);
							return respBoolean;
						}
						
					}else{
						respBoolean.setRespBoolean(false);
						respuesta.setCodigoError(outParam1.getCodigoError());
						respuesta.setMensajeError(outParam1.getMensajeError());
						respuesta.setNumeroEvento(outParam1.getNumeroEvento());
						respBoolean.setRespuesta(respuesta);
						return respBoolean;
					}
				}else{
					if (outParam0.getMensajeError().equals("")){
						respBoolean.setRespBoolean(false);
						respuesta.setCodigoError(outParam0.getCodigoError());
						respuesta.setMensajeError("El número de tarjeta ingresado no es válido");
						respuesta.setNumeroEvento(outParam0.getNumeroEvento());
						respBoolean.setRespuesta(respuesta);
						return respBoolean;
					}else{
						respBoolean.setRespBoolean(false);
						respuesta.setCodigoError(outParam0.getCodigoError());
						respuesta.setMensajeError("No ha sido posible validar el número de tarjeta de crédito");
						respuesta.setNumeroEvento(outParam0.getNumeroEvento());
						respBoolean.setRespuesta(respuesta);
						return respBoolean;
					}
				}

			}else{
				respBoolean.setRespBoolean(false);
				respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
				respuesta.setMensajeError(datosClienteOut.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
				respBoolean.setRespuesta(respuesta);
				return respBoolean;
			}
		}else{
			respBoolean.setRespBoolean(false);
			respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
			respuesta.setMensajeError(datosClienteOut.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
			respBoolean.setRespuesta(respuesta);
			return respBoolean;
		}
		
		logger.info("validarNumTarjCredito:despues()");
		logger.info("validarNumTarjCredito:end()");
		return respBoolean;
		
	}


	/**
	* Entrega Listado de Tarjetas de Credito
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO listarTarjetasDeCredito(AuditoriaDTO inParam0)
			throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
			UtilLog.setLog(config.getString("IntegracionGTEService.log"));
			TarjetaCreditoResponseDTO outParam0 = new TarjetaCreditoResponseDTO();
			AuditoriaDTO	codPuntoAccesoDto	= new AuditoriaDTO();		
			AuditoriaDTO 	codAplicacionDto	= new AuditoriaDTO();		
			AuditoriaDTO 	codServicioDto		= new AuditoriaDTO();		
			AuditoriaDTO 	nombreUsuarioDto	= new AuditoriaDTO();	
			ArrayList 		campos				= new ArrayList();
	
			// Realizando Proceso de Auditoria 
			// Validación de Punto Acceso
				codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getCodPuntoAcceso());
				logger.info("validarPuntoAcceso:start()");
				logger.info("validarPuntoAcceso:antes()");
				PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
				logger.info("validarPuntoAcceso:despues()");
				logger.info("validarPuntoAcceso:end()");
				if (puntoAcceso.getRespuesta().getCodigoError()!=0)
				{
					outParam0.setRespuesta(puntoAcceso.getRespuesta());
					return outParam0;
				}
			// Fin Validación de Punto Acceso
			// Validación de Cod. Aplicacion
				codAplicacionDto.setCodAplicacion(inParam0.getCodAplicacion());
				if ((codAplicacionDto.getCodAplicacion()!=null)&&!(codAplicacionDto.getCodAplicacion()).equals(""))
				{
					logger.info("validarAplicacion:start()");
					logger.info("validarAplicacion:antes()");
					com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO aplicacionValidada =  auditoriaDAO.validarAplicacion(codAplicacionDto);
					logger.info("validarAplicacion:despues()");
					logger.info("validarAplicacion:end()");
					if (aplicacionValidada.getCodigoError()!=0)
					{
						outParam0.setRespuesta(aplicacionValidada);
						return outParam0;
					}
				}
			// Fin validación de Cod. Aplicacion
			// Validación de Cod. Servicio
				codServicioDto.setCodServicio(inParam0.getCodServicio());
				logger.info("validarServicio:start()");
				logger.info("validarServicio:antes()");
				com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO servicioValidado =  auditoriaDAO.validarServicio(codServicioDto);
				logger.info("validarServicio:despues()");
				logger.info("validarServicio:end()");
				if (servicioValidado.getCodigoError()!=0)
				{
					outParam0.setRespuesta(servicioValidado);
					return outParam0;
				}
			// Fin Validación de Cod. Servicio
			// Validación de nombre Usuario
				nombreUsuarioDto.setNombreUsuario(inParam0.getNombreUsuario());
				logger.info("validarNombreUsuario:start()");
				logger.info("validarNombreUsuario:antes()");
				com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO usuarioValidado =  auditoriaDAO.validarNombreUsuario(nombreUsuarioDto);
				logger.info("validarNombreUsuario:despues()");
				logger.info("validarNombreUsuario:end()");
				if (usuarioValidado.getCodigoError()!=0)
				{
					outParam0.setRespuesta(usuarioValidado);
					return outParam0;
				}
			// Fin Validación de nombre Usuario
				
			// Inicio de Registro de auditoría 		
			logger.info("insertarAuditoria:start()");
			logger.info("insertarAuditoria:antes()");
			com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO  auditoria =  auditoriaDAO.insertarAuditoria(inParam0);
			logger.info("insertarAuditoria:despues()");
			logger.info("insertarAuditoria:end()");
			if (auditoria != null && auditoria.getRespuesta()!= null &&  auditoria.getRespuesta().getCodigoError()==0  )
			{
				AuditoriaServicioDTO auditoriaServicioDTO = new AuditoriaServicioDTO();
				auditoriaServicioDTO.setCodAuditoria(auditoria.getCodAuditoria());
				auditoriaServicioDTO.setNombreUsuario(inParam0.getNombreUsuario());
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
							outParam0.setRespuesta(servicio);
							return outParam0;
						}
		       }
		        	       
			}else
			{
				outParam0.setRespuesta(auditoria.getRespuesta());
				return outParam0;
			}
			// Fin Proceso de Auditoria 
						
			logger.info("listarTarjetasDeCredito:start()");
			logger.info("listarTarjetasDeCredito:antes()");
			outParam0 = tarjetaDeCreditoDTODAO.listarTarjetasDeCredito();
			if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  )
			{
				if(outParam0.getTarjetasDeCreditoDTO().length > 0){
				   return outParam0;
				}else{
				   outParam0.getRespuesta().setMensajeError("No ha sido posible obtener los tipos de tarjetas de crédito disponibles");
				}
			}else{
				outParam0.getRespuesta().setMensajeError("No ha sido posible obtener los tipos de tarjetas de crédito disponibles");
			}
			logger.info("listarTarjetasDeCredito:despues()");
			logger.info("listarTarjetasDeCredito:end()");
			return outParam0;
	}


}