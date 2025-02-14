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
import com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.ActividadDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.ClienteOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.ClientePospagoHibridoDTO;
import com.tmmas.gte.integraciongtecommon.dto.ClientePrepagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsDirecTipoDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosClienteOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosClientePospHibrPrepDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCueDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionInDTO;
import com.tmmas.gte.integraciongtecommon.dto.DireccionOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribPedidoDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EquipoAbonadoDTO;
import com.tmmas.gte.integraciongtecommon.dto.EquipoDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.IdentificacionDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespTipoClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class ClienteDTOServiceImpl implements ClienteDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(ClienteDTOServiceImpl.class);
	
	private com.tmmas.gte.integraciongtebo.dao.ClienteDTODAO 		clienteDTODAO 			= new com.tmmas.gte.integraciongtebo.dao.ClienteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ActividadDTODAO 		actividadDTODAO 		= new com.tmmas.gte.integraciongtebo.dao.ActividadDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.IdentificacionDTODAO identificacionDTODAO	= new com.tmmas.gte.integraciongtebo.dao.IdentificacionDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.EquipoDTODAO         equipoDTODAO            = new com.tmmas.gte.integraciongtebo.dao.EquipoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.DireccionDTODAO 		direccionDTODAO 		= new com.tmmas.gte.integraciongtebo.dao.DireccionDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 		abonadoDTODAO 			= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 		auditoriaDAO			= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();

 	
	public ClienteDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Entrega Listado de Clientes por código de Cuenta
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCueDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		AuditoriaDTO	 	codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 	 	codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 	 	codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 	nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 		 	campos				= new ArrayList();
		LstCliResponseDTO   outParam0 			= new LstCliResponseDTO();

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
				outParam0.setRespuesta(puntoAcceso.getRespuesta());
				return outParam0;
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
					outParam0.setRespuesta(aplicacionValidada);
					return outParam0;
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
				outParam0.setRespuesta(servicioValidado);
				return outParam0;
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
				outParam0.setRespuesta(usuarioValidado);
				return outParam0;
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

		logger.info("listadoClientes(CodCuenta):start()");
		logger.info("listadoClientes(CodCuenta):antes()");
		outParam0 = clienteDTODAO.listarClientes(inParam0);
		logger.info("listadoClientes(CodCuenta):despues()");
		if (outParam0 == null && outParam0.getRespuesta()== null &&  outParam0.getRespuesta().getCodigoError()!=0  )
		{
			outParam0.getRespuesta().setMensajeError("No existen clientes asociados al código de cuenta consultado");
			
		}
		logger.info("listadoClientes(CodCuenta):end()");
		return outParam0;
	}

	/**
	* Entrega Listado de Clientes por número de telefono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstCliResponseDTO listarClientes(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		AuditoriaDTO	 	codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 	 	codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 	 	codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 	nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 		 	campos				= new ArrayList();
		LstCliResponseDTO   outParam0 			= new LstCliResponseDTO();
		EsTelefIgualClieDTO numeroTelefonoDTO	= new EsTelefIgualClieDTO();
		AbonadoOutDTO		abonadoOutDTO		= new AbonadoOutDTO();
		DatosLstCliCueDTO   numeroCuentaDTO		= new DatosLstCliCueDTO();

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
				outParam0.setRespuesta(puntoAcceso.getRespuesta());
				return outParam0;
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
					outParam0.setRespuesta(aplicacionValidada);
					return outParam0;
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
				outParam0.setRespuesta(servicioValidado);
				return outParam0;
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
				outParam0.setRespuesta(usuarioValidado);
				return outParam0;
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

		numeroTelefonoDTO.setNum_telefono1(inParam0.getNumeroTelefono());
		logger.info("consultarAbonadoTelefono():start()");
		logger.info("consultarAbonadoTelefono():antes()");
		abonadoOutDTO = abonadoDTODAO.consultarAbonadoTelefono(numeroTelefonoDTO);
		logger.info("consultarAbonadoTelefono():despues()");
		logger.info("consultarAbonadoTelefono():end()");
		if (abonadoOutDTO != null && abonadoOutDTO.getRespuesta()!= null &&  abonadoOutDTO.getRespuesta().getCodigoError()==0  )
		{
			numeroCuentaDTO.setCodCuenta(abonadoOutDTO.getListadoAbonados()[0].getCodCuenta());
			logger.info("listadoClientes(numeroTelefono):start()");
			logger.info("listadoClientes(numeroTelefono):antes()");
			outParam0 = clienteDTODAO.listarClientes(numeroCuentaDTO);
			logger.info("listadoClientes(numeroTelefono):despues()");
			if (outParam0 == null && outParam0.getRespuesta()== null &&  outParam0.getRespuesta().getCodigoError()!=0  )
			{
				outParam0.getRespuesta().setMensajeError("No existen clientes asociados al código de cuenta consultado");
			}
			logger.info("listadoClientes(numeroTelefono):end()");
		}else{
			outParam0.setRespuesta(abonadoOutDTO.getRespuesta());
		}
		return outParam0;
	}

	/**
	* Entrega número de identificación del cliente (NIT) y el código de tipo de identificación
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO consultarDatosCliente(com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarDatosCliente:start()");
		logger.info("consultarDatosCliente:antes()");
		com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO outParam0 = clienteDTODAO.consultarDatosCliente(inParam0);
		logger.info("consultarDatosCliente:despues()");
		logger.info("consultarDatosCliente:end()");
		return outParam0;
	}
	
	/**
	* Entrega un listado de datos de cliente a través de un número de teléfono y código de cliente.
	* Método sobrecargado.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClientePospHibrPrepDTO consultarDatosGenCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		RespuestaDTO  respuesta                  = null;
		DatosClientePospHibrPrepDTO respuestaCliente = new DatosClientePospHibrPrepDTO();
		Global global = Global.getInstance();
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
				
				respuestaCliente.setRespuesta(puntoAcceso.getRespuesta());
				return respuestaCliente;
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
					respuestaCliente.setRespuesta(aplicacionValidada);
					return respuestaCliente;
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
				respuestaCliente.setRespuesta(servicioValidado);
				return respuestaCliente;
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
				respuestaCliente.setRespuesta(usuarioValidado);
				return respuestaCliente;
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
						respuestaCliente.setRespuesta(servicio);
						return respuestaCliente;
					}
	        	}	
	       }
	        
		}else
		{
			respuestaCliente.setRespuesta(auditoria.getRespuesta());
			return respuestaCliente;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarDatosGenCliente:start()");
		logger.info("consultarDatosGenCliente:antes()");
		
		logger.info("Declaracion de variables para el metodo consultarDatosGenCliente por número de telefono");
		ActividadDTO inParamAc            = new ActividadDTO();
		IdentificacionDTO inParamId       = new IdentificacionDTO();
		EquipoAbonadoDTO inParamEqAbo = new EquipoAbonadoDTO();
		EquipoDTO equipo               = new EquipoDTO();
		ConsDirecTipoDTO nuevaEntradaTipo = new ConsDirecTipoDTO(); 
		
		logger.info("Fin declaracion de variables para el metodo consultarDatosGenCliente por número de telefono");
		
		EsTelefIgualClieDTO telefonoCliente = new EsTelefIgualClieDTO(); 
		telefonoCliente.setNum_telefono1(inParam0.getNumeroTelefono());

			logger.info("Abonado n°telefono:antes()");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO abonado = abonadoDTODAO.consultarAbonadoTelefono(telefonoCliente);
			logger.info("Abonado n°telefono:despues()");
			if (abonado != null && abonado.getRespuesta()!= null &&  abonado.getRespuesta().getCodigoError() == 0  && abonado.getListadoAbonados() != null && abonado.getListadoAbonados().length > 0){
				
				AbonadoDTO abonadoEvaluacion = abonado.getListadoAbonados()[0];
				if(  abonadoEvaluacion != null && 
					(abonadoEvaluacion.getCodTiplan() != null  && !abonadoEvaluacion.getCodTiplan().equals("")) &&
					(abonadoEvaluacion.getCodTiplan().equals(global.getValor("tipo.tipPospago")) || 
					 abonadoEvaluacion.getCodTiplan().equals(global.getValor("tipo.tipPostpago")) || 
					 abonadoEvaluacion.getCodTiplan().equals(global.getValor("tipo.tipHibrido")))){
					
					logger.info("Consulta POSPAGO o Hibrido x n°telefono:antes()");
					com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParamPos = clienteDTODAO.consultarClientePospago(inParam0);
					logger.info("Consulta POSPAGO x n°telefono:despues()");
					if(outParamPos != null && outParamPos.getRespuesta()!= null &&  outParamPos.getRespuesta().getCodigoError() == 0 ){
						ClienteDTO cliente = new ClienteDTO();
						cliente = outParamPos.getDatosCliente();
						nuevaEntradaTipo.setCodCliente(cliente.getCodCliente());
						nuevaEntradaTipo.setTipDireccion(global.getValor("tipo.dirfacturacion"));
						/**
						 * INICIAL DIRECCIONES  
						 ****/		
						logger.info("Direccion POSPAGO x n°telefono:antes()");
						com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO outParamDirec = direccionDTODAO.consultarCodigoDireccion(nuevaEntradaTipo);
						logger.info("Direccion POSPAGO x n°telefono:despues()");
						if (outParamDirec != null && outParamDirec.getLstlistadoDireciones()!= null && outParamDirec.getLstlistadoDireciones().length > 0 && outParamDirec.getRespuesta()!= null &&  outParamDirec.getRespuesta().getCodigoError() == 0 ){
							DireccionDTO direccion = null;
							DireccionDTO objListaDireccion = null;
							ArrayList listaDireciones = new ArrayList();
							for(int i = 0 ; i < outParamDirec.getLstlistadoDireciones().length ; i++){
								direccion = outParamDirec.getLstlistadoDireciones()[i];
								if(direccion != null && direccion.getCodDireccion() != null && !direccion.getCodDireccion().equals("")){
									DireccionInDTO datosEntradas = new DireccionInDTO();
									datosEntradas.setCodDireccion(Long.parseLong(direccion.getCodDireccion()));
									datosEntradas.setCodTipDireccion(global.getValor("tipo.dirfacturacion"));
									
									objListaDireccion = direccionDTODAO.consultarDireccion(datosEntradas);
									if(objListaDireccion != null){
										listaDireciones.add(objListaDireccion);
									}
								}
							}
							cliente.setLstDireccion((DireccionDTO[]) com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaDireciones.toArray(), com.tmmas.gte.integraciongtecommon.dto.DireccionDTO.class));
						 }
						/**
						* TERMINA DIRECCIONES  
						*
						* INICIAL TECNOLOGIA   
						****/
						
						if(cliente.getCodTecnologia()!= null && cliente.getCodTecnologia().equals(global.getValor("cliente.consultarDatosGenCliente.gsm"))){
								try{
									equipo.setNumSerie(cliente.getNumImei());
								}catch (Exception e) {
									equipo.setNumSerie(null);
								}
						}else{
								try{
									equipo.setNumSerie(cliente.getNumSerie());
								}catch (Exception e) {
									equipo.setNumSerie(null);
								}
						}
						/**
						 * TERMINA DIRECCIONES 
						 * 
						 * INICIAL EQUIPO  
						 ****/						
						
					     logger.info("Equipo POSPAGO x n°telefono:antes()");
						 inParamEqAbo.setEquipo(equipo);
						 inParamEqAbo.setAbonado(abonadoEvaluacion);
					     com.tmmas.gte.integraciongtecommon.dto.EquipoResponseDTO outParamEq = equipoDTODAO.consultarTerminal(inParamEqAbo);
						 logger.info("Equipo POSPAGO x n°telefono:despues()");
						 if (outParamEq != null && outParamEq.getEquipo() != null && outParamEq.getRespuesta()!= null &&  outParamEq.getRespuesta().getCodigoError() == 0){
					 		cliente.setDesEquipo(outParamEq.getEquipo().getDescEquipo());
					 		cliente.setCodArticulo(outParamEq.getEquipo().getCodArticulo());
				    	 }
						/**
						 * TERMINA EQUIPO 
						 * 
						 * INICIAL ACTIVIDAD  
						 ****/						
								
						 if(cliente.getCodProfesion() != 0){
							inParamAc.setCodActividad(cliente.getCodProfesion());
							logger.info("Actividad POSPAGO x n°telefono:antes()");
							com.tmmas.gte.integraciongtecommon.dto.ActividadResponseDTO outParamAc = actividadDTODAO.consultarActividad(inParamAc);
							logger.info("Actividad POSPAGO x n°telefono:despues()");
								if (outParamAc != null &&( outParamAc.getDesActividad() != null && !outParamAc.getDesActividad().equals("") ) &&outParamAc.getRespuesta()!= null &&  outParamAc.getRespuesta().getCodigoError() == 0 ){
									cliente.setDesProfesion(outParamAc.getDesActividad());
								}
						  }	
						 
						  /**
						  * TERMINA ACTIVIDAD 
						  * 
						  * INICIAL OCUPACION 
						  ****/							 	
						  if(cliente.getCodOcupacion() != null && !cliente.getCodOcupacion().equals("")){
								inParamAc.setCodOcupacion(cliente.getCodOcupacion());
								logger.info("Actividad POSPAGO x n°telefono:antes()");
								com.tmmas.gte.integraciongtecommon.dto.ActividadResponseDTO outParamAc = actividadDTODAO.consultarOcupacion(inParamAc);
								logger.info("Actividad POSPAGO x n°telefono:despues()");
								if (outParamAc != null &&( outParamAc.getDesActividad() != null && !outParamAc.getDesActividad().equals("") ) &&outParamAc.getRespuesta()!= null &&  outParamAc.getRespuesta().getCodigoError() == 0 ){
										cliente.setDesOcupacion(outParamAc.getDesActividad());
										
								}
						  }	
						 
						  /**
						  * TERMINA OCUPACION 
						  * 
						  * INICIAL CODIGO TIPO IDENTIFICACION  
						  ****/							 
						 if (cliente.getCodTipident() != null && !cliente.getCodTipident().equals("")){
							  inParamId.setCodTipIdent(cliente.getCodTipident());
    					  }else{
								inParamId.setCodTipIdent(null);
						  }
						    logger.info("Identificacion POSPAGO x n°telefono:antes()");
						     com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamId = identificacionDTODAO.consultarTipoIdent(inParamId);
						    logger.info("Identificacion POSPAGO x n°telefono:despues()");
							if (outParamId != null &&(outParamId.getDesIdentificacion() != null && !outParamId.getDesIdentificacion().equals("")) && outParamId.getRespuesta()!= null &&  outParamId.getRespuesta().getCodigoError() == 0 ){
								cliente.setDesNit(outParamId.getDesIdentificacion());
							}
							
							logger.info("Identificacion del apoderado POSPAGO x n°telefono:antes()");
							if (cliente.getCodTipident2() != null && !cliente.getCodTipident2().equals("")){
							    inParamId.setCodTipIdent(cliente.getCodTipident2());
							    com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamIdent2 = identificacionDTODAO.consultarTipoIdent(inParamId);
							    if (outParamIdent2 != null &&(outParamIdent2.getDesIdentificacion() != null && !outParamIdent2.getDesIdentificacion().equals("")) && outParamIdent2.getRespuesta()!= null &&  outParamIdent2.getRespuesta().getCodigoError() == 0 ){
							    	cliente.setDesIdent2(outParamIdent2.getDesIdentificacion());
							    }
							}
							logger.info("Identificacion del apoderado POSPAGO x n°telefono:despues()");
							
							logger.info("Identificacion del apoderado POSPAGO x n°telefono:antes()");
							if (cliente.getCodTipidentapor() != null && !cliente.getCodTipidentapor().equals("")){
							    inParamId.setCodTipIdent(cliente.getCodTipidentapor());
							    com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamApoderado = identificacionDTODAO.consultarTipoIdent(inParamId);
							    if (outParamApoderado != null &&(outParamApoderado.getDesIdentificacion() != null && !outParamApoderado.getDesIdentificacion().equals("")) && outParamApoderado.getRespuesta()!= null &&  outParamApoderado.getRespuesta().getCodigoError() == 0 ){
							  	   cliente.setDesIdentApor(outParamApoderado.getDesIdentificacion());
							    }
							}
							logger.info("Identificacion del apoderado POSPAGO x n°telefono:despues()");
						  /**
						   * TERMINA CODIGO TIPO IDENTIFICACION 
						   * 
						   * INICIAL SETEO PARA PODER RETORNAR OBJETO
						   ****/	
						      ClientePospagoHibridoDTO clienteNuevo = new ClientePospagoHibridoDTO();
						      clienteNuevo.setSysDate(cliente.getSysDate());
						      clienteNuevo.setNumCelular(cliente.getNumCelular());
						      clienteNuevo.setCodCliente(cliente.getCodCliente());
						      clienteNuevo.setFecAlta(cliente.getFecAlta());
						      clienteNuevo.setFecFincontra(cliente.getFecFincontra());
						      clienteNuevo.setNomCliente(cliente.getNomCliente());
						      clienteNuevo.setNomApeClien1(cliente.getNomApeClien1());
						      clienteNuevo.setNomApeClien2(cliente.getNomApeClien2());
						      clienteNuevo.setDesNit(cliente.getDesNit());
						      clienteNuevo.setNumIdent(cliente.getNumIdent());
						      clienteNuevo.setCodTipident(cliente.getCodTipident());
						      clienteNuevo.setNumIdent2(cliente.getNumIdent2());
						      clienteNuevo.setCodTipident2(cliente.getCodTipident2());
						      clienteNuevo.setNumIdentapor(cliente.getNumIdentapor());
						      clienteNuevo.setCodTipidentapor(cliente.getCodTipidentapor());
						      clienteNuevo.setFecNacimien(cliente.getFecNacimien());
						      clienteNuevo.setCodProfesion(cliente.getCodProfesion());
						      clienteNuevo.setDesProfesion(cliente.getDesProfesion());
						      clienteNuevo.setCodOcupacion(cliente.getCodOcupacion());
						      clienteNuevo.setDesOcupacion(cliente.getDesOcupacion());
						      clienteNuevo.setNomApoderado(cliente.getNomApoderado());
						      clienteNuevo.setIndEstcivil(cliente.getIndEstcivil());
						      clienteNuevo.setNacionalidad(cliente.getNacionalidad());
						      ArrayList listaDirecciones = new ArrayList();
						      for(int i = 0; i< cliente.getLstDireccion().length ; i++){
						    	  DireccionDTO nuevo = cliente.getLstDireccion()[i];
						    	  if(nuevo != null ){
						    		  DireccionOutDTO direccion = new DireccionOutDTO();
						    		  direccion.setCodTipoCalle(nuevo.getCodTipoCalle()); 
						    		  direccion.setCodTipDireccion(nuevo.getCodTipDireccion()); 
						    		  direccion.setDesTipDireccion(nuevo.getDesTipDireccion()); 
						    		  direccion.setCodDireccion(nuevo.getCodDireccion()); 
						    		  direccion.setCodProvincia(nuevo.getCodProvincia()); 
						    		  direccion.setDesProvincia(nuevo.getDesProvincia()); 
						    		  direccion.setCodRegion(nuevo.getCodRegion()); 
						    		  direccion.setDesRegion(nuevo.getDesRegion());
						    		  direccion.setCodCiudad(nuevo.getCodCiudad()); 
						    		  direccion.setDesCuidad(nuevo.getDesCuidad());
						    		  direccion.setCodComuna(nuevo.getCodComuna());
						    		  direccion.setDesComuna(nuevo.getDesComuna());
						    		  direccion.setNomCalle(nuevo.getNomCalle()); 
						    		  direccion.setNumCalle(nuevo.getNumCalle()); 
						    		  direccion.setNumCasilla(nuevo.getNumCalle()); 
						    		  direccion.setObsDirecc(nuevo.getObsDirecc()); 
						    		  direccion.setDesDirec1(nuevo.getDesDirec1()); 
						    		  direccion.setDesDirec2(nuevo.getDesDirec2()); 
						    		  direccion.setCodPueblo(nuevo.getCodPueblo()); 
						    		  direccion.setCodEstado(nuevo.getCodEstado()); 
						    		  direccion.setNumPiso(nuevo.getNumPiso());
						    		  listaDirecciones.add(direccion);
						    	  }
						    	  
						    	  
						    	  
						      }
						      clienteNuevo.setLstDireccion((com.tmmas.gte.integraciongtecommon.dto.DireccionOutDTO[])
						       com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaDirecciones.toArray(),
												com.tmmas.gte.integraciongtecommon.dto.DireccionOutDTO.class));
						      
						      clienteNuevo.setCodTecnologia(cliente.getCodTecnologia());
						      clienteNuevo.setNumSerie(cliente.getNumSerie());
						      clienteNuevo.setNumImei(cliente.getNumImei());
						      clienteNuevo.setCodArticulo(cliente.getCodArticulo());
						      clienteNuevo.setDesEquipo(cliente.getDesEquipo());
						      clienteNuevo.setDesPlantarif(cliente.getDesPlantarif());
						      clienteNuevo.setTipCliente(cliente.getTipCliente());
						      clienteNuevo.setTefCliente1(cliente.getTefCliente1());
						      clienteNuevo.setCodTipCliente(cliente.getCodTipo());
						      clienteNuevo.setDesIdentApor(cliente.getDesIdentApor());
						      clienteNuevo.setNacionalidad(cliente.getDesPais());
						      clienteNuevo.setNomApeClien1(cliente.getNomApeclien1());
						      clienteNuevo.setNomApeClien2(cliente.getNomApeclien2());
						      
							
							respuestaCliente.setDatosCliente(clienteNuevo);
							respuestaCliente.setDatosClientePre(null);
							respuestaCliente.setRespuesta(new RespuestaDTO());
							return respuestaCliente;
						
					}else{
						if(outParamPos != null && outParamPos.getRespuesta() != null && outParamPos.getRespuesta().getCodigoError() != 0){
							respuestaCliente.setRespuesta(outParamPos.getRespuesta());
							return respuestaCliente;
						}else{
							respuesta = new RespuestaDTO();
							respuesta.setCodigoError(-10009);
							respuesta.setMensajeError("Se ha producido un error al obtener los datos del cliente pospago.");
						    respuestaCliente.setRespuesta(respuesta);
						    return respuestaCliente;
						}
					}
					
			/**
			 *FINAL de postpago y hibrido
			 ****/		
		    }else if(
		    		abonadoEvaluacion != null && 
					(abonadoEvaluacion.getCodTiplan() != null  && !abonadoEvaluacion.getCodTiplan().equals("")) &&
					abonadoEvaluacion.getCodTiplan().equals(global.getValor("tipo.tipPrepago"))){
				   /**
				    * CONSULTA DE DATOS PREPAGOS
				    ****/											
		    		logger.info("Consulta PREPAGO x n°telefono:antes()");
		    		com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParamPre = clienteDTODAO.consultarClientePrepago(inParam0);
		    		logger.info("Consulta PREPAGO x n°telefono:despues()");
		    		if (outParamPre != null && outParamPre.getDatosCliente() != null && outParamPre.getRespuesta()!= null &&  outParamPre.getRespuesta().getCodigoError() == 0 ){
		    			ClienteDTO clientePre = new ClienteDTO();
		    			clientePre = outParamPre.getDatosCliente();
					    /**
					     * ASIGNACION DE LA TECNOLOGIA
					     ****/											
		    			 if (clientePre.getCodTecnologia()!= null && clientePre.getCodTecnologia().equals(global.getValor("cliente.consultarDatosGenCliente.gsm"))){
							try{
								equipo.setNumSerie(""+Long.parseLong(clientePre.getNumImei()));
							}catch (Exception e) {
								equipo.setNumSerie(null);
							}
						 }else{
							try{
								equipo.setNumSerie(""+Long.parseLong(clientePre.getNumSerie()));
							}catch (Exception e) {
								equipo.setNumSerie(null);
							}
						 }
					     /**
						  * TERMINA ASIGNACION DE TECNOLOGIA
						  * 
						  * INICIAL ASIGNACION DE EQUIPO
						  ****/											
		    			  logger.info("Equipo PREPAGO x n°telefono:antes()");
						  inParamEqAbo.setEquipo(equipo);
						  inParamEqAbo.setAbonado(abonadoEvaluacion);
						  com.tmmas.gte.integraciongtecommon.dto.EquipoResponseDTO outParamEq = equipoDTODAO.consultarTerminal(inParamEqAbo);
						  logger.info("Equipo PREPAGO x n°telefono:despues()");
						  if (outParamEq != null && outParamEq.getEquipo() != null && outParamEq.getRespuesta()!= null &&  outParamEq.getRespuesta().getCodigoError() == 0 ){
							  clientePre.setDesEquipo(outParamEq.getEquipo().getDescEquipo());
							  clientePre.setCodArticulo(outParamEq.getEquipo().getCodArticulo());
						  }
					     /**
						  * TERMINA ASIGNACION DE EQUIPO
						  * 
						  * INICIAL ASIGNACION DE PRIMERA IDENTIFICACION  
						  ****/											
						  try{
							if (clientePre.getCodTipident() != null && !clientePre.getCodTipident().equals("")){
								inParamId.setCodTipIdent(clientePre.getCodTipident());
							}
						  }catch (Exception e) {
								inParamId.setCodTipIdent(null);
						  }	
						  logger.info("Identificacion1 PREPAGO x n°telefono:antes()");
						  com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamId = identificacionDTODAO.consultarTipoIdent(inParamId);
						  logger.info("Identificacion1 PREPAGO x n°telefono:despues()");
						  if (outParamId != null && (outParamId.getDesIdentificacion() != null && !outParamId.getDesIdentificacion().equals("")) && outParamId.getRespuesta()!= null &&  outParamId.getRespuesta().getCodigoError() == 0 ){
								clientePre.setDesNit(outParamId.getDesIdentificacion());
						  }		
					     /**
						  * TERMINA ASIGNACION DE PRIMERA IDENTIFICACION
						  * 
						  * INICIAL ASIGNACION DE LA SEGUNDA IDENTIFICACION
						  ****/								
						  logger.info("Identificacion2 PREPAGO x n°telefono:antes()");
						  try{
							if (clientePre.getCodTipident2() != null && !clientePre.getCodTipident2().equals("")){
								inParamId.setCodTipIdent(clientePre.getCodTipident2());
								com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamIdApoderado = identificacionDTODAO.consultarTipoIdent(inParamId);
								clientePre.setDesIdent2(outParamIdApoderado.getDesIdentificacion());
							}
						  }catch (Exception e) {
								inParamId.setCodTipIdent(null);
						  }
						  logger.info("Identificacion2 PREPAGO x n°telefono:despues()");
					     /**
						  * TERMINA ASIGNACION DE LA SEGUNDA IDENTIFICACION
						  * 
						  * INICIAL ASIGNACION DE LA IDENTIFICACION DE OPERADOR
						  ****/								
						  logger.info("operador PREPAGO x n°telefono:antes()");
							try{
								if (clientePre.getCodTipidentapor() != null && !clientePre.getCodTipidentapor().equals("")){
									inParamId.setCodTipIdent(clientePre.getCodTipidentapor());
									com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamIdApoderado = identificacionDTODAO.consultarTipoIdent(inParamId);
									clientePre.setDesIdentApor(outParamIdApoderado.getDesIdentificacion());
								}
							}catch (Exception e) {
									inParamId.setCodTipIdent(null);
							}	
					      logger.info("operador PREPAGO x n°telefono:despues()");
					     /**
						  * TERMINA ASIGNACION DE LA IDENTIFICACION DE OPERADOR
						  * 
						  * INICIAL SE SETEA EL OBJETO CLIENTE EN LA RESPUESTACLIENTE.
						  ****/	
					      ClientePrepagoDTO clienteNuevo = new ClientePrepagoDTO();
					      clienteNuevo.setSysDate(clientePre.getSysDate());
					      clienteNuevo.setNumCelular(clientePre.getNumCelular());
					      clienteNuevo.setCodCliente(clientePre.getCodCliente());
					      clienteNuevo.setNomCliente(clientePre.getNomCliente());
					      clienteNuevo.setNomApeClien1(clientePre.getNomApeClien1());
					      clienteNuevo.setNomApeClien2(clientePre.getNomApeClien2());
					      clienteNuevo.setDesNit(clientePre.getDesNit());
					      clienteNuevo.setNumIdent(clientePre.getNumIdent());
					      clienteNuevo.setCodTipident(clientePre.getCodTipident());
					      clienteNuevo.setNumIdent2(clientePre.getNumIdent2());
					      clienteNuevo.setCodTipident2(clientePre.getCodTipident2());
					      clienteNuevo.setFecNacimien(clientePre.getFecNacimien());
					      clienteNuevo.setCodTecnologia(clientePre.getCodTecnologia());
					      clienteNuevo.setNumSerie(clientePre.getNumSerie());
					      clienteNuevo.setNumImei(clientePre.getNumImei());
					      clienteNuevo.setCodArticulo(clientePre.getCodArticulo());
					      clienteNuevo.setDesEquipo(clientePre.getDesEquipo());
					      
					      respuestaCliente.setDatosClientePre(clienteNuevo);
					      respuestaCliente.setDatosCliente(null);
					      respuestaCliente.setRespuesta(new RespuestaDTO());
						  return respuestaCliente;
					
				}else{
					if(outParamPre != null && outParamPre.getRespuesta()!= null &&  outParamPre.getRespuesta().getCodigoError() != 0){
				    	respuestaCliente.setRespuesta(outParamPre.getRespuesta());
				    	return respuestaCliente;
					}else{
						respuesta = new RespuestaDTO();
						respuesta.setCodigoError(-10010);
						respuesta.setMensajeError("Se ha producido un error al obtener los datos del cliente prepago.");
					    respuestaCliente.setRespuesta(respuesta);
					    return respuestaCliente;
					}
				}
			/**
			 *final de prepago
			 ****/		
			}else{
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10011);
				respuesta.setMensajeError("No fue posible obtener datos del cliente");
			    respuestaCliente.setRespuesta(respuesta);
			}
				
				
		/**
		 * esta el else final de la primara consulta la que sirve.
		 * **/		
		}else{
			if(abonado != null && abonado.getRespuesta() != null && abonado.getRespuesta().getCodigoError() != 0){
				respuestaCliente.setRespuesta(abonado.getRespuesta());
			}else{
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10011);
				respuesta.setMensajeError("No fue posible obtener datos de cliente.");
			    respuestaCliente.setRespuesta(respuesta);
			}
		}
		logger.info("consultarDatosGenCliente:despues()");
		logger.info("consultarDatosGenCliente:end()");
		return respuestaCliente;
	}
	/**
	* Entrega un listado de datos de cliente a través de un número de teléfono y código de cliente.
	* Método sobrecargado.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DatosClienteOutDTO consultarDatosGenCliente(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		Global global = Global.getInstance();
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		DatosClienteOutDTO respuestaCliente = new DatosClienteOutDTO();
		
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
				
				respuestaCliente.setRespuesta(puntoAcceso.getRespuesta());
				return respuestaCliente;
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
					respuestaCliente.setRespuesta(aplicacionValidada);
					return respuestaCliente;
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
				respuestaCliente.setRespuesta(servicioValidado);
				return respuestaCliente;
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
				respuestaCliente.setRespuesta(usuarioValidado);
				return respuestaCliente;
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
						respuestaCliente.setRespuesta(servicio);
						return respuestaCliente;
					}
	        	}	
	       }
	        
		}else
		{
			respuestaCliente.setRespuesta(auditoria.getRespuesta());
			return respuestaCliente;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarDatosGenCliente:start()");
		logger.info("consultarDatosGenCliente:antes()");
		
		logger.info("Declaración de variables para el metodo consultarDatosGenClienteCod");
		ActividadDTO inParamAc            = new ActividadDTO();
		IdentificacionDTO inParamId       = new IdentificacionDTO();
		ConsDirecTipoDTO nuevaEntradaTipo = new ConsDirecTipoDTO(); 
		logger.info("Fin declaración de variables para el metodo consultarDatosGenClienteCod");
	     /**
		  * RECUPERARLOS DATOS DEL CLIENTE A TRAVES DE CODIGO DE CLIENTE 
		  ****/								
		logger.info("Consulta los datos del cliente x código cliente:antes()");
		com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParamCod = clienteDTODAO.consultarClienteXCodigo(inParam0);
		logger.info("Consulta los datos del cliente x código cliente:despues()");

		if (outParamCod != null && outParamCod.getDatosCliente() != null && outParamCod.getRespuesta()!= null &&  outParamCod.getRespuesta().getCodigoError() == 0 ){
			 ClienteDTO clienteCod = new ClienteDTO();
			 clienteCod = outParamCod.getDatosCliente();
		     /**
			 * INICIAL RECUPERACION LOS DATOS DE DIRECCIONES 
			 ****/								
			 nuevaEntradaTipo.setCodCliente(clienteCod.getCodCliente());
			 nuevaEntradaTipo.setTipDireccion(global.getValor("tipo.dirfacturacion"));
			 logger.info("Direccion CODIGO x código cliente:antes()");
			 com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO outParamDirec = direccionDTODAO.consultarCodigoDireccion(nuevaEntradaTipo);
			 logger.info("Direccion CODIGO x código cliente:despues()");
			 if (  outParamDirec != null 
				&& outParamDirec.getLstlistadoDireciones() != null 
				&& outParamDirec.getLstlistadoDireciones().length > 0 
				&& outParamDirec.getRespuesta()!= null 
				&&  outParamDirec.getRespuesta().getCodigoError() == 0 ){
				 
				DireccionDTO direccion = null;
				DireccionDTO objListaDireccion = null;
				ArrayList listaDireciones = new ArrayList();
				for(int i = 0 ; i < outParamDirec.getLstlistadoDireciones().length ; i++){
					direccion = outParamDirec.getLstlistadoDireciones()[i];
					if(direccion != null && direccion.getCodDireccion() != null && !direccion.getCodDireccion().equals("")){
						DireccionInDTO datosEntradas = new DireccionInDTO();
						datosEntradas.setCodDireccion(Long.parseLong(direccion.getCodDireccion()));
						datosEntradas.setCodTipDireccion(global.getValor("tipo.dirfacturacion"));
						
						objListaDireccion = direccionDTODAO.consultarDireccion(datosEntradas);
						if(objListaDireccion != null){
							listaDireciones.add(objListaDireccion);
						}
					}
				}
			     clienteCod.setLstDireccion((DireccionDTO[]) com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaDireciones.toArray(), com.tmmas.gte.integraciongtecommon.dto.DireccionDTO.class) );
			  }
			  /**
			  * TERMINA LA RECUPERACION LOS DATOS DE DIRECCIONES 
			  * 
			  * INICIAL RECUPERACION PROFESION
			  ****/	
 			  if (clienteCod.getCodProfesion() != 0){
					inParamAc.setCodActividad(clienteCod.getCodProfesion());
					logger.info("Actividad CODIGO x código cliente:antes()");
					com.tmmas.gte.integraciongtecommon.dto.ActividadResponseDTO outParamAc = actividadDTODAO.consultarActividad(inParamAc);
					logger.info("Actividad CODIGO x código cliente:despues()");
					if (outParamAc != null && (outParamAc.getDesActividad() != null  && !outParamAc.getDesActividad().equals("")) && outParamAc.getRespuesta()!= null &&  outParamAc.getRespuesta().getCodigoError() == 0 ){
						//clienteCod.setDesActividad(outParamAc.getDesActividad());
						clienteCod.setDesProfesion(outParamAc.getDesActividad());
					}	
 			   }
 			  
			  /**
			  * TERMINA RECUPERACION PROFESION
			  * 
			  * INICIAL OCUPACION 
			  ****/							 	
			  if(clienteCod.getCodOcupacion() != null && !clienteCod.getCodOcupacion().equals("")){
					inParamAc.setCodOcupacion(clienteCod.getCodOcupacion());
					logger.info("Actividad POSPAGO x n°telefono:antes()");
					com.tmmas.gte.integraciongtecommon.dto.ActividadResponseDTO outParamAc = actividadDTODAO.consultarOcupacion(inParamAc);
					logger.info("Actividad POSPAGO x n°telefono:despues()");
					if (outParamAc != null &&( outParamAc.getDesActividad() != null && !outParamAc.getDesActividad().equals("") ) &&outParamAc.getRespuesta()!= null &&  outParamAc.getRespuesta().getCodigoError() == 0 ){
						clienteCod.setDesOcupacion(outParamAc.getDesActividad());
							
					}
			  }	
			  /**
 			  * TERMINA OCUPACION
 			  * 
 			  * INICIAL RECUPERACION IDENTIFICACION NUMERO 1
 			  ****/	
			  try{
				 if (  clienteCod.getCodTipident()  != null && !clienteCod.getCodTipident().equals("")){
				    inParamId.setCodTipIdent(clienteCod.getCodTipident());
				 }
			  }catch (Exception e) {
				   inParamId.setCodTipIdent(null);
			  }
			  
			  logger.info("Identificacion CODIGO x código cliente:antes()");
			  com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamId = identificacionDTODAO.consultarTipoIdent(inParamId);
			  logger.info("Identificacion CODIGO x código cliente:despues()");
			  if (outParamId != null && (outParamId.getDesIdentificacion() != null && !outParamId.getDesIdentificacion().equals("")) && outParamId.getRespuesta()!= null &&  outParamId.getRespuesta().getCodigoError() == 0 ){
				  clienteCod.setDesIdent2(outParamId.getDesIdentificacion());
			  }  
			  /**
 			  * TERMINA RECUPERACION IDENTIFICACION NUMERO 1
 			  * 
 			  * INICIAL RECUPERACION IDENTIFICACION NUMERO 2
 			  ****/	
			  logger.info("Identificacion CODIGO x código cliente:antes()");
			  try{
					if (  clienteCod.getCodTipident2()  != null && !clienteCod.getCodTipident2().equals("")){
					   inParamId.setCodTipIdent(clienteCod.getCodTipident2());
					   com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamIdIdent2 = identificacionDTODAO.consultarTipoIdent(inParamId);
					   if (outParamIdIdent2 != null && (outParamIdIdent2.getDesIdentificacion() != null && !outParamIdIdent2.getDesIdentificacion().equals("")) && outParamIdIdent2.getRespuesta()!= null &&  outParamIdIdent2.getRespuesta().getCodigoError() == 0 ){
						   clienteCod.setDesIdent2(outParamIdIdent2.getDesIdentificacion());
					   }else{
							RespuestaDTO respuesta = new  RespuestaDTO();
							respuesta.setCodigoError(-10005);
							respuesta.setMensajeError("No fue posible obtener la identificación.");
							respuestaCliente.setRespuesta(respuesta);
							return respuestaCliente;
						}
					   
					}
			  }catch (Exception e) {
					clienteCod.setDesIdent2(null);
			  }
			  logger.info("Identificacion CODIGO x código cliente:despues()");
			  /**
 			  * TERMINA RECUPERACION IDENTIFICACION NUMERO 2
 			  * 
 			  * INICIAL RECUPERACION IDENTIFICACION OPERADOR
 			  ****/	
			  logger.info("Identificacion CODIGO x código cliente:antes()");
			  try{
					if (  clienteCod.getCodTipidentapor()  != null && !clienteCod.getCodTipidentapor().equals("")){
					   inParamId.setCodTipIdent(clienteCod.getCodTipidentapor());
					   com.tmmas.gte.integraciongtecommon.dto.IdentificacionResponseDTO outParamIdApoderado = identificacionDTODAO.consultarTipoIdent(inParamId);
					   if (outParamIdApoderado != null && (outParamIdApoderado.getDesIdentificacion() != null && !outParamIdApoderado.getDesIdentificacion().equals("")) && outParamIdApoderado.getRespuesta()!= null &&  outParamIdApoderado.getRespuesta().getCodigoError() == 0 ){
					   clienteCod.setDesIdentApor(outParamIdApoderado.getDesIdentificacion());
					   }else{
							RespuestaDTO respuesta = new  RespuestaDTO();
							respuesta.setCodigoError(-10005);
							respuesta.setMensajeError("No fue posible obtener la identificación.");
							respuestaCliente.setRespuesta(respuesta);
							return respuestaCliente;
						}
					}
			  }catch (Exception e) {
					clienteCod.setDesIdentApor(null);
			  }
			  logger.info("Identificacion CODIGO x código cliente:despues()");
			  
			  /**
 			  * TERMINA RECUPERACION IDENTIFICACION OPERADOR
 			  * 
 			  * INICIAL EL SETEO DE OBJETO CLIENTE  Y EL DE RESPUESTA 
 			  ****/	
			  
			      ClienteOutDTO clienteNuevo = new ClienteOutDTO();
			      clienteNuevo.setSysDate(clienteCod.getSysDate());
			      clienteNuevo.setNumCelular(clienteCod.getNumCelular());
			      clienteNuevo.setCodCliente(clienteCod.getCodCliente());
			      clienteNuevo.setNomCliente(clienteCod.getNomCliente());
			      clienteNuevo.setNomApeClien1(clienteCod.getNomApeClien1());
			      clienteNuevo.setNomApeClien2(clienteCod.getNomApeClien2());
			      clienteNuevo.setDesNit(clienteCod.getDesNit());
			      clienteNuevo.setNumIdent(clienteCod.getNumIdent());
			      clienteNuevo.setCodTipident(clienteCod.getCodTipident());
			      clienteNuevo.setNumIdentapor(clienteCod.getNumIdentapor());
			      clienteNuevo.setCodTipidentapor(clienteCod.getCodTipidentapor());
			      clienteNuevo.setFecNacimien(clienteCod.getFecNacimien());
			      clienteNuevo.setCodProfesion(clienteCod.getCodProfesion());
			      clienteNuevo.setDesProfesion(clienteCod.getDesProfesion());
			      clienteNuevo.setCodOcupacion(clienteCod.getCodOcupacion());
			      clienteNuevo.setDesOcupacion(clienteCod.getDesOcupacion());
			      clienteNuevo.setNomApoderado(clienteCod.getNomApoderado());
			      clienteNuevo.setIndEstcivil(clienteCod.getIndEstcivil());
			      clienteNuevo.setNacionalidad(clienteCod.getNacionalidad());
			      
			      
			      ArrayList listaDirecciones = new ArrayList();
			      for(int i = 0; i < clienteCod.getLstDireccion().length ; i++){
			    	  DireccionDTO nuevo = clienteCod.getLstDireccion()[i];
			    	  if(nuevo != null ){
			    		  DireccionOutDTO direccion = new DireccionOutDTO();
			    		  direccion.setCodTipoCalle(nuevo.getCodTipoCalle()); 
			    		  direccion.setCodTipDireccion(nuevo.getCodTipDireccion()); 
			    		  direccion.setDesTipDireccion(nuevo.getDesTipDireccion()); 
			    		  direccion.setCodDireccion(nuevo.getCodDireccion()); 
			    		  direccion.setCodProvincia(nuevo.getCodProvincia()); 
			    		  direccion.setDesProvincia(nuevo.getDesProvincia()); 
			    		  direccion.setCodRegion(nuevo.getCodRegion()); 
			    		  direccion.setDesRegion(nuevo.getDesRegion());
			    		  direccion.setCodCiudad(nuevo.getCodCiudad()); 
			    		  direccion.setDesCuidad(nuevo.getDesCuidad());
			    		  direccion.setCodComuna(nuevo.getCodComuna());
			    		  direccion.setDesComuna(nuevo.getDesComuna());
			    		  direccion.setNomCalle(nuevo.getNomCalle()); 
			    		  direccion.setNumCalle(nuevo.getNumCalle()); 
			    		  direccion.setNumCasilla(nuevo.getNumCalle()); 
			    		  direccion.setObsDirecc(nuevo.getObsDirecc()); 
			    		  direccion.setDesDirec1(nuevo.getDesDirec1()); 
			    		  direccion.setDesDirec2(nuevo.getDesDirec2()); 
			    		  direccion.setCodPueblo(nuevo.getCodPueblo()); 
			    		  direccion.setCodEstado(nuevo.getCodEstado()); 
			    		  direccion.setNumPiso(nuevo.getNumPiso());
			    		  listaDirecciones.add(direccion);
			    	  }
			    	  
			    	  
			    	  
			      }
			      clienteNuevo.setLstDireccion((com.tmmas.gte.integraciongtecommon.dto.DireccionOutDTO[])
			       com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaDirecciones.toArray(),
									com.tmmas.gte.integraciongtecommon.dto.DireccionOutDTO.class));
			      
			      clienteNuevo.setTipCliente(clienteCod.getTipCliente());
			      clienteNuevo.setTefCliente1(clienteCod.getTefCliente1());
			      clienteNuevo.setCodTipCliente(clienteCod.getCodTipo());
			      clienteNuevo.setNomApeClien1(clienteCod.getNomApeclien1());
			      clienteNuevo.setNomApeClien2(clienteCod.getNomApeclien2());
			      clienteNuevo.setNacionalidad(clienteCod.getDesPais());
			      clienteNuevo.setDesIdentApor(clienteCod.getDesIdentApor());

			      respuestaCliente.setDatosCliente(clienteNuevo);
				  respuestaCliente.setRespuesta(new RespuestaDTO());
				  return respuestaCliente;
			  /**
 			  * TERMINA EL SETEO DE OBJETO CLIENTE Y EL DE RESPUESTA
 			  ****/			  
			
		}else{
			if(outParamCod != null && outParamCod.getRespuesta() != null && outParamCod.getRespuesta().getCodigoError() != 0){
				respuestaCliente.setRespuesta(outParamCod.getRespuesta());
				return respuestaCliente;
			}else{
				RespuestaDTO respuesta = new  RespuestaDTO();
			    respuesta.setCodigoError(-10011);
			    respuesta.setMensajeError("No fue posible obtener datos de cliente.");
			    respuestaCliente.setRespuesta(respuesta);
			}
		}

		logger.info("consultarDatosGenCliente:despues()");
		logger.info("consultarDatosGenCliente:end()");
		
		return respuestaCliente;
	}
	/**
	* Servicio que permite identificar si una persona es de tipo natural o empresa. 
	* Autor: Leonardo Muñoz R. 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespTipoClienteDTO consultarTipoCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 campos					= new ArrayList();
		
		RespTipoClienteDTO RespTipoClienteDTO = new RespTipoClienteDTO();
		
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
				
				RespTipoClienteDTO.setRespuesta(puntoAcceso.getRespuesta());
				return RespTipoClienteDTO;
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
					RespTipoClienteDTO.setRespuesta(aplicacionValidada);
					return RespTipoClienteDTO;
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
				RespTipoClienteDTO.setRespuesta(servicioValidado);
				return RespTipoClienteDTO;
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
				RespTipoClienteDTO.setRespuesta(usuarioValidado);
				return RespTipoClienteDTO;
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
						RespTipoClienteDTO.setRespuesta(servicio);
						return RespTipoClienteDTO;
					}
	        	}	
	       }
	        
		}else
		{
			RespTipoClienteDTO.setRespuesta(auditoria.getRespuesta());
			return RespTipoClienteDTO;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarTipoCliente:start()");
		logger.info("consultarTipoCliente:antes()");
		
		logger.info("declaracion de variables para el metodo consultarTipoCliente");
		AbonadoDTO respAbonado = new AbonadoDTO();
		RespuestaDTO respuesta = new RespuestaDTO();
		//RespTipoClienteDTO RespTipoClienteDTO = new RespTipoClienteDTO();
		logger.info("fin de la declaraciones de variables para el metodo consultarTipoCliente");
		
		EsTelefIgualClieDTO telefonoCliente = new EsTelefIgualClieDTO(); 
		telefonoCliente.setNum_telefono1(inParam0.getNumeroTelefono());

		if (inParam0.getNumeroTelefono() != 0){
			logger.info("Abonado x n°telefono:antes()");
			com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO abonado = abonadoDTODAO.consultarAbonadoTelefono(telefonoCliente);
			logger.info("Abonado x n°telefono:despues()");
			if (abonado != null && abonado.getRespuesta()!= null &&  abonado.getRespuesta().getCodigoError() == 0 && abonado.getListadoAbonados().length > 0){
				for(int i = 0 ; i < abonado.getListadoAbonados().length; i++){
					respAbonado = abonado.getListadoAbonados()[i];
				}
			}
			if (respAbonado != null && respAbonado.getCodCliente() != 0){
				CodClienteDTO codClienteDTO = new CodClienteDTO();
				codClienteDTO.setCodCliente(respAbonado.getCodCliente());
				logger.info("Consulta tipo cliente:antes()");
				com.tmmas.gte.integraciongtecommon.dto.DatosClienteResponseDTO outParam0 = clienteDTODAO.consultarTipoCliente(codClienteDTO);
				logger.info("Consulta tipo cliente:despues()");
				if (outParam0 != null && outParam0.getDatosCliente() != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == 0){
						RespTipoClienteDTO.setCodCliente(outParam0.getDatosCliente().getCodCliente());
						RespTipoClienteDTO.setCodTipo(outParam0.getDatosCliente().getCodTipo());
						RespTipoClienteDTO.setTipCliente(outParam0.getDatosCliente().getTipCliente());
						RespTipoClienteDTO.setRespuesta(outParam0.getRespuesta());
				}else{
					if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0){
						RespTipoClienteDTO.setRespuesta(outParam0.getRespuesta());
					}else{
						respuesta.setCodigoError(-10011);
						respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			    		respuesta.setMensajeError("No fue posible obtener datos de cliente.");
			    		RespTipoClienteDTO.setRespuesta(respuesta);
					}
				}
			}else{
				if(abonado  != null && abonado.getRespuesta() != null && abonado.getRespuesta().getCodigoError() != 0){
					RespTipoClienteDTO.setRespuesta(abonado.getRespuesta());
				}else{
					respuesta.setCodigoError(-10011);
		    		respuesta.setMensajeError("No fue posible obtener datos de cliente.");
		    		RespTipoClienteDTO.setRespuesta(respuesta);
				}
			}
		}
		logger.info("consultarTipoCliente:despues()");
		logger.info("consultarTipoCliente:end()");
		
		return RespTipoClienteDTO;
		
	}
	/**
	* Entrega Datos Del segmento del Cliente (Obtener Segmento del Cliente)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SegmentoClienteResponseDTO obtenerSegmentoCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));

		CodClienteDTO 				codClienteDTO			= new CodClienteDTO();
		SegmentoClienteResponseDTO 	segmentoClienteResponse = new SegmentoClienteResponseDTO();
		EsTelefIgualClieDTO 		telefonoClienteDTO 		= new EsTelefIgualClieDTO();
		AuditoriaDTO		 		codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 		codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 		codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 		nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 		campos					= new ArrayList();

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
				segmentoClienteResponse.setRespuesta(puntoAcceso.getRespuesta());
				return segmentoClienteResponse;
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
					segmentoClienteResponse.setRespuesta(aplicacionValidada);
					return segmentoClienteResponse;
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
				segmentoClienteResponse.setRespuesta(servicioValidado);
				return segmentoClienteResponse;
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
				segmentoClienteResponse.setRespuesta(usuarioValidado);
				return segmentoClienteResponse;
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
						segmentoClienteResponse.setRespuesta(servicio);
						return segmentoClienteResponse;
					}
	       }
	        	       
		}else
		{
			segmentoClienteResponse.setRespuesta(auditoria.getRespuesta());
			return segmentoClienteResponse;
		}
		// Fin Proceso de Auditoria 

		telefonoClienteDTO.setNum_telefono1(inParam0.getNumeroTelefono());
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		AbonadoOutDTO outParam0 = abonadoDTODAO.consultarAbonadoTelefono(telefonoClienteDTO);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  )
		{
			if(outParam0.getListadoAbonados().length>0)
			{
				segmentoClienteResponse.setCodTecnologia(outParam0.getListadoAbonados()[0].getCodTecnologia());
				codClienteDTO.setCodCliente(outParam0.getListadoAbonados()[0].getCodCliente());
				logger.info("consultarAbonadoTelefono:start()");
				logger.info("consultarAbonadoTelefono:antes()");
				segmentoClienteResponse  = clienteDTODAO.obtenerSegmentoCliente(codClienteDTO);
				logger.info("consultarAbonadoTelefono:despues()");
				logger.info("consultarAbonadoTelefono:end()");
				if (segmentoClienteResponse != null && segmentoClienteResponse.getRespuesta()!= null &&  segmentoClienteResponse.getRespuesta().getCodigoError()==0  )
				{
					segmentoClienteResponse.setCodTecnologia(outParam0.getListadoAbonados()[0].getCodTecnologia());
				}else{
					segmentoClienteResponse.setRespuesta(segmentoClienteResponse.getRespuesta());
				}
			}else{
				outParam0.getRespuesta().setMensajeError("No ha sido posible obtener datos del segmento del cliente");
				segmentoClienteResponse.setRespuesta(outParam0.getRespuesta());
			}
		
	  }else{
		  outParam0.getRespuesta().setMensajeError("No ha sido posible obtener datos del segmento del cliente");
		  segmentoClienteResponse.setRespuesta(outParam0.getRespuesta());
	  }
		return segmentoClienteResponse;
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
		com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO outParam0 = clienteDTODAO.consultarDatosDistrib(distribuidorIn);
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			respDistrib.setNomVendedor(outParam0.getNomVendedor());
			respDistrib.setCodTipident(outParam0.getCodTipident());
			respDistrib.setDesTipident(outParam0.getDesTipident());
			respDistrib.setNumIdent(outParam0.getNumIdent());
			respDistrib.setCodCliente(outParam0.getCodCliente());
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			respDistrib.setRespuesta(respuesta);
			
			logger.info("consBodegasDistrib:start()");
			logger.info("consBodegasDistrib:antes()");
			com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO outParam1 = clienteDTODAO.consultarBodegasDistrib(distribuidorIn);
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
	public com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO consultarDatosDistribuidor(com.tmmas.gte.integraciongtecommon.dto.DistribPedidoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		DistribuidorDTO distribuidorIn 			= new DistribuidorDTO();
		DistribPedidoResponseDTO respDistrib	= new DistribPedidoResponseDTO();
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
		com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO outParam0 = clienteDTODAO.consultarDatosDistrib(distribuidorIn);
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			respDistrib.setNomVendedor(outParam0.getNomVendedor());
			respDistrib.setCodTipident(outParam0.getCodTipident());
			respDistrib.setDesTipident(outParam0.getDesTipident());
			respDistrib.setNumIdent(outParam0.getNumIdent());
			respDistrib.setCodCliente(outParam0.getCodCliente());
			distribuidorIn.setCodClienteDistrib(Long.parseLong(outParam0.getCodCliente()));
			distribuidorIn.setCodPedido(inParam0.getCodPedido());
			respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
			respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
			respDistrib.setRespuesta(respuesta);
			
			logger.info("consBodegasDistrib:start()");
			logger.info("consBodegasDistrib:antes()");
			com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO outParam1 = clienteDTODAO.consultarBodegasDistrib(distribuidorIn);
			logger.info("consBodegasDistrib:despues()");
			logger.info("consBodegasDistrib:end()");
			
			if (outParam1 != null && outParam1.getRespuesta()!= null &&  outParam1.getRespuesta().getCodigoError()==0  ){
				if ( outParam1.getListBodegas() != null && outParam1.getListBodegas().length > 0){
					respDistrib.setBodegasList(outParam1.getListBodegas());
					
					logger.info("consPedidoDistrib:start()");
					logger.info("consPedidoDistrib:antes()");
					com.tmmas.gte.integraciongtecommon.dto.DistribPedidoResponseDTO outParam2 = clienteDTODAO.consultarPedidoDistrib(distribuidorIn);
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
						DistribPedidoResponseDTO resp = new DistribPedidoResponseDTO();
						respuesta.setCodigoError(outParam2.getRespuesta().getCodigoError());
						respuesta.setMensajeError(outParam2.getRespuesta().getMensajeError());
						respuesta.setNumeroEvento(outParam2.getRespuesta().getNumeroEvento());
						resp.setRespuesta(respuesta);
						return resp;
					}
				}else{
					DistribPedidoResponseDTO resp = new DistribPedidoResponseDTO();
					respuesta.setCodigoError(outParam1.getRespuesta().getCodigoError());
					respuesta.setMensajeError(outParam1.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(outParam1.getRespuesta().getNumeroEvento());
					resp.setRespuesta(respuesta);
					return resp;
				}
			}else{
				DistribPedidoResponseDTO resp = new DistribPedidoResponseDTO();
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