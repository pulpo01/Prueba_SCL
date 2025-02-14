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
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsDirecDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionInDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class ConsDireccClienteDTOServiceImpl implements ConsDireccClienteDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ConsDireccClienteDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO consAbonadoDTODAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	
	public ConsDireccClienteDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Retorna Detalle Direccion para un Numero de Telefono Ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionDTO consultarDireccionTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		EsTelefIgualClieDTO 	numeroTelefonoIn 					= new EsTelefIgualClieDTO();
		AbonadoOutDTO 			datosAbonadoOut 					= new AbonadoOutDTO();
		Global 					global 								= Global.getInstance();
		ConsDirecDTO 			codClienteDireccIn 					= new ConsDirecDTO();
		DireccionDTOService     consultarCodDireccionSrv			= new DireccionDTOServiceImpl();
		DireccionDTOService     consultardetalleDireccionSrv		= new DireccionDTOServiceImpl();
		DireccionResponseDTO    codDireccionOut						= new DireccionResponseDTO();
		DireccionInDTO 			consDetalleDireccionIn				= new DireccionInDTO();
		DireccionDTO			datosDireccionOut					= new DireccionDTO();
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
				datosDireccionOut.setRespuesta(respuesta);
				return datosDireccionOut;
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
					datosDireccionOut.setRespuesta(aplicacionValidada);
					return datosDireccionOut;
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
				datosDireccionOut.setRespuesta(servicioValidado);
				return datosDireccionOut;
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
				datosDireccionOut.setRespuesta(usuarioValidado);
				return datosDireccionOut;
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
					datosDireccionOut.setRespuesta(respuesta);
					return datosDireccionOut;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			datosDireccionOut.setRespuesta(respuesta);
			return datosDireccionOut;
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
		
		if (datosAbonadoOut != null && datosAbonadoOut.getRespuesta()!= null &&  datosAbonadoOut.getRespuesta().getCodigoError()==0 ){
			if (datosAbonadoOut.getListadoClientes().length > 0 ){
				codClienteDireccIn.setCodCliente(datosAbonadoOut.getListadoClientes()[0].getCodCliente());
				codClienteDireccIn.setTipDireccion(global.getValor("tipo.dirfacturacion"));
				consDetalleDireccionIn.setCodSujeto(String.valueOf(datosAbonadoOut.getListadoClientes()[0].getCodCliente()));

				/**
				* Retorna codDireccion a partir de un codCliente y codTipDireccion
				*/
				logger.info("consultarDireccionXCodClienteTipo:start()");
				logger.info("consultarDireccionXCodClienteTipo:antes()");
				codDireccionOut = consultarCodDireccionSrv.consultarDireccionXCodClienteTipo(codClienteDireccIn);
				logger.info("consultarDireccionXCodClienteTipo:despues()");
				logger.info("consultarDireccionXCodClienteTipo:end()");
				
				if (codDireccionOut != null && codDireccionOut.getRespuesta()!= null &&  codDireccionOut.getRespuesta().getCodigoError()==0 ){
					if (codDireccionOut.getLstlistadoDireciones().length > 0){
						consDetalleDireccionIn.setTipDireccion(Long.parseLong(codDireccionOut.getLstlistadoDireciones()[0].getCodDireccion()));
						consDetalleDireccionIn.setCodSujeto(global.getValor("tipo.sujeto"));
						consDetalleDireccionIn.setTipDisplay(Long.parseLong(global.getValor("tipo.despliegue")));
												
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
							respuesta.setCodigoError(paramOut.getRespuesta().getCodigoError());
							respuesta.setMensajeError(paramOut.getRespuesta().getMensajeError());
							respuesta.setNumeroEvento(paramOut.getRespuesta().getNumeroEvento());
							datosDireccionOut.setRespuesta(respuesta);							
						}else{
							respuesta.setCodigoError(paramOut.getRespuesta().getCodigoError());
							respuesta.setMensajeError(paramOut.getRespuesta().getMensajeError());
							respuesta.setNumeroEvento(paramOut.getRespuesta().getNumeroEvento());
							datosDireccionOut.setRespuesta(respuesta);}
					}else{
						respuesta.setCodigoError(paramOut.getRespuesta().getCodigoError());
						respuesta.setMensajeError(paramOut.getRespuesta().getMensajeError());
						respuesta.setNumeroEvento(paramOut.getRespuesta().getNumeroEvento());
						datosDireccionOut.setRespuesta(respuesta);}
				}else{
					respuesta.setCodigoError(paramOut.getRespuesta().getCodigoError());
					respuesta.setMensajeError(paramOut.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(paramOut.getRespuesta().getNumeroEvento());
					datosDireccionOut.setRespuesta(respuesta);
				}
			}else {
				respuesta.setCodigoError(datosAbonadoOut.getRespuesta().getCodigoError());
				respuesta.setMensajeError("No ha sido posible obtener la dirección de facturación para el teléfono consultado");
				respuesta.setNumeroEvento(datosAbonadoOut.getRespuesta().getNumeroEvento());
				datosDireccionOut.setRespuesta(respuesta);
			}
		}else {
			respuesta.setCodigoError(datosAbonadoOut.getRespuesta().getCodigoError());
			respuesta.setMensajeError("No ha sido posible obtener la dirección de facturación para el teléfono consultado");
			respuesta.setNumeroEvento(datosAbonadoOut.getRespuesta().getNumeroEvento());
			datosDireccionOut.setRespuesta(respuesta);
		}
		logger.info("consultarDetalleDireccion:despues()");
		logger.info("consultarDetalleDireccion:end()");
		return datosDireccionOut;
	}
}