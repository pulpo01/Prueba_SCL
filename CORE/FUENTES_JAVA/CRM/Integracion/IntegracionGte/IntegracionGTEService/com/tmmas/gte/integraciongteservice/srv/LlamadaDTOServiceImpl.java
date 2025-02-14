/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongteservice.srv;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO;
import com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsCicloFactDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosCliNitDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;

public class LlamadaDTOServiceImpl implements LlamadaDTOService{
	private CompositeConfiguration config;
	public static final String FORMATO_FECHA_ISO = "yyyyMMdd"; 
	
	private static Logger logger = Logger.getLogger(LlamadaDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.LlamadaDTODAO llamadaDTODAO = new com.tmmas.gte.integraciongtebo.dao.LlamadaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ClienteDTODAO clienteDAO = new com.tmmas.gte.integraciongtebo.dao.ClienteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.FacturaDTODAO facturaDTODAO = new com.tmmas.gte.integraciongtebo.dao.FacturaDTODAOImpl();

	public LlamadaDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	
   public String fechaDateTOfechaString(String formato,Date fecha){
        try {
    		SimpleDateFormat format = new SimpleDateFormat(formato);
    		return format.format(fecha);
           }
        catch (Exception e) {
             System.out.println(e.getMessage());
             System.out.println("Fecha incorrecta");
             return null;
       }
	 }  
	 public String fechaStringTOfechaString(String formato, String fecha){
			SimpleDateFormat format = new SimpleDateFormat(formato);
			Date date = null;
			
			if(fecha.length() == 10){
				int dia = Integer.parseInt(fecha.substring(0,2));
				int mes = Integer.parseInt(fecha.substring(3,5))-1;
				int anyo = Integer.parseInt(fecha.substring(6,10))-1900;
				date = new Date(anyo, mes, dia);
			}
			String fechaSalida =format.format(date); 
			return fechaSalida;
		}	 
	
	

	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO lstLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("decalraciones de variables locales del metodos :start()");
		LstDatosCliNitDTO recuperacionCliente = null;
		DatosLstCliCliDTO datosEntradaCliente = null;
		DatosCliNitDTO    datosRecuperadoSegundaConsulta = null;
		ConsAbonadoPospagoDTO recuperaAbonadoPospago = null;
		ConsCicloFactDTO      datosEntradaAbonadoPospago = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;         
		LlamadoResponseDTO  llamadoResponseDTOFinal = new LlamadoResponseDTO();
		RespuestaDTO nuevaRespuesta = null;
		ConsLlamadaInternaDTO llamadaInterna = null;
		ConsLlamadaInternaDTO llamadaInternaRespuesta = null;
		ConsLlamadaInternaDTO resultadoDeLlamada = null;
		LlamadaInDTO  entradaLlamadasNoFacturadas = null; 
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		logger.info("finalizaciones declaraciones de variables locales del metodos :end()");
		
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
				llamadoResponseDTOFinal.setRespuesta(puntoAcceso.getRespuesta());
				return llamadoResponseDTOFinal;
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
					llamadoResponseDTOFinal.setRespuesta(aplicacionValidada);
					return llamadoResponseDTOFinal;
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
				llamadoResponseDTOFinal.setRespuesta(servicioValidado);
				return llamadoResponseDTOFinal;
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
				llamadoResponseDTOFinal.setRespuesta(usuarioValidado);
				return llamadoResponseDTOFinal;
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
						llamadoResponseDTOFinal.setRespuesta(servicio);
						return llamadoResponseDTOFinal;
					}
	       }
	        	       
		}else
		{
			llamadoResponseDTOFinal.setRespuesta(auditoria.getRespuesta());
			return llamadoResponseDTOFinal;
		}
		// Fin Proceso de Auditoria 
		
		
		

		
		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefonico() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefonico());
		     		datosAbonados = abonadoDAO.consultarAbonadoTelefono(telefono);
		     	}
				logger.info("recuperacion de datos del abanado");
		     	if(   datosAbonados != null 
		     	   && datosAbonados.getListadoClientes() != null 
		     	   && datosAbonados.getListadoClientes().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoClientes().length; i++){
			     			abonado = datosAbonados.getListadoClientes()[i]; 
			     		}
		     	}
		logger.info("cerrando metodo :consultarAbonadoTelefono");
		logger.info("cerrando AbonadoImpl");		

		logger.info("Primera parte : codición si el abonado trae los datos");
		if(abonado != null &&  abonado.getCodCliente()!=0  && abonado.getNumAbonado() != 0){
		
		  logger.info("Segunda parte : condición para obtener datos del cliente");
			logger.info("utilizando ClienteDTODAOImpl");
			logger.info("utilizando metodo:consultarDatosCliente");
			  datosEntradaCliente = new DatosLstCliCliDTO();  
			  datosEntradaCliente.setCodCliente(abonado.getCodCliente());
			  recuperacionCliente = clienteDAO.consultarDatosCliente(datosEntradaCliente);
			  
			  logger.info("recuperacion de datos del cliente ");
		     	if(   recuperacionCliente != null 
		     	   && recuperacionCliente.getListadoClientes() != null 
		     	   && recuperacionCliente.getListadoClientes().length > 0){
			     		for(int i = 0 ; i < recuperacionCliente.getListadoClientes().length; i++){
			     			datosRecuperadoSegundaConsulta = recuperacionCliente.getListadoClientes()[i]; 
			     		}
		     	}
		      logger.info("se termina la recuperación de datos del cliente ");	
		    logger.info("cerrando metodo :consultarDatosCliente");
		    logger.info("cerrando ClienteDTODAOImpl");	
		    
		  logger.info("analizando los datos del cliente");
		  if(datosRecuperadoSegundaConsulta != null && datosRecuperadoSegundaConsulta.getCodCiclo() != 0 && datosRecuperadoSegundaConsulta.getCodCiclo() > 0 ){
			     logger.info("Tercera parte : condición para obtener el ciclo de facturación");
					logger.info("utilizando ConsAbonadoPospagoDTODAOImpl");
					logger.info("utilizando metodo:consultarCicloFact");
					datosEntradaAbonadoPospago = new ConsCicloFactDTO();
					datosEntradaAbonadoPospago.setCodCiclo(datosRecuperadoSegundaConsulta.getCodCiclo());
					recuperaAbonadoPospago = facturaDTODAO.consultarCicloFact(datosEntradaAbonadoPospago);
				    logger.info("cerrando metodo :consultarCicloFact");
				    logger.info("cerrando ConsAbonadoPospagoDTODAOImpl");	
				  
				    logger.info("analizando los datos del abonado pospago");
				    if(recuperaAbonadoPospago != null && recuperaAbonadoPospago.getCodCicloFact() != 0  && recuperaAbonadoPospago.getCodCicloFact( )> 0){
					    logger.info("evalución de las fechas con el ciclo");
					        llamadaInterna = new ConsLlamadaInternaDTO();
					        llamadaInternaRespuesta = new ConsLlamadaInternaDTO();
					    logger.info("fin la evalución de las fechas con el ciclo");
					    logger.info("construcción del objeto llamadaInterna para validar las fechas");
					    
					    	llamadaInterna.setCicloFacturacion(recuperaAbonadoPospago.getCodCicloFact());
					    	if(inParam0.getFecDesde() != null){
						    	llamadaInterna.setFecDesde(fechaStringTOfechaString(LlamadaDTOServiceImpl.FORMATO_FECHA_ISO,inParam0.getFecDesde()));
						    	llamadaInternaRespuesta.setFecDesde(fechaStringTOfechaString(LlamadaDTOServiceImpl.FORMATO_FECHA_ISO,inParam0.getFecDesde()));
					    	}
					    	if(inParam0.getFecHasta() != null){
						    	llamadaInterna.setFecHasta(fechaStringTOfechaString(LlamadaDTOServiceImpl.FORMATO_FECHA_ISO,inParam0.getFecHasta()));
						    	llamadaInternaRespuesta.setFecHasta(fechaStringTOfechaString(LlamadaDTOServiceImpl.FORMATO_FECHA_ISO,inParam0.getFecHasta()));
					    	}
					    	
					    	resultadoDeLlamada = llamadaDTODAO.validacionFechasCicloFacturacion(llamadaInterna);
					    	
					    	if(resultadoDeLlamada != null && resultadoDeLlamada.getFecDesde()!= null && resultadoDeLlamada.getFecDesde().length() == 10){
					    		llamadaInternaRespuesta.setFecDesde(fechaStringTOfechaString(LlamadaDTOServiceImpl.FORMATO_FECHA_ISO,resultadoDeLlamada.getFecDesde()));
					    	}
					    	if(resultadoDeLlamada != null && resultadoDeLlamada.getFecHasta()!= null && resultadoDeLlamada.getFecHasta().length() == 10){
						    	llamadaInternaRespuesta.setFecHasta(fechaStringTOfechaString(LlamadaDTOServiceImpl.FORMATO_FECHA_ISO,resultadoDeLlamada.getFecHasta()));
					    	}
					    	logger.info("finaliza construcción y la consulta de  validar las fechas");
					    logger.info("analizando los datos del resultado de las fechas ");
					    if(resultadoDeLlamada !=  null && resultadoDeLlamada.getRespuesta() != null && resultadoDeLlamada.getRespuesta().getCodigoError() == 0 ){
							logger.info("lstLlamadasNoFacturadas:start()");
							logger.info("lstLlamadasNoFacturadas:antes()");
							entradaLlamadasNoFacturadas = new LlamadaInDTO();
							entradaLlamadasNoFacturadas.setNumAbonado(abonado.getNumAbonado());
							entradaLlamadasNoFacturadas.setCodCliente(abonado.getCodCliente());
							entradaLlamadasNoFacturadas.setCodCiclo(datosRecuperadoSegundaConsulta.getCodCiclo());
							entradaLlamadasNoFacturadas.setNumCelular((inParam0.getNumeroTelefonico()+"").trim());
							entradaLlamadasNoFacturadas.setFecDesde(llamadaInternaRespuesta.getFecDesde());
							entradaLlamadasNoFacturadas.setFecHasta(llamadaInternaRespuesta.getFecHasta());
							entradaLlamadasNoFacturadas.setFecTasa((""+recuperaAbonadoPospago.getCodCicloFact()).trim());
							entradaLlamadasNoFacturadas.setImpuesto(inParam0.getImpuesto());
							
							com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO outParam0 = llamadaDTODAO.lstLlamadasNoFacturadas(entradaLlamadasNoFacturadas);

							if(outParam0 != null && outParam0.getRespuesta()!= null && outParam0.getRespuesta().getCodigoError() == 0 && outParam0.getLstListadoLlamados() != null){
								if(outParam0.getLstListadoLlamados().length > 0){
									llamadoResponseDTOFinal = outParam0;	
								}else{
								    llamadoResponseDTOFinal = new LlamadoResponseDTO();
									nuevaRespuesta = new RespuestaDTO();
								    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == -1 ){
								    	nuevaRespuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
								    	nuevaRespuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
								    	nuevaRespuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
								    }else{
										nuevaRespuesta.setCodigoError(-1);
										nuevaRespuesta.setMensajeError("Las fechas de inicio y término ingresadas están fuera de rango para el ciclo de facturación consultado.");
									}
									llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
								}
							}else{
							    llamadoResponseDTOFinal = new LlamadoResponseDTO();
								nuevaRespuesta = new RespuestaDTO();
							    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == -1 ){
							    	nuevaRespuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
							    	nuevaRespuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
							    	nuevaRespuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
							    }else{
									nuevaRespuesta.setCodigoError(-1);
									nuevaRespuesta.setMensajeError("Las fechas de inicio y término ingresadas están fuera de rango para el ciclo de facturación consultado.");
								}
								llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
							}
							logger.info("lstLlamadasNoFacturadas:despues()");
							logger.info("lstLlamadasNoFacturadas:end()");
					    }else{
						    llamadoResponseDTOFinal = new LlamadoResponseDTO();
							nuevaRespuesta = new RespuestaDTO();
						    if(resultadoDeLlamada != null && resultadoDeLlamada.getRespuesta() != null && resultadoDeLlamada.getRespuesta().getCodigoError() == -1 ){
						    	nuevaRespuesta.setCodigoError(resultadoDeLlamada.getRespuesta().getCodigoError());
						    	nuevaRespuesta.setNumeroEvento(resultadoDeLlamada.getRespuesta().getNumeroEvento());
						    	nuevaRespuesta.setMensajeError(resultadoDeLlamada.getRespuesta().getMensajeError());
						    }else{
								nuevaRespuesta.setCodigoError(-1);
								nuevaRespuesta.setMensajeError("Fechas no corresponden al ciclo del abonado.");
							}
							llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
					    }
					    logger.info("finalizando el analices los datos del resultado de las fechas ");
				    }else{
					    llamadoResponseDTOFinal = new LlamadoResponseDTO();
						nuevaRespuesta = new RespuestaDTO();
					    if(recuperaAbonadoPospago != null && recuperaAbonadoPospago.getRespuesta() != null && recuperaAbonadoPospago.getRespuesta().getCodigoError() == -1 ){
					    	nuevaRespuesta.setCodigoError(recuperaAbonadoPospago.getRespuesta().getCodigoError());
					    	nuevaRespuesta.setNumeroEvento(recuperaAbonadoPospago.getRespuesta().getNumeroEvento());
					    	nuevaRespuesta.setMensajeError(recuperaAbonadoPospago.getRespuesta().getMensajeError());
					    }else{
							nuevaRespuesta.setCodigoError(-1);
							nuevaRespuesta.setMensajeError("No existe código de ciclo para estas abonado");
						}
						llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
				    }
				    logger.info("finalizando el analice de los datos del abonado pospago");
		         logger.info("Tercera parte : finaliza la condición para obtener el ciclo de facturación");
		  }else{
			    llamadoResponseDTOFinal = new LlamadoResponseDTO();
				nuevaRespuesta = new RespuestaDTO();
			    if(datosRecuperadoSegundaConsulta != null && datosRecuperadoSegundaConsulta.getRespuesta() != null && datosRecuperadoSegundaConsulta.getRespuesta().getCodigoError() == -1 ){
			    	nuevaRespuesta.setCodigoError(datosRecuperadoSegundaConsulta.getRespuesta().getCodigoError());
			    	nuevaRespuesta.setNumeroEvento(datosRecuperadoSegundaConsulta.getRespuesta().getNumeroEvento());
			    	nuevaRespuesta.setMensajeError(datosRecuperadoSegundaConsulta.getRespuesta().getMensajeError());
			    }else{
					nuevaRespuesta.setCodigoError(-1);
					nuevaRespuesta.setMensajeError("No existe código de ciclo para estas abonado");
				}
				llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
		  }
		  logger.info("finalizando el analice de los datos del cliente");
     	  logger.info("Segunda parte : finaliza la condición para obtener datos del cliente");
		}else{
			    llamadoResponseDTOFinal = new LlamadoResponseDTO();
				nuevaRespuesta = new RespuestaDTO();
			    if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() == -1 ){
			    	nuevaRespuesta.setCodigoError(datosAbonados.getRespuesta().getCodigoError());
			    	nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
			    	nuevaRespuesta.setMensajeError(datosAbonados.getRespuesta().getMensajeError());
			    }else{
					nuevaRespuesta.setCodigoError(-1);
					nuevaRespuesta.setMensajeError("El Número teléfono no esta registrado");
				}
				llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
	  }
	  logger.info("Primera parte : finaliza la condición del abonado ");
	  return llamadoResponseDTOFinal;
	}

}