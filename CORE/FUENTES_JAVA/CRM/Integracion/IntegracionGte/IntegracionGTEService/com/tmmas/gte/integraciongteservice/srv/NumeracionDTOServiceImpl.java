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
import com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO;
import com.tmmas.gte.integraciongtebo.dao.TraficoDTODAO;
import com.tmmas.gte.integraciongtebo.dao.TraficoDTODAOImpl;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.EntServSupleDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.ParamOperDTO;
import com.tmmas.gte.integraciongtecommon.dto.ParamOperNumTelefDTO;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class NumeracionDTOServiceImpl implements NumeracionDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(NumeracionDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.NumeracionDTODAO numeracionDTODAO = new com.tmmas.gte.integraciongtebo.dao.NumeracionDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 			auditoriaDAO		 = new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	protected TraficoDTODAO traficoDTODAO= new TraficoDTODAOImpl(); 

	public NumeracionDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO consultarNumeracion(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		RespBooleanDTO respBoolean = new RespBooleanDTO();
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 campos					= new ArrayList();

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
				
				respBoolean.setRespuesta(puntoAcceso.getRespuesta());
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
	        	if (!(valorcampos.getNombreCampo()).equals("ListaActDesSS"))
	        	{
	        		auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
	        		auditoriaServicioDTO.setValParametro(valorcampos.getValorCampo());
	        		logger.info("insertarServicios:start()");
	        		logger.info("insertarServicios:antes()");
	        		RespuestaDTO servicio =  auditoriaDAO.insertarServicios(auditoriaServicioDTO);
	        		logger.info("insertarServicios:despues()");
	        		logger.info("insertarServicios:end()");
					if (servicio == null &&  servicio.getCodigoError()!=0  )
					{
						respBoolean.setRespuesta(servicio);
						return respBoolean;
					}
	        	}	
	       }
	        
		}else 
		{
			respBoolean.setRespuesta(auditoria.getRespuesta());
			return respBoolean;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultaNumeracion:start()");
		
		/**
		 * @author rlozano
		 * @description se invoca PL para obtención del código operadora
		 */
		ParamOperDTO paramOperDTO = traficoDTODAO.getConsultaParametrosOperadora();
		
		logger.info("consultaNumeracion:antes()");
		ParamOperNumTelefDTO paramOperNumTelefDTO= new ParamOperNumTelefDTO();
		paramOperNumTelefDTO.setNumeroTelefono(inParam0.getNumeroTelefono());
		paramOperNumTelefDTO.setCodOperadora(paramOperDTO.getCodOperadora());

		com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO outParam0 = numeracionDTODAO.consultarNumeracion(paramOperNumTelefDTO);
		//numeracionDTODAO.consultarNumeracion(inParam0);
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()== 0)
		{
			respBoolean.setRespBoolean(true);
			respBoolean.setRespuesta(outParam0.getRespuesta());
			
		}else
		{
			outParam0.getRespuesta().setMensajeError("El número de teléfono ingresado no existe en el plan de numeración de SCL");
	    	respBoolean.setRespuesta(outParam0.getRespuesta());	
		}
		logger.info("consultaNumeracion:despues()");
		logger.info("consultaNumeracion:end()");
		return respBoolean;
	}
	
	
	
	
}