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
import com.tmmas.gte.integraciongtecommon.dto.BancoDispInDTO;
import com.tmmas.gte.integraciongtecommon.dto.BancoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO;

import com.tmmas.gte.integraciongteservice.helper.Global;

public class BancoDTOServiceImpl implements BancoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(BancoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.BancoDTODAO 			bancoDTODAO 	= new com.tmmas.gte.integraciongtebo.dao.BancoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 		auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();

	public BancoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	
	/**
	* Entrega datos de los bancos disponibles para la contratación de PAC
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BancoResponseDTO listarBancosDisponibles(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		AuditoriaDTO	 	codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 	 	codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 	 	codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 	nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 		 	campos				= new ArrayList();
		BancoResponseDTO    bancoResponseDTO 	= new BancoResponseDTO();
		BancoDispInDTO		inParam1			= new BancoDispInDTO();
		Global 				global 				= Global.getInstance();

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
				bancoResponseDTO.setRespuesta(puntoAcceso.getRespuesta());
				return bancoResponseDTO;
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
					bancoResponseDTO.setRespuesta(aplicacionValidada);
					return bancoResponseDTO;
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
				bancoResponseDTO.setRespuesta(servicioValidado);
				return bancoResponseDTO;
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
				bancoResponseDTO.setRespuesta(usuarioValidado);
				return bancoResponseDTO;
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
						bancoResponseDTO.setRespuesta(servicio);
						return bancoResponseDTO;
					}
	       }
	        	       
		}else
		{
			bancoResponseDTO.setRespuesta(auditoria.getRespuesta());
			return bancoResponseDTO;
		}
		// Fin Proceso de Auditoria
		
		logger.info("consultarBancosDisponibles:start()");
		inParam1.setIndPac(Long.parseLong(global.getValor("banco.ind_pac")));
		logger.info("consultarBancosDisponibles:antes()");
		com.tmmas.gte.integraciongtecommon.dto.BancoResponseDTO outParam0 = bancoDTODAO.listarBancosDisponibles(inParam1);
		logger.info("consultarBancosDisponibles:despues()");
		
		if (outParam0 != null && outParam0.getRespuesta() != null &&  outParam0.getRespuesta().getCodigoError() == 0){
			if(outParam0.getListadoBancos().length > 0){
				return outParam0;
			}else{
				outParam0.getRespuesta().setMensajeError("No ha sido posible obtener los bancos disponibles para PAC");
			}
		}else{
			outParam0.getRespuesta().setMensajeError("No ha sido posible obtener los bancos disponibles para PAC");
		}
		logger.info("consultarBancosDisponibles:end()");
		return outParam0;
	}

}