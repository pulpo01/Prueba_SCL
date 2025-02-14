package com.tmmas.cl.scl.integracionexterna.srv;

import com.tmmas.cl.scl.integracionexterna.bo.MovimientoBO;
import com.tmmas.cl.scl.integracionexterna.bo.TraspasoMasivoBO;
import com.tmmas.cl.scl.integracionexterna.common.dto.TraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.TraspasoMasivoInDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;

public class MovimientoSRV extends IntegracionExternaSRV {
	MovimientoBO movimientoBO = new MovimientoBO();
	TraspasoMasivoBO traspasoMasivoBO = new TraspasoMasivoBO();
	
	/**
     * Funcion que inserta al_movimiento de las series informadas
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public void insertaAlMovmiento(TraspasoMasivoInDTO masivoDTO)throws IntegracionExternaException{
        loggerDebug("insertaAlMovmiento: inicio");
        TraspasoMasivoDTO traspasoMasivoDTO = new TraspasoMasivoDTO();        
        traspasoMasivoDTO.setMasivoInDTO(masivoDTO);
        movimientoBO.insertaAlMovmiento(traspasoMasivoDTO);
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
        SalidaConsultaTraspasoDTO resultado = movimientoBO.obtSeriesErrorMov(numSecuencia, codModulo, codProceso, numLinea);
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
        movimientoBO.eliminaTempoErrorMov(numSecuencia, codModulo, codProceso, numLinea);
        loggerDebug("eliminaTempoErrorMov: fin");
	}

}
