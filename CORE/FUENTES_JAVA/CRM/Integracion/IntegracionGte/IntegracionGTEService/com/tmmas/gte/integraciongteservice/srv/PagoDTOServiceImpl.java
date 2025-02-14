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
import com.tmmas.gte.integraciongtecommon.dto.BancoDTO;
import com.tmmas.gte.integraciongtecommon.dto.BancoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsParametrosDTO;
import com.tmmas.gte.integraciongtecommon.dto.ConsParametrosResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
import com.tmmas.gte.integraciongtecommon.dto.FacturaDTO;
import com.tmmas.gte.integraciongtecommon.dto.NombreCamposDTO;
import com.tmmas.gte.integraciongtecommon.dto.ObtenerCampos;
import com.tmmas.gte.integraciongtecommon.dto.OficinaDTO;
import com.tmmas.gte.integraciongtecommon.dto.OficinaInDTO;
import com.tmmas.gte.integraciongtecommon.dto.PagoDTO;
import com.tmmas.gte.integraciongtecommon.dto.PagoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.PagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.PagoRecaudadoraOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.PagoVistaClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;

public class PagoDTOServiceImpl implements PagoDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(PagoDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.PagoDTODAO pagoDTODAO = new com.tmmas.gte.integraciongtebo.dao.PagoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO abonadoDAO = new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.BancoDTODAO bancoDAO = new com.tmmas.gte.integraciongtebo.dao.BancoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.OficinaDTODAO oficinaDAO = new com.tmmas.gte.integraciongtebo.dao.OficinaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 	auditoriaDAO = new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	
	private com.tmmas.gte.integraciongtebo.dao.ConsParametrosDTODAO consParametros = new com.tmmas.gte.integraciongtebo.dao.ConsParametrosDTODAOImpl(); 
	public PagoDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Ingresa como parametros un objeto de tipo PagoInDTO y despues devuelve un cursor con datos de los pagos, este se setean los datos en PagoResponseDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PagoOutDTO consultaPagosRealizados(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("Declarciones de variables");
		PagoInDTO entradaPago = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;  
		PagoOutDTO pagoOutDTOFinal = new PagoOutDTO();  
		RespuestaDTO nuevaRespuesta = null;
		ConsParametrosDTO parametro = null;
		ConsParametrosResponseDTO consParametrosResponseDTO = null;
		ArrayList listaPagosAux  = null; 
		ArrayList listaPagosAuxRecaudacion = null;
		int iteracion = 0;
		Global global = Global.getInstance();
		AuditoriaDTO			codPuntoAccesoDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codAplicacionDto	= new AuditoriaDTO();		
		AuditoriaDTO 			codServicioDto		= new AuditoriaDTO();		
		AuditoriaDTO 			nombreUsuarioDto	= new AuditoriaDTO();	
		ArrayList 				campos				= new ArrayList();
		logger.info("finalizaciones de variables");

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
				pagoOutDTOFinal.setRespuesta(puntoAcceso.getRespuesta());
				return pagoOutDTOFinal;
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
					pagoOutDTOFinal.setRespuesta(aplicacionValidada);
					return pagoOutDTOFinal;
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
				pagoOutDTOFinal.setRespuesta(servicioValidado);
				return pagoOutDTOFinal;
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
				pagoOutDTOFinal.setRespuesta(usuarioValidado);
				return pagoOutDTOFinal;
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
						pagoOutDTOFinal.setRespuesta(servicio);
						return pagoOutDTOFinal;
					}
	       }
	        	       
		}else
		{
			pagoOutDTOFinal.setRespuesta(auditoria.getRespuesta());
			return pagoOutDTOFinal;
		}
		// Fin Proceso de Auditoria 
		
		
		
		logger.info("utilizando AbonadoImpl");
		logger.info("utilizando metodo:consultarAbonadoTelefono");
		     	telefono = new EsTelefIgualClieDTO();
		     	if(inParam0 != null && inParam0.getNumeroTelefono() != 0){
		     		telefono.setNum_telefono1(inParam0.getNumeroTelefono());
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
     		logger.info("Segunda Parte : rescatando los valores del propertis");
     		       parametro = new ConsParametrosDTO();
     		       parametro.setNomParametro(global.getValor("pagos.consultaPagosRealizados.nombre"));
     		       parametro.setCodModulo(global.getValor("pagos.consultaPagosRealizados.modulo"));
     		       int codigoProducto = 0;
     		       try{
     		    	  codigoProducto = Integer.parseInt(global.getValor("pagos.consultaPagosRealizados.producto"));
     		       }catch (Exception e) {
     		    	  codigoProducto = 1;
     		       }
     		       parametro.setCodProducto(codigoProducto);
     		
     		       consParametrosResponseDTO = consParametros.consultarParametros(parametro);
			logger.info("Segunda Parte : finaliza el rescate de los datos del propertis");
			logger.info("tercera Parte : evaluciones del valor entregado");
			  if(consParametrosResponseDTO != null && consParametrosResponseDTO.getValParametro() != null && !consParametrosResponseDTO.getValParametro().equals("") && consParametrosResponseDTO.getRespuesta() != null && consParametrosResponseDTO.getRespuesta().getCodigoError() == 0){
					logger.info("consultaPagosRealizados:antes()");
					entradaPago = new PagoInDTO();
					entradaPago.setCodCliente(abonado.getCodCliente());
					com.tmmas.gte.integraciongtecommon.dto.PagoResponseDTO outParam0 = pagoDTODAO.consultaPagosRealizados(entradaPago);
					logger.info("consultaPagosRealizados:despues()");

					logger.info("generación de la lista segun corresponda el parametro obtenido");
					if(outParam0 != null && outParam0.getLstListadoPagos() != null && outParam0.getLstListadoPagos().length > 0 && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == 0){
						listaPagosAux = new ArrayList();
						try{
							iteracion =  Integer.parseInt(consParametrosResponseDTO.getValParametro());
						}catch (Exception e) {
							iteracion = 0;
						}
						for(int i=0; i < outParam0.getLstListadoPagos().length;i++){
							PagoDTO nuevo = outParam0.getLstListadoPagos()[i];
							if(nuevo != null){
								listaPagosAux.add(nuevo);	
							}
							if((i+1)== iteracion){
								break;
							}
						}
					}else{
					    pagoOutDTOFinal = new PagoOutDTO();
						nuevaRespuesta = new RespuestaDTO();
					    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == -1 ){
					    	nuevaRespuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
					    	nuevaRespuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
					    	nuevaRespuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
					    }else{
							nuevaRespuesta.setCodigoError(-1);
							nuevaRespuesta.setMensajeError("No ha sido posible consultar los pagos realizados por el cliente");
						}
						pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
					}
					logger.info("fin de la generacion de la lista ");
			  }else{
				    pagoOutDTOFinal = new PagoOutDTO();
					nuevaRespuesta = new RespuestaDTO();
				    if(consParametrosResponseDTO != null && consParametrosResponseDTO.getRespuesta() != null && consParametrosResponseDTO.getRespuesta().getCodigoError() == -1 ){
				    	nuevaRespuesta.setCodigoError(consParametrosResponseDTO.getRespuesta().getCodigoError());
				    	nuevaRespuesta.setNumeroEvento(consParametrosResponseDTO.getRespuesta().getNumeroEvento());
				    	nuevaRespuesta.setMensajeError(consParametrosResponseDTO.getRespuesta().getMensajeError());
				    }else{
						nuevaRespuesta.setCodigoError(-1);
						nuevaRespuesta.setMensajeError("El Número teléfono no esta registrado");
					}
					pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
			  }
			logger.info("tercera Parte : fin de la evalucion del valor entregado");

		}else{	
		    pagoOutDTOFinal = new PagoOutDTO();
			nuevaRespuesta = new RespuestaDTO();
		    if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() == -1 ){
		    	nuevaRespuesta.setCodigoError(datosAbonados.getRespuesta().getCodigoError());
		    	nuevaRespuesta.setNumeroEvento(datosAbonados.getRespuesta().getNumeroEvento());
		    	nuevaRespuesta.setMensajeError(datosAbonados.getRespuesta().getMensajeError());
		    }else{
				nuevaRespuesta.setCodigoError(-1);
				nuevaRespuesta.setMensajeError("El Número teléfono no esta registrado");
			}
			pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
        }
		logger.info("Primera parte : finaliza la condición del abonado ");
		
		logger.info("se evalua si la lista Auxiliar viene con datos"); 
		if(listaPagosAux != null && listaPagosAux.size() > 0){
			listaPagosAuxRecaudacion = new ArrayList();
			Iterator ite = listaPagosAux.iterator();
			while(ite.hasNext()){
				PagoDTO pagoAux = (PagoDTO)ite.next();
				
				logger.info("Evalua y la empresa recuadadora"); 
				if(pagoAux != null && pagoAux.getCodOripago() == 11){
					PagoRecaudadoraOutDTO recuadacion = pagoDTODAO.consultarRecaudadora(pagoAux);
					pagoAux.setRecuadacion(recuadacion);
				}
				logger.info("fin de la evaluación de la empresa recaudadora"); 
				logger.info("se evalua para sacar los datos del banco"); 
				if(pagoAux != null && pagoAux.getCodBanco() != null && !pagoAux.getCodBanco().equals("")){
					if(pagoAux.getCodOripago() == 3){
						BancoInDTO consultaBanco = new BancoInDTO();
						consultaBanco.setCodBanco(pagoAux.getCodBanco());
						BancoDTO banco = bancoDAO.consultarBanco(consultaBanco);
						if(banco!= null && banco.getRespuesta() != null && banco.getRespuesta().getCodigoError() == 0){
							pagoAux.setDesBanco(banco.getDescripcion());
						}
					}
				}
				logger.info("fin de la evalución de los datos del banco"); //
				logger.info("se evalua los datos para poder sacar la oficinas");
				if(pagoAux != null && pagoAux.getPrefPlaza() != null && !pagoAux.getPrefPlaza().equals("") && pagoAux.getNumCompago() > 0){
					if(pagoAux.getCodOripago() != 3 && pagoAux.getCodOripago() != 11 ){
						OficinaInDTO oficinaEntrada = new OficinaInDTO();
						oficinaEntrada.setPRefPlaza(pagoAux.getPrefPlaza());
						oficinaEntrada.setNumComPago(pagoAux.getNumCompago());
						OficinaDTO oficina = oficinaDAO.consultarOficina(oficinaEntrada);
						pagoAux.setOficina(oficina);
						
					}
				}
				logger.info("finaliza la  evaluación los datos para poder sacar la oficinas");
				listaPagosAuxRecaudacion.add(pagoAux);
			}
		}else{
		    pagoOutDTOFinal = new PagoOutDTO();
			nuevaRespuesta = new RespuestaDTO();
			nuevaRespuesta.setCodigoError(-1);
			nuevaRespuesta.setMensajeError("No ha sido posible consultar los pagos realizados por el cliente, valor del parámetro es : " + iteracion);
			pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
		}
		logger.info("fin de la evaluación de la lista Auxiliar"); 

		logger.info("evaluación de la lista listaPagosAuxRecaudacion para la construcción final");
		if(listaPagosAuxRecaudacion != null && listaPagosAuxRecaudacion.size() > 0){
			pagoOutDTOFinal           = new PagoOutDTO();
			PagoDTO nuevoPagoCabecera = (PagoDTO) listaPagosAuxRecaudacion.get(0);
			ArrayList listaPagoVistaClienteDTO        = new ArrayList();
			ArrayList listaFacturas                   = null;
			PagoVistaClienteDTO   pagoVistaClienteDTO = null;
			FacturaDTO            factura             = null;   
			PagoDTO pagoParaConsulta                  = null;
			logger.info("construcción de la cabecera del la respuesta hacia el cliente");
			pagoOutDTOFinal.setNumeroTelefono(inParam0.getNumeroTelefono());
			pagoOutDTOFinal.setFecha(nuevoPagoCabecera.getFechaHora().substring(0, 10));
			pagoOutDTOFinal.setHora(nuevoPagoCabecera.getFechaHora().substring(10, nuevoPagoCabecera.getFechaHora().length())); // falta sacar el sysdate de la base de dato.
			pagoOutDTOFinal.setDesPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
			logger.info("fin de la construccion de la cabecera");
			int contador = 0;
			long  secuenciaAnterior   = 0;
			
			Iterator iterator = listaPagosAuxRecaudacion.iterator();
			while(iterator.hasNext()){
				PagoDTO nuevoPago = (PagoDTO)iterator.next();
				if(nuevoPago != null){
					if(secuenciaAnterior != nuevoPago.getNumSecuenci()){
						pagoVistaClienteDTO = new PagoVistaClienteDTO();
						factura             = new FacturaDTO();
						logger.info("objeto de pago vista cliente");
						pagoVistaClienteDTO.setNumFolio(nuevoPago.getNumFolio());
						pagoVistaClienteDTO.setImporteTotDoc(nuevoPago.getImporteTotDoc());
						pagoVistaClienteDTO.setImpPago(nuevoPago.getTotFactura());
						pagoVistaClienteDTO.setSaldoDocumento(nuevoPago.getTotPagar()- nuevoPago.getImporteTotDoc());
						pagoVistaClienteDTO.setFecEfectividad(nuevoPago.getFecEfectividad());
						if(nuevoPago.getRecuadacion() != null && nuevoPago.getRecuadacion().getRecaudadora()!= null ){
							pagoVistaClienteDTO.setRecaudadora(nuevoPago.getRecuadacion().getRecaudadora());
						}
						if(nuevoPago.getRecuadacion() != null && nuevoPago.getRecuadacion().getDescripcionEmpresa() != null){
							pagoVistaClienteDTO.setDescripcionEmpresa(nuevoPago.getRecuadacion().getDescripcionEmpresa());
						}
						logger.info("fin del objeto pago vista cliente");
						logger.info("objeto de factura");
						listaFacturas = new ArrayList();
						factura.setNumFolio(nuevoPago.getNumFolio());
						listaFacturas.add(factura);
						logger.info("fin del objeto de factura");

						logger.info("seteo de la lista de factura dentro del objeto de pagoVistaClienteDTO");
						pagoVistaClienteDTO.setLstListadoFacturasPorPagos((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
								com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaFacturas.toArray(),
										com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

						listaPagoVistaClienteDTO.add(pagoVistaClienteDTO);
						logger.info("fin del seteo de la listapagoVistaClienteDTO");
					
						
					}else if(secuenciaAnterior == nuevoPago.getNumSecuenci()){
	                      if(listaPagoVistaClienteDTO != null && listaPagoVistaClienteDTO.size() > 0){
							 logger.info("objeto de factura");
							 listaFacturas = new ArrayList();
							 factura.setNumFolio(nuevoPago.getNumFolio());
							 listaFacturas.add(factura);
							 logger.info("fin del objeto de factura");	                    	  
	                    	  Iterator itera = listaPagoVistaClienteDTO.iterator();
	                    	  while(itera.hasNext()){
	                    		  PagoVistaClienteDTO vistaCliente = (PagoVistaClienteDTO)itera.next();
	                    		  if(pagoParaConsulta.getNumFolio() == vistaCliente.getNumFolio()){
	                    			  int cantidad = vistaCliente.getLstListadoFacturasPorPagos().length;
	                    			   for(int i = 0; i < vistaCliente.getLstListadoFacturasPorPagos().length; i++){
	                    				   if(i == (cantidad -1)){
	                    					   vistaCliente.getLstListadoFacturasPorPagos()[i+1] = factura;
	                    				   }
	                    			   }
	                    		  }else{
	      	  						pagoVistaClienteDTO = new PagoVistaClienteDTO();
	    							factura             = new FacturaDTO();
	    							logger.info("objeto de pago vista cliente");
	    							pagoVistaClienteDTO.setNumFolio(nuevoPago.getNumFolio());
	    							pagoVistaClienteDTO.setImporteTotDoc(nuevoPago.getImporteTotDoc());
	    							pagoVistaClienteDTO.setImpPago(nuevoPago.getTotFactura());
	    							pagoVistaClienteDTO.setSaldoDocumento(nuevoPago.getTotPagar()- nuevoPago.getImporteTotDoc());
	    							pagoVistaClienteDTO.setFecEfectividad(nuevoPago.getFecEfectividad());
	    							pagoVistaClienteDTO.setRecaudadora(nuevoPago.getRecuadacion().getRecaudadora());
	    							pagoVistaClienteDTO.setDescripcionEmpresa(nuevoPago.getRecuadacion().getDescripcionEmpresa());
	    							logger.info("fin del objeto pago vista cliente");
	    							logger.info("objeto de factura");
	    							listaFacturas = new ArrayList();
	    							factura.setNumFolio(nuevoPago.getNumFolio());
	    							listaFacturas.add(factura);
	    							logger.info("fin del objeto de factura");

	    							logger.info("seteo de la lista de factura dentro del objeto de pagoVistaClienteDTO");
	    							pagoVistaClienteDTO.setLstListadoFacturasPorPagos((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
	    									com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaFacturas.toArray(),
	    											com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

	    							listaPagoVistaClienteDTO.add(pagoVistaClienteDTO);
	    							logger.info("fin del seteo de la listapagoVistaClienteDTO");
	                    		  }
	                    	  }
	                      }else{
	  						pagoVistaClienteDTO = new PagoVistaClienteDTO();
							factura             = new FacturaDTO();
							logger.info("objeto de pago vista cliente");
							pagoVistaClienteDTO.setNumFolio(nuevoPago.getNumFolio());
							pagoVistaClienteDTO.setImporteTotDoc(nuevoPago.getImporteTotDoc());
							pagoVistaClienteDTO.setImpPago(nuevoPago.getTotFactura());
							pagoVistaClienteDTO.setSaldoDocumento(nuevoPago.getTotPagar()- nuevoPago.getImporteTotDoc());
							pagoVistaClienteDTO.setFecEfectividad(nuevoPago.getFecEfectividad());
							pagoVistaClienteDTO.setRecaudadora(nuevoPago.getRecuadacion().getRecaudadora());
							pagoVistaClienteDTO.setDescripcionEmpresa(nuevoPago.getRecuadacion().getDescripcionEmpresa());
							logger.info("fin del objeto pago vista cliente");
							logger.info("objeto de factura");
							listaFacturas = new ArrayList();
							factura.setNumFolio(nuevoPago.getNumFolio());
							listaFacturas.add(factura);
							logger.info("fin del objeto de factura");

							logger.info("seteo de la lista de factura dentro del objeto de pagoVistaClienteDTO");
							pagoVistaClienteDTO.setLstListadoFacturasPorPagos((com.tmmas.gte.integraciongtecommon.dto.FacturaDTO[])
									com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaFacturas.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.FacturaDTO.class));

							listaPagoVistaClienteDTO.add(pagoVistaClienteDTO);
							logger.info("fin del seteo de la listapagoVistaClienteDTO");
	                      }
					}
					secuenciaAnterior = nuevoPago.getNumSecuenci();
					pagoParaConsulta = nuevoPago;
				}
				contador++;
			}

			if(listaPagoVistaClienteDTO!= null && listaPagoVistaClienteDTO.size() > 0){
				logger.info("seteando la lista final para poder desplegar al cliente");
				pagoOutDTOFinal.setLstListadoPagos((com.tmmas.gte.integraciongtecommon.dto.PagoVistaClienteDTO[])
						com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaPagoVistaClienteDTO.toArray(),
								com.tmmas.gte.integraciongtecommon.dto.PagoVistaClienteDTO.class));
				logger.info("seteando la lista final para poder desplegar al cliente");
			}else{
			    pagoOutDTOFinal = new PagoOutDTO();
				nuevaRespuesta = new RespuestaDTO();
				nuevaRespuesta.setCodigoError(-1);
				nuevaRespuesta.setMensajeError("No ha sido posible consultar los pagos realizados por el cliente, valor del parámetro es : " + iteracion);
				pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
			}
		}else{
		    pagoOutDTOFinal = new PagoOutDTO();
			nuevaRespuesta = new RespuestaDTO();
			nuevaRespuesta.setCodigoError(-1);
			nuevaRespuesta.setMensajeError("No ha sido posible consultar los pagos realizados por el cliente, valor del parámetro es : " + iteracion);
			pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
		}
		logger.info("fin de la evaluación de la lista listaPagosAuxRecaudacion");
		
		
		
		return pagoOutDTOFinal;
	}

}