package com.tmmas.cl.scl.integracionsicsa.bo;

import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.dao.SerieDAO;


public class SerieBO extends IntegracionSICSABO {

    private SerieDAO   serieDAO = new SerieDAO();

    /*
     * -------------------------------------------------------------------------
     * INICIO BLOQUE METODOS HOM
     * -------------------------------------------------------------------------
     */
    /**
     * Metodo que registra una serie vendida por CELTICS
     * 
     * @author Hugo Olivares
     * @throws IntegracionSICSAException
     */
    public void registrarSerieVendidaTercero(SerieDTO[] entrada, int numOperacion) throws IntegracionSICSAException {

        loggerDebug("registrarSerieVendidaTercero: inicio");
        serieDAO.registrarSerieVendidaTercero(entrada, numOperacion);
        loggerDebug("registrarSerieVendidaTercero");
    }
    
	/**
	 * Metodo que devuelve las series vendidas por CELTICS
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void devolverSeries(SerieDTO[] entrada) throws IntegracionSICSAException {

		loggerDebug("devolverSeries: inicio");
		serieDAO.devolverSeries(entrada);
		loggerDebug("devolverSeries: fin");
	}

    /*
     * -------------------------------------------------------------------------
     * FIN BLOQUE METODOS HOM
     * -------------------------------------------------------------------------
     */

}
