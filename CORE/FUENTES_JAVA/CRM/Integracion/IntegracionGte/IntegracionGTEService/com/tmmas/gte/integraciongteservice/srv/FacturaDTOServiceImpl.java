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
import com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConceptoFacturasDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsultarConscFactDTO;
import com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaMesAnteriorResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaNoCicloDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaNoCicloResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.FechaReporteConsumoDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesDTO;
import com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;
import com.tmmas.gte.integraciongteservice.helper.Util;

public class FacturaDTOServiceImpl implements FacturaDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(FacturaDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.FacturaDTODAO 				facturaDTODAO 			= new com.tmmas.gte.integraciongtebo.dao.FacturaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 				abonadoDAO 				= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAO 	consFacturasAdesplegar 	= new com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ClienteDTODAO 				distribuidorDAO 		= new com.tmmas.gte.integraciongtebo.dao.ClienteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 				auditoriaDAO			= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAO 	consParametros 			= new com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAOImpl();
	
	public FacturaDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	/**
	* Entrega conceptos facturables
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO consultarConceptosFactura(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		ConsultarConscFactDTO 	inParam1  			= new ConsultarConscFactDTO();
		FacturaInDTO 			facturaInDTO        = new FacturaInDTO();
		LstConceptoFacturaDTO 	outParam1 			= new LstConceptoFacturaDTO();
		LstConceptoFacturaDTO 	outParamAux 		= new LstConceptoFacturaDTO();
		ArrayList 				listaConceptos 		= new ArrayList();
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		ParametrosGeneralesDTO 	consParamFactura 	= new ParametrosGeneralesDTO();
		ParametrosGeneralesResponseDTO paramFactura = new ParametrosGeneralesResponseDTO();
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
				outParam1.setRespuesta(puntoAcceso.getRespuesta());
				return outParam1;
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
					outParam1.setRespuesta(aplicacionValidada);
					return outParam1;
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
				outParam1.setRespuesta(servicioValidado);
				return outParam1;
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
				outParam1.setRespuesta(usuarioValidado);
				return outParam1;
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
						outParam1.setRespuesta(servicio);
						return outParam1;
					}
	       }
	        	       
		}else
		{
			outParam1.setRespuesta(auditoria.getRespuesta());
			return outParam1;
		}
		// Fin Proceso de Auditoria 
		Global global = Global.getInstance();
		facturaInDTO.setOpcion(Integer.parseInt(global.getValor("opcion.todas.facturas")));
		facturaInDTO.setCodCliente(inParam0.getCodCliente());
		
		consParamFactura.setNomParametro(global.getValor("factura.nomparametroconcepto"));
		consParamFactura.setCodModulo(global.getValor("factura.codmodulo"));
		consParamFactura.setCodProducto(Integer.parseInt(global.getValor("factura.codproducto")));
		
		logger.info("consultarParametros:start()");
		logger.info("consultarParametros:antes()");
			paramFactura = consFacturasAdesplegar.consultarParametros(consParamFactura);
		logger.info("consultarParametros:despues()");
		logger.info("consultarParametros:end()");
		if (paramFactura != null && paramFactura.getRespuesta() != null && paramFactura.getRespuesta().getCodigoError() == 0)
		{
			facturaInDTO.setCantidadIteracion(Integer.parseInt(paramFactura.getValParametro()));
			logger.info("consultarFacturas:start()");
			logger.info("consultarFacturas:antes()");
			com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = facturaDTODAO.consultarFacturas(facturaInDTO);
			logger.info("consultarFacturas:despues()");
			logger.info("consultarFacturas:end()");
			if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getLstListadoFacturas() != null&& outParam0.getRespuesta().getCodigoError() == 0){
				if(outParam0.getLstListadoFacturas().length > 0 ){
					for (int i=0;i<(outParam0.getLstListadoFacturas().length);i++){
						inParam1.setCodCliente(inParam0.getCodCliente());
						inParam1.setNumFolio(outParam0.getLstListadoFacturas()[i].getNumFolio());
						inParam1.setCodTipDocum(outParam0.getLstListadoFacturas()[i].getCodTipDocum());
	  
						logger.info("consultarConceptosFactura:start()" + i );
						logger.info("consultarConceptosFactura:antes()" + i);
						outParamAux = facturaDTODAO.consultarConceptosFactura(inParam1);
						if(outParamAux.getListadoConcFactura() == null){
								outParam1.setRespuesta(outParamAux.getRespuesta());
						}else{
							for (int j=0;j<outParamAux.getListadoConcFactura().length;j++)
							{
								ConceptoFacturasDTO conceptoFacturaAux1 = new ConceptoFacturasDTO();
								conceptoFacturaAux1.setCodConcepto(outParamAux.getListadoConcFactura()[j].getCodConcepto());
								conceptoFacturaAux1.setDesConcepto(outParamAux.getListadoConcFactura()[j].getDesConcepto());
								conceptoFacturaAux1.setImporteDebe(outParamAux.getListadoConcFactura()[j].getImporteDebe());
								conceptoFacturaAux1.setImporteHaber(outParamAux.getListadoConcFactura()[j].getImporteHaber());
								listaConceptos.add(conceptoFacturaAux1);
							}	
							
						}
						outParam1.setListadoConcFactura((com.tmmas.gte.integraciongtecommon.dto.ConceptoFacturasDTO[])
								com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaConceptos.toArray(),
														com.tmmas.gte.integraciongtecommon.dto.ConceptoFacturasDTO.class));
						
						outParam1.setRespuesta(outParamAux.getRespuesta());
						logger.info("consultarConceptosFactura:despues()"+ i);
						logger.info("consultarConceptosFactura:end()" + i);
					}
				}else{
					outParam0.getRespuesta().setMensajeError("Cliente no presenta periodos facturados");
					outParam1.setRespuesta(outParam0.getRespuesta());
				}
			}else{
				
				outParam0.getRespuesta().setMensajeError("No ha sido posible obtener las facturas del cliente");
				outParam1.setRespuesta(outParam0.getRespuesta());
			}
		}else{
			paramFactura.getRespuesta().setMensajeError("No ha sido posible obtener las facturas del cliente");
			outParam1.setRespuesta(paramFactura.getRespuesta());
		}

		return outParam1;
	}
    /**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagas e inpagas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarFacturas:start()");
		logger.info("consultarFacturas:antes()");
		com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = facturaDTODAO.consultarFacturas(inParam0);
		
		if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getLstListadoFacturas() != null&& outParam0.getRespuesta().getCodigoError() == 0){
			if(outParam0.getLstListadoFacturas().length == 0 ){
				RespuestaDTO nuevaRespuesta = new RespuestaDTO();
				nuevaRespuesta.setCodigoError(-10014);
				nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas del cliente");
				nuevaRespuesta.setNumeroEvento(0);
				outParam0.setRespuesta(nuevaRespuesta);

			}
		}else{
			if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == 0 ){
				RespuestaDTO nuevaRespuesta = new RespuestaDTO();
				nuevaRespuesta.setCodigoError(-10014);
				nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas del cliente");
				outParam0.setRespuesta(nuevaRespuesta);
			}	

		}
		logger.info("consultarFacturas:despues()");
		logger.info("consultarFacturas:end()");
		return outParam0;
	}
	
	/**
	* Consulta Link de Factura para un proceso ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO consultarLinkFactura(com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		ConsLinkFacturaResponseDTO linkFacturaResp = new ConsLinkFacturaResponseDTO();
		ConsLinkFacturaDTO datosEntrada = new ConsLinkFacturaDTO();
		RespuestaDTO 	respuesta 				= new RespuestaDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		datosEntrada.setCodCliente(inParam0.getCodCliente());
		datosEntrada.setNumProceso(inParam0.getNumProceso());
		
		
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
				linkFacturaResp.setRespuesta(respuesta);
				return linkFacturaResp;
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
					linkFacturaResp.setRespuesta(aplicacionValidada);
					return linkFacturaResp;
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
				linkFacturaResp.setRespuesta(servicioValidado);
				return linkFacturaResp;
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
				linkFacturaResp.setRespuesta(usuarioValidado);
				return linkFacturaResp;
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
					linkFacturaResp.setRespuesta(respuesta);
					return linkFacturaResp;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			linkFacturaResp.setRespuesta(respuesta);
			return linkFacturaResp;
		}
		//Fin de Registro de auditoría 				

		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarLinkFactura:start()");
		logger.info("consultarLinkFactura:antes()");
		com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO outParam0 = facturaDTODAO.consultarLinkFactura(datosEntrada);
		logger.info("consultarLinkFactura:despues()");
		logger.info("consultarLinkFactura:end()");
		if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
			linkFacturaResp.setRutaFactura(outParam0.getRutaFactura());
			linkFacturaResp.setRespuesta(outParam0.getRespuesta());
		}else {
			if (outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0){
				linkFacturaResp.setRespuesta(outParam0.getRespuesta());
			}else {
				respuesta  = new RespuestaDTO();
				respuesta.setCodigoError(-10015);
				respuesta.setMensajeError("No fue posible obtener el link de Factura.");
				linkFacturaResp.setRespuesta(respuesta);
			}
		}
		return linkFacturaResp;
	}

	/**
	* Metodos Creado, se ingresa solo el numero telefonico, se trabaja para poder obtener los datos y retorna FacturaResponseDTO.  
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasPorCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("declaracion de variables para el metodo consultarFacturasPorCliente");
		FacturaInDTO facturaInDTO = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;         
		FacturaResponseDTO  facturaResponseFinal = new FacturaResponseDTO();
		RespuestaDTO nuevaRespuesta = null;
		RespuestaDTO    respuesta = new RespuestaDTO();
		Global global = Global.getInstance();
		ParametrosGeneralesResponseDTO paramFactura = new ParametrosGeneralesResponseDTO();
		ParametrosGeneralesDTO consParamFactura = new ParametrosGeneralesDTO();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
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
				respuesta.setCodigoError(puntoAcceso.getRespuesta().getCodigoError());
				respuesta.setMensajeError(puntoAcceso.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(puntoAcceso.getRespuesta().getNumeroEvento());
				facturaResponseFinal.setRespuesta(respuesta);
				return facturaResponseFinal;
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
					facturaResponseFinal.setRespuesta(aplicacionValidada);
					return facturaResponseFinal;
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
				facturaResponseFinal.setRespuesta(servicioValidado);
				return facturaResponseFinal;
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
				facturaResponseFinal.setRespuesta(usuarioValidado);
				return facturaResponseFinal;
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
							facturaResponseFinal.setRespuesta(respuesta);
							return facturaResponseFinal;
						}
			        }	
				}else
				{
					respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
					respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
					facturaResponseFinal.setRespuesta(respuesta);
					return facturaResponseFinal;
				}
			//Fin de Registro de auditoría 
				
		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abanado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoAbonados() != null 
		     	   && datosAbonados.getListadoAbonados().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
			     			abonado = datosAbonados.getListadoAbonados()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo :consultarAbonadoTelefono");
		logger.info("cerrando AbonadoImpl");		
		
		logger.info("construción para obtener los datos de los facturas por clientes, con el opcion  Nº 1");
		   if(abonado != null && abonado.getCodCliente()!=0 ){
			  if(abonado.getCodTiplan() != null && 
			    !abonado.getCodTiplan().equals("") && 
			    (abonado.getCodTiplan().equals(global.getValor("tipo.tipPospago")) || 
			     abonado.getCodTiplan().equals(global.getValor("tipo.tipPostpago")) ||
			     abonado.getCodTiplan().equals(global.getValor("tipo.tipHibrido")))){ 
				   facturaInDTO = new FacturaInDTO();
				   facturaInDTO.setCodCliente(abonado.getCodCliente());
				   logger.info("leer properties del service :start()");
				   
				   /* Código agregado por Alejandro Lorca */
				   consParamFactura.setNomParametro(global.getValor("factura.nomparametro"));
				   consParamFactura.setCodModulo(global.getValor("factura.codmodulo"));
				   consParamFactura.setCodProducto(Integer.parseInt(global.getValor("factura.codproducto")));
				   paramFactura = consFacturasAdesplegar.consultarParametros(consParamFactura);
				   
				   if (paramFactura != null && paramFactura.getRespuesta() != null && paramFactura.getRespuesta().getCodigoError() == 0){
					   facturaInDTO.setCantidadIteracion(Integer.parseInt(paramFactura.getValParametro()));
					   /* Fin Código Alejandro Lorca */
					   
					   try{
						   facturaInDTO.setOpcion(Integer.parseInt(global.getValor("factura.consultarFacturasPorCliente.pagaeimpaga")));
					   }catch (Exception e) {
						   /*excepcion, se coloca uno  1 para poder implemetar el metodo de paga e impagas dentro del PL*/
						   facturaInDTO.setOpcion(1);
					   }
					   logger.info("leer properties del service :end()");

					   logger.info("consultarFacturas:start()");
					   logger.info("consultarFacturas:antes()");
						    facturaResponseFinal = facturaDTODAO.consultarFacturas(facturaInDTO);
							if(facturaResponseFinal != null && facturaResponseFinal.getRespuesta() != null && facturaResponseFinal.getLstListadoFacturas() != null && facturaResponseFinal.getRespuesta().getCodigoError() == 0){
								if(facturaResponseFinal.getLstListadoFacturas().length == 0 ){
									nuevaRespuesta = new RespuestaDTO();
									nuevaRespuesta.setCodigoError(-10014);
									nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas del cliente");
									nuevaRespuesta.setNumeroEvento(facturaResponseFinal.getRespuesta().getNumeroEvento());
									facturaResponseFinal.setRespuesta(nuevaRespuesta);
								}
							}else{
								nuevaRespuesta = new RespuestaDTO();
								nuevaRespuesta.setCodigoError(facturaResponseFinal.getRespuesta().getCodigoError());
								nuevaRespuesta.setMensajeError(facturaResponseFinal.getRespuesta().getMensajeError());
								nuevaRespuesta.setNumeroEvento(facturaResponseFinal.getRespuesta().getNumeroEvento());
								facturaResponseFinal.setRespuesta(nuevaRespuesta);
							}
						logger.info("consultarFacturas:despues()");
						logger.info("consultarFacturas:end()");

				   		}else{
				   			/* Código agregado por Alejandro Lorca */
				   			facturaResponseFinal = new FacturaResponseDTO();
				   			nuevaRespuesta = new RespuestaDTO();
							if(paramFactura != null && paramFactura.getRespuesta() != null && paramFactura.getRespuesta().getCodigoError() != 0 ){
								nuevaRespuesta.setCodigoError(paramFactura.getRespuesta().getCodigoError());
								nuevaRespuesta.setMensajeError(paramFactura.getRespuesta().getMensajeError());
							    nuevaRespuesta.setNumeroEvento(paramFactura.getRespuesta().getNumeroEvento());
							 }
							facturaResponseFinal.setRespuesta(nuevaRespuesta);
							/* Fin Código Alejandro Lorca */
				   		}
				   	}else{
	 					 if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
						     facturaResponseFinal.setRespuesta(datosAbonados.getRespuesta());
						 }else{
						     facturaResponseFinal = new FacturaResponseDTO();
							 nuevaRespuesta = new RespuestaDTO();
							 nuevaRespuesta.setCodigoError(-10048);
							 nuevaRespuesta.setMensajeError("El Número teléfono no es pospago");
							 facturaResponseFinal.setRespuesta(nuevaRespuesta);
						 }
			  }
		   }else{
			   if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
				    facturaResponseFinal.setRespuesta(datosAbonados.getRespuesta());
				}else{
				    facturaResponseFinal = new FacturaResponseDTO();
					nuevaRespuesta = new RespuestaDTO();
					nuevaRespuesta.setCodigoError(-10048);
					nuevaRespuesta.setMensajeError("El Número teléfono no es pospago");
					facturaResponseFinal.setRespuesta(nuevaRespuesta);
				}
		   }
         logger.info("termina la obtencion de los datos de los facturas por clientes, con el opcion  Nº 1");		
		return facturaResponseFinal;
	}
	
	/**
	* Servicio que permite consultar las facturas pendientes de pago de un cliente. 
	* Autor: Leonardo Muñoz R.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasImpagasPorCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		Global global = Global.getInstance();
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 			 campos					= new ArrayList();
		
		FacturaResponseDTO 	 facturaResponseFinal  	= new FacturaResponseDTO();
		RespuestaDTO 		 respuesta				= new RespuestaDTO();
		
//		Realizando Proceso de Auditoria 
		//Validación de Punto Acceso
		codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
		logger.info("validarPuntoAcceso:start()");
		logger.info("validarPuntoAcceso:antes()");
		PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
		logger.info("validarPuntoAcceso:despues()");
		logger.info("validarPuntoAcceso:end()");
		if (puntoAcceso.getRespuesta().getCodigoError()!=0)
		{
			facturaResponseFinal.setRespuesta(puntoAcceso.getRespuesta());
			return facturaResponseFinal;
		}
		//Fin Validación de Punto Acceso
		//Validación de Cod. Aplicacion
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
				facturaResponseFinal.setRespuesta(aplicacionValidada);
				return facturaResponseFinal;
			}
		}
		//Fin validación de Cod. Aplicacion
		//Validación de Cod. Servicio
		codServicioDto.setCodServicio(inParam0.getAuditoria().getCodServicio());
		logger.info("validarServicio:start()");
		logger.info("validarServicio:antes()");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO servicioValidado =  auditoriaDAO.validarServicio(codServicioDto);
		logger.info("validarServicio:despues()");
		logger.info("validarServicio:end()");
		if (servicioValidado.getCodigoError()!=0)
		{
			facturaResponseFinal.setRespuesta(servicioValidado);
			return facturaResponseFinal;
		}
		//Fin Validación de Cod. Servicio
		//Validación de nombre Usuario
		nombreUsuarioDto.setNombreUsuario(inParam0.getAuditoria().getNombreUsuario());
		logger.info("validarNombreUsuario:start()");
		logger.info("validarNombreUsuario:antes()");
		com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO usuarioValidado =  auditoriaDAO.validarNombreUsuario(nombreUsuarioDto);
		logger.info("validarNombreUsuario:despues()");
		logger.info("validarNombreUsuario:end()");
		if (usuarioValidado.getCodigoError()!=0)
		{
			facturaResponseFinal.setRespuesta(usuarioValidado);
			return facturaResponseFinal;
		}
		//Fin Validación de nombre Usuario
		
		//Inicio de Registro de auditoría 		
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
			//Fin de Obtención de Nombres de Campos del DTO de Entrada
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
							respuesta.setCodigoError(servicio.getCodigoError());
							respuesta.setMensajeError(servicio.getMensajeError());
							respuesta.setNumeroEvento(servicio.getNumeroEvento());
							facturaResponseFinal.setRespuesta(respuesta);
							return facturaResponseFinal;
						}
				}	
			}
		
			}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			facturaResponseFinal.setRespuesta(respuesta);
			return facturaResponseFinal;
		}
		//Fin de Registro de auditoría
		
		FacturaInDTO facturaInDTO     = null;
		AbonadoPospagoDTO datoPospago = null;
		RespuestaDTO nuevaRespuesta   = null;
		
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null; 
		
		ParametrosGeneralesResponseDTO paramFactura = new ParametrosGeneralesResponseDTO();
		ParametrosGeneralesDTO consParamFactura     = new ParametrosGeneralesDTO();
		 
		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abanado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoAbonados() != null 
		     	   && datosAbonados.getListadoAbonados().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
			     			abonado = datosAbonados.getListadoAbonados()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo :consultarAbonadoTelefono");
		logger.info("cerrando AbonadoImpl");	
		
		
		
		
		
		if (abonado != null && abonado.getCodCliente() != 0){
			
			      if(!abonado.getCodTiplan().equals("") && 
				    (abonado.getCodTiplan().equals(global.getValor("tipo.tipPospago")) || 
				     abonado.getCodTiplan().equals(global.getValor("tipo.tipPostpago")))){ 
				
			    	  inParam0.setDesPlanTarifario(global.getValor("plan.tarifario.pospago"));
			    	  
			      }else if(!abonado.getCodTiplan().equals("") &&
			    		  (abonado.getCodTiplan().equals(global.getValor("tipo.tipHibrido")))){
				
			    	  inParam0.setDesPlanTarifario(global.getValor("plan.tarifario.hibrido"));
			      }

			      
			      
			com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO lstPospago = abonadoDAO.consAbonadoPospagoHibrido(inParam0);
			if (lstPospago != null && lstPospago.getListadoClientes() != null && lstPospago.getListadoClientes().length > 0){
				for(int i = 0 ; i < lstPospago.getListadoClientes().length; i++){
	     			datoPospago = lstPospago.getListadoClientes()[i]; 
	     		}
			}

			
			
			logger.info("Construción para obtener los datos de las facturas impagas por cliente, con el opcion  Nº 2");
			if (datoPospago != null && datoPospago.getCodCliente() != 0){
				facturaInDTO = new FacturaInDTO();
				facturaInDTO.setCodCliente(datoPospago.getCodCliente());
				
				/* Código agregado por Alejandro Lorca */
				consParamFactura.setNomParametro(global.getValor("factura.nomparametro"));
				consParamFactura.setCodModulo(global.getValor("factura.codmodulo"));
				consParamFactura.setCodProducto(Integer.parseInt(global.getValor("factura.codproducto")));
				paramFactura = consFacturasAdesplegar.consultarParametros(consParamFactura);
				   
				if (paramFactura != null && paramFactura.getRespuesta() != null && paramFactura.getRespuesta().getCodigoError() == 0){
					facturaInDTO.setCantidadIteracion(Integer.parseInt(paramFactura.getValParametro()));
				/* Fin Código Alejandro Lorca */
					
					try{
						   facturaInDTO.setOpcion(Integer.parseInt(global.getValor("factura.consultarFacturasPorCliente.impagas")));
						}catch (Exception e) {
						   facturaInDTO.setOpcion(2);
						}
						
						facturaResponseFinal = facturaDTODAO.consultarFacturasImpagas(facturaInDTO);
						if(facturaResponseFinal != null && facturaResponseFinal.getRespuesta() != null && facturaResponseFinal.getLstListadoFacturas() != null && facturaResponseFinal.getRespuesta().getCodigoError() == 0){
							if(facturaResponseFinal.getLstListadoFacturas().length == 0 ){
								nuevaRespuesta = new RespuestaDTO();
								nuevaRespuesta.setCodigoError(-10016);
								nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas pendientes de pago del cliente.");
								facturaResponseFinal.setRespuesta(nuevaRespuesta);
							}
						}else{
							if(facturaResponseFinal != null && facturaResponseFinal.getRespuesta() != null && facturaResponseFinal.getRespuesta().getCodigoError() != 0){
								return facturaResponseFinal;
							}else{
								facturaResponseFinal = new FacturaResponseDTO();
								nuevaRespuesta = new RespuestaDTO();
								nuevaRespuesta.setCodigoError(-10016);
								nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas pendientes de pago del cliente.");
								facturaResponseFinal.setRespuesta(nuevaRespuesta);
								return facturaResponseFinal;
							}
						}
				}else{
					/* Código agregado por Alejandro Lorca */
					facturaResponseFinal = new FacturaResponseDTO();
		   			nuevaRespuesta = new RespuestaDTO();
					if(paramFactura != null && paramFactura.getRespuesta() != null && paramFactura.getRespuesta().getCodigoError() != 0 ){
						nuevaRespuesta.setCodigoError(paramFactura.getRespuesta().getCodigoError());
						nuevaRespuesta.setMensajeError(paramFactura.getRespuesta().getMensajeError());
					    nuevaRespuesta.setNumeroEvento(paramFactura.getRespuesta().getNumeroEvento());
					 }
					facturaResponseFinal.setRespuesta(nuevaRespuesta);
				}   /* Fin Código Alejandro Lorca */

			}else{
				if(lstPospago != null && lstPospago.getRespuesta() != null && lstPospago.getRespuesta().getCodigoError() != 0){
					facturaResponseFinal = new FacturaResponseDTO();
					facturaResponseFinal.setRespuesta(lstPospago.getRespuesta());
				}else{
		     		facturaResponseFinal = new FacturaResponseDTO();
					nuevaRespuesta = new RespuestaDTO();
					nuevaRespuesta.setCodigoError(-10016);
					nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas pendientes de pago del cliente");
					facturaResponseFinal.setRespuesta(nuevaRespuesta);
				}
		   }
		}else{
			 if(abonado != null && abonado.getRespuesta() != null && abonado.getRespuesta().getCodigoError() != 0){
				 facturaResponseFinal.setRespuesta(abonado.getRespuesta());
				 return facturaResponseFinal;
			 }else{
				 respuesta = new RespuestaDTO();
				 respuesta.setCodigoError(-10016);
				 respuesta.setMensajeError("No ha sido posible obtener las facturas pendientes de pago del cliente");
				 facturaResponseFinal.setRespuesta(respuesta);
				 return facturaResponseFinal;
			 }
		}
		
		return facturaResponseFinal;
	}	

	/**
	* Ingresa como parametros el codigo del cliente, y devuele una lista de 12 FacturaDTO pero solo con datos en el atributo fecHastallam
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaOutDTO consultarFechasReporteConsumo(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("declaracion de variable:start()");
		FacturaInDTO nuevo = new FacturaInDTO();
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null; 
		FacturaOutDTO facturaResponseFinal = new FacturaOutDTO(); 
		RespuestaDTO    respuesta = new RespuestaDTO();
		RespuestaDTO nuevaRespuesta = null;
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		Util            util                    = new Util();
		logger.info("fin de la declaracion de variable:end()");
		
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
				facturaResponseFinal.setRespuesta(respuesta);
				return facturaResponseFinal;
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
					facturaResponseFinal.setRespuesta(aplicacionValidada);
					return facturaResponseFinal;
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
				facturaResponseFinal.setRespuesta(servicioValidado);
				return facturaResponseFinal;
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
				facturaResponseFinal.setRespuesta(usuarioValidado);
				return facturaResponseFinal;
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
							facturaResponseFinal.setRespuesta(respuesta);
							return facturaResponseFinal;
						}
			        }	
				}else
				{
					respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
					respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
					facturaResponseFinal.setRespuesta(respuesta);
					return facturaResponseFinal;
				}
			//Fin de Registro de auditoría 
		
		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
		     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abanado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoAbonados() != null 
		     	   && datosAbonados.getListadoAbonados().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
			     			abonado = datosAbonados.getListadoAbonados()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo :consultarAbonadoTelefono");
		logger.info("cerrando AbonadoImpl");		

		
		if(abonado != null && abonado.getCodCliente()!=0 ){
			logger.info("seteo de las variables:start()");
				nuevo.setCodCliente(abonado.getCodCliente()); 
			logger.info("fin del seteo de las variables:end()");
			
			logger.info("consultarFechasReporteConsumo:start()");
			logger.info("consultarFechasReporteConsumo:antes()");
			com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = facturaDTODAO.consultarFechasReporteConsumo(nuevo);
			
			if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getLstListadoFacturas() != null&& outParam0.getRespuesta().getCodigoError() == 0){
				if(outParam0.getLstListadoFacturas().length == 0 ){
					nuevaRespuesta = new RespuestaDTO();
					nuevaRespuesta.setCodigoError(-10017);
					nuevaRespuesta.setMensajeError("No existen fechas de corte de ciclo para el cliente ingresado.");
					nuevaRespuesta.setNumeroEvento(0);
					facturaResponseFinal = new FacturaOutDTO();
					facturaResponseFinal.setRespuesta(nuevaRespuesta);
					return facturaResponseFinal;

					
				}
			}else{
				if(outParam0 !=  null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0){
					facturaResponseFinal = new FacturaOutDTO();
					facturaResponseFinal.setRespuesta(outParam0.getRespuesta());
					return facturaResponseFinal;
				}else{	
					nuevaRespuesta = new RespuestaDTO();
					nuevaRespuesta.setCodigoError(-10017);
					nuevaRespuesta.setMensajeError("No existen fechas de corte de ciclo para el cliente ingresado.");
					nuevaRespuesta.setNumeroEvento(0);
					facturaResponseFinal = new FacturaOutDTO();
					outParam0.setRespuesta(nuevaRespuesta);					
					return facturaResponseFinal;
				}
			}
			ArrayList listafechas = new ArrayList();
			for(int i = 0; i < outParam0.getLstListadoFacturas().length ; i++){
				if(i< 12){
					FacturaDTO nueva = outParam0.getLstListadoFacturas()[i];
					if(nueva != null){
						FechaReporteConsumoDTO objFecha = new FechaReporteConsumoDTO();
						objFecha.setFecha(util.fechaDateTOfechaString(Util.FORMATO_FECHA_ESPAÑOL, nueva.getFecHastaLlam()));
						listafechas.add(objFecha);
					}
					if(i == 12){
						break;
					}
				}
			}
			
			facturaResponseFinal = new FacturaOutDTO();
			facturaResponseFinal.setLstListadoFechasConsumos((com.tmmas.gte.integraciongtecommon.dto.FechaReporteConsumoDTO[])
					com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listafechas.toArray(),
							com.tmmas.gte.integraciongtecommon.dto.FechaReporteConsumoDTO.class));
			
			
			facturaResponseFinal.setRespuesta(outParam0.getRespuesta());
			
			logger.info("consultarFechasReporteConsumo:despues()");
			logger.info("consultarFechasReporteConsumo:end()");
		}else{
			facturaResponseFinal = new FacturaOutDTO();
			nuevaRespuesta = new RespuestaDTO();
			nuevaRespuesta.setCodigoError(-10004);
			nuevaRespuesta.setMensajeError("No se ha obtenido fechas para el reporte de consumo asociadas al número de teléfono ingresado.");
			if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
			    nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
			}
			facturaResponseFinal.setRespuesta(nuevaRespuesta);
		}
		
		return facturaResponseFinal;
	}

	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagadas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasPagadas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("consultarFacturasPagadas:start()");
		logger.info("consultarFacturasPagadas:antes()");
		com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = facturaDTODAO.consultarFacturasPagadas(inParam0);
		if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getLstListadoFacturas() != null&& outParam0.getRespuesta().getCodigoError() == 0){
			if(outParam0.getLstListadoFacturas().length == 0 ){
				RespuestaDTO nuevaRespuesta = new RespuestaDTO();
				nuevaRespuesta.setCodigoError(-10014);
				nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas del cliente");
				outParam0.setRespuesta(nuevaRespuesta);
			}
		}else{
			if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == 0 ){
				RespuestaDTO nuevaRespuesta = new RespuestaDTO();
				nuevaRespuesta.setCodigoError(-10014);
				nuevaRespuesta.setMensajeError("No ha sido posible obtener las facturas del cliente");
				outParam0.setRespuesta(nuevaRespuesta);
			}	
		}
		
		logger.info("consultarFacturasPagadas:despues()");
		logger.info("consultarFacturasPagadas:end()");
		return outParam0;
	}	 		

	/**
	* con el número de Teléfono obtiene las Ultima factura Pagada
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO obtenerUltimaFacturaPagada(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		Global global = Global.getInstance();
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		FacturaInDTO 			facturaInDTO		= new FacturaInDTO();
		FacturaResponseDTO 		outParam0 			= new FacturaResponseDTO();
		EsTelefIgualClieDTO 	numeroTelefono		= new EsTelefIgualClieDTO();
		numeroTelefono.setNum_telefono1(inParam0.getNumeroTelefono());
		

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

		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam = abonadoDAO.consultarAbonadoTelefono(numeroTelefono);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam != null && outParam.getRespuesta()!= null &&  outParam.getRespuesta().getCodigoError()==0  )
		{
			if (outParam.getListadoAbonados().length > 0 )
			{	
				
				facturaInDTO.setCodCliente(outParam.getListadoAbonados()[0].getCodCliente());
				facturaInDTO.setCantidadIteracion(Integer.parseInt(global.getValor("cantidad.iteraciones")));
				facturaInDTO.setOpcion(Integer.parseInt(global.getValor("opcion.factura")));
				
				logger.info("consultarFacturasImpagas:start()");
				logger.info("consultarFacturasImpagas:antes()");
				outParam0 = facturaDTODAO.consultarFacturasPagadas(facturaInDTO);
				
				if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getLstListadoFacturas() != null&& outParam0.getRespuesta().getCodigoError() == 0){
					if(outParam0.getLstListadoFacturas().length == 0 )
					{
						outParam0.getRespuesta().setMensajeError("Cliente no presenta facturas pagadas o aún no ha sido facturado ningún período");
					}
				}else{
					outParam0.getRespuesta().setMensajeError("Cliente no presenta facturas pagadas o aún no ha sido facturado ningún período");
				}
				logger.info("consultarFacturasImpagas:despues()");
				logger.info("consultarFacturasImpagas:end()");
			}else
			{
				outParam.getRespuesta().setMensajeError("No ha sido posible obtener la última factura pagada del cliente");
				outParam0.setRespuesta(outParam.getRespuesta());
	
			}
		}else{
			outParam.getRespuesta().setMensajeError("No ha sido posible obtener la última factura pagada del cliente");
			outParam0.setRespuesta(outParam.getRespuesta());
		}
		return outParam0;
	}
	/**
	* Consulta Factura Mes Anterior
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaMesAnteriorResponseDTO consultaFacturaMesAnterior(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		Global global = Global.getInstance();
		AuditoriaDTO					codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 					codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 					codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 					nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 						campos				= new ArrayList();
		FacturaInDTO 					facturaInDTO		= new FacturaInDTO();
		FacturaMesAnteriorResponseDTO 	outParam0 			= new FacturaMesAnteriorResponseDTO();
		FacturaResponseDTO				FacturaResponse		= new FacturaResponseDTO();
		EsTelefIgualClieDTO 			numeroTelefono		= new EsTelefIgualClieDTO();
		Util							util				= new Util();
		numeroTelefono.setNum_telefono1(inParam0.getNumeroTelefono());
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

		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam = abonadoDAO.consultarAbonadoTelefono(numeroTelefono);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam != null && outParam.getRespuesta()!= null &&  outParam.getRespuesta().getCodigoError()==0  )
		{
			if (outParam.getListadoAbonados().length > 0 )
			{	
				
				facturaInDTO.setCodCliente(outParam.getListadoAbonados()[0].getCodCliente());
				facturaInDTO.setCantidadIteracion(Integer.parseInt(global.getValor("cantidad.iteraciones")));
				facturaInDTO.setOpcion(Integer.parseInt(global.getValor("factura.consultarFacturasPorCliente.pagaeimpaga")));
				
				logger.info("consultarFacturas:start()");
				logger.info("consultarFacturas:antes()");
				FacturaResponse = facturaDTODAO.consultarFacturas(facturaInDTO);
				logger.info("consultarFacturas:despues()");
				logger.info("consultarFacturas:end()");
				if(FacturaResponse != null && FacturaResponse.getRespuesta() != null && FacturaResponse.getLstListadoFacturas() != null && FacturaResponse.getRespuesta().getCodigoError() == 0){
					if(FacturaResponse.getLstListadoFacturas().length > 0 )
					{
						String fechaString = util.fechaDateTOfechaString(Util.FORMATO_FECHA_ESPAÑOL, FacturaResponse.getLstListadoFacturas()[0].getFecEmision());
						
						int ParteEntera = (int)FacturaResponse.getLstListadoFacturas()[0].getTotalFactura();
						double ParteDecimal = util.parteDecimal(FacturaResponse.getLstListadoFacturas()[0].getTotalFactura(),ParteEntera,4);
						
						int ParteTotalEntera = (int)FacturaResponse.getLstListadoFacturas()[0].getTotalPagar();
						double ParteTotalDecimal = util.parteDecimal(FacturaResponse.getLstListadoFacturas()[0].getTotalPagar(),ParteTotalEntera,4);
												
						outParam0.setMesFactura(fechaString.substring(3,5));
						outParam0.setSaldoEntero(ParteEntera);
						outParam0.setSaldoDecimal(ParteDecimal);
						outParam0.setSaldoTotalEntero(ParteTotalEntera);
						outParam0.setSaldoTotalDecimal(ParteTotalDecimal);
						outParam0.setFechaCorte(FacturaResponse.getLstListadoFacturas()[0].getFecHastaLlam());
						outParam0.setFechaCancelacion(FacturaResponse.getLstListadoFacturas()[0].getFecCancelacion());
						outParam0.setRespuesta(FacturaResponse.getRespuesta());
					}else{
						
						FacturaResponse.getRespuesta().setMensajeError("No se han encontrado facturas asociadas al cliente");
						outParam0.setRespuesta(FacturaResponse.getRespuesta());
					}
					
				}else{
					FacturaResponse.getRespuesta().setMensajeError("No se han encontrado facturas asociadas al cliente");
					outParam0.setRespuesta(FacturaResponse.getRespuesta());
				}
			}else
			{
				outParam.getRespuesta().setMensajeError("No ha sido posible obtener la factura del mes anterior del cliente");
				outParam0.setRespuesta(outParam.getRespuesta());
			}
		}else{
			outParam.getRespuesta().setMensajeError("No ha sido posible obtener la factura del mes anterior del cliente");
			outParam0.setRespuesta(outParam.getRespuesta());
		}
		return outParam0;
	}
/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones, la opcion, fecha de inicio y de termino en formato (yyyymmdd)y devuelve yna lista con facturas 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaNoCicloResponseDTO consultarFacturasNoCicloCliente(com.tmmas.gte.integraciongtecommon.dto.DistribuidorInDTO inParam0)
		 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("declaracion de variables:start()");
		FacturaInDTO entredaConsulta = null;
		DistribuidorDTO  entradaDistribuidor = null;
		DistribuidorDTO  salidaDistribuidor  = null;
		RespuestaDTO   respuesta             = null;
		ParametrosGeneralesDTO  parametro         = null;
		ParametrosGeneralesResponseDTO consParametrosResponseDTO = null;
		ArrayList listaFacturasNuevas        = null;
		Global global = Global.getInstance();
		Util               util  = new Util();
		FacturaNoCicloResponseDTO facturaResponseFinal = new FacturaNoCicloResponseDTO(); 
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		logger.info("fin de la decalracion de  variables:start()");
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
				facturaResponseFinal.setRespuesta(puntoAcceso.getRespuesta());
				return facturaResponseFinal;
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
					facturaResponseFinal.setRespuesta(aplicacionValidada);
					return facturaResponseFinal;
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
				facturaResponseFinal.setRespuesta(servicioValidado);
				return facturaResponseFinal;
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
				facturaResponseFinal.setRespuesta(usuarioValidado);
				return facturaResponseFinal;
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
						facturaResponseFinal.setRespuesta(servicio);
						return facturaResponseFinal;
					}
	       }
	        	       
		}else
		{
			facturaResponseFinal.setRespuesta(auditoria.getRespuesta());
			return facturaResponseFinal;
		}
		// Fin Proceso de Auditoria 

		logger.info("obtención del codigo del cliente atravez del codigo del distribuidor:start()");
		entradaDistribuidor = new DistribuidorDTO(); 
		entradaDistribuidor.setCodVendedor(inParam0.getCodVendedor());
		salidaDistribuidor = distribuidorDAO.consultarDistribuidor(entradaDistribuidor);
		logger.info("fin de la btención del codigo del cliente atravez del codigo del distribuidor:end()");
		
		logger.info("evalución del distribuidor obtenido:start()");
		if(salidaDistribuidor != null && salidaDistribuidor.getCodCliente()!=0 && salidaDistribuidor.getRespuesta() != null && salidaDistribuidor.getRespuesta().getCodigoError() == 0){
     		logger.info("Segunda Parte : rescatando los valores del propertis");
		       parametro = new ParametrosGeneralesDTO();
		       parametro.setNomParametro(global.getValor("factura.consultarFacturasNoCicloCliente.nombre"));
		       parametro.setCodModulo(global.getValor("factura.consultarFacturasNoCicloCliente.modulo"));
		       int codigoProducto = 0;
		       try{
		    	  codigoProducto = Integer.parseInt(global.getValor("factura.consultarFacturasNoCicloCliente.producto"));
		       }catch (Exception e) {
		    	  codigoProducto = 1;
		       }
		       parametro.setCodProducto(codigoProducto);
		
		       consParametrosResponseDTO = consParametros.consultarParametros(parametro);
		    logger.info("Segunda Parte : finaliza el rescate de los datos del propertis");

			if(consParametrosResponseDTO != null && consParametrosResponseDTO.getRespuesta() != null && consParametrosResponseDTO.getRespuesta().getCodigoError() == 0 && consParametrosResponseDTO.getValParametro() != null && !consParametrosResponseDTO.getValParametro().equals("")){
				logger.info("construcción del DTO para sacar las facturas:start()");
				entredaConsulta = new FacturaInDTO();
				logger.info("fin de la construcción del DTO para sacar las facturas:end()");
				try{
					entredaConsulta.setCodCliente(salidaDistribuidor.getCodCliente());
					entredaConsulta.setOpcion(4);
					entredaConsulta.setCantidadIteracion(Integer.parseInt(consParametrosResponseDTO.getValParametro()));
					entredaConsulta.setFechaDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFechaDesde()));
					entredaConsulta.setFechaHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFechaHasta()));
				}catch (Exception e) {
					entredaConsulta.setCodCliente(salidaDistribuidor.getCodCliente());
					entredaConsulta.setOpcion(4);
					entredaConsulta.setCantidadIteracion(50);
					entredaConsulta.setFechaDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFechaDesde()));
					entredaConsulta.setFechaHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFechaHasta()));
				}
				logger.info("consultarFacturasNoCicloCliente:start()");
				logger.info("consultarFacturasNoCicloCliente:antes()");
				com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO outParam0 = facturaDTODAO.consultarFacturasNoCicloCliente(entredaConsulta);
				logger.info("consultarFacturasNoCicloCliente:despues()");
				logger.info("consultarFacturasNoCicloCliente:end()");

				if(outParam0 != null && outParam0.getRespuesta()!= null && outParam0.getLstListadoFacturas()!= null && outParam0.getLstListadoFacturas().length > 0 && outParam0.getRespuesta().getCodigoError() == 0 ){
					listaFacturasNuevas = new ArrayList();
					FacturaDTO facturaNueva = null;
					FacturaNoCicloDTO ultimaFactura = null;
					for(int i = 0; i < outParam0.getLstListadoFacturas().length ; i++){
						facturaNueva  = new FacturaDTO();
						ultimaFactura = new FacturaNoCicloDTO();
						facturaNueva = outParam0.getLstListadoFacturas()[i];
						if(facturaNueva != null){
							ultimaFactura.setNumFolio(facturaNueva.getNumFolio());
							ultimaFactura.setTotalFactura(facturaNueva.getTotalFactura());
							ultimaFactura.setTotalPagar(facturaNueva.getTotalPagar());
							ultimaFactura.setTotDescuento(facturaNueva.getTotDescuento());
							ultimaFactura.setFecEmision(facturaNueva.getFecEmision());
							ultimaFactura.setFecVencimie(facturaNueva.getFecVencimie());
							ultimaFactura.setFecCancelacion(facturaNueva.getFecCancelacion());
							listaFacturasNuevas.add(ultimaFactura);
						}
					}
					facturaResponseFinal.setLstListadoFacturas((com.tmmas.gte.integraciongtecommon.dto.FacturaNoCicloDTO[])
							com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaFacturasNuevas.toArray(),
									com.tmmas.gte.integraciongtecommon.dto.FacturaNoCicloDTO.class));
					
					
					facturaResponseFinal.setRespuesta(outParam0.getRespuesta());
					
				}else{
					facturaResponseFinal =  new FacturaNoCicloResponseDTO();
					if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0){
						respuesta = new RespuestaDTO();
						respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
						respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
						respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
						facturaResponseFinal.setRespuesta(respuesta);
					}else{
						respuesta = new RespuestaDTO();
						respuesta.setCodigoError(-10018);
						respuesta.setMensajeError("No existe valor de parametros.");
						respuesta.setNumeroEvento(0);
						facturaResponseFinal.setRespuesta(respuesta);
					}
				}
			}else{
				facturaResponseFinal =  new FacturaNoCicloResponseDTO();
				if(consParametrosResponseDTO != null && consParametrosResponseDTO.getRespuesta() != null && consParametrosResponseDTO.getRespuesta().getCodigoError() != 0){
					respuesta = new RespuestaDTO();
					respuesta.setCodigoError(consParametrosResponseDTO.getRespuesta().getCodigoError());
					respuesta.setMensajeError(consParametrosResponseDTO.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(consParametrosResponseDTO.getRespuesta().getNumeroEvento());
					facturaResponseFinal.setRespuesta(respuesta);
				}else{
					respuesta = new RespuestaDTO();
					respuesta.setCodigoError(-10018);
					respuesta.setMensajeError("No existe valor de parametros.");
					respuesta.setNumeroEvento(0);
					facturaResponseFinal.setRespuesta(respuesta);
				}
			}
		}else{
			facturaResponseFinal =  new FacturaNoCicloResponseDTO();
			if(salidaDistribuidor != null && salidaDistribuidor.getRespuesta() != null && salidaDistribuidor.getRespuesta().getCodigoError() != 0){
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(salidaDistribuidor.getRespuesta().getCodigoError());
				respuesta.setMensajeError(salidaDistribuidor.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(salidaDistribuidor.getRespuesta().getNumeroEvento());
				facturaResponseFinal.setRespuesta(respuesta);
			}else{
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10019);
				respuesta.setMensajeError("No existe información del distrubuidor.");
				respuesta.setNumeroEvento(0);
				facturaResponseFinal.setRespuesta(respuesta);
			}
		}
		logger.info("fin de la evaluación:end()");
		
		return facturaResponseFinal;
	}
	

}