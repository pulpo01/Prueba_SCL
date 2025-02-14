package com.tmmas.cl.scl.integracionsicsa.bo;

import com.tmmas.cl.scl.integracionsicsa.common.dto.LineaErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.StockTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.dao.TraspasoDAO;

public class TraspasoBO extends IntegracionSICSABO {
	TraspasoDAO traspasoDAO = new TraspasoDAO();
	
	/**
     * Funcion que Obtiene la cantidad total de series del traspaso informado
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtCantTotalTraspaso(String numTraspaso)throws IntegracionSICSAException{
		loggerDebug("obtCantTotalTraspaso: inicio");
        String resultado = traspasoDAO.obtCantTotalTraspaso(numTraspaso);
        loggerDebug("obtCantTotalTraspaso: fin");
        return resultado;		
	}
	
	/**
     * Funcion que elimina los datos de la tabla temporal
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void eliminaSeriesTraspasoTemporal(String numTraspaso, String codModulo)throws IntegracionSICSAException{
        loggerDebug("eliminaSeriesTraspasoTemporal: inicio");
        traspasoDAO.eliminaSeriesTraspasoTemporal(numTraspaso, codModulo);
        loggerDebug("eliminaSeriesTraspasoTemporal: fin");
	}
	
	/**
     * Metodo que registra las series Informadas por CELISTIC
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */	
	public void registraSeriesTemporal(EntradaTraspasoDTO traspasoDTO, String codModulo, String codInvocador)throws IntegracionSICSAException, Exception{
		loggerDebug("registraSeriesTemporal(): Inicio");
		traspasoDAO.registraSeriesTemporal(traspasoDTO, codModulo, codInvocador);
		loggerDebug("registraSeriesTemporal(): fin");
	}
	
	/**
     * Funcion que Actualiza la Tabla AL_CAB_PETICION 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updEstadoPeticion(String codEstado, String numPeticion)throws IntegracionSICSAException{
        loggerDebug("updEstadoPeticion: Inicio");
        traspasoDAO.updEstadoPeticion(codEstado, numPeticion);
        loggerDebug("updEstadoPeticion: Fin");
	}
	
	/**
     * Funcion que Obtiene el tipMovimiento del proceso ingresado
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtTipoMovimiento(String codProceso)throws IntegracionSICSAException{
        loggerDebug("obtTipoMovimiento: inicio");
        String resultado = traspasoDAO.obtTipoMovimiento(codProceso);
        loggerDebug("obtTipoMovimiento: Fin");
        return resultado;
	}
	
	/**
     * Funcion que actualiza la tabla AL_TRASPASOS
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updateTraspaso(String codEstado, String tipMovEnv, String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("updateTraspaso: inicio");
        traspasoDAO.updateTraspaso(codEstado, tipMovEnv, numTraspaso);
        loggerDebug("updateTraspaso: fin");
	}
	
	/**
     * Funcion que Obtiene la codega origen del traspaso
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtBodegaOrigenTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtBodegaOrigenTraspaso: inicio");
        String resultado = traspasoDAO.obtBodegaOrigenTraspaso(numTraspaso);
        loggerDebug("obtBodegaOrigenTraspaso: Fin");
        return resultado;
	}
	
	/**
     * Funcion que actualiza el codigo de estado del traspaso en la 
     * tabla AL_TRASPASOS
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updateEstadoTraspaso(String codEstado, String numTraspaso)throws IntegracionSICSAException{
		loggerDebug("updateEstadoTraspaso: inicio");
        traspasoDAO.updateEstadoTraspaso(codEstado,numTraspaso);
        loggerDebug("updateEstadoTraspaso: fin");
	}
	
	/**
     * Funcion que Obtiene el codigo de la operadora 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtieneOperadora()throws IntegracionSICSAException{
        loggerDebug("obtieneOperadora: inicio");
        String resultado = traspasoDAO.obtieneOperadora();
        loggerDebug("obtieneOperadora: Fin");
        return resultado;
	}
	
	/**
     * Funcion que Obtiene numero de guia de remision y actualiza la tabla AL_TRASPASOS
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void updGuiaTraspaso(String codBodega, String codOperadora, String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("updGuiaTraspaso: inicio");
        traspasoDAO.updGuiaTraspaso(codBodega, codOperadora, numTraspaso);
        loggerDebug("updGuiaTraspaso: fin");
	}
	
	/**
     * Funcion que valida las series insertadas en la tabla temporal AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void validaSeriesTempTraspaso(String numTraspaso, String codEstado, String tipStock)throws IntegracionSICSAException{
		loggerDebug("validaSeriesTempTraspaso: inicio");
		traspasoDAO.validaSeriesTempTraspaso(numTraspaso, codEstado, tipStock);
		loggerDebug("validaSeriesTempTraspaso: Fin");
	}
	
	/**
     * Funcion que consulta las series con error de la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean consultaErrorSerieTemp(String numTraspaso, String codInvocador, String codModulo)throws IntegracionSICSAException{
        loggerDebug("consultaErrorSerieTemp: inicio");
        boolean resultado = traspasoDAO.consultaErrorSerieTemp(numTraspaso, codInvocador, codModulo);
        loggerDebug("consultaErrorSerieTemp: fin");
        return resultado;
	}
	
	/**
     * Funcion que obtiene lista de errores de las series que se encuentran en la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SerieErrorDTO[] obtieneErrorSerieTemp(String numTraspaso, String codInvocador, String codModulo)throws IntegracionSICSAException{
        loggerDebug("obtieneErrorSerieTemp: inicio");
        SerieErrorDTO[] resultado = null;
        resultado = traspasoDAO.obtieneErrorSerieTemp(numTraspaso, codInvocador, codModulo);
        loggerDebug("obtieneErrorSerieTemp: fin");
        return resultado;
	}	
	
	/**
     * Funcion que Obtiene los stock del traspaso por linea
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public StockTraspasoDTO[] obtStockTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtStockTraspaso: inicio");
        StockTraspasoDTO[] resultado = traspasoDAO.obtStockTraspaso(numTraspaso);
        loggerDebug("obtStockTraspaso: Fin");
        return resultado;
	}
	
	/**
     * Funcion que Obtiene cantidad de Stock 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public long obtCantidadStock(String codBodega, String codArticulo, String indDisponi, String codUso, String codEstado)throws IntegracionSICSAException{
        loggerDebug("obtCantidadStock: inicio");
        long resultado = traspasoDAO.obtCantidadStock(codBodega, codArticulo, indDisponi, codUso, codEstado);
        loggerDebug("obtCantidadStock: fin");
        return resultado;
	}
	
	/**
     * Funcion que valida estado del Numero de traspaso
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void validaEstadoTraspaso(String numTraspaso, String codEstado)throws IntegracionSICSAException{
        loggerDebug("validaEstadoTraspaso: inicio");
        traspasoDAO.validaEstadoTraspaso(numTraspaso, codEstado);
        loggerDebug("validaEstadoTraspaso: fin");
	}
	
	/**
     * Funcion que Obtiene el número de petición del traspaso 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public long obtNumPeticionTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("obtNumPeticionTraspaso: inicio");
        long respuesta = traspasoDAO.obtNumPeticionTraspaso(numTraspaso);
        loggerDebug("obtNumPeticionTraspaso: inicio");
        return respuesta;
	}
	
	/**
     * Funcion que Obtiene parametro de la tabla GED_PARAMETROS 
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public String obtParametro(String nomParametro, String codModulo)throws IntegracionSICSAException{
        loggerDebug("obtParametro: inicio");
        String respuesta = traspasoDAO.obtParametro(nomParametro, codModulo);
        loggerDebug("obtParametro: fin");
        return respuesta;
	}
	
	/**
     * Funcion que Valida Si las series ya no existen o han sido modificadas
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public boolean validaTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("validaTraspaso: inicio");
        boolean resultado = traspasoDAO.validaTraspaso(numTraspaso);
        loggerDebug("validaTraspaso: fin");
        return resultado;
	}
	
	/**
     * Funcion que Inserta en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public void insertaEstadoTraspaso(String numTraspaso, String estadoTraspaso)throws IntegracionSICSAException{
		loggerDebug("insertaEstadoTraspaso: inicio");
		traspasoDAO.insertaEstadoTraspaso(numTraspaso, estadoTraspaso);
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
        traspasoDAO.actualizaEstadoTraspaso(numTraspaso, estadoTraspaso, mensError);
        loggerDebug("actualizaEstadoTraspaso: fin");
	}
	
	/**
     * Funcion que consulta estado del traspaso en la tabla AL_ESTADO_TRASPASO_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public SalidaConsultaTraspasoDTO consultaEstadoTraspaso(String numTraspaso)throws IntegracionSICSAException{
        loggerDebug("consultaEstadoTraspaso: inicio");
        SalidaConsultaTraspasoDTO resultado = null;
        resultado = traspasoDAO.consultaEstadoTraspaso(numTraspaso);
        loggerDebug("consultaEstadoTraspaso: fin");
        return resultado;
	}
	
	/**
     * Funcion que obtiene lista de errores de las lineas que se encuentran en la tabla AL_SERIES_TEMP_TO
     * 
     * @author Jorge González
     * @throws IntegracionSICSAException
     */
	public LineaErrorDTO[] obtieneErrorLineaTemp(String numTraspaso, String codInvocador, String codModulo)throws IntegracionSICSAException{
        loggerDebug("obtieneErrorLineaTemp: inicio");
        LineaErrorDTO[] resultado = null;
        /*Obtiene Error de la Linea*/
        resultado = traspasoDAO.obtieneErrorLineaTemp(numTraspaso, codInvocador, codModulo);
        /*Se obtiene la cantidad solicitada por articulo*/
        resultado = traspasoDAO.obtieneCantidadTraspasoArticulo(numTraspaso, resultado);
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
        traspasoDAO.elimiSerTraspaso(numTraspaso);
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
        traspasoDAO.elimiLineaTraspaso(numTraspaso);
        loggerDebug("elimiLineaTraspaso: fin");
	} 
}
