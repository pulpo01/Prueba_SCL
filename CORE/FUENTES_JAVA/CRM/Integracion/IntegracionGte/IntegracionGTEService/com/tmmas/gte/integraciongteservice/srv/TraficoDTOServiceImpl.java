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
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodCicloFacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsCicloFactDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadaFacturadaDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsumoClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsumoDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsumoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosCliNitDTO;
import com.tmmas.gte.integraciongtecommon.dto.DatosLstCliCliDTO;
import com.tmmas.gte.integraciongtecommon.dto.EntServSupleDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.ImpuestoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO;
import com.tmmas.gte.integraciongtecommon.dto.LlamadaInFactDTO;
import com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO;
import com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO;
import com.tmmas.gte.integraciongtecommon.dto.MinutosLdiResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesDTO;
import com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongtecommon.dto.TraficoDTO;
import com.tmmas.gte.integraciongtecommon.dto.TraficoResponseDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;
import com.tmmas.gte.integraciongteservice.helper.Util;

public class TraficoDTOServiceImpl implements TraficoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(TraficoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.TraficoDTODAO traficoDTODAO = new com.tmmas.gte.integraciongtebo.dao.TraficoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ClienteDTODAO clienteDAO = new com.tmmas.gte.integraciongtebo.dao.ClienteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO auditoriaDAO	= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.FacturaDTODAO facturaDTODAO = new com.tmmas.gte.integraciongtebo.dao.FacturaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDTODAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ClienteDTODAO clienteDTODAO = new com.tmmas.gte.integraciongtebo.dao.ClienteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAO parametrosGeneralesDTODAO = new com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAOImpl();
	
	public TraficoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}
	
	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasOutDTO listarLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInDTO inParam0)
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
		LlamadasFacturadasOutDTO  llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
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
		Util                     util               = new Util(); 
		
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
		     	   && datosAbonados.getListadoAbonados() != null 
		     	   && datosAbonados.getListadoAbonados().length > 0){
			     		for(int i = 0 ; i < datosAbonados.getListadoAbonados().length; i++){
			     			abonado = datosAbonados.getListadoAbonados()[i]; 
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
						    	llamadaInterna.setFecDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecDesde()));
						    	llamadaInternaRespuesta.setFecDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecDesde()));
					    	}
					    	if(inParam0.getFecHasta() != null){
						    	llamadaInterna.setFecHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecHasta()));
						    	llamadaInternaRespuesta.setFecHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecHasta()));
					    	}
					    	resultadoDeLlamada = traficoDTODAO.validarFechasTrafico(llamadaInterna);
					    	try {
						    	if(resultadoDeLlamada != null && resultadoDeLlamada.getFecDesde()!= null && resultadoDeLlamada.getFecDesde().length() == 10){
						    		llamadaInternaRespuesta.setFecDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,resultadoDeLlamada.getFecDesde()));
						    	}
						    	if(resultadoDeLlamada != null && resultadoDeLlamada.getFecHasta()!= null && resultadoDeLlamada.getFecHasta().length() == 10){
							    	llamadaInternaRespuesta.setFecHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,resultadoDeLlamada.getFecHasta()));
						    	}
					    	}catch (Exception e) {
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
							try{
								FacturaDTO paraSacarImpuesto = new FacturaDTO();
								paraSacarImpuesto.setCodCliente(abonado.getCodCliente());
								paraSacarImpuesto.setUsuario(inParam0.getAuditoria().getNombreUsuario());
								ImpuestoResponseDTO impuesto =  facturaDTODAO.consultarImpuesto(paraSacarImpuesto);
								if(impuesto != null && impuesto.getImpuesto() >= 0 && impuesto.getRespuesta().getCodigoError() == 0){
									entradaLlamadasNoFacturadas.setImpuesto(impuesto.getImpuesto());
								}else{
									llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
									if(impuesto != null && impuesto.getRespuesta() != null && impuesto.getRespuesta().getCodigoError() != 0){
									   llamadoResponseDTOFinal.setRespuesta(impuesto.getRespuesta());
									}else{
									   RespuestaDTO nuevoMensaje = new RespuestaDTO();
									   nuevoMensaje.setMensajeError("Error al recuperar el impuesto de las llamadas no facturadas.");
									   llamadoResponseDTOFinal.setRespuesta(nuevoMensaje);
									}
									return llamadoResponseDTOFinal;
								}
							}catch (Exception e) {
								entradaLlamadasNoFacturadas.setImpuesto(0.0);
							}
							
							com.tmmas.gte.integraciongtecommon.dto.TraficoResponseDTO outParam0 = traficoDTODAO.listarLlamadasNoFacturadas(entradaLlamadasNoFacturadas);

							if(outParam0 != null && outParam0.getRespuesta()!= null && outParam0.getRespuesta().getCodigoError() == 0 && outParam0.getLstListadoLlamados() != null){
								if(outParam0.getLstListadoLlamados().length > 0){
									
									ArrayList listaNuevaLLamadasFacturadas = new ArrayList();
									
									for(int i = 0; i < outParam0.getLstListadoLlamados().length; i++){
										TraficoDTO obj =  outParam0.getLstListadoLlamados()[i];
										if (obj != null){
											LlamadaFacturadaDTO llamada = new LlamadaFacturadaDTO();
											llamada.setNumFolio(obj.getNumFolio());
											llamada.setFechaLlamada(obj.getFechaLlamada());
											llamada.setHoraLlamada(obj.getHoraLlamada());
											llamada.setNumeroDestino(obj.getNumeroDestino());
											llamada.setMtoLlamSinImp(obj.getMtoLlamSinImp());
											llamada.setMtoLlamConImp(obj.getMtoLlamConImp());
											llamada.setDesLlamada(obj.getDesLlamada());
											llamada.setDuracion(obj.getDuracion());
											llamada.setUnidad(obj.getUnidad());
											
											listaNuevaLLamadasFacturadas.add(llamada);
										}
									}
									llamadoResponseDTOFinal.setLstLlamadasFact((com.tmmas.gte.integraciongtecommon.dto.LlamadaFacturadaDTO[])
											com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaNuevaLLamadasFacturadas.toArray(),
													com.tmmas.gte.integraciongtecommon.dto.LlamadaFacturadaDTO.class));
									llamadoResponseDTOFinal.setRespuesta(outParam0.getRespuesta());									
									logger.info("paso todas la validaciones con el numero de celular");
									
								}else{
								    llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
									nuevaRespuesta = new RespuestaDTO();
								    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0 ){
								    	nuevaRespuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
								    	nuevaRespuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
								    	nuevaRespuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
								    }else{
										nuevaRespuesta.setCodigoError(-10034);
										nuevaRespuesta.setMensajeError("No ha sido posible obtener el detalle de llamadas no facturadas para el período vigente.");
									}
									llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
								}
							}else{
							    llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
								nuevaRespuesta = new RespuestaDTO();
							    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0 ){
							    	nuevaRespuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
							    	nuevaRespuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
							    	nuevaRespuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
							    }else{
									nuevaRespuesta.setCodigoError(-10034);
									nuevaRespuesta.setMensajeError("No ha sido posible obtener el detalle de llamadas no facturadas para el período vigente.");
								}
								llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
							}
							logger.info("lstLlamadasNoFacturadas:despues()");
							logger.info("lstLlamadasNoFacturadas:end()");
					    }else{
						    llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
							nuevaRespuesta = new RespuestaDTO();
						    if(resultadoDeLlamada != null && resultadoDeLlamada.getRespuesta() != null && resultadoDeLlamada.getRespuesta().getCodigoError() != 0 ){
						    	nuevaRespuesta.setCodigoError(resultadoDeLlamada.getRespuesta().getCodigoError());
						    	nuevaRespuesta.setNumeroEvento(resultadoDeLlamada.getRespuesta().getNumeroEvento());
						    	nuevaRespuesta.setMensajeError(resultadoDeLlamada.getRespuesta().getMensajeError());
						    }else{
								nuevaRespuesta.setCodigoError(-10035);
								nuevaRespuesta.setMensajeError("Las fechas de inicio y término ingresadas están fuera de rango para el ciclo de facturación consultado.");
							}
							llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
					    }
					    logger.info("finalizando el analices los datos del resultado de las fechas ");
				    }else{
					    llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
						nuevaRespuesta = new RespuestaDTO();
					    if(recuperaAbonadoPospago != null && recuperaAbonadoPospago.getRespuesta() != null && recuperaAbonadoPospago.getRespuesta().getCodigoError() != 0 ){
					    	nuevaRespuesta.setCodigoError(recuperaAbonadoPospago.getRespuesta().getCodigoError());
					    	nuevaRespuesta.setNumeroEvento(recuperaAbonadoPospago.getRespuesta().getNumeroEvento());
					    	nuevaRespuesta.setMensajeError(recuperaAbonadoPospago.getRespuesta().getMensajeError());
					    }else{
							nuevaRespuesta.setCodigoError(-10036);
							nuevaRespuesta.setMensajeError("No existe código de ciclo para estas abonado.");
						}
						llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
				    }
				    logger.info("finalizando el analice de los datos del abonado pospago");
		         logger.info("Tercera parte : finaliza la condición para obtener el ciclo de facturación");
		  }else{
			    llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
				nuevaRespuesta = new RespuestaDTO();
			    if(datosRecuperadoSegundaConsulta != null && datosRecuperadoSegundaConsulta.getRespuesta() != null && datosRecuperadoSegundaConsulta.getRespuesta().getCodigoError() != 0 ){
			    	nuevaRespuesta.setCodigoError(datosRecuperadoSegundaConsulta.getRespuesta().getCodigoError());
			    	nuevaRespuesta.setNumeroEvento(datosRecuperadoSegundaConsulta.getRespuesta().getNumeroEvento());
			    	nuevaRespuesta.setMensajeError(datosRecuperadoSegundaConsulta.getRespuesta().getMensajeError());
			    }else{
					nuevaRespuesta.setCodigoError(-10036);
					nuevaRespuesta.setMensajeError("No existe código de ciclo para el número de teléfonico.");
				}
				llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
		  }
		  logger.info("finalizando el analice de los datos del cliente");
     	  logger.info("Segunda parte : finaliza la condición para obtener datos del cliente");
		}else{
			    llamadoResponseDTOFinal = new LlamadasFacturadasOutDTO();
				nuevaRespuesta = new RespuestaDTO();
			    if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
			    	nuevaRespuesta.setCodigoError(datosAbonados.getRespuesta().getCodigoError());
			    	nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
			    	nuevaRespuesta.setMensajeError(datosAbonados.getRespuesta().getMensajeError());
			    }else{
					nuevaRespuesta.setCodigoError(-10003);
					nuevaRespuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
				}
				llamadoResponseDTOFinal.setRespuesta(nuevaRespuesta);
	  }
	  logger.info("Primera parte : finaliza la condición del abonado ");
	  return llamadoResponseDTOFinal;
	}


	/**
	* parametros de entreda LlamadaInDTO pero sin impuestos y despues devuelve un cursor con datos, este se setean los datos en ConsumoDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseOutDTO listarConsumoMensajesCortos(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("declaracion de variables:start()");
		LlamadaInDTO   entradaLlamadaConsumo = null;
		DatosLstCliCliDTO datosEntradaCliente = null;
		LstDatosCliNitDTO recuperacionCliente = null;
		DatosCliNitDTO    datosRecuperadoSegundaConsulta = null;
		ConsAbonadoPospagoDTO recuperaAbonadoPospago = null;
		ConsCicloFactDTO      datosEntradaAbonadoPospago = null;
		CodCicloFacturaDTO   codCicloFacturaDTO = null;
		MinutosConsumidosDTO resultadoFechaCorte = null;
		RespuestaDTO   respuesta = new RespuestaDTO();
		ConsumoResponseOutDTO consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;      
		Global global = Global.getInstance();
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 		campos					= new ArrayList();
		Util            util                    = new Util();   
		logger.info("fin de decalracion de variables:end()");
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
				consumoMensajesCortosFinal.setRespuesta(respuesta);
				return consumoMensajesCortosFinal;
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
					consumoMensajesCortosFinal.setRespuesta(aplicacionValidada);
					return consumoMensajesCortosFinal;
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
				consumoMensajesCortosFinal.setRespuesta(servicioValidado);
				return consumoMensajesCortosFinal;
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
				consumoMensajesCortosFinal.setRespuesta(usuarioValidado);
				return consumoMensajesCortosFinal;
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
							consumoMensajesCortosFinal.setRespuesta(respuesta);
							return consumoMensajesCortosFinal;
						}
			        }	
				}else
				{
					respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
					respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
					consumoMensajesCortosFinal.setRespuesta(respuesta);
					return consumoMensajesCortosFinal;
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
				
				logger.info("analizando los datos del cliente, revisnado el abonado");	
			    logger.info("Primera parte : analizando la condición del abonado ");
				if(abonado != null && abonado.getCodCliente()!=0 && abonado.getNumAbonado() != 0){
					if(abonado.getTipAbonado() != null && !abonado.getCodTiplan().equals("") && !abonado.getCodTiplan().equals(global.getValor("consumo.lstConsumoMensajesCortos.tipPrepago"))){
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
											        codCicloFacturaDTO = new CodCicloFacturaDTO();
											        codCicloFacturaDTO.setCodCicloFactura(recuperaAbonadoPospago.getCodCicloFact());
											    logger.info("fin la evalución de las fechas con el ciclo");
											    logger.info("construcción del objeto llamadaInterna para validar las fechas");
										    		resultadoFechaCorte = facturaDTODAO.obtenerFechaCorte(codCicloFacturaDTO);
										    	logger.info("finaliza construcción y la consulta de  validar las fechas");
										    logger.info("analizando los datos del resultado de las fechas ");
										    if(resultadoFechaCorte !=  null && resultadoFechaCorte.getRespuesta() != null && resultadoFechaCorte.getRespuesta().getCodigoError() == 0 && resultadoFechaCorte.getCorteCiclo() != null){
										    	
										    	String fechaDeCorte = util.fechaDateTOfechaString(Util.FORMATO_FECHA_ESPAÑOL, resultadoFechaCorte.getCorteCiclo()); 
										    	
												logger.info("lstConsumoMensajesCortos:start()");
												logger.info("lstConsumoMensajesCortos:antes()");										
												entradaLlamadaConsumo = new LlamadaInDTO();
												entradaLlamadaConsumo.setNumAbonado(abonado.getNumAbonado());
												entradaLlamadaConsumo.setCodCliente(abonado.getCodCliente());
												entradaLlamadaConsumo.setCodCiclo(datosRecuperadoSegundaConsulta.getCodCiclo());
												entradaLlamadaConsumo.setNumCelular((inParam0.getNumeroTelefono()+"").trim());
												entradaLlamadaConsumo.setFecTasa((""+recuperaAbonadoPospago.getCodCicloFact()).trim());
		
												com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseDTO outParam0 = traficoDTODAO.listarConsumoMensajesCortos(entradaLlamadaConsumo);
												logger.info("evaluación si existe datos de consumo, si la lista trae datos:start()");
												if(outParam0 != null && outParam0.getRespuesta()!= null && outParam0.getRespuesta().getCodigoError() == 0 && outParam0.getLstListadoConsumosMensajesCortos()!= null && outParam0.getLstListadoConsumosMensajesCortos().length > 0){
												   ArrayList listaConsumoClientes = new ArrayList();
												   ConsumoDTO consumo = null;
												   logger.info("se inicia el recorrido del arreglo  de consumo");
												   for(int i = 0; i < outParam0.getLstListadoConsumosMensajesCortos().length; i++){
													   consumo = outParam0.getLstListadoConsumosMensajesCortos()[i];
													   if(consumo != null && consumo.getCodUnidad() != null && !consumo.getCodUnidad().equals("")){
														   if(consumo.getCodUnidad().equals(global.getValor("consumo.lstConsumoMensajesCortos.codUnidad"))){
															   logger.info("llenando la lista para el cliente"); 
																   ConsumoOutDTO consumoFinal = new ConsumoOutDTO();
																   consumoFinal.setFechaCorteCiclo(fechaDeCorte);
																   consumoFinal.setCantidadMensaje(consumo.getDurReal());
																   consumoFinal.setTipoAbonado(abonado.getTipAbonado());
																   listaConsumoClientes.add(consumoFinal);
															   logger.info("fin del llenado de la lista del cliente");
														   }
													   }
												   }
												   logger.info("fin con el recorrido del archivo");	
												   logger.info("evaluación de la lista final");
												   if(listaConsumoClientes != null && listaConsumoClientes.size() > 0){
													   consumoMensajesCortosFinal =  new ConsumoResponseOutDTO();
													   consumoMensajesCortosFinal.setLstListadoConsumosMensajesCortos((com.tmmas.gte.integraciongtecommon.dto.ConsumoOutDTO[])
																com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaConsumoClientes.toArray(),
																		com.tmmas.gte.integraciongtecommon.dto.ConsumoOutDTO.class));
													   
													   consumoMensajesCortosFinal.setRespuesta(new RespuestaDTO());
													   
													   return consumoMensajesCortosFinal;
												   }else{
															consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
															respuesta = new RespuestaDTO();
															respuesta.setCodigoError(-10037);
															respuesta.setMensajeError("No ha sido posible obtener el consumo de mensajes cortos para el número de teléfono consultado.");
														    consumoMensajesCortosFinal.setRespuesta(respuesta);
												   }
												   logger.info("se termina la evaluación de la lista final del cliente");	
												}else{
													consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
													respuesta = new RespuestaDTO();
												    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0 ){
												    	respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
												    	respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
												    	respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
												    }else{
														respuesta.setCodigoError(-10038);
														respuesta.setMensajeError("No existe fecha de corte para el ciclo del abonado.");
													}
												    consumoMensajesCortosFinal.setRespuesta(respuesta);
												}
												logger.info("lstConsumoMensajesCortos:despues()");
												logger.info("lstConsumoMensajesCortos:end()");
										    }else{
										    	consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
												respuesta = new RespuestaDTO();
											    if(resultadoFechaCorte != null && resultadoFechaCorte.getRespuesta() != null && resultadoFechaCorte.getRespuesta().getCodigoError() != 0 ){
											    	respuesta.setCodigoError(resultadoFechaCorte.getRespuesta().getCodigoError());
											    	respuesta.setNumeroEvento(resultadoFechaCorte.getRespuesta().getNumeroEvento());
											    	respuesta.setMensajeError(resultadoFechaCorte.getRespuesta().getMensajeError());
											    }else{
													respuesta.setCodigoError(-10039);
													respuesta.setMensajeError("Fechas no corresponden al ciclo del abonado.");
												}
											    consumoMensajesCortosFinal.setRespuesta(respuesta);
										    }
										    logger.info("finalizando el analisis los datos del resultado de las fechas ");
									    }else{
									    	consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
											respuesta = new RespuestaDTO();
										    if(recuperaAbonadoPospago != null && recuperaAbonadoPospago.getRespuesta() != null && recuperaAbonadoPospago.getRespuesta().getCodigoError() != 0 ){
										    	respuesta.setCodigoError(recuperaAbonadoPospago.getRespuesta().getCodigoError());
										    	respuesta.setNumeroEvento(recuperaAbonadoPospago.getRespuesta().getNumeroEvento());
										    	respuesta.setMensajeError(recuperaAbonadoPospago.getRespuesta().getMensajeError());
										    }else{
												respuesta.setCodigoError(-10036);
												respuesta.setMensajeError("No existe código de ciclo para estas abonado");
											}
										    consumoMensajesCortosFinal.setRespuesta(respuesta);
									    }
									    logger.info("finalizando el analisis de los datos del abonado pospago");
							         logger.info("Tercera parte : finaliza la condición para obtener el ciclo de facturación");
							    }else{
							    	consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
									respuesta = new RespuestaDTO();
								    if(datosRecuperadoSegundaConsulta != null && datosRecuperadoSegundaConsulta.getRespuesta() != null && datosRecuperadoSegundaConsulta.getRespuesta().getCodigoError() != 0 ){
								    	respuesta.setCodigoError(datosRecuperadoSegundaConsulta.getRespuesta().getCodigoError());
								    	respuesta.setNumeroEvento(datosRecuperadoSegundaConsulta.getRespuesta().getNumeroEvento());
								    	respuesta.setMensajeError(datosRecuperadoSegundaConsulta.getRespuesta().getMensajeError());
								    }else{
										respuesta.setCodigoError(-10036);
										respuesta.setMensajeError("No existe código de ciclo para estas abonado.");
									}
								    consumoMensajesCortosFinal.setRespuesta(respuesta);
							    }
						        logger.info("finalizando el analice de los datos del cliente");
				     	     logger.info("Segunda parte : finaliza la condición para obtener datos del cliente");
		     	     
					}else{
						consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
						respuesta = new RespuestaDTO();
					    respuesta.setCodigoError(-10040);
					    respuesta.setMensajeError("El número de teléfono ingresado no corresponde a un abonado pospago.");
					    consumoMensajesCortosFinal.setRespuesta(respuesta);
					}
		     	     
				}else{
					consumoMensajesCortosFinal = new ConsumoResponseOutDTO();
					respuesta = new RespuestaDTO();
				    if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
				    	respuesta.setCodigoError(datosAbonados.getRespuesta().getCodigoError());
				    	respuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
				    	respuesta.setMensajeError(datosAbonados.getRespuesta().getMensajeError());
				    }else{
				    	respuesta.setCodigoError(-10003);
				    	respuesta.setMensajeError("El número de teléfono ingresado no existe, esta dado de baja o en proceso de baja.");
					}
				    consumoMensajesCortosFinal.setRespuesta(respuesta);
				}
			   logger.info("Primera parte : finaliza la condición del abonado ");
			   
		return consumoMensajesCortosFinal;
	}
	/**
	* retorna Los minutos Consumidos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO consultarMinutosConsumidos(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		EsTelefIgualClieDTO  	inParam1			  	= new EsTelefIgualClieDTO();
		MinutosConsumidosDTO 	minutosConsumidosDTO 	= new MinutosConsumidosDTO();
		DatosLstCliCliDTO    	codigoClienteDto 	 	= new DatosLstCliCliDTO();
		ConsAbonadoPospagoDTO 	clientePospagoParametro = new ConsAbonadoPospagoDTO();
		ConsCicloFactDTO 		consCicloFact 			= new ConsCicloFactDTO();
		ConsumoClienteDTO		consumoClienteDTO		= new ConsumoClienteDTO();
		CodCicloFacturaDTO		codCicloFacturaDTO		= new CodCicloFacturaDTO();
		MinutosConsumidosDTO 	fechaCorteDTO		 	= new MinutosConsumidosDTO();
		AuditoriaDTO	 		codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO 	 		nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		 		campos					= new ArrayList();
		Global 					global 					= Global.getInstance();
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
				minutosConsumidosDTO.setRespuesta(puntoAcceso.getRespuesta());
				return minutosConsumidosDTO;
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
					minutosConsumidosDTO.setRespuesta(aplicacionValidada);
					return minutosConsumidosDTO;
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
				minutosConsumidosDTO.setRespuesta(servicioValidado);
				return minutosConsumidosDTO;
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
				minutosConsumidosDTO.setRespuesta(usuarioValidado);
				return minutosConsumidosDTO;
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
						minutosConsumidosDTO.setRespuesta(servicio);
						return minutosConsumidosDTO;
					}
	       }
	        	       
		}else
		{
			minutosConsumidosDTO.setRespuesta(auditoria.getRespuesta());
			return minutosConsumidosDTO;
		}
		// Fin Proceso de Auditoria 
		
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		inParam1.setNum_telefono1(inParam0.getNumeroTelefono());
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO outParam = abonadoDTODAO.consultarAbonadoTelefono(inParam1);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		if (outParam != null && outParam.getRespuesta()!= null &&  outParam.getRespuesta().getCodigoError()==0  )
		{
			if (outParam.getListadoAbonados().length > 0 )
			{	
				if(!(outParam.getListadoAbonados()[0].getCodTiplan()).equals(global.getValor("codigo.tipo.plan.prepago")))
				{
					codigoClienteDto.setCodCliente(outParam.getListadoAbonados()[0].getCodCliente());
					logger.info("consultarDatosCliente:start()");
					logger.info("consultarDatosCliente:antes()");
					com.tmmas.gte.integraciongtecommon.dto.LstDatosCliNitDTO outParam0 = clienteDTODAO.consultarDatosCliente(codigoClienteDto);
					logger.info("consultarDatosCliente:despues()");
					logger.info("consultarDatosCliente:end()");		
					
					if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0 )
					{
						if(outParam0.getListadoClientes().length > 0){
					    	
								consCicloFact.setCodCiclo(outParam0.getListadoClientes()[0].getCodCiclo());
								logger.info("consultarCicloFact:start()");
								logger.info("consultarCicloFact:antes()");
								clientePospagoParametro = facturaDTODAO.consultarCicloFact(consCicloFact);
								logger.info("consultarCicloFact:despues()");
								logger.info("consultarCicloFact:end()");
								if (clientePospagoParametro != null && clientePospagoParametro.getRespuesta()!= null &&  clientePospagoParametro.getRespuesta().getCodigoError()==0 )
								{
									codCicloFacturaDTO.setCodCicloFactura(clientePospagoParametro.getCodCicloFact());
									logger.info("obtieneFechaCorte:start()");
									logger.info("obtieneFechaCorte:antes()");
									fechaCorteDTO = facturaDTODAO.obtenerFechaCorte(codCicloFacturaDTO);
									logger.info("obtieneFechaCorte:despues()");
									logger.info("obtieneFechaCorte:end()");
									if (fechaCorteDTO != null && fechaCorteDTO.getRespuesta()!= null &&  fechaCorteDTO.getRespuesta().getCodigoError()==0 )
									{
										consumoClienteDTO.setFecTasa(clientePospagoParametro.getCodCicloFact());
										consumoClienteDTO.setCodCiclo(outParam0.getListadoClientes()[0].getCodCiclo());
										consumoClienteDTO.setCodCliente(outParam.getListadoAbonados()[0].getCodCliente());
										consumoClienteDTO.setNumAbonado(outParam.getListadoAbonados()[0].getNumAbonado());
										
										logger.info("consultarMinutosConsumidos:start()");
										logger.info("consultarMinutosConsumidos:antes()");
										minutosConsumidosDTO = traficoDTODAO.consultarMinutosConsumidos(consumoClienteDTO);
										logger.info("consultarMinutosConsumidos:despues()");
										logger.info("consultarMinutosConsumidos:end()");
										if (minutosConsumidosDTO != null && minutosConsumidosDTO.getRespuesta()!= null &&  minutosConsumidosDTO.getRespuesta().getCodigoError()==0 )
										{	
											if((minutosConsumidosDTO.getRespuesta().getCodigoError()== 0)&& (minutosConsumidosDTO.getRespuesta().getMensajeError()!=null))
											{
												minutosConsumidosDTO.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
												return minutosConsumidosDTO;
											}
											double minutos=0;
											double segundos=0;
											segundos = minutosConsumidosDTO.getConsumoTelefono();
											minutos = segundos / 60;
											minutosConsumidosDTO.setConsumoTelefono(minutos);
											minutosConsumidosDTO.setCorteCiclo(fechaCorteDTO.getCorteCiclo());
											
										}else {
											minutosConsumidosDTO.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
										}
									}else{
										fechaCorteDTO.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
										minutosConsumidosDTO.setRespuesta(clientePospagoParametro.getRespuesta());
								}
								}else{
									clientePospagoParametro.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
									minutosConsumidosDTO.setRespuesta(clientePospagoParametro.getRespuesta());
								}
						}else{
							outParam0.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
							minutosConsumidosDTO.setRespuesta(outParam0.getRespuesta());
						}
					}else
					{
						outParam0.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
						minutosConsumidosDTO.setRespuesta(outParam0.getRespuesta());
					}
				}else
				{
					outParam.getRespuesta().setCodigoError(-10040);
					outParam.getRespuesta().setMensajeError("El número de teléfono ingresado no corresponde a un abonado pospago");
					outParam.getRespuesta().setNumeroEvento(0);
					minutosConsumidosDTO.setRespuesta(outParam.getRespuesta());
				}

			}else
			{
				outParam.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
				minutosConsumidosDTO.setRespuesta(outParam.getRespuesta());
			}
		}else{
			outParam.getRespuesta().setMensajeError("No ha sido posible obtener el consumo del cliente-abonado para la facturación vigente");
			minutosConsumidosDTO.setRespuesta(outParam.getRespuesta());
		}
		return minutosConsumidosDTO;
	}	
	
	
	/**
	* Devuelve el total de minutos consumidos y el saldo de llamadas LDI para números pospago.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosLdiResponseDTO consultarMinutosLDI(com.tmmas.gte.integraciongtecommon.dto.MinutosLdiInDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		MinutosLdiResponseDTO 			minutosLdiDTO 			= new MinutosLdiResponseDTO();
		RespuestaDTO 			respuesta 				= new RespuestaDTO();
		EsTelefIgualClieDTO 	datosClienteIn  		= new EsTelefIgualClieDTO();
		AbonadoOutDTO 			datosClienteOut			= new AbonadoOutDTO();
		AuditoriaDTO	 		codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO 	 		codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO 	 		nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		 		campos					= new ArrayList();
		DatosLstCliCliDTO		datosClienteIn1			= new DatosLstCliCliDTO();
		LstDatosCliNitDTO		datosClienteOut1		= new LstDatosCliNitDTO();
		ConsAbonadoPospagoDTO   cicloFacturaOut			= new ConsAbonadoPospagoDTO();
		ConsCicloFactDTO		cicloFacturaIn			= new ConsCicloFactDTO();
		MinutosConsumidosDTO	fechaCorte				= new MinutosConsumidosDTO();
		CodCicloFacturaDTO		codCicloFact			= new CodCicloFacturaDTO();
		FacturaDTO				impuestoIn				= new FacturaDTO();
		ImpuestoResponseDTO     impuestoOut				= new ImpuestoResponseDTO();
		TraficoResponseDTO		traficoOut				= new TraficoResponseDTO();
		LlamadaInDTO			traficoIn				= new LlamadaInDTO();
		ParametrosGeneralesResponseDTO parametroCodDopeOut = new ParametrosGeneralesResponseDTO();
		ParametrosGeneralesDTO	parametroCodDopeIn		= new ParametrosGeneralesDTO();
		Util					util					= new Util();
		ConsLlamadaInternaDTO 	llamadaInterna 			= null;
		ConsLlamadaInternaDTO 	llamadaInternaRespuesta = null;
		ConsLlamadaInternaDTO 	resultadoDeLlamada 		= null;
		
		logger.info("consultarMinutosLdi:start()");
		logger.info("consultarMinutosLdi:antes()");
		
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
				minutosLdiDTO.setRespuesta(puntoAcceso.getRespuesta());
				return minutosLdiDTO;
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
					minutosLdiDTO.setRespuesta(aplicacionValidada);
					return minutosLdiDTO;
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
				minutosLdiDTO.setRespuesta(servicioValidado);
				return minutosLdiDTO;
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
				minutosLdiDTO.setRespuesta(usuarioValidado);
				return minutosLdiDTO;
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
						minutosLdiDTO.setRespuesta(servicio);
						return minutosLdiDTO;
					}
	       }
	        	       
		}else
		{
			minutosLdiDTO.setRespuesta(auditoria.getRespuesta());
			return minutosLdiDTO;
		}
		// Fin Proceso de Auditoria 
		
		datosClienteIn.setNum_telefono1(inParam0.getNumeroTelefono());
		
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
				if (!datosClienteOut.getListadoAbonados()[0].getCodTiplan().trim().equals("1")){
					datosClienteIn1.setCodCliente(datosClienteOut.getListadoAbonados()[0].getCodCliente());
					/**
					* Entrega el código de ciclo del Cliente
					*/
					logger.info("consultarDatosCliente:start()");
					logger.info("consultarDatosCliente:antes()");
					datosClienteOut1 = clienteDAO.consultarDatosCliente(datosClienteIn1);
					logger.info("consultarDatosCliente:despues()");
					logger.info("consultarDatosCliente:end()");
					
					if (datosClienteOut1 != null && datosClienteOut1.getRespuesta()!= null &&  datosClienteOut1.getRespuesta().getCodigoError()==0  ){
						if (datosClienteOut1.getListadoClientes()!=null&&datosClienteOut1.getListadoClientes().length>0){
							
							cicloFacturaIn.setCodCiclo(datosClienteOut1.getListadoClientes()[0].getCodCiclo());
							
							/**
							* Retorna codCicloFacturacion a partir de un codCiclo pospago
							*/
							logger.info("consultarCicloFact:start()");
							logger.info("consultarCicloFact:antes()");
							cicloFacturaOut = facturaDTODAO.consultarCicloFact(cicloFacturaIn);
							logger.info("consultarCicloFact:despues()");
							logger.info("consultarCicloFact:end()");
							
							if (cicloFacturaOut != null && cicloFacturaOut.getRespuesta() != null && cicloFacturaOut.getRespuesta().getCodigoError() == 0){
								
								codCicloFact.setCodCicloFactura(cicloFacturaOut.getCodCicloFact());
								
								llamadaInterna = new ConsLlamadaInternaDTO();
						        llamadaInternaRespuesta = new ConsLlamadaInternaDTO();
						    
						    	llamadaInterna.setCicloFacturacion(cicloFacturaOut.getCodCicloFact());
						    	if(inParam0.getFecDesde() != null){
							    	llamadaInterna.setFecDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecDesde()));
							    	llamadaInternaRespuesta.setFecDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecDesde()));
						    	}
						    	if(inParam0.getFecHasta() != null){
							    	llamadaInterna.setFecHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecHasta()));
							    	llamadaInternaRespuesta.setFecHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,inParam0.getFecHasta()));
						    	}
						    	
						    	/**
								* Valida FECHA_DESDE y FECHA_HASTA de acuerdo al ciclo de facturación obtenido en el punto anterior
								*/
								logger.info("validacionFechasCicloFacturacion:start()");
								logger.info("validacionFechasCicloFacturacion:antes()");
						    	resultadoDeLlamada = traficoDTODAO.validarFechasTrafico(llamadaInterna);
						    	logger.info("validacionFechasCicloFacturacion:despues()");
								logger.info("validacionFechasCicloFacturacion:end()");
								
						    	if(resultadoDeLlamada != null && resultadoDeLlamada.getFecDesde()!= null && resultadoDeLlamada.getFecDesde().length() == 10){
						    		llamadaInternaRespuesta.setFecDesde(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,resultadoDeLlamada.getFecDesde()));
						    	}
						    	if(resultadoDeLlamada != null && resultadoDeLlamada.getFecHasta()!= null && resultadoDeLlamada.getFecHasta().length() == 10){
							    	llamadaInternaRespuesta.setFecHasta(util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES,resultadoDeLlamada.getFecHasta()));
						    	}
								
						    	if(resultadoDeLlamada !=  null && resultadoDeLlamada.getRespuesta() != null && resultadoDeLlamada.getRespuesta().getCodigoError() == 0 ){
	
						    		/**
						    		 * Obtiene la fecha de corte del ciclo de facturacion
						    		 */
						    		logger.info("obtieneFechaCorte:start()");
						    		logger.info("obtieneFechaCorte:antes()");
						    		fechaCorte = facturaDTODAO.obtenerFechaCorte(codCicloFact);
						    		logger.info("obtieneFechaCorte:despues()");
						    		logger.info("obtieneFechaCorte:end()");
								
						    		if (fechaCorte != null && fechaCorte.getRespuesta() != null && fechaCorte.getRespuesta().getCodigoError() == 0){
						    			impuestoIn.setCodCliente(datosClienteOut.getListadoAbonados()[0].getCodCliente());
						    			impuestoIn.setUsuario(inParam0.getAuditoria().getNombreUsuario());
									
						    			/**
						    			 * Llama a la funcion FA_ObtenerImpuesto_FN
						    			 */
						    			logger.info("consultarImpuesto:start()");
						    			logger.info("consultarImpuesto:antes()");
						    			impuestoOut = facturaDTODAO.consultarImpuesto(impuestoIn);
						    			logger.info("consultarImpuesto:despues()");
						    			logger.info("consultarImpuesto:end()");
									
						    			if (impuestoOut != null && impuestoOut.getRespuesta() != null && impuestoOut.getRespuesta().getCodigoError() == 0){
										
						    				traficoIn.setCodCliente(datosClienteOut.getListadoAbonados()[0].getCodCliente());
						    				traficoIn.setNumAbonado(datosClienteOut.getListadoAbonados()[0].getNumAbonado());
						    				traficoIn.setNumCelular(String.valueOf(inParam0.getNumeroTelefono()));
						    				traficoIn.setCodCiclo(datosClienteOut1.getListadoClientes()[0].getCodCiclo());
						    				traficoIn.setFecTasa(String.valueOf(cicloFacturaOut.getCodCicloFact()));
										
						    				String fechaDesde = util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES, inParam0.getFecDesde());
						    				String fechaHasta = util.fechaStringTOfechaString(Util.FORMATO_FECHA_INGLES, inParam0.getFecHasta());
										
						    				traficoIn.setFecDesde(fechaDesde);
						    				traficoIn.setFecHasta(fechaHasta);
						    				traficoIn.setImpuesto(impuestoOut.getImpuesto());
										
						    				/**
						    				 * devuelve una lista con detalle de llamadas
						    				 */
						    				logger.info("lstLlamadasNoFacturadas:start()");
						    				logger.info("lstLlamadasNoFacturadas:antes()");
						    				traficoOut = traficoDTODAO.listarLlamadasNoFacturadas(traficoIn);
						    				logger.info("lstLlamadasNoFacturadas:despues()");
						    				logger.info("lstLlamadasNoFacturadas:end()");
						    				
						    				if (traficoOut != null && traficoOut.getRespuesta() != null &&  traficoOut.getRespuesta().getCodigoError()==0  ){
						    					if (traficoOut.getLstListadoLlamados() != null && traficoOut.getLstListadoLlamados().length>0){
												
						    						double montoTotalConImp = 0;
						    						long duracionTotalSeg = 0;
						    						double cantidadMinutos;
						    						String fecUltimaLlamada = "";

								    				logger.info("consultarParametros:start(): Parámetro COD_DOPE llamadas internacionales");
								    				logger.info("consultarParametros:antes()");
								    				Global global = Global.getInstance();
								    				parametroCodDopeIn.setCodModulo(global.getValor("consultar.minutos.ldi.modulo"));
								    				parametroCodDopeIn.setCodProducto(Integer.parseInt(global.getValor("consultar.minutos.ldi.producto")));
								    				parametroCodDopeIn.setNomParametro(global.getValor("consultar.minutos.ldi.parametro"));
								    				parametroCodDopeOut = parametrosGeneralesDTODAO.consultarParametros(parametroCodDopeIn);
								    				logger.info("consultarParametros:después()");
								    				logger.info("consultarParametros:end(): Parámetro COD_DOPE llamadas internacionales");
								    				
								    				if (parametroCodDopeOut != null && parametroCodDopeOut.getRespuesta() != null 
								    						&& parametroCodDopeOut.getRespuesta().getCodigoError() == 0){
							    						for (int i = 0; i < traficoOut.getLstListadoLlamados().length; i++){
							    							if (traficoOut.getLstListadoLlamados()[i].getUnidad().trim().equals("S") 
							    									&& traficoOut.getLstListadoLlamados()[i].getCodDopeb().trim().equals(parametroCodDopeOut.getValParametro())){
							    								
							    								montoTotalConImp = montoTotalConImp + traficoOut.getLstListadoLlamados()[i].getMtoLlamConImp();
							    								duracionTotalSeg = duracionTotalSeg + traficoOut.getLstListadoLlamados()[i].getDuracion();
							    								fecUltimaLlamada = traficoOut.getLstListadoLlamados()[i].getFechaLlamada();
							    								}
							    						}
							    						cantidadMinutos = duracionTotalSeg/60;
							    						minutosLdiDTO.setFechaInicioCiclo(fechaCorte.getCorteCiclo());
							    						minutosLdiDTO.setCantidadMinutos(cantidadMinutos);
							    						minutosLdiDTO.setFechaUltimaLlamada(fecUltimaLlamada);
													
							    						int saldoParteEntera = (int)montoTotalConImp;
							    						double saldoParteDecimal = util.parteDecimal(montoTotalConImp,saldoParteEntera,4);
													
							    						minutosLdiDTO.setSaldoParteEntera(saldoParteEntera);
							    						minutosLdiDTO.setSaldoParteDecimal(saldoParteDecimal);
								    				}
						    					}else{
						    						respuesta.setCodigoError(traficoOut.getRespuesta().getCodigoError());
						    						respuesta.setMensajeError("No ha sido posible obtener el consumo de minutos para las llamadas de larga distancia internacional (LDI).");
						    						respuesta.setNumeroEvento(traficoOut.getRespuesta().getNumeroEvento());
						    						minutosLdiDTO.setRespuesta(respuesta);
						    					}
						    				}else{
						    					respuesta.setCodigoError(traficoOut.getRespuesta().getCodigoError());
						    					respuesta.setMensajeError("No ha sido posible obtener el consumo de minutos para las llamadas de larga distancia internacional (LDI).");
						    					respuesta.setNumeroEvento(traficoOut.getRespuesta().getNumeroEvento());
						    					minutosLdiDTO.setRespuesta(respuesta);
						    				}
										
						    			}else{
						    				respuesta.setCodigoError(impuestoOut.getRespuesta().getCodigoError());
						    				respuesta.setMensajeError(impuestoOut.getRespuesta().getMensajeError());
						    				respuesta.setNumeroEvento(impuestoOut.getRespuesta().getNumeroEvento());
						    				minutosLdiDTO.setRespuesta(respuesta);
						    			}
			
						    		}else{
						    			respuesta.setCodigoError(fechaCorte.getRespuesta().getCodigoError());
						    			respuesta.setMensajeError("No ha sido posible obtener la fecha de inicio del ciclo actual.");
						    			respuesta.setNumeroEvento(fechaCorte.getRespuesta().getNumeroEvento());
						    			minutosLdiDTO.setRespuesta(respuesta);
						    		}
								
						    	}else{
						    		respuesta.setCodigoError(resultadoDeLlamada.getRespuesta().getCodigoError());
									respuesta.setMensajeError("Las fechas de inicio y término ingresadas están fuera de rango para el ciclo de facturación consultado.");
									respuesta.setNumeroEvento(resultadoDeLlamada.getRespuesta().getNumeroEvento());
									minutosLdiDTO.setRespuesta(respuesta);
								}
								
							}else{
								respuesta.setCodigoError(cicloFacturaOut.getRespuesta().getCodigoError());
								respuesta.setMensajeError("No ha sido posible obtener el código de ciclo de facturación del cliente.");
								respuesta.setNumeroEvento(cicloFacturaOut.getRespuesta().getNumeroEvento());
								minutosLdiDTO.setRespuesta(respuesta);
							}
				
						}else{
							respuesta.setCodigoError(datosClienteOut1.getRespuesta().getCodigoError());
							respuesta.setMensajeError("No ha sido posible obtener el código de ciclo del cliente.");
							respuesta.setNumeroEvento(datosClienteOut1.getRespuesta().getNumeroEvento());
							minutosLdiDTO.setRespuesta(respuesta);
						}
						
					}else{
						respuesta.setCodigoError(datosClienteOut1.getRespuesta().getCodigoError());
						respuesta.setMensajeError("No ha sido posible obtener el código de ciclo del cliente.");
						respuesta.setNumeroEvento(datosClienteOut1.getRespuesta().getNumeroEvento());
						minutosLdiDTO.setRespuesta(respuesta);
					}
					
				}else{
					respuesta.setCodigoError(-10041);
					respuesta.setMensajeError("El número de teléfono ingresado no corresponde a un abonado pospago o híbrido.");
					respuesta.setNumeroEvento(0);
					minutosLdiDTO.setRespuesta(respuesta);
				}
			}else{
				respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
				respuesta.setMensajeError(datosClienteOut.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
				minutosLdiDTO.setRespuesta(respuesta);
			}
				
		}else{
			respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
			respuesta.setMensajeError(datosClienteOut.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
			minutosLdiDTO.setRespuesta(respuesta);
		}
		logger.info("consultarMinutosLdi:despues()");
		logger.info("consultarMinutosLdi:end()");
		
		return minutosLdiDTO;
	}
	
	/**
	* Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasOutDTO consultarLlamadasFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		LlamadasFacturadasOutDTO consultaLlamadasFacturadasResponseDTO = new LlamadasFacturadasOutDTO();
		
		AuditoriaDTO		 codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	 	 codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	 	 nombreUsuarioDto		= new AuditoriaDTO();
		ArrayList 			 campos					= new ArrayList();
		RespuestaDTO 		 respuesta				= new RespuestaDTO();
		EntServSupleDTO 	 ArregloEntrada			= new EntServSupleDTO();

		//Realizando Proceso de Auditoria 
		//Validación de Punto Acceso
		codPuntoAccesoDto.setCodPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
		logger.info("validarPuntoAcceso:start()");
		logger.info("validarPuntoAcceso:antes()");
		PuntoAccesoResponseDTO  puntoAcceso =  auditoriaDAO.consultarPuntoAcceso(codPuntoAccesoDto);
		logger.info("validarPuntoAcceso:despues()");
		logger.info("validarPuntoAcceso:end()");
		if (puntoAcceso.getRespuesta().getCodigoError()!=0)
		{
			consultaLlamadasFacturadasResponseDTO.setRespuesta(puntoAcceso.getRespuesta());
			return consultaLlamadasFacturadasResponseDTO;
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
				consultaLlamadasFacturadasResponseDTO.setRespuesta(aplicacionValidada);
				return consultaLlamadasFacturadasResponseDTO;
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
			consultaLlamadasFacturadasResponseDTO.setRespuesta(servicioValidado);
			return consultaLlamadasFacturadasResponseDTO;
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
			return consultaLlamadasFacturadasResponseDTO;
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
							return consultaLlamadasFacturadasResponseDTO;
						}
				}	
			}
			//Inicio de Obtención de Nombres de Campos del DTO interno 	
			logger.info("ObtenerCampos.getAttributes:start()");
			logger.info("ObtenerCampos.getAttributes:antes()");
			campos = ObtenerCampos.getAttributes(ArregloEntrada.getClass(),ArregloEntrada);
			logger.info("ObtenerCampos.getAttributes:despues()");
			logger.info("ObtenerCampos.getAttributes:end()");
			//Fin de Obtención de Nombres de Campos del DTO interno 
			Iterator  i2 = campos.iterator();
			//recorrido del ArraylList(obtencion de nombres de Campos) 
		
			}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			return consultaLlamadasFacturadasResponseDTO;
		}
		//Fin de Registro de auditoría
		
		logger.info("consultarLlamadasFacturadas:start()");
			LlamadasFacturadasOutDTO detalleFacturas = new LlamadasFacturadasOutDTO();
		logger.info("consultarLlamadasFacturadas:antes()");
		
		EsTelefIgualClieDTO telefonoCliente = new EsTelefIgualClieDTO(); 
		telefonoCliente.setNum_telefono1(inParam0.getNumTelefono());

		logger.info("Abonado x n°telefono:antes()");
		com.tmmas.gte.integraciongtecommon.dto.AbonadoOutDTO abonado = abonadoDAO.consultarAbonadoTelefono(telefonoCliente);
		logger.info("Abonado x n°telefono:despues()");
		
		if(abonado!= null && abonado.getListadoAbonados() != null && abonado.getListadoAbonados().length > 0 && abonado != null && abonado.getRespuesta().getCodigoError() == 0){

			AbonadoDTO datosAbonado = new AbonadoDTO();
			LlamadasFacturadasResponseDTO objListaLlamFact = null;
			for(int i = 0 ; i < abonado.getListadoAbonados().length ; i++){
				datosAbonado = abonado.getListadoAbonados()[i];
			}
			if(datosAbonado != null && datosAbonado.getNumAbonado() != 0){
				LlamadaInFactDTO datosEntrada = new LlamadaInFactDTO();
				datosEntrada.setNumAbonado(datosAbonado.getNumAbonado());
				datosEntrada.setCodCicloFact(null);
				datosEntrada.setNumFolio(inParam0.getNumFolio());
				datosEntrada.setFecIni(null);
				datosEntrada.setFecTerm(null);
				datosEntrada.setUsuario(inParam0.getAuditoria().getNombreUsuario());
				datosEntrada.setCampoOrden(inParam0.getCampoOrden());
				datosEntrada.setTipoOrden(inParam0.getTipoOrden());
				
				objListaLlamFact = traficoDTODAO.consultarLlamadasFacturadas(datosEntrada);
				if(objListaLlamFact != null && objListaLlamFact.getLstLlamadasFact() != null && objListaLlamFact.getLstLlamadasFact().length > 0 && objListaLlamFact.getRespuesta() != null && objListaLlamFact.getRespuesta().getCodigoError() == 0){
					
					ArrayList listaNuevaLLamadasFacturadas = new ArrayList();
					
					for(int i = 0; i < objListaLlamFact.getLstLlamadasFact().length; i++){
						
							LlamadaFacturadaDTO llamada = new LlamadaFacturadaDTO();
							
							llamada.setNumFolio(objListaLlamFact.getLstLlamadasFact()[i].getNumFolio());
							logger.debug("Antes : Fecha Llamada :"+objListaLlamFact.getLstLlamadasFact()[i].getFechaLlamada());
							llamada.setFechaLlamada(""+objListaLlamFact.getLstLlamadasFact()[i].getFecLlamada());
							llamada.setHoraLlamada(objListaLlamFact.getLstLlamadasFact()[i].getHoraLlamada());
							logger.debug("Antes : Numero destino :"+objListaLlamFact.getLstLlamadasFact()[i].getNumeroDestino());
							llamada.setNumeroDestino(""+objListaLlamFact.getLstLlamadasFact()[i].getNumDestino());
							llamada.setMtoLlamSinImp(objListaLlamFact.getLstLlamadasFact()[i].getMtoLlamSinImp());
							llamada.setMtoLlamConImp(objListaLlamFact.getLstLlamadasFact()[i].getMtoLlamConImp());
							llamada.setDesLlamada(objListaLlamFact.getLstLlamadasFact()[i].getDesLlamada());
							llamada.setDuracion(objListaLlamFact.getLstLlamadasFact()[i].getDuracion());
							llamada.setUnidad(objListaLlamFact.getLstLlamadasFact()[i].getUnidad());
					
							
							listaNuevaLLamadasFacturadas.add(llamada);
					}
					detalleFacturas.setLstLlamadasFact((com.tmmas.gte.integraciongtecommon.dto.LlamadaFacturadaDTO[])
							com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaNuevaLLamadasFacturadas.toArray(),
									com.tmmas.gte.integraciongtecommon.dto.LlamadaFacturadaDTO.class));
					detalleFacturas.setRespuesta(objListaLlamFact.getRespuesta());
				}else{
					if(objListaLlamFact != null && objListaLlamFact.getRespuesta() != null && objListaLlamFact.getRespuesta().getCodigoError() != 0){
						detalleFacturas.setRespuesta(objListaLlamFact.getRespuesta());
						return detalleFacturas;
					}else{
						respuesta = new RespuestaDTO();
						respuesta.setCodigoError(-10042);
						respuesta.setMensajeError("No ha sido posible obtener el detalle de llamadas para el teléfono y folio consultado.");
						detalleFacturas.setRespuesta(respuesta);
						return detalleFacturas;
					}
				}
			}else{
				if(abonado != null && abonado.getRespuesta()!= null && abonado.getRespuesta().getCodigoError() != 0 ){
					detalleFacturas.setRespuesta(abonado.getRespuesta());
					return detalleFacturas;
				}else{
					respuesta = new RespuestaDTO();
					respuesta.setCodigoError(-10043);
					respuesta.setMensajeError("No existe información del abonado consultado.");
					detalleFacturas.setRespuesta(respuesta);
					return detalleFacturas;				
				}
			}
		}else{
			if(abonado != null && abonado.getRespuesta()!= null && abonado.getRespuesta().getCodigoError() != 0 ){
				detalleFacturas.setRespuesta(abonado.getRespuesta());
				return detalleFacturas;
			}else{
				respuesta = new RespuestaDTO();
				respuesta.setCodigoError(-10043);
				respuesta.setMensajeError("No existe información del abonado consultado.");
				detalleFacturas.setRespuesta(respuesta);
				return detalleFacturas;				
			}
		}

		logger.info("consultarLlamadasFacturadas:despues()");
		logger.info("consultarLlamadasFacturadas:end()");
		return detalleFacturas;
	}
	

	
}