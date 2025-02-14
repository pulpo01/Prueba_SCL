package com.tmmas.cl.scl.integracionsicsa.srv;

import com.tmmas.cl.scl.integracionsicsa.bo.PedidoBO;
import com.tmmas.cl.scl.integracionsicsa.bo.TraspasoBO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.LineaErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.StockTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;

public class TraspasoSRV extends IntegracionSICSASRV {
	TraspasoBO traspasoBO = new TraspasoBO();
	PedidoBO pedidoBO = new PedidoBO();
	private GlobalProperties global = GlobalProperties.getInstance();
	
	/**
     * Metodo que registra las series Informadas por CELISTIC
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void traspasoSeries(EntradaTraspasoDTO traspasoDTO)throws IntegracionSICSAException, Exception{
		loggerDebug("traspasoSeries: Inicio");
		String codError = null;
		int numEvento = -1;
		String msgError = null;
		StockTraspasoDTO[] stockTraspasoDTOs = null;
		String codBodegaOrigen = null;
		try{
			actualizaEstadoTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.estadoProcesando"), "");
			traspasoBO.validaEstadoTraspaso(traspasoDTO.getNumTraspaso(),  global.getValor("AL.estadoPendienteAutorizado"));
	        //Se Valida Total de Series informadas sea igual a la cantidad total Registrada en el traspaso
			String cantTotal = traspasoBO.obtCantTotalTraspaso(traspasoDTO.getNumTraspaso());
			if(!cantTotal.equals(String.valueOf(traspasoDTO.getSerieTraspasoDTOs().length))){
				codError = "ERR.0019";
				numEvento = -1;
				msgError = global.getValor("ERR.0019").replace("[nP]", traspasoDTO.getNumTraspaso());
				actualizaEstadoTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.estadoError"), msgError);
				throw new IntegracionSICSAException(codError,numEvento,msgError);				
			}
			
			//Se Borra la tabla Temporal AL_SERIES_TEMP_TO segun el numero de Traspaso
			loggerDebug("Se Borra la tabla Temporal AL_SERIES_TEMP_TO segun el numero de Traspaso");
			String codInvocador = global.getValor("AL.Invocador");
			String codModulo = global.getValor("AL.codModulo");
			traspasoBO.eliminaSeriesTraspasoTemporal(traspasoDTO.getNumTraspaso(), codModulo);
			
			//Inserta Las Series en la tabla Temporal AL_SERIES_TEMP_TO
			loggerDebug("Inserta Las Series en la tabla Temporal AL_SERIES_TEMP_TO");
			traspasoBO.registraSeriesTemporal(traspasoDTO, codModulo, codInvocador);			
			
			//Valida las series insertadas en la tabla AL_SERIES_TEMP_TO
			loggerDebug("Valida las series insertadas en la tabla AL_SERIES_TEMP_TO");
			traspasoBO.validaSeriesTempTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.codEstadoNuevo"), global.getValor("Al.stockMercaderia"));
			
			//Se consulta si las series validadas se encuentran con error
			loggerDebug("Se consulta si las series validadas se encuentran con error");
			if(traspasoBO.consultaErrorSerieTemp(traspasoDTO.getNumTraspaso(), codInvocador, codModulo)){
				loggerDebug("Series estan con error");
				codError = "ERR.0020";
				numEvento = -1;
				msgError = global.getValor("ERR.0020");
				actualizaEstadoTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.estadoError"), msgError);
				throw new IntegracionSICSAException(codError,numEvento,msgError);	
			}
			
			//Despues de Validadas las Series se Borra la tabla Temporal AL_SERIES_TEMP_TO segun el numero de Traspaso
			loggerDebug("Despues de Validadas las Series se Borra la tabla Temporal AL_SERIES_TEMP_TO segun el numero de Traspaso");
			traspasoBO.eliminaSeriesTraspasoTemporal(traspasoDTO.getNumTraspaso(), codModulo);
			
			//Desde aca se esta simulando la Accion que realiza el Boton Autorizar en VB
			//Se Obtiene el stock del traspaso por linea
			loggerDebug("Se Obtiene el stock del traspaso por linea");
			stockTraspasoDTOs = traspasoBO.obtStockTraspaso(traspasoDTO.getNumTraspaso());
			
			//Se obtiene el codBodegaOrigen
			loggerDebug("Se obtiene el codBodegaOrigen");
			codBodegaOrigen = traspasoBO.obtBodegaOrigenTraspaso(traspasoDTO.getNumTraspaso());			
			
			//Se obtiene Estados de No Traspaso
			String noTraspaso = traspasoBO.obtParametro(global.getValor("AL.estNoTraspaso"), global.getValor("AL.codModulo"));
			
			//Se valida si stock es suficiente para las lineas ingresadas
			loggerDebug("Se valida si stock es suficiente para las lineas ingresadas");
			for(int i=0; i < stockTraspasoDTOs.length;i++){
				long cantStock = traspasoBO.obtCantidadStock(codBodegaOrigen, stockTraspasoDTOs[i].getCodArticulo(), 
						global.getValor("AL.indDisponibilidad"), stockTraspasoDTOs[i].getCodUso(), noTraspaso);
				
				if(Long.parseLong(stockTraspasoDTOs[i].getCantTraspaso()) > cantStock){
					String desArticulo = pedidoBO.obtieneDescrArtic(Long.parseLong(stockTraspasoDTOs[i].getCodArticulo()));
					codError = "ERR.0024";
					numEvento = -1;
					msgError = global.getValor("ERR.0024").replace("[tCA]", stockTraspasoDTOs[i].getCodArticulo()).replace("[tDA]", desArticulo);
					actualizaEstadoTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.estadoError"), msgError);
					throw new IntegracionSICSAException(codError,numEvento,msgError);					
				}
			}	
			//hay Stock suficiente para todas las lineas de ese traspaso
			loggerDebug("hay Stock suficiente para todas las lineas de ese traspaso");
			
			//se valida Si las series ya no existen o han sido modificadas
			loggerDebug("Valida Si las series ya no existen o han sido modificadas");
			if(!traspasoBO.validaTraspaso(traspasoDTO.getNumTraspaso())){
				loggerDebug("Valida Si las series ya no existen o han sido modificadas");
				throw new IntegracionSICSAException(codError,numEvento,msgError);					
			}
			
			//Se obtiene el numero de Peticion del Traspaso
			loggerDebug("Se obtiene el numero de Peticion del Traspaso");
			String numPeticion = String.valueOf(traspasoBO.obtNumPeticionTraspaso(traspasoDTO.getNumTraspaso()));
			
			//Se actualiza la tabla AL_CAB_PETICION de estado AP a AU
			loggerDebug("Se actualiza la tabla AL_CAB_PETICION de estado AP a AU");
			traspasoBO.updEstadoPeticion(global.getValor("AL.estadoAutorizado"), numPeticion);
			
			//Se actualiza la tabla AL_TRASPASOS de estado AP a AU
			loggerDebug("Se actualiza la tabla AL_TRASPASOS de estado AP a AU");
			traspasoBO.updateEstadoTraspaso(global.getValor("AL.estadoAutorizado"), traspasoDTO.getNumTraspaso());
			
			//Se obtiene tipo movimiento de envio
			loggerDebug("Se obtiene tipo movimiento de envio");
			String tipMovEnv = traspasoBO.obtTipoMovimiento(global.getValor("AL.envioTraspaso"));
			
			//Actualiza traspaso y lo deja con estado EN
			loggerDebug("Actualiza traspaso y lo deja con estado EN");
			traspasoBO.updateTraspaso(global.getValor("AL_estadoEnviado"), tipMovEnv, traspasoDTO.getNumTraspaso());
			
			//Se obtiene Guia de Remision y Se actualiza la tabla AL_TRASPASOS
			loggerDebug("Se obtiene Guia de Remision y Se actualiza la tabla AL_TRASPASOS");
			String codOperadora = traspasoBO.obtieneOperadora();
			traspasoBO.updGuiaTraspaso(codBodegaOrigen, codOperadora, traspasoDTO.getNumTraspaso());
			
			//Se actualiza el estado del traspaso en la tabla AL_ESTADO_TRASPASO_TO
			actualizaEstadoTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.estadoFinalizado"), "");
			
		}catch(IntegracionSICSAException e){
			loggerError("IntegracionSICSAExceptionSRV: " + e);
			actualizaEstadoTraspaso(traspasoDTO.getNumTraspaso(), global.getValor("AL.estadoError"), e.getDescripcionEvento());
			throw e;
		}		
		loggerDebug("traspasoSeries: Fin");
	}
	
	/**
     * Funcion que obtiene las series con error de la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SerieErrorDTO[] obtieneErrorSerieTemp(String numTraspaso)throws IntegracionSICSAException, Exception{
		loggerDebug("obtieneSeriesErroneas");
		SerieErrorDTO[] resultado = null;
		String codInvocador = global.getValor("AL.Invocador");
		String codModulo = global.getValor("AL.codModulo");
		resultado = traspasoBO.obtieneErrorSerieTemp(numTraspaso, codInvocador, codModulo);
		loggerDebug("obtieneSeriesErroneas");
		return resultado;
	}
	
	/**
     * Funcion que valida estado del Numero de traspaso
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void validaTraspaso(EntradaTraspasoDTO traspasoDTO, String codEstado)throws IntegracionSICSAException{
        loggerDebug("validaTraspaso: inicio");
        String codError = null;
		int numEvento = -1;
		String msgError = null;
        
        traspasoBO.validaEstadoTraspaso(traspasoDTO.getNumTraspaso(), codEstado);
        //Se Valida Total de Series informadas sea igual a la cantidad total Registrada en el traspaso
		String cantTotal = traspasoBO.obtCantTotalTraspaso(traspasoDTO.getNumTraspaso());
		if(!cantTotal.equals(String.valueOf(traspasoDTO.getSerieTraspasoDTOs().length))){
			codError = "ERR.0019";
			numEvento = -1;
			msgError = global.getValor("ERR.0019").replace("[nP]", traspasoDTO.getNumTraspaso());
			throw new IntegracionSICSAException(codError,numEvento,msgError);				
		}
        loggerDebug("validaTraspaso: fin");
	}	
	
	/**
     * Funcion que Inserta en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void insertaEstadoTraspaso(String numTraspaso, String estadoTraspaso)throws IntegracionSICSAException{
		loggerDebug("insertaEstadoTraspaso: inicio");
		traspasoBO.insertaEstadoTraspaso(numTraspaso, estadoTraspaso);
		loggerDebug("insertaEstadoTraspaso: fin");
	}
	
	/**
     * Funcion que Actualiza en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void actualizaEstadoTraspaso(String numTraspaso, String estadoTraspaso, String mensError)throws IntegracionSICSAException{
        loggerDebug("actualizaEstadoTraspaso: inicio");
        traspasoBO.actualizaEstadoTraspaso(numTraspaso, estadoTraspaso, mensError);
        loggerDebug("actualizaEstadoTraspaso: fin");
	}
	
	/**
     * Funcion que Actualiza en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaConsultaTraspasoDTO consultaEstadoTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("consultaEstadoTraspaso: inicio");
        SalidaConsultaTraspasoDTO resultado = null;
        resultado = traspasoBO.consultaEstadoTraspaso(numTraspaso);
        loggerDebug("consultaEstadoTraspaso: fin");
        return resultado;
	}
	
	/**
     * Funcion que obtiene lista de errores de las lineas que se encuentran en la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public LineaErrorDTO[] obtieneErrorLineaTemp(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtieneErrorLineaTemp: inicio");
        LineaErrorDTO[] resultado = null;
        String codInvocador = global.getValor("AL.Invocador");
		String codModulo = global.getValor("AL.codModulo");
        resultado = traspasoBO.obtieneErrorLineaTemp(numTraspaso, codInvocador, codModulo);        
        loggerDebug("obtieneErrorLineaTemp: fin");
        return resultado;
    }
	
	/**
     * Funcion que elimina las series insertadas en la tabla temporal AL_SER_TRASPASO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void elimiSerTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("elimiSerTraspaso: inicio");
        traspasoBO.elimiSerTraspaso(numTraspaso);
        loggerDebug("elimiSerTraspaso: fin");
	}  
	
	/**
     * Funcion que elimina las lineas insertadas en la tabla temporal AL_LIN_TRASPASO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void elimiLineaTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("elimiLineaTraspaso: inicio");
        traspasoBO.elimiLineaTraspaso(numTraspaso);
        loggerDebug("elimiLineaTraspaso: fin");
	} 
}