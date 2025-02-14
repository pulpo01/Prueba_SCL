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

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsDirecTipoDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionInDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionRespOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class DireccionDTOServiceImpl implements DireccionDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(DireccionDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.DireccionDTODAO direccionDTODAO = new com.tmmas.gte.integraciongtebo.dao.DireccionDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO consAbonadoDTODAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	
	public DireccionDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Entrega el tipo de dirección, el código de dirección y las descripción
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarDireccionXCodCliente:start()");
		logger.info("consultarDireccionXCodCliente:antes()");
		com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO outParam0 = direccionDTODAO.consultarCodigoDireccion(inParam0);
		logger.info("consultarDireccionXCodCliente:despues()");
		logger.info("consultarDireccionXCodCliente:end()");
		logger.info(" verificar datos en la lista");
			if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getLstlistadoDireciones() != null && outParam0.getLstlistadoDireciones().length == 0){
				if(outParam0.getRespuesta().getCodigoError() == 0){
					RespuestaDTO  respuesta = new RespuestaDTO();
					respuesta.setCodigoError(-10012);
					respuesta.setMensajeError("No se ha podido obtener el listado de direcciones asociadas al cliente.");
					respuesta.setNumeroEvento(0);
					outParam0.setRespuesta(respuesta);
				}
			}
		logger.info(" fin de verificar datos en la lista");
		
		return outParam0;
	}

	/**
	* Entrega el tipo de dirección y el código de dirección
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecTipoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarDireccionXCodClienteTipo:start()");
		logger.info("consultarDireccionXCodClienteTipo:antes()");
		com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO outParam0 = direccionDTODAO.consultarCodigoDireccion(inParam0);
		logger.info("consultarDireccionXCodClienteTipo:despues()");
		logger.info("consultarDireccionXCodClienteTipo:end()");
		logger.info(" verificar datos en la lista");

		if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getLstlistadoDireciones()!= null && outParam0.getLstlistadoDireciones().length == 0){
			if(outParam0.getRespuesta().getCodigoError() == 0){
				RespuestaDTO  respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10013);
				respuesta.setMensajeError("No se ha podido obtener la dirección consultada para el código de cliente consultado.");
				respuesta.setNumeroEvento(0);
				outParam0.setRespuesta(respuesta);
			}
		}
	logger.info(" fin de verificar datos en la lista");
		
		
		return outParam0;
	}

	/**
	* Entrega un DireccionDTO con los datos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionDTO consultarDireccion(com.tmmas.gte.integraciongtecommon.dto.DireccionInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarDireccion:start()");
		logger.info("consultarDireccion:antes()");
		com.tmmas.gte.integraciongtecommon.dto.DireccionDTO outParam0 = direccionDTODAO.consultarDireccion(inParam0);
		logger.info("consultarDireccion:despues()");
		logger.info("consultarDireccion:end()");
		return outParam0;
	}

	/**
	* Retorna Detalle Direccion para un Numero de Telefono Ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionRespOutDTO consultarDireccionTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		EsTelefIgualClieDTO 	numeroTelefonoIn 					= new EsTelefIgualClieDTO();
		AbonadoOutDTO 			datosAbonadoOut 					= new AbonadoOutDTO();
		Global 					global 								= Global.getInstance();
		ConsDirecTipoDTO 			codClienteDireccIn 				= new ConsDirecTipoDTO();
		DireccionDTOService     consultarCodDireccionSrv			= new DireccionDTOServiceImpl();
		DireccionDTOService     consultardetalleDireccionSrv		= new DireccionDTOServiceImpl();
		DireccionResponseDTO    codDireccionOut						= new DireccionResponseDTO();
		DireccionRespOutDTO     salidaFinal                         = new DireccionRespOutDTO();
		DireccionInDTO 			consDetalleDireccionIn				= new DireccionInDTO();
		DireccionOutDTO			datosDireccionOut					= new DireccionOutDTO();
		DireccionDTO			paramOut							= new DireccionDTO();
		RespuestaDTO			respuesta							= new RespuestaDTO();
		
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();
		
		logger.info("consultarDetalleDireccion:start()");
		logger.info("consultarDetalleDireccion:antes()");
		numeroTelefonoIn.setNum_telefono1(inParam0.getNumeroTelefono());
		
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
				salidaFinal.setRespuesta(respuesta);
				return salidaFinal;
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
					salidaFinal.setRespuesta(aplicacionValidada);
					return salidaFinal;
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
				salidaFinal.setRespuesta(servicioValidado);
				return salidaFinal;
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
				salidaFinal.setRespuesta(usuarioValidado);
				return salidaFinal;
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
					salidaFinal.setRespuesta(respuesta);
					return salidaFinal;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			salidaFinal.setRespuesta(respuesta);
			return salidaFinal;
		}
		//Fin de Registro de auditoría 				

		
		
		/**
		* Retorna numAbonado y codCliente a partir de un numero Telefono
		*/
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		datosAbonadoOut = consAbonadoDTODAO.consultarAbonadoTelefono(numeroTelefonoIn);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		
		if (datosAbonadoOut != null && 
			datosAbonadoOut.getRespuesta()!= null &&  
			datosAbonadoOut.getRespuesta().getCodigoError()==0  &&
			datosAbonadoOut.getListadoAbonados() != null &&
			datosAbonadoOut.getListadoAbonados().length > 0){

			    codClienteDireccIn.setCodCliente(datosAbonadoOut.getListadoAbonados()[0].getCodCliente());
				codClienteDireccIn.setTipDireccion(global.getValor("tipo.dirfacturacion"));
				/**
				* Retorna codDireccion a partir de un codCliente y codTipDireccion
				*/
				logger.info("consultarDireccionXCodClienteTipo:start()");
				logger.info("consultarDireccionXCodClienteTipo:antes()");
				codDireccionOut = consultarCodDireccionSrv.consultarCodigoDireccion(codClienteDireccIn);
				logger.info("consultarDireccionXCodClienteTipo:despues()");
				logger.info("consultarDireccionXCodClienteTipo:end()");
				
				if (codDireccionOut != null && 
					codDireccionOut.getRespuesta()!= null &&  
					codDireccionOut.getRespuesta().getCodigoError()==0  && 
					codDireccionOut.getLstlistadoDireciones() != null &&
					codDireccionOut.getLstlistadoDireciones().length > 0){
					
					DireccionDTO     datosFacturacion = null;
					
						for(int i =0; i < codDireccionOut.getLstlistadoDireciones().length ; i++){
							DireccionDTO  nuevo = codDireccionOut.getLstlistadoDireciones()[i];
							if(nuevo != null && nuevo.getCodDireccion()!= null && !nuevo.getCodDireccion().equals("") && nuevo.getCodTipDireccion()!= null && nuevo.getCodTipDireccion().equals("1")){
								datosFacturacion = nuevo;
								break;
							}
						}
					
						if(datosFacturacion != null){
							consDetalleDireccionIn.setCodDireccion(Long.parseLong(datosFacturacion.getCodDireccion()));
							consDetalleDireccionIn.setCodTipDireccion(global.getValor("tipo.dirfacturacion"));
							
						}else{
							consDetalleDireccionIn.setCodDireccion(0);
							consDetalleDireccionIn.setCodTipDireccion(global.getValor("tipo.dirfacturacion"));
						}
												
						/**
						* Retorna Detalle Direccion para un codDireccion y codTipodireccion
						*/
						logger.info("consultarDireccion:start()");
						logger.info("consultarDireccion:antes()");
						paramOut = consultardetalleDireccionSrv.consultarDireccion(consDetalleDireccionIn);
						logger.info("consultarDireccion:despues()");
						logger.info("consultarDireccion:end()");
						if (paramOut != null && paramOut.getRespuesta()!= null &&  paramOut.getRespuesta().getCodigoError()==0 ){
							
							datosDireccionOut.setCodCiudad(paramOut.getCodCiudad());
							datosDireccionOut.setCodComuna(paramOut.getCodComuna());
							datosDireccionOut.setCodDireccion(paramOut.getCodDireccion());
							datosDireccionOut.setCodEstado(paramOut.getCodEstado());
							datosDireccionOut.setCodProvincia(paramOut.getCodProvincia());
							datosDireccionOut.setCodPueblo(paramOut.getCodPueblo());
							datosDireccionOut.setCodRegion(paramOut.getCodRegion());
							datosDireccionOut.setCodTipDireccion(paramOut.getCodTipDireccion());
							datosDireccionOut.setCodTipoCalle(paramOut.getCodTipoCalle());
							datosDireccionOut.setDesComuna(paramOut.getDesComuna());
							datosDireccionOut.setDesCuidad(paramOut.getDesCuidad());
							datosDireccionOut.setDesDirec1(paramOut.getDesDirec1());
							datosDireccionOut.setDesDirec2(paramOut.getDesDirec2());
							datosDireccionOut.setDesProvincia(paramOut.getDesProvincia());
							datosDireccionOut.setDesRegion(paramOut.getDesRegion());
							datosDireccionOut.setDesTipDireccion(paramOut.getDesTipDireccion());
							datosDireccionOut.setNomCalle(paramOut.getNomCalle());
							datosDireccionOut.setNumCalle(paramOut.getNumCalle());
							datosDireccionOut.setNumCasilla(paramOut.getNumCasilla());
							datosDireccionOut.setNumPiso(paramOut.getNumPiso());
							datosDireccionOut.setObsDirecc(paramOut.getObsDirecc());
						    salidaFinal.setDireccionFacturacion(datosDireccionOut); 
							salidaFinal.setRespuesta(respuesta);							
						}else{
							if(paramOut != null && paramOut.getRespuesta() != null && paramOut.getRespuesta().getCodigoError() != 0){
								salidaFinal.setRespuesta(respuesta);
							}else{
								respuesta.setCodigoError(-10046);
								respuesta.setMensajeError("No ha sido posible obtener la dirección de facturación para el teléfono consultado.");
								salidaFinal.setRespuesta(respuesta);
							}
					   }
			}else{
				if(codDireccionOut != null && codDireccionOut.getRespuesta() != null && codDireccionOut.getRespuesta().getCodigoError() != 0){
					respuesta.setCodigoError(codDireccionOut.getRespuesta().getCodigoError());
					respuesta.setMensajeError(codDireccionOut.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(codDireccionOut.getRespuesta().getNumeroEvento());
					salidaFinal.setRespuesta(respuesta);					
				}else{
					respuesta.setCodigoError(-10046);
					respuesta.setMensajeError("No ha sido posible obtener la dirección de facturación para el teléfono consultado.");
					salidaFinal.setRespuesta(respuesta);					
				}
			}
		}else {
			if(datosAbonadoOut != null && datosAbonadoOut.getRespuesta() != null && datosAbonadoOut.getRespuesta().getCodigoError() != 0){
				respuesta.setCodigoError(datosAbonadoOut.getRespuesta().getCodigoError());
				respuesta.setMensajeError(datosAbonadoOut.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(datosAbonadoOut.getRespuesta().getNumeroEvento());
				salidaFinal.setRespuesta(respuesta);					
			}else{
				respuesta.setCodigoError(-10046);
				respuesta.setMensajeError("No ha sido posible obtener la dirección de facturación para el teléfono consultado.");
				salidaFinal.setRespuesta(respuesta);
			}
		}
		logger.info("consultarDetalleDireccion:despues()");
		logger.info("consultarDetalleDireccion:end()");
		return salidaFinal;
	}
}