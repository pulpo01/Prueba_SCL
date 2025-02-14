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
import com.tmmas.gte.integraciongtecommon.dto.AbonadoPospagoOutDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;
import com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO;
import com.tmmas.gte.integraciongtecommon.dto.BancoDTO;
import com.tmmas.gte.integraciongtecommon.dto.BancoInDTO;
import com.tmmas.gte.integraciongtecommon.dto.CarteraDTO;
import com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.DetallePagoVistaClienteDTO;
import com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesDTO;
import com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesResponseDTO;
import com.tmmas.gte.integraciongtecommon.dto.EsTelefIgualClieDTO;
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
import com.tmmas.gte.integraciongtecommon.dto.SaldoMorosidadDTO;
import com.tmmas.gte.integraciongteservice.helper.Global;
import com.tmmas.gte.integraciongteservice.helper.Util;

public class MovimientoCtaCteDTOServiceImpl implements MovimientoCtaCteDTOService{
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(MovimientoCtaCteDTOServiceImpl.class);
	private com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAO 			abonadoDAO 			= new com.tmmas.gte.integraciongtebo.dao.AbonadoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.BancoDTODAO 				bancoDAO 			= new com.tmmas.gte.integraciongtebo.dao.BancoDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.OficinaDTODAO 			oficinaDAO 			= new com.tmmas.gte.integraciongtebo.dao.OficinaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.MovimientoCtaCteDTODAO 	consCarteraDTODAO 	= new com.tmmas.gte.integraciongtebo.dao.MovimientoCtaCteDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAO 			auditoriaDAO		= new com.tmmas.gte.integraciongtebo.dao.AuditoriaDTODAOImpl();
	private com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAO consParametros 	= new com.tmmas.gte.integraciongtebo.dao.ParametrosGeneralesDTODAOImpl(); 
	
	
	public MovimientoCtaCteDTOServiceImpl() {
		config = UtilProperty.getConfiguration("IntegracionGte.properties", "com/tmmas/gte/integraciongteservice/properties/IntegracionGTEService.properties");
	}

	/**
	* Ingresa como parametros un objeto de tipo PagoInDTO y despues devuelve un cursor con datos de los pagos, este se setean los datos en PagoResponseDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PagoOutDTO consultarPagosRealizados(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		logger.info("Declarciones de variables");
		PagoInDTO entradaPago = null;
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null;  
		PagoOutDTO pagoOutDTOFinal = new PagoOutDTO();  
		RespuestaDTO nuevaRespuesta = null;
		ParametrosGeneralesDTO parametro = null;
		ParametrosGeneralesResponseDTO consParametrosResponseDTO = null;
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
     		logger.info("Segunda Parte : rescatando los valores del propertie");
     		       parametro = new ParametrosGeneralesDTO();
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
			logger.info("Segunda Parte : finaliza el rescate de los datos del propertie");
			logger.info("tercera Parte : evaluciones del valor entregado");
			  if(consParametrosResponseDTO != null && consParametrosResponseDTO.getValParametro() != null && !consParametrosResponseDTO.getValParametro().equals("") && consParametrosResponseDTO.getRespuesta() != null && consParametrosResponseDTO.getRespuesta().getCodigoError() == 0){
					logger.info("consultaPagosRealizados:antes()");
					entradaPago = new PagoInDTO();
					entradaPago.setCodCliente(abonado.getCodCliente());
					com.tmmas.gte.integraciongtecommon.dto.PagoResponseDTO outParam0 = consCarteraDTODAO.consultarPagosRealizados(entradaPago);
					logger.info("consultaPagosRealizados:despues()");

					pagoOutDTOFinal                           = new PagoOutDTO();
					ArrayList listaPagoVistaClienteDTO        = new ArrayList();
					PagoVistaClienteDTO   pagoVistaClienteDTO = null;
					ArrayList listaDetallePagoVistaClienteDTO = null;
					DetallePagoVistaClienteDTO detallePagoVistaClienteDTO = null;
					Util formatoFecha = new Util();
					logger.info("construcción de la cabecera del la respuesta hacia el cliente");
					pagoOutDTOFinal.setNumeroTelefono(inParam0.getNumeroTelefono());
					pagoOutDTOFinal.setDesPuntoAcceso(inParam0.getAuditoria().getCodPuntoAcceso());
					logger.info("fin de la construccion de la cabecera");

					
					logger.info("generación de la lista segun corresponda el parametro obtenido");
					if(outParam0 != null && outParam0.getLstListadoPagos() != null && outParam0.getLstListadoPagos().length > 0 && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() == 0){
						logger.info("fecha No formateada: " + outParam0.getLstListadoPagos()[0].getFechaHora());
						String fecha = formatoFecha.fechaDateTOfechaString(Util.FORMATO_FECHA_HORA_GUION_PUNTO,outParam0.getLstListadoPagos()[0].getFechaHora());
						logger.info("fecha formateada: " + fecha);
						pagoOutDTOFinal.setFecha(fecha.substring(0, 10));
						pagoOutDTOFinal.setHora(fecha.substring(10, fecha.length())); // falta sacar el sysdate de la base de dato.
							
						try{
							iteracion =  Integer.parseInt(consParametrosResponseDTO.getValParametro());
							logger.info("Número de pagos a a desplegar: " + iteracion);
						}catch (Exception e) {
							iteracion = 0;
							logger.info("Número de pagos a a desplegar: " + iteracion);
						}
						String numSecuencia = "";
						int cont = 0;
						
						for(int i=0; i < outParam0.getLstListadoPagos().length;i++){
							PagoDTO nuevo = outParam0.getLstListadoPagos()[i];
							if(nuevo != null && !numSecuencia.equals((""+nuevo.getNumSecuenci()).trim())){
								if (cont > 0){
									logger.info("Llenando lista de pago vista cliente: " + cont);
									listaPagoVistaClienteDTO.add(pagoVistaClienteDTO);
								}
								if(cont == iteracion){
									break;
								}
								pagoVistaClienteDTO = new PagoVistaClienteDTO();
								pagoVistaClienteDTO.setImpPago(nuevo.getImpPago());
								listaDetallePagoVistaClienteDTO = new ArrayList();
								cont = cont+1;
								logger.info("valor del contador: "+ cont);
							}
							logger.info("objeto de pago vista cliente");
							detallePagoVistaClienteDTO = new DetallePagoVistaClienteDTO();
							detallePagoVistaClienteDTO.setNumFolio(nuevo.getNumFolio());
							detallePagoVistaClienteDTO.setImporteTotDoc(nuevo.getTotFactura());
							detallePagoVistaClienteDTO.setImporteTotConcPagados(nuevo.getImporteTotDoc());
							detallePagoVistaClienteDTO.setSaldoDocumento(nuevo.getTotPagar());
							String fechaEfectiva = formatoFecha.fechaDateTOfechaString(Util.FORMATO_FECHA_HORA_GUION_PUNTO, nuevo.getFecEfectividad());
							if (fechaEfectiva != null && fechaEfectiva.length() > 15){
								int cantidad = fechaEfectiva.length();
								detallePagoVistaClienteDTO.setFechaEfectividad(fechaEfectiva.substring(0, 10));
								detallePagoVistaClienteDTO.setHoraEfectividad(fechaEfectiva.substring(11, cantidad));
							}
							logger.info("Se obtienen los datos del banco"); 
							if(nuevo != null && nuevo.getCodBanco() != null && !nuevo.getCodBanco().equals("")){
								if(nuevo.getCodOripago() == 3){
									BancoInDTO consultaBanco = new BancoInDTO();
									consultaBanco.setCodBanco(nuevo.getCodBanco());
									BancoDTO banco = bancoDAO.consultarBanco(consultaBanco);
									if(banco!= null && banco.getRespuesta() != null && banco.getRespuesta().getCodigoError() == 0){
										nuevo.setDesBanco(banco.getDescripcion());
									}
								}
							}
							if(nuevo.getRecuadacion() == null && nuevo.getOficina() == null && 
									nuevo.getCodBanco() != null && nuevo.getCodBanco() != ""){
								detallePagoVistaClienteDTO.setRecaudadora(nuevo.getCodBanco());
								detallePagoVistaClienteDTO.setDescripcionEmpresa(nuevo.getDesBanco());
							}

							logger.info("Fin de la obtención de datos del banco"); //
							
							logger.info("Se obtienen datos de la empresa recuadadora"); 
							if(nuevo != null && nuevo.getCodOripago() == 11){
								PagoRecaudadoraOutDTO recuadacion = consCarteraDTODAO.consultarRecaudadora(nuevo);
								nuevo.setRecuadacion(recuadacion);
							
								if(nuevo.getRecuadacion() != null && nuevo.getRecuadacion().getRecaudadora()!= null ){
									detallePagoVistaClienteDTO.setRecaudadora(nuevo.getRecuadacion().getRecaudadora());
								}
								if(nuevo.getRecuadacion() != null && nuevo.getRecuadacion().getDescripcionEmpresa() != null){
									detallePagoVistaClienteDTO.setDescripcionEmpresa(nuevo.getRecuadacion().getDescripcionEmpresa());
								}
							}
							logger.info("Fin de la obtención de datos de la empresa recaudadora"); 

							logger.info("Se obtienen los datos de la oficina");
							if(nuevo != null && nuevo.getPrefPlaza() != null && !nuevo.getPrefPlaza().equals("") && nuevo.getNumCompago() > 0){
								if(nuevo.getCodOripago() != 3 && nuevo.getCodOripago() != 11 ){
									OficinaInDTO oficinaEntrada = new OficinaInDTO();
									oficinaEntrada.setPRefPlaza(nuevo.getPrefPlaza());
									oficinaEntrada.setNumComPago(nuevo.getNumCompago());
									OficinaDTO oficina = oficinaDAO.consultarOficina(oficinaEntrada);
									nuevo.setOficina(oficina);
									
								}
								if(nuevo.getOficina() != null && nuevo.getOficina().getCodOficina()!= null ){
									detallePagoVistaClienteDTO.setRecaudadora(nuevo.getOficina().getCodOficina());
								}
								if(nuevo.getOficina() != null && nuevo.getOficina().getDesOficina() != null){
									detallePagoVistaClienteDTO.setDescripcionEmpresa(nuevo.getOficina().getDesOficina());
								}
							}
							logger.info("Fin obtención de datos de la oficina");
							
							logger.info("fin del objeto pago vista cliente");
							
							/*cargo la lista detalle del pago (facturas que se pagaron con ese pago)*/
							listaDetallePagoVistaClienteDTO.add(detallePagoVistaClienteDTO);
							pagoVistaClienteDTO.setLstDetallePago((com.tmmas.gte.integraciongtecommon.dto.DetallePagoVistaClienteDTO[]) 
									com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaDetallePagoVistaClienteDTO.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.DetallePagoVistaClienteDTO.class));
								
							numSecuencia = ""+nuevo.getNumSecuenci();
						}
						if(listaPagoVistaClienteDTO!= null && listaPagoVistaClienteDTO.size() > 0){
							logger.info("seteando la lista final para poder desplegar al cliente");
							pagoOutDTOFinal.setLstListadoPagos((com.tmmas.gte.integraciongtecommon.dto.PagoVistaClienteDTO[])
									com.tmmas.cl.framework.util.ArrayUtl.copiaArregloTipoEspecifico(listaPagoVistaClienteDTO.toArray(),
											com.tmmas.gte.integraciongtecommon.dto.PagoVistaClienteDTO.class));
							
							pagoOutDTOFinal.setRespuesta(new RespuestaDTO());
							logger.info("seteando la lista final para poder desplegar al cliente");
						}else{
						    pagoOutDTOFinal = new PagoOutDTO();
							nuevaRespuesta = new RespuestaDTO();
							nuevaRespuesta.setCodigoError(-10022);
							nuevaRespuesta.setMensajeError("No ha sido posible consultar los pagos realizados por el cliente.");
							pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
							return pagoOutDTOFinal;
						}
					}else{
					    pagoOutDTOFinal = new PagoOutDTO();
						nuevaRespuesta = new RespuestaDTO();
					    if(outParam0 != null && outParam0.getRespuesta() != null && outParam0.getRespuesta().getCodigoError() != 0 ){
					    	pagoOutDTOFinal.setRespuesta(outParam0.getRespuesta());
					    }else{
							nuevaRespuesta.setCodigoError(-10020);
							nuevaRespuesta.setMensajeError("No ha sido posible obtener los pagos realizados por el cliente");
							pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
					    }
						return pagoOutDTOFinal;
					}
					logger.info("fin de la generacion de la lista ");
			  }else{
				    pagoOutDTOFinal = new PagoOutDTO();
					nuevaRespuesta = new RespuestaDTO();
				    if(consParametrosResponseDTO != null && consParametrosResponseDTO.getRespuesta() != null && consParametrosResponseDTO.getRespuesta().getCodigoError() != 0 ){
				    	pagoOutDTOFinal.setRespuesta(consParametrosResponseDTO.getRespuesta());
				    }else{
						nuevaRespuesta.setCodigoError(-10021);
						nuevaRespuesta.setMensajeError("El Número teléfono no esta registrado");
						pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
				    }
					return pagoOutDTOFinal;
			  }
			logger.info("tercera Parte : fin de la evalucion del valor entregado");

		}else{	
		    pagoOutDTOFinal = new PagoOutDTO();
			nuevaRespuesta = new RespuestaDTO();
		    if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0 ){
		    	pagoOutDTOFinal.setRespuesta(datosAbonados.getRespuesta());
		    }else{
				nuevaRespuesta.setCodigoError(-10021);
				nuevaRespuesta.setMensajeError("El Número teléfono no esta registrado");
				pagoOutDTOFinal.setRespuesta(nuevaRespuesta);
		    }
	    	return pagoOutDTOFinal;
        }
		logger.info("Primera parte : finaliza la condición del abonado ");
		
		return pagoOutDTOFinal;
	}

	
	/**
	* Retorna saldo total de un Cliente a partir del codigo_cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO consultarSaldo(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		Global global = Global.getInstance();
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));

		AbonadoPospagoOutDTO	datosClienteOut 	= new AbonadoPospagoOutDTO();
		CodClienteDTO			codigoClienteIn		= new CodClienteDTO();
		CarteraResponseDTO		outParam0			= new CarteraResponseDTO();
		RespuestaDTO			respuesta			= new RespuestaDTO();
		CarteraResponseDTO		saldoCliente		= new CarteraResponseDTO();
		
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();

		logger.info("consultarSaldoCliente:start()");
		logger.info("consultarSaldoCliente:antes()");
		
		
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
				saldoCliente.setRespuesta(respuesta);
				return saldoCliente;
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
					saldoCliente.setRespuesta(aplicacionValidada);
					return saldoCliente;
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
				saldoCliente.setRespuesta(servicioValidado);
				return saldoCliente;
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
				saldoCliente.setRespuesta(usuarioValidado);
				return saldoCliente;
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
					saldoCliente.setRespuesta(respuesta);
					return saldoCliente;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			saldoCliente.setRespuesta(respuesta);
			return saldoCliente;
		}
		//Fin de Registro de auditoría 				

		
		
		/**
		* Retorna numAbonado y codCliente a partir de un numero Telefono
		*/
		
		
		EsTelefIgualClieDTO telefono  = null;
		AbonadoOutDTO datosAbonados = null; 
		AbonadoDTO abonado = null; 

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
		
				logger.info("consAbonadoPospagoHibrido:start()");
				logger.info("consAbonadoPospagoHibrido:antes()");
				datosClienteOut = abonadoDAO.consAbonadoPospagoHibrido(inParam0);
				logger.info("consAbonadoPospagoHibrido:despues()");
				logger.info("consAbonadoPospagoHibrido:end()");
				
				if (datosClienteOut != null && datosClienteOut.getRespuesta()!= null &&  datosClienteOut.getRespuesta().getCodigoError()==0 ){
					if (datosClienteOut.getListadoClientes().length > 0 ){
						codigoClienteIn.setCodCliente(datosClienteOut.getListadoClientes()[0].getCodCliente());
						
						/**
						* Retorna Saldo Total de un Cliente a partir de un codCliente
						*/
						logger.info("obtenerSaldoCliente:start()");
						logger.info("obtenerSaldoCliente:antes()");
						outParam0 = consCarteraDTODAO.obtenerSaldoCliente(codigoClienteIn);
						logger.info("obtenerSaldoCliente:despues()");
						logger.info("obtenerSaldoCliente:end()");
						
						if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
							CarteraDTO cartera = new CarteraDTO();
							cartera.setSaldoCliente(outParam0.getCarteraCliente().getSaldoCliente());
							saldoCliente.setCarteraCliente(cartera);
							respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
							respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
							respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
							saldoCliente.setRespuesta(respuesta);
						}else{
							respuesta.setCodigoError(-10023);
							respuesta.setMensajeError("No fue posible obtener el saldo total del cliente");
							respuesta.setNumeroEvento(0);
							saldoCliente.setRespuesta(respuesta);
						}
						
					}else {
						respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
						respuesta.setMensajeError("No fue posible obtener el saldo total del cliente");
						respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
						saldoCliente.setRespuesta(respuesta);
					}
				}else {
					respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
					respuesta.setMensajeError("No fue posible obtener el saldo total del cliente");
					respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
					saldoCliente.setRespuesta(respuesta);
				}
		
		}else{
			 if(datosAbonados != null && datosAbonados.getRespuesta() != null && datosAbonados.getRespuesta().getCodigoError() != 0){
				 saldoCliente.setRespuesta(datosAbonados.getRespuesta());
				 return saldoCliente;
			 }else{
				 respuesta = new RespuestaDTO();
				 respuesta.setCodigoError(-10047);
				 respuesta.setMensajeError("No ha sido posible obtener el saldo para el teléfono consultado.");
				 saldoCliente.setRespuesta(respuesta);
				 return saldoCliente;
			 }
		}
		
		logger.info("consultarSaldoCliente:despues()");
		logger.info("consultarSaldoCliente:end()");
		return saldoCliente;
	}
	
	
	/**
	* Retorna deuda vencida y deuda por vencer de un Cliente a partir del codigo_cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SaldoMorosidadDTO consultarSaldo(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException{
		
		UtilLog.setLog(config.getString("IntegracionGTEService.log"));
		
		EsTelefIgualClieDTO	 	numeroTelefonoIn 	= new EsTelefIgualClieDTO();
		AbonadoOutDTO			datosClienteOut 	= new AbonadoOutDTO();
		CodClienteDTO			codigoClienteIn		= new CodClienteDTO();
		SaldoMorosidadDTO		outParam0			= new SaldoMorosidadDTO();
		RespuestaDTO			respuesta			= new RespuestaDTO();
		SaldoMorosidadDTO		saldoCliente		= new SaldoMorosidadDTO();
		
		AuditoriaDTO	codPuntoAccesoDto		= new AuditoriaDTO();		
		AuditoriaDTO	codAplicacionDto		= new AuditoriaDTO();		
		AuditoriaDTO	codServicioDto			= new AuditoriaDTO();		
		AuditoriaDTO	nombreUsuarioDto		= new AuditoriaDTO();	
		ArrayList 		campos					= new ArrayList();

		logger.info("consultarSaldoCliente:start()");
		logger.info("consultarSaldoCliente:antes()");
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
				saldoCliente.setRespuesta(respuesta);
				return saldoCliente;
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
					saldoCliente.setRespuesta(aplicacionValidada);
					return saldoCliente;
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
				saldoCliente.setRespuesta(servicioValidado);
				return saldoCliente;
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
				saldoCliente.setRespuesta(usuarioValidado);
				return saldoCliente;
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
					saldoCliente.setRespuesta(respuesta);
					return saldoCliente;
				}
	        }	
		}else
		{
			respuesta.setCodigoError(auditoria.getRespuesta().getCodigoError());
			respuesta.setMensajeError(auditoria.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(auditoria.getRespuesta().getNumeroEvento());
			saldoCliente.setRespuesta(respuesta);
			return saldoCliente;
		}
		//Fin de Registro de auditoría 				

		
		/**
		* Retorna numAbonado y codCliente a partir de un numero Telefono
		*/
		logger.info("consultarAbonadoTelefono:start()");
		logger.info("consultarAbonadoTelefono:antes()");
		datosClienteOut = abonadoDAO.consultarAbonadoTelefono(numeroTelefonoIn);
		logger.info("consultarAbonadoTelefono:despues()");
		logger.info("consultarAbonadoTelefono:end()");
		
		if (datosClienteOut != null && datosClienteOut.getRespuesta()!= null &&  datosClienteOut.getRespuesta().getCodigoError()==0 ){
			if (datosClienteOut.getListadoAbonados().length > 0 ){
				codigoClienteIn.setCodCliente(datosClienteOut.getListadoAbonados()[0].getCodCliente());
				
				/**
				* Retorna deuda vencida y deuda por vencer de un Cliente a partir de un codCliente
				*/
				logger.info("obtenerSaldoCliente:start()");
				logger.info("obtenerSaldoCliente:antes()");
				outParam0 = consCarteraDTODAO.consultarSaldoClieBloqueado(codigoClienteIn);
				logger.info("obtenerSaldoCliente:despues()");
				logger.info("obtenerSaldoCliente:end()");
				
				if (outParam0 != null && outParam0.getRespuesta()!= null &&  outParam0.getRespuesta().getCodigoError()==0  ){
					
					saldoCliente.setSaldoVenc(outParam0.getSaldoVenc());
					saldoCliente.setSaldoNoVenc(outParam0.getSaldoNoVenc());
					
					respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
					respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
					saldoCliente.setRespuesta(respuesta);
				}else{
					respuesta.setCodigoError(outParam0.getRespuesta().getCodigoError());
					respuesta.setMensajeError(outParam0.getRespuesta().getMensajeError());
					respuesta.setNumeroEvento(outParam0.getRespuesta().getNumeroEvento());
					saldoCliente.setRespuesta(respuesta);
				}
				
			}else {
				respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
				respuesta.setMensajeError(datosClienteOut.getRespuesta().getMensajeError());
				respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
				saldoCliente.setRespuesta(respuesta);
			}
		}else {
			respuesta.setCodigoError(datosClienteOut.getRespuesta().getCodigoError());
			respuesta.setMensajeError(datosClienteOut.getRespuesta().getMensajeError());
			respuesta.setNumeroEvento(datosClienteOut.getRespuesta().getNumeroEvento());
			saldoCliente.setRespuesta(respuesta);
		}
		logger.info("consultarSaldoCliente:despues()");
		logger.info("consultarSaldoCliente:end()");
		return saldoCliente;
	}
	
}