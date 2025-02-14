package com.tmmas.cl.scl.integracionsicsa.srv;

import java.util.HashMap;

import com.tmmas.cl.scl.integracionsicsa.bo.PedidoBO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaPedidoUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosFolioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.PedidoLineaDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.PedidoInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;

public class PedidoSRV extends IntegracionSICSASRV {
	private PedidoBO pedidoBO = new PedidoBO();
	private GlobalProperties global = GlobalProperties.getInstance();
	
	public void validaPedido(PedidoInDTO pedidoInDTO)throws IntegracionSICSAException, Exception{
		loggerDebug("validaPedido: Inicio");
		SalidaIntegracionSICSADTO respuesta = null;
		String codError = null;
		int numEvento = -1;
		String msgError = null;
		PedidoLineaDTO[] pedidoLineaDTOs = null;
		try{
		//Se obtiene Parametro de la NPT_PARAMETRO		//TODO AQUI	
		String valAsigDespa = pedidoBO.obtieneParametroNPW(global.getValor("valorAsigDespachadorLee"));
		//Valida que estado de pedido sea "ASIGNADO DESPACHADOR"  //TODO AQUI	
		loggerDebug("Valida que estado de pedido sea ASIGNADO DESPACHADOR");
		respuesta = pedidoBO.validaEstadoPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), valAsigDespa);	
		
		loggerDebug("Obtiene Cantidad Total Pedido Registrado y valida si es igual al informado");
		int cantPedido = pedidoBO.obtieneCantTotalPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
		loggerDebug("cantPedidoBD: "+ cantPedido);
		loggerDebug("cantPedidoEnviado: "+ pedidoInDTO.getPedidoEncabezadoDTO().getTotalPedido());
		
		if(!String.valueOf(cantPedido).trim().equals(pedidoInDTO.getPedidoEncabezadoDTO().getTotalPedido())){
			msgError = global.getValor("ERR.0006").replace("[nXML]", pedidoInDTO.getPedidoEncabezadoDTO().getTotalPedido()).replace("[nBD]", String.valueOf(cantPedido));
			loggerDebug(msgError);
			throw new IntegracionSICSAException("ERR.0006",-1,msgError);
		}
		
		loggerDebug("Obtiene cantidad pedido por linea");
		pedidoLineaDTOs = pedidoBO.obtieneCantTotalPedidoXLinea(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
		int cantLineasBD = pedidoLineaDTOs.length;
		int cantLineasXML = pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs().length;
		
		loggerDebug("cantLineasBD: " + cantLineasBD);
		loggerDebug("cantLineasXML: " + cantLineasXML);
		
		//Valida que la cantidad de lineas informadas sea igual a la cantidad de lineas que se encuentra en BD //TODO AQUI
		loggerDebug("Valida que la cantidad de lineas informadas sea igual a la cantidad de lineas que se encuentra en BD");
		if(cantLineasXML != cantLineasBD){
			codError = "ERR.0007";
			numEvento = -1;
			msgError = global.getValor("ERR.0007").replace("nXML", String.valueOf(cantLineasXML)).replace("nBD", String.valueOf(cantLineasBD));
			loggerDebug(msgError);
			throw new IntegracionSICSAException(codError,numEvento,msgError);
		}
		
		//Se Valida que la cantidad detalle de pedido por linea sea igual a la informada
		loggerDebug("Se Valida que la cantidad detalle de pedido por linea sea igual a la informada");			
		for(int x = 0; x < cantLineasBD; x++){
			for(int i = 0; i < cantLineasXML; i++){
				loggerDebug("pedidoLineaDTOs[x].getLinPedido(): "+pedidoLineaDTOs[x].getLinPedido());
				loggerDebug("pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido(): "+pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido());
				if(pedidoLineaDTOs[x].getLinPedido() == pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido()){
					if(pedidoLineaDTOs[x].getCodArticulo() == pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getCodArticulo()){
						if(!(pedidoLineaDTOs[x].getCanDetallePedido() == pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getCanDetallePedido())){
							loggerDebug("Linea ["+pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido()+"] no contiene" +
										" la misma cantidad de articulos registrados en base de datos");
							codError = "ERR.0008";
							numEvento = -1;
							String numLinea = String.valueOf(pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido());
							String canXML = String.valueOf(pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getCanDetallePedido());
							String canBD = String.valueOf(pedidoLineaDTOs[x].getCanDetallePedido());								
							msgError = global.getValor("ERR.0008").replace("[nl]",numLinea).replace("[nXML]", canXML).replace("[nBD]", canBD);	
							loggerDebug(msgError);	
							throw new IntegracionSICSAException(codError,numEvento,msgError);	
						}	
						else{
							loggerDebug("Entro al Break");
							break;
						}
					}else{
						long codArticulo = pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getCodArticulo();
						String desArticulo = pedidoBO.obtieneDescrArtic(codArticulo);
						String numLinea = String.valueOf(pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido());
						codError = "ERR.0009";
						numEvento = -1;
						msgError = global.getValor("ERR.0009").replace("[nl]", numLinea).replace("[nCA]", String.valueOf(codArticulo)).replace("[nDA]", desArticulo);
						loggerDebug(msgError);
						throw new IntegracionSICSAException(codError,numEvento,msgError);							
					}
				}					
			}				
		}
		
		//Valida que la cantidad de serie informada sea igual a la cantidad de series enviadas
		loggerDebug("Valida que la cantidad de serie informada sea igual a la cantidad de series enviadas");
		long cantidad = obtieneCantidadSeriesInformadas(pedidoInDTO);		
		if(!(pedidoInDTO.getPedidoEncabezadoDTO().getTotalPedido().trim().equals(String.valueOf(cantidad)))){
			codError = "ERR.0010";
			numEvento = -1;
			msgError = global.getValor("ERR.0010");
			loggerDebug(msgError);
			throw new IntegracionSICSAException(codError,numEvento,msgError);					
		}
		
		//Valida que la cantidad de Series informadas por linea sea igual a la cantida de series por lineas enviadas
		loggerDebug("Valida que la cantidad de Series informadas por linea sea igual a la cantida de series por lineas enviadas");
		for(int i = 0; i < pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs().length; i++){
			long cantXLinea = obtCantSeriesInformadasXLinea(pedidoInDTO, pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido());				
			if(!(pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getCanDetallePedido() == cantXLinea)){
				codError = "ERR.0011";
				numEvento = -1;
				msgError = "Cantidad de Series informadas en la linea["+pedidoInDTO.getPedidoEncabezadoDTO().getPedidoLineasDTOs()[i].getLinPedido()
						+"] no es igual a la cantidad de series ingresadas";
				throw new IntegracionSICSAException(codError,numEvento,msgError);
			}				
		}		
				
		//Valida si existe Pedido en la tabla NP_VALIDACION_SERIES_TO
		loggerDebug("Valida si existe Pedido en la tabla NP_VALIDACION_SERIES_TO");
		respuesta = pedidoBO.validaExistenciaPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
	 	
		if(respuesta.getStrCodError().trim().equals("1")){//Pedido existe en la tabla NP_VALIDACION_SERIES_TO 
			loggerDebug("Pedido existe en la tabla NP_VALIDACION_SERIES_TO");
			//Valida si Existe alguna serie con error del pedido ingresado en la tabla NP_VALIDACION_SERIES_TO
			loggerDebug("Valida si Existe alguna serie con error del pedido ingresado en la tabla NP_VALIDACION_SERIES_TO");
			respuesta.setIEvento(0);
			respuesta.setStrCodError("0"); 
			respuesta.setStrDesError("OK");
			/*respuesta = pedidoBO.validaSeriePedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());				
			//Si Existe al menos 1 serie con error se borra todas las series del pedido en la tabla NP_VALIDACION_SERIES_TO
			if(respuesta.getStrCodError().trim().equals("1")){*/
				//Serie con error
				respuesta.setIEvento(0);
				respuesta.setStrCodError("0");
				respuesta.setStrDesError("OK");
				loggerDebug("Si Existe al menos 1 serie con error se borra todas las series del pedido en la tabla NP_VALIDACION_SERIES_TO");
				respuesta = pedidoBO.borrarSeriePedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				//Se elimina Pedido de la tabla NP_CONTROL_ING_SERIES_TO
				loggerDebug("Elimina Control de Pedido");					
				pedidoBO.borrarControlPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), global.getValor("estadoRegistroError"));
				//Se elimina los errores de la tabla temporal NP_VAL_SERIES_TEMP_TO P-CSR-11017 JLGN
				pedidoBO.borrarSeriePedidoTemp(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());				
			//}				
		}
		
		//Valida que pedido exista en la tabla NP_CONTROL_ING_SERIES_TO
		if (!pedidoBO.validaPedidoControl(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido())){
			//No existe pedido en la tabla NP_CONTROL_ING_SERIES_TO
			//Consulta si pedido se encuentra dado de Baja
			if(pedidoBO.validaBajaPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido())){
				//Pedido esta de Baja
				codError = "ERR.0012";
				numEvento = -1;
				msgError = global.getValor("ERR.0012");
				loggerDebug(msgError);
				throw new IntegracionSICSAException(codError,numEvento,msgError);					
			}else{
				//Inserta registro en la tabla NP_CONTROL_ING_SERIES_TO
				String codPedido = pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido();
				String userWeb = global.getValorExterno("GE.user.web");
				pedidoBO.insertaControlPedido(codPedido, userWeb, cantPedido);					
			}				
		}	
		
		//Valida que pedido no exista en la tabla npt_serie_pedido
		loggerDebug("Valida que pedido no exista en la tabla npt_serie_pedido");
		if(pedidoBO.validaSeriePedidoNPW(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido())){
			//Serie existe en la tabla npt_serie_pedido
			codError = "ERR.0013";
			numEvento = -1;
			msgError = global.getValor("ERR.0013");
			loggerDebug(msgError);
			throw new IntegracionSICSAException(codError,numEvento,msgError);
		}
		
		//Pregunta si existe el pedido en la tabla NP_CONTROL_ING_SERIES_TO con estado pendiente
		loggerDebug("Pregunta si existe el pedido en la tabla NP_CONTROL_ING_SERIES_TO con estado pendiente");
		if(!pedidoBO.validaEstadoControl(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), global.getValor("estadoControlPendiente"))){
			//Serie existe en la tabla npt_serie_pedido
			loggerDebug("Serie existe en la tabla npt_serie_pedido");
			codError = "ERR.0014";
			numEvento = -1;
			msgError = "Pedido: " + pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido() + " está siendo procesado. Intente más tarde.";
			loggerDebug(msgError);
			throw new IntegracionSICSAException(codError,numEvento,msgError);
		}
		
		}catch(IntegracionSICSAException e){
			loggerError("IntegracionSICSAExceptionSRV: " + e);
			e.printStackTrace();
			throw e;
		}
		loggerDebug("validaPedido: Fin");		
	}
	
	/**
     * Metodo que registra las series Informadas por CELISTIC
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	//public SalidaIntegracionSICSADTO registraSeries(PedidoInDTO pedidoInDTO)throws IntegracionSICSAException, Exception{
	public void registraSeries(PedidoInDTO pedidoInDTO)throws IntegracionSICSAException, Exception{
		loggerDebug("registraSeries: Inicio");
		SalidaIntegracionSICSADTO respuesta = new SalidaIntegracionSICSADTO();
		String codError = null;
		int numEvento = -1;
		String msgError = null;
		try{
			
			loggerDebug("Se obtiene Bodega del Pedido");
			long codBodega = pedidoBO.obtieneBodegaPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
			//Se obtiene codigo de la Operadora que se encuentra parametrizado
			loggerDebug("Se obtiene codigo de la Operadora que se encuentra parametrizado");
			String codOperadora = pedidoBO.obtieneParametroNPW(global.getValor("valorCodOperadora"));
			
			//Se obtiene folio
			loggerDebug("Se obtiene folio");
			DatosFolioDTO folioDTO = pedidoBO.obtieneNumFolio(codBodega, codOperadora);
			//Valida si consume es 0 o 2 
			loggerDebug("Valida si consume es 0 o 2");
			if(folioDTO.getConsume() == 0 || folioDTO.getConsume() == 2){
				//Actualiza numero de Guia
				loggerDebug("Actualiza numero de Guia");
				pedidoBO.updateNumGuia(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());				
			}else if(folioDTO.getConsume() == 1){
				//Actualiza numero de Guia
				loggerDebug("Actualiza numero de Guia");
				pedidoBO.updateNumGuia(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), folioDTO.getNumFolio());
			}
			
			respuesta.setIEvento(0);
			respuesta.setStrCodError("0");
			respuesta.setStrDesError("OK");
			
			//Registra Listado de Series
			loggerDebug("Registra Series");
			respuesta = pedidoBO.registraSeries(pedidoInDTO);		
			loggerDebug("Valida Existencia del Pedido");
			respuesta = pedidoBO.validaExistenciaPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
			loggerDebug("Ejecuta PL que Valida las Series Insertadas");			
			//Ejecuta PL que Valida Series Insertadas
			pedidoBO.validaSeriesInsertadas(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());			
			//Valida Si alguna serie del pedido quedo con Error
			loggerDebug("Valida Si alguna serie del pedido quedo con Error");
			respuesta = pedidoBO.validaSeriePedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
			//Si Existe al menos 1 serie con error Se retorna mensaje de error
			if(respuesta.getStrCodError().trim().equals("1")){
				//Existe 1 serie con error
				codError = "ERR.0002";
				numEvento = -1;
				msgError = global.getValor("ERR.0002");
				loggerDebug(msgError);
				throw new IntegracionSICSAException(codError,numEvento,msgError);				
			}else{
				//Series quedaron sin error en la tabla NPT_VALIDACION_SERIES_TO
				//Se obtiene Datos Pedido
				loggerDebug("Series quedaron sin error en la tabla NPT_VALIDACION_SERIES_TO");
				loggerDebug("Se obtiene Datos Pedido");
				DatosPedidoDTO datosPedidoDTO = null;
				datosPedidoDTO = pedidoBO.obtieneDatosPedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				
				//Se obtiene estado de la tabla npt_fun_estado_flujo_esc
				loggerDebug("Se obtiene estado de la tabla ");
				String valIngreSerie = pedidoBO.obtieneParametroNPW(global.getValor("valorIngresiPedidoEsc"));
				loggerDebug("valIngreSerie: "+valIngreSerie);
				String valEstadoFlujo = pedidoBO.obtieneEstadoEscNPW(valIngreSerie);
				datosPedidoDTO.setCodEstadoFlujo(valEstadoFlujo);
				
				//Valida pedido en las tablas npt_detalle_pedido y np_validacion_series_to
				loggerDebug("Valida pedido en las tablas npt_detalle_pedido y np_validacion_series_to");
				if(pedidoBO.valDetalleValidaSeries(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido())){
					//Ocurrio un error en la Validacion
					loggerDebug("Ocurrio un error en la Validacion del pedido en las tablas npt_detalle_pedido y np_validacion_series_to");					
				}				
				
				//Actualiza el Estado del proceso en la tabla NP_CONTROL_ING_SERIES_TO de PENDIENTE a EN PROCESO
				loggerDebug("Actualiza el Estado del proceso en la tabla NP_CONTROL_ING_SERIES_TO de PENDIENTE a EN PROCESO");
				pedidoBO.actualizaControlSeries(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), global.getValor("estadoControlPendiente"),
						global.getValor("estadoControlEnProceso"));

				//Inserta las series ingresadas en la tabla NPT_SERIE_PEDIDO
				loggerDebug("Inserta las series ingresadas en la tabla NPT_SERIE_PEDIDO");
				pedidoBO.insertPedidoSerie(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				 
				//Actualiza el estado del proceso de EN PROCESO a CERRADO
				loggerDebug("Actualiza el estado del proceso de EN PROCESO a CERRADO");
				pedidoBO.actualizaControlSeries(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido(), global.getValor("estadoControlEnProceso"),
						global.getValor("estadoControlCerrado"));
				
				//Elimina pedido de la tabla NPT_VALIDACION_SERIES_TO
				loggerDebug("Elimina pedido de la tabla NPT_VALIDACION_SERIES_TO");
				respuesta.setIEvento(0);
				respuesta.setStrCodError("0");
				respuesta.setStrDesError("OK");
				respuesta = pedidoBO.borrarSeriePedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				
				//Se elimina los errores de la tabla temporal NP_VAL_SERIES_TEMP_TO P-CSR-11017 JLGN
				pedidoBO.borrarSeriePedidoTemp(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				
				//Actualiza estado del Pedidoa a 9
				loggerDebug("Actualiza estado del Pedido a 9");				
				pedidoBO.insertaEstadoPedido(datosPedidoDTO);
			}			
		}catch(IntegracionSICSAException e){
			loggerError("IntegracionSICSAExceptionSRV: " + e);
			e.printStackTrace();
			throw e;
		}
		loggerDebug("registraSeries: Fin");
		//return respuesta;
	}
	
	private long obtieneCantidadSeriesInformadas(PedidoInDTO pedidoInDTO){		
		loggerDebug("obtieneCantidadSeriesInformadas:Inicio");
		long cantidad = 0;
		loggerDebug("pedidoInDTO.getSeriePedidoDTOs().length: " + pedidoInDTO.getSeriePedidoDTOs().length);
		for(int i = 0; i < pedidoInDTO.getSeriePedidoDTOs().length; i++){
			cantidad = cantidad + 1;
		}	
		loggerDebug("Cantidad de Series Informadas es: "+ cantidad);		
		loggerDebug("obtieneCantidadSeriesInformadas:Fin");
		return cantidad;
	}
	
	private long obtCantSeriesInformadasXLinea(PedidoInDTO pedidoInDTO, int linPedido){
		loggerDebug("obtCantSeriesInformadasXLinea:Inicio");
		long cantidad = 0;		
		for(int i = 0; i < pedidoInDTO.getSeriePedidoDTOs().length; i++){
			if(pedidoInDTO.getSeriePedidoDTOs()[i].getLinPedido().trim().equals(String.valueOf(linPedido))){
				cantidad = cantidad + 1;
			}
		}	
		loggerDebug("Cantidad de Series Informadas Para la Linea ["+linPedido+"] es: "+ cantidad);
		loggerDebug("obtCantSeriesInformadasXLinea:Fin");
		return cantidad;
	}
	
	public SerieErrorDTO[] obtieneSeriesErroneas(String codPedido)throws IntegracionSICSAException, Exception{
		loggerDebug("obtieneSeriesErroneas");
		SerieErrorDTO[] resultado = null;
		resultado = pedidoBO.obtieneSeriesErroneas(codPedido);
		loggerDebug("obtieneSeriesErroneas");
		return resultado;
	}
	
	public SalidaConsultaPedidoDTO obtieneEstadoPedido(String codPedido)throws IntegracionSICSAException{
		loggerDebug("obtieneEstadoPedido: Inicio");
		SalidaConsultaPedidoDTO respuesta = pedidoBO.obtieneEstadoPedido(codPedido);
		loggerDebug("obtieneEstadoPedido: Fin");
		return respuesta;
	}
	
	/**
	 * Hugo Olivares
	 * @param codUsuario
	 * @param codPedido
	 * @param fecDesde
	 * @param fecHasta
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public ConsultaPedidoUsuarioDTO[] consultarPedidosUsuario(String codUsuario, String codPedido, String fecDesde, String fecHasta)throws IntegracionSICSAException{
		loggerDebug("consultarPedidosUsuario: Inicio");
		ConsultaPedidoUsuarioDTO[] respuesta = pedidoBO.consultarPedidosUsuario(codUsuario,codPedido,fecDesde,fecHasta);
		loggerDebug("consultarPedidosUsuario: Fin");
		return respuesta;
	}
	
	/**
	 * Hugo Olivares
	 * @param codPedido
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarDetallePedidosUsuario(String codPedido, HashMap detalles)throws IntegracionSICSAException{
        loggerDebug("consultarDetallePedidosUsuario: inicio");
        HashMap respuesta = pedidoBO.consultarDetallePedidosUsuario(codPedido, detalles);
		loggerDebug("consultarDetallePedidosUsuario: Fin");
		return respuesta;
	}
	
	/**
	 * Hugo Olivares
	 * @param codPedido
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarSeriePedidosUsuario(String codPedido,String linProceso, HashMap series)throws IntegracionSICSAException{
        loggerDebug("consultarSeriePedidosUsuario: inicio");
        HashMap respuesta = pedidoBO.consultarSeriePedidosUsuario(codPedido, linProceso, series);
		loggerDebug("consultarSeriePedidosUsuario: Fin");
		return respuesta;
	}
	
	/**
     * Metodo que Inserta las series con error del pedido en la tabla NP_VAL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void InsertaSeriePedidoTemp(String codPedido)throws IntegracionSICSAException{
		loggerDebug("InsertaSeriePedidoTemp: Inicio");
		pedidoBO.InsertaSeriePedidoTemp(codPedido);
		loggerDebug("InsertaSeriePedidoTemp: Fin");
	}
	
	public void borrarSeriePedido(String codPedido)throws IntegracionSICSAException{
		loggerDebug("borrarSeriePedido: Inicio");
		SalidaIntegracionSICSADTO respuesta = pedidoBO.borrarSeriePedido(codPedido);
		loggerDebug("borrarSeriePedido: Fin");
	}
	
	/**
	 * Metodo que limpia un pedido
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void limpiarPedido(String codPedido)
			throws IntegracionSICSAException {
		loggerDebug("limpiarPedido: inicio");
		pedidoBO.limpiarPedido(codPedido);
		loggerDebug("limpiarPedido: fin");
	}

	
}
