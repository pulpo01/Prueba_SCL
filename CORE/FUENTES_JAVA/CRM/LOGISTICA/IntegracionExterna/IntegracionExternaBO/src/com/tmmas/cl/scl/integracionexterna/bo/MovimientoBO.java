package com.tmmas.cl.scl.integracionexterna.bo;

import com.tmmas.cl.scl.integracionexterna.common.dto.TraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.dao.MovimientoDAO;

public class MovimientoBO extends IntegracionExternaBO{
	MovimientoDAO movimientoDAO = new MovimientoDAO();
	
	/**
     * Funcion que inserta al_movimiento de las series informadas
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public void insertaAlMovmiento(TraspasoMasivoDTO masivoDTO)throws IntegracionExternaException{
        loggerDebug("insertaAlMovmiento: inicio");
        movimientoDAO.insertaAlMovmiento(masivoDTO);
        loggerDebug("insertaAlMovmiento: fin");
	}
	
	/**
     * Funcion que Obtiene el numero de secuencia del parametro ingresado
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public SalidaConsultaTraspasoDTO obtSeriesErrorMov(String numSecuencia, String codModulo, String codProceso, String numLinea)throws IntegracionExternaException{
        loggerDebug("obtSeriesErrorMov: inicio");
        SalidaConsultaTraspasoDTO resultado = movimientoDAO.obtSeriesErrorMov(numSecuencia, codModulo, codProceso, numLinea);
        loggerDebug("obtSeriesErrorMov: fin");
        return resultado;
	}
	
	/**
     * Funcion que elimina series con error de tabla temporal
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public void eliminaTempoErrorMov(String numSecuencia, String codModulo, String codProceso, String numLinea)throws IntegracionExternaException{
        loggerDebug("eliminaTempoErrorMov: inicio");
        movimientoDAO.eliminaTempoErrorMov(numSecuencia, codModulo, codProceso, numLinea);
        loggerDebug("eliminaTempoErrorMov: fin");
	}

}
