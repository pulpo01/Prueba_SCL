package com.tmmas.gte.pagoonlineservice.srv;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

//import com.tmmas.cl.framework20.util.ServiceLocator;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;

import com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;

public class PagoOnLineServiceImpl implements PagoOnLineService {

	private CompositeConfiguration config;
	//private static Logger logger = Logger.getLogger(ClientePagoDTODAOImpl.class);
	private static Logger logger = Logger.getLogger(PagoOnLineServiceImpl.class);
	
	//private ServiceLocator  serviceLocator = ServiceLocator.getInstance();	
	
	public PagoOnLineServiceImpl() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineservice/properties/PagoOnLineService.properties");
	}	
		
	private com.tmmas.gte.pagoonlineservice.srv.ClientePagoDTOService clientePagoDTOService = new com.tmmas.gte.pagoonlineservice.srv.ClientePagoDTOServiceImpl();
	private com.tmmas.gte.pagoonlineservice.srv.EmpresaRecaudacionDTOService empresaRecaudacionDTOService = new com.tmmas.gte.pagoonlineservice.srv.EmpresaRecaudacionDTOServiceImpl();
	private com.tmmas.gte.pagoonlineservice.srv.InterfazPagoDTOService interfazPagoDTOService = new com.tmmas.gte.pagoonlineservice.srv.InterfazPagoDTOServiceImpl();
	private com.tmmas.gte.pagoonlineservice.srv.GedParametrosDTOService gedParametrosDTOService = new com.tmmas.gte.pagoonlineservice.srv.GedParametrosDTOServiceImpl();
	private com.tmmas.gte.pagoonlineservice.srv.TransaccionDTOService transaccionDTOService = new com.tmmas.gte.pagoonlineservice.srv.TransaccionDTOServiceImpl();
	
	private com.tmmas.gte.pagoonlineservice.srv.InterfazReversaDTOService interfazReversaDTOService = new com.tmmas.gte.pagoonlineservice.srv.InterfazReversaDTOServiceImpl();
	
		public com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO aplicaPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.PagoDTO inParam) throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException {
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO respuestaPago = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO();			
			com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO clientePago = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();
			com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO saldos = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();
			com.tmmas.gte.pagoonlinecommon.dto.InterfazPagoDTO interfazPago = new com.tmmas.gte.pagoonlinecommon.dto.InterfazPagoDTO();
			com.tmmas.gte.pagoonlinecommon.dto.EmpresaRecaudacionDTO empresaRecaudacion = new com.tmmas.gte.pagoonlinecommon.dto.EmpresaRecaudacionDTO();
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO respuesta = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();
			com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO gedParametro = new com.tmmas.gte.pagoonlinecommon.dto.GedParametrosDTO();
			com.tmmas.gte.pagoonlinecommon.dto.TransaccionDTO transaccion = new com.tmmas.gte.pagoonlinecommon.dto.TransaccionDTO();			
			
			double pagoDeudaVencida = 0, saldoDeudaVencida = 0;
			double saldoDeudaPorVencer = 0;
			double pagoLimitePlanTarifario = 0, saldoLimitePlanTarifario = 0;
			double pagoLimitePlanAdicional = 0, saldoLimitePlanAdicional = 0;
			double saldoPago = 0;
			int numPagos = 0;
			String ctaCteDefecto = new String();
			String bancoDefecto = new String();
								
			UtilLog.setLog(config.getString("PagoOnLineService.log"));
			
			logger.info("PagoOnLineServiceImpl:start()");
			//TODO Modifique datos de busqueda de clase com.tmmas.sc.maniuccommon.dto.Ambito de ser necesario
			try {
				logger.debug("Agencia[" + inParam.getAgencia() + "]");
				interfazPago.setAgencia(inParam.getAgencia());
				logger.debug("CodBanco[" + inParam.getCodBanco() + "]");
				interfazPago.setCodBanco(inParam.getCodBanco());
				//Obtiene Codigo de Cliente
				logger.debug("numTelefonoCliente[" + inParam.getNumTelefonoCliente() + "]");
				logger.debug("Telefono[" + String.valueOf(inParam.getTelefono()).toString() + "]");
				if (inParam.getNumTelefonoCliente().equals(String.valueOf(inParam.getTelefono()).toString())){
					//Llamar a Obtener Cliente 
					clientePago.setNumCelular(inParam.getNumTelefonoCliente());
					logger.info("obtenerCodCliente:start()");
					clientePago = clientePagoDTOService.obtenerCodCliente(clientePago);
					if (clientePago.getRespuesta().getCodigoError()!=0){
						respuestaPago.setRespuesta(clientePago.getRespuesta());
						return respuestaPago;						
					}
					logger.info("obtenerCodCliente:end()");
					interfazPago.setCodCliente(clientePago.getCodCliente());
					logger.debug("CodCliente[" + clientePago.getCodCliente() + "]");
				}
				else{
					clientePago.setCodCliente(Integer.valueOf(inParam.getNumTelefonoCliente()).intValue());
					interfazPago.setCodCliente(clientePago.getCodCliente());				
				}
							
				//Obtiene Caja de la Empresa de Recaudación
				empresaRecaudacion.setEmpRecaudadora(inParam.getCodBanco());
				logger.info("obtenerCaja:start()");
				empresaRecaudacion = empresaRecaudacionDTOService.obtenerCaja(empresaRecaudacion);
				logger.info("obtenerCaja:end()");
				if (empresaRecaudacion.getRespuesta().getCodigoError()!= 0){
					respuestaPago.setRespuesta(empresaRecaudacion.getRespuesta());
					return respuestaPago;
				}
				interfazPago.setCodCaja(empresaRecaudacion.getCodCaja());
				
				//Obtiene Saldo del Cliente
				clientePago.setCodCliente(interfazPago.getCodCliente());
				logger.info("obtenerSaldo:start()");
				clientePago = clientePagoDTOService.obtenerSaldo(clientePago);
				logger.info("obtenerSaldo:end()");
				if (clientePago.getRespuesta().getCodigoError()!=0){
					respuestaPago.setRespuesta(clientePago.getRespuesta());
					return respuestaPago;						
				}				
				logger.debug("saldoVencido[" + clientePago.getSaldoVencido() + "]");
				logger.debug("saldoPorVencer[" + clientePago.getSaldoPorVencer() + "]");
				saldos.setSaldoVencido(clientePago.getSaldoVencido());
				saldos.setSaldoPorVencer(clientePago.getSaldoPorVencer());
				
				//Obtiene Saldo Limite Consumo solo si se deberá pagar alguno de estos montos			
				if (saldos.getSaldoVencido()< inParam.getMontoTotalOperacion()){
					clientePago = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();
					clientePago.setCodCliente(interfazPago.getCodCliente());
					logger.info("obtenerSaldoLimite:start()");
					clientePago = clientePagoDTOService.obtenerSaldoLimite(clientePago);
					logger.info("obtenerSaldoLimite:end()");
					if (clientePago.getRespuesta().getCodigoError()!=0){
						respuestaPago.setRespuesta(clientePago.getRespuesta());
						return respuestaPago;						
					}					
					logger.debug("saldoPlanTarifario[" + clientePago.getSaldoLimiteConsumoPlanTarifario() + "]");
					logger.debug("saldoPlanAdicional[" + clientePago.getSaldoLimiteConsumoPlanAdicional() + "]");
					
					saldos.setSaldoLimiteConsumoPlanAdicional(clientePago.getSaldoLimiteConsumoPlanAdicional());
					saldos.setSaldoLimiteConsumoPlanTarifario(clientePago.getSaldoLimiteConsumoPlanTarifario());
				}
				
				//Obtiene Nombre del Cliente
				clientePago = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();
				clientePago.setCodCliente(interfazPago.getCodCliente());
				logger.info("obtenerNombreCliente:start()");
				clientePago = clientePagoDTOService.obtenerNombreCliente(clientePago);
				logger.info("obtenerNombreCliente:end()");
				if (clientePago.getRespuesta().getCodigoError()!=0){
					respuestaPago.setRespuesta(clientePago.getRespuesta());
					return respuestaPago;						
				}				
				logger.debug("NombreCliente[" + clientePago.getNombre() + "]");
				
				//Aplica pago en efectivo solo a deuda												
				interfazPago.setCodServicio(Integer.valueOf(config.getString("codServicio")).intValue());
				interfazPago.setOperador(inParam.getCajero());
				interfazPago.setServicioSolicitado(config.getString("serSolicitado"));
				interfazPago.setTipTransaccion(config.getString("tipTransaccion"));
				interfazPago.setSubTipo(config.getString("subTipo"));				
				interfazPago.setNumEjercicio(inParam.getFecha());
				
				interfazPago.setFecEfectividad(inParam.getFecha() + " " + inParam.getHora());
				if (inParam.getNumBoleta() > 0){
					interfazPago.setNumAutorizacion(String.valueOf(inParam.getNumBoleta()).toString());
				}				
				
				//Obtiene Datos por Defecto
				if ((inParam.getMontoChequeOtroBanco()>= 0) || (inParam.getMontoChequeBanco()>= 0)) {
					gedParametro.setCodModulo(config.getString("codModulo"));
					gedParametro.setCodProducto(Integer.valueOf(config.getString("codProducto")).intValue());
					gedParametro.setNomParametro(config.getString("ctacteWEB"));
					logger.info("obtenerParametro ctacteDefecto:start()");
					gedParametro = gedParametrosDTOService.obtenerParametro(gedParametro);
					logger.info("obtenerParametro ctacteDefecto:end()");
					if (gedParametro.getRespuesta().getCodigoError()!=0){
						respuestaPago.setRespuesta(gedParametro.getRespuesta());
						return respuestaPago;						
					}					
					ctaCteDefecto = gedParametro.getValParametro();
					if (inParam.getMontoChequeOtroBanco()>= 0) {
						gedParametro.setCodModulo(config.getString("codModulo"));
						gedParametro.setCodProducto(Integer.valueOf(config.getString("codProducto")).intValue());						
						gedParametro.setNomParametro(config.getString("bancoWEB"));
						logger.info("obtenerParametro bancoDefecto:start()");
						gedParametro = gedParametrosDTOService.obtenerParametro(gedParametro);
						logger.info("obtenerParametro bancoDefecto:end()");
						if (gedParametro.getRespuesta().getCodigoError()!=0){
							respuestaPago.setRespuesta(gedParametro.getRespuesta());
							return respuestaPago;						
						}						
						bancoDefecto = gedParametro.getValParametro();
					} 				
				}
				pagoDeudaVencida = 0;
				saldoDeudaVencida = saldos.getSaldoVencido();
				saldoDeudaPorVencer = saldos.getSaldoPorVencer();
				pagoLimitePlanTarifario = 0;
				saldoLimitePlanTarifario = saldos.getSaldoLimiteConsumoPlanTarifario();
				pagoLimitePlanAdicional = 0;
				saldoLimitePlanAdicional = saldos.getSaldoLimiteConsumoPlanAdicional();
				
				//Obtiene Número de Transaccion
				logger.info("obtenerTransaccion:start()");
				transaccion = transaccionDTOService.obtenerTransaccion();
				logger.info("obtenerTransaccion:end()");
				if (transaccion.getRespuesta().getCodigoError()!=0){
					respuestaPago.setRespuesta(transaccion.getRespuesta());
					return respuestaPago;						
				}				
				logger.debug("transaccionEmp[" + transaccion.getNumTransaccion()+ "]");
				interfazPago.setNumTransaccion(transaccion.getNumTransaccion());
				interfazPago.setNumTransaccionEmp(transaccion.getNumTransaccion());
				
				for (int i=1;i<=5;i++) {
					if (i == 1) { //Pago Efectivo
						saldoPago = inParam.getMontoEfectivo();
						interfazPago.setTipValor(Integer.valueOf(config.getString("tipValorEfectivo")).intValue());
						interfazPago.setBancoCheque(null);
						interfazPago.setCtaCte(null);
						interfazPago.setNumCheque(0);
						interfazPago.setNumTarjeta(null);
						interfazPago.setNumAutorizacion(null);
						interfazPago.setTipTarjeta(null);						
					}
					if (i == 2) { //Pago cheque mismo banco						
						saldoPago = inParam.getMontoChequeBanco();
						interfazPago.setTipValor(Integer.valueOf(config.getString("tipValorChequeDia")).intValue());						
						interfazPago.setNumCheque(inParam.getNumCheque());
						interfazPago.setBancoCheque(interfazPago.getCodBanco());					
						interfazPago.setCtaCte(ctaCteDefecto);
						interfazPago.setNumTarjeta(null);
						interfazPago.setNumAutorizacion(null);
						interfazPago.setTipTarjeta(null);						
					}
					if (i == 3) { //Pago Cheque otros bancos					
						saldoPago = inParam.getMontoChequeOtroBanco();
						interfazPago.setTipValor(Integer.valueOf(config.getString("tipValorChequeDia")).intValue());
						interfazPago.setNumCheque(inParam.getNumCheque());
						interfazPago.setBancoCheque(bancoDefecto);
						interfazPago.setCtaCte(ctaCteDefecto);
						interfazPago.setNumTarjeta(null);
						interfazPago.setNumAutorizacion(null);
						interfazPago.setTipTarjeta(null);						
					}
					
					if (i == 4) { //Pago Tarjeta Credito					
						saldoPago = inParam.getMontoTarjetaCredito();
						interfazPago.setTipValor(Integer.valueOf(config.getString("tipValorTarjetaCredito")).intValue());
						interfazPago.setNumCheque(0);
						interfazPago.setBancoCheque(null);
						interfazPago.setCtaCte(null);
						interfazPago.setNumTarjeta(inParam.getNumTarjeta());
						interfazPago.setNumAutorizacion(inParam.getNumAutorizacion());
						interfazPago.setTipTarjeta(inParam.getTipTarjeta());
					}		
					
					if (i == 5) { //Pago Tarjeta Debito					
						saldoPago = inParam.getMontoTarjetaDebito();
						interfazPago.setTipValor(Integer.valueOf(config.getString("tipValorTarjetaDebito")).intValue());
						interfazPago.setNumCheque(0);
						interfazPago.setCtaCte(null);
						interfazPago.setNumTarjeta(null);
						interfazPago.setNumAutorizacion(null);
						interfazPago.setTipTarjeta(null);
						interfazPago.setBancoCheque(inParam.getBancoTarjetaDebito());
					}						
					//Pago Deuda Vencida
					if ((saldoPago > 0) && (saldoDeudaVencida> 0)) { 
						if (saldoPago > saldoDeudaVencida) {
							pagoDeudaVencida = saldoDeudaVencida;
							saldoDeudaVencida = 0;
							saldoPago = saldoPago - pagoDeudaVencida;
						}
						else {
							pagoDeudaVencida = saldoPago;
							saldoDeudaVencida = (saldoDeudaVencida - saldoPago);
							saldoPago = 0;								
						}							
					}
					
					//Pago Limite de Consumo por Plan Tarifario
					if ((saldoPago > 0) && (saldoLimitePlanTarifario> 0)) {
						if (saldoPago > saldoLimitePlanTarifario) {
							pagoLimitePlanTarifario = saldoLimitePlanTarifario;
							saldoLimitePlanTarifario = 0;
							saldoPago = saldoPago - pagoLimitePlanTarifario;
						}
						else {
							pagoLimitePlanTarifario = saldoPago;
							saldoLimitePlanTarifario = (saldoLimitePlanTarifario - saldoPago);
							saldoPago = 0;								
						}						
					}
				
					//Pago Limite de Consumo por Plan Adicional
					if ((saldoPago > 0) && (saldoLimitePlanAdicional> 0)) {
						if (saldoPago > saldoLimitePlanAdicional) {
							pagoLimitePlanAdicional = saldoLimitePlanAdicional;
							saldoLimitePlanAdicional = 0;
							saldoPago = saldoPago - pagoLimitePlanAdicional;
						}
						else {
							pagoLimitePlanAdicional = saldoPago;
							saldoLimitePlanAdicional = (saldoLimitePlanAdicional - saldoPago);
							saldoPago = 0;								
						}						
					}
					
					//Lo que sobra va a Deuda por Vencer o Abono
					if (saldoPago > 0) {
						saldoDeudaPorVencer = saldoDeudaPorVencer - saldoPago;
						pagoDeudaVencida = pagoDeudaVencida + saldoPago;
						saldoPago = 0;
					}
			
					// Inserta Pago Deuda Vencida + Deuda por Vencer  + Abono
					if (pagoDeudaVencida > 0) {
						if (numPagos > 0) {
							//Obtiene Número de Transaccion
							logger.info("obtenerTransaccion:start()");
							transaccion = transaccionDTOService.obtenerTransaccion();
							logger.info("obtenerTransaccion:end()");
							if (transaccion.getRespuesta().getCodigoError()!=0){
								respuestaPago.setRespuesta(transaccion.getRespuesta());
								return respuestaPago;						
							}								
							interfazPago.setNumTransaccion(transaccion.getNumTransaccion());							
						}
						interfazPago.setCodOperacion(Integer.valueOf(config.getString("codOperacionPago")).intValue());						
						interfazPago.setMtoPago(pagoDeudaVencida);
						logger.debug("transaccion[" + transaccion.getNumTransaccion()+ "]");
						logger.info("ingresaPagoInterfaz:start()");
						respuesta = interfazPagoDTOService.ingresaPagoInterfaz(interfazPago);
						logger.info("ingresaPagoInterfaz:end()");
						if (respuesta.getCodigoError()!=0){
							respuestaPago.setRespuesta(respuesta);
							return respuestaPago;						
						}						
						numPagos++;
					}
					
					//Inserta Pago Límite Consumo por Plan Tarifario
					if (pagoLimitePlanTarifario > 0) {
						if (numPagos > 0) {
							//Obtiene Número de Transaccion
							logger.info("obtenerTransaccion:start()");
							transaccion = transaccionDTOService.obtenerTransaccion();
							logger.info("obtenerTransaccion:end()");
							if (transaccion.getRespuesta().getCodigoError()!=0){
								respuestaPago.setRespuesta(transaccion.getRespuesta());
								return respuestaPago;						
							}								
							interfazPago.setNumTransaccion(transaccion.getNumTransaccion());							
						}						
						interfazPago.setCodOperacion(Integer.valueOf(config.getString("codOperacionLimitePlanTarifario")).intValue());
						interfazPago.setMtoPago(pagoLimitePlanTarifario);
						logger.debug("transaccion[" + transaccion.getNumTransaccion()+ "]");
						logger.info("ingresaPagoInterfaz:start()");
						respuesta = interfazPagoDTOService.ingresaPagoInterfaz(interfazPago);						
						logger.info("ingresaPagoInterfaz:end()");
						if (respuesta.getCodigoError()!=0){
							respuestaPago.setRespuesta(respuesta);
							return respuestaPago;						
						}							
						numPagos++;
					}					
					//Inserta Pago Límite Consumo por Plan Adicional
					if (pagoLimitePlanAdicional > 0) {
						if (numPagos > 0) {
							//Obtiene Número de Transaccion
							logger.info("obtenerTransaccion:start()");
							transaccion = transaccionDTOService.obtenerTransaccion();
							logger.info("obtenerTransaccion:end()");
							if (transaccion.getRespuesta().getCodigoError()!=0){
								respuestaPago.setRespuesta(transaccion.getRespuesta());
								return respuestaPago;						
							}								
							interfazPago.setNumTransaccion(transaccion.getNumTransaccion());							
						}						
						interfazPago.setCodOperacion(Integer.valueOf(config.getString("codOperacionLimitePlanAdicional")).intValue());
						interfazPago.setMtoPago(pagoLimitePlanAdicional);
						logger.debug("transaccion[" + transaccion.getNumTransaccion()+ "]");
						logger.info("ingresaPagoInterfaz:start()");
						respuesta = interfazPagoDTOService.ingresaPagoInterfaz(interfazPago);
						logger.info("ingresaPagoInterfaz:end()");
						if (respuesta.getCodigoError()!=0){
							respuestaPago.setRespuesta(respuesta);
							return respuestaPago;						
						}						
						numPagos++;
					}	
					pagoDeudaVencida = 0;
					pagoLimitePlanTarifario = 0;
					pagoLimitePlanAdicional = 0;
				}
			
				respuestaPago.setApellidosCliente(clientePago.getApellido());
				respuestaPago.setNombreCliente(clientePago.getNombre());
				respuestaPago.setNumTelefonoCliente(Long.valueOf(inParam.getNumTelefonoCliente()).longValue());
				if ((saldoDeudaVencida + saldoDeudaPorVencer) > 0) {
					respuestaPago.setMtoSaldo(saldoDeudaVencida + saldoDeudaPorVencer);
				}
				else {
					respuestaPago.setMtoSaldo(0);
				}
				logger.debug("saldoFinal[" + respuestaPago.getMtoSaldo()+ "]");
				respuestaPago.setnumTransaccion(interfazPago.getNumTransaccionEmp());
				respuestaPago.setRespuesta(respuesta);
				logger.info("PagoOnLineServiceImpl:end()");
				
			} catch (PagoOnLineException e) {
				logger.debug("ProyectoException[", e);
				throw e;
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new PagoOnLineException(e);
			}
			return respuestaPago;			
		}		
		
		/* Reversa del Pago */
		public com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO reversarPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.ReversaDTO inParam) throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException {
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO respuestaReversa = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO();			
			com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO clientePago = new com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO();
			com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO interfazReversa = new com.tmmas.gte.pagoonlinecommon.dto.InterfazReversaDTO();
			com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO respuesta = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();						
								
			UtilLog.setLog(config.getString("PagoOnLineService.log"));
			
			logger.info("PagoOnLineServiceImpl:start()");
			//TODO Modifique datos de busqueda de clase com.tmmas.sc.maniuccommon.dto.Ambito de ser necesario
			try {
				logger.debug("Banco[" + inParam.getCodBanco() + "]");
				interfazReversa.setCodBanco(inParam.getCodBanco());
				logger.debug("CodCliente[" + inParam.getNumTelefonoCliente() + "]");
				interfazReversa.setCodCliente(Long.valueOf(inParam.getNumTelefonoCliente()).longValue());
				interfazReversa.setFecPago(inParam.getFecha());
				interfazReversa.setHorPago(inParam.getHora());
				interfazReversa.setMtoPago(inParam.getMontoTotalOperacion());
				interfazReversa.setNumTransaccion(inParam.getNumTransaccion());
				
				//Valida que exista la Reversa
				logger.info("validaReversa:start()");
				respuesta = interfazReversaDTOService.validaReversa(interfazReversa);
				logger.info("validaReversa:end()");
				if (respuesta.getCodigoError()!=0){
					respuestaReversa.setRespuesta(respuesta);
					return respuestaReversa;						
				}	
				
				//Aplica la Reversa del Pago		
				logger.info("aplicaReversa:start()");
				respuesta = interfazReversaDTOService.aplicaReversa(interfazReversa);
				logger.info("aplicaReversa:end()");
				if (respuesta.getCodigoError()!=0){
					respuestaReversa.setRespuesta(respuesta);
					return respuestaReversa;						
				}			

				respuestaReversa.setRespuesta(respuesta);
				logger.info("PagoOnLineServiceImpl:end()");
				
			} catch (PagoOnLineException e) {
				logger.debug("ProyectoException[", e);
				throw e;
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new PagoOnLineException(e);
			}
			
			return respuestaReversa;			
		}			
}
