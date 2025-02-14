package com.tmmas.cl.scl.integracionexterna.bo;

import com.tmmas.cl.scl.integracionexterna.common.dto.TraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.dao.TraspasoMasivoDAO;

public class TraspasoMasivoBO extends IntegracionExternaBO{
	TraspasoMasivoDAO traspasoMasivoDAO = new TraspasoMasivoDAO();
	
	/**
     * Funcion que Obtiene el numero de secuencia del parametro ingresado
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public String obtNumSecuencia(String nomSecuencia)throws IntegracionExternaException{
        loggerDebug("obtNumSecuencia: inicio");
        String resultado = traspasoMasivoDAO.obtNumSecuencia(nomSecuencia);
        loggerDebug("obtNumSecuencia: fin");
        return resultado;
	}
	
	/**
     * Funcion que Obtiene los datos de las series ingresadas
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public TraspasoMasivoDTO obtDatosSeries(TraspasoMasivoDTO masivoDTO)throws IntegracionExternaException{
        loggerDebug("obtDatosSeries: inicio");
        TraspasoMasivoDTO traspasoMasivoDTO = traspasoMasivoDAO.obtDatosSeries(masivoDTO);
        loggerDebug("obtDatosSeries: fin");	
        return traspasoMasivoDTO;
	}
	
	/**
     * Metodo que registra las series del Traspaso Masivo
     * 
     * @author Jorge González
	 * @throws IntegracionExternaException 
     * @throws IntegracionExternaException
     */	
	public void registraTraspasoMasivo(TraspasoMasivoDTO masivoDTO, String nomUsuario) throws IntegracionExternaException, Exception{
		loggerDebug("registraTraspasoMasivo: inicio");
		traspasoMasivoDAO.registraTraspasoMasivo(masivoDTO, nomUsuario);
		loggerDebug("registraTraspasoMasivo: fin");		
	}
	
	/**
     * Metodo que ejecuta PLSQL de valdiacion de traspaso masivo
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void validaTraspasoMasivo(String nomTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("validaTraspasoMasivo: inicio");
		traspasoMasivoDAO.validaTraspasoMasivo(nomTraspasoMasivo);
		loggerDebug("validaTraspasoMasivo: fin");
	}
	
	/**
     * Metodo que consulta las series que se encuentran con error
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean consultaSeriesError(String numTraspasoMasivo, String tipConsulta) throws IntegracionExternaException{
		loggerDebug("consultaSeriesError: inicio");
		boolean resultado = traspasoMasivoDAO.consultaSeriesError(numTraspasoMasivo, tipConsulta);
		loggerDebug("consultaSeriesError: fin");
		return resultado;
	}
	
	/**
     * Metodo que realiza tratamiento masivo del traspaso
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void tratamientoTraspasoMasivo(String numTraspasoMasivo, String obsTraspaso) throws IntegracionExternaException{
		loggerDebug("tratamientoTraspasoMasivo: inicio");
		traspasoMasivoDAO.tratamientoTraspasoMasivo(numTraspasoMasivo, obsTraspaso);
		loggerDebug("tratamientoTraspasoMasivo: fin");
	}
	
	/**
     * Metodo que realiza copia en la tabla AL_HTRASPASOS_MASIVO
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void traspasoHistoricoMasivo(String numTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("traspasoHistoricoMasivo: inicio");
		traspasoMasivoDAO.traspasoHistoricoMasivo(numTraspasoMasivo);
		loggerDebug("traspasoHistoricoMasivo: fin");
	}
	
	/**
     * Metodo que consulta parametros
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public String consultaParametros(String nomParametro, String codModulo, String codProducto) throws IntegracionExternaException{
		loggerDebug("consultaParametros: inicio");
		String resultado = traspasoMasivoDAO.consultaParametros(nomParametro, codModulo, codProducto);
		loggerDebug("consultaParametros: fin");
		return resultado;
	}
	
	/**
     * Metodo que registra traspaso masivo operador logisitico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void insertaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException{
		loggerDebug("insertaTraspasoOP: inicio");
		traspasoMasivoDAO.insertaTraspasoOP(numTraspaso, numSecuencia, codEstado);
		loggerDebug("insertaTraspasoOP: fin");
	}
	
	/**
     * Metodo que actualiza estado traspaso masivo operador logisitico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void actualizaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException{
		loggerDebug("actualizaTraspasoOP: inicio");
		traspasoMasivoDAO.actualizaTraspasoOP(numTraspaso, numSecuencia, codEstado);
		loggerDebug("actualizaTraspasoOP: fin");
	}
	
	/**
     * Metodo que valida el numero de secuencia del operador logistico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean validaTraspOP(String numSecuencia) throws IntegracionExternaException{
		loggerDebug("validaTraspOP: inicio");
		boolean resultado = traspasoMasivoDAO.validaTraspOP(numSecuencia);
		loggerDebug("validaTraspOP: fin");
		return resultado;
	}
	
	/**
     * Metodo que consulta estado del traspaso masivo
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public SalidaConsultaTraspasoDTO consultaEstadoTraspOP(String numSecuencia) throws IntegracionExternaException{
		loggerDebug("consultaEstadoTraspOP: Inicio");
		SalidaConsultaTraspasoDTO respuesta = traspasoMasivoDAO.consultaEstadoTraspOP(numSecuencia);
		loggerDebug("consultaEstadoTraspOP: Fin");
		return respuesta;
	}
	
	/**
     * Metodo que valida que la bodega sea del distribuidor
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean validaBodegaDTS(String codCliente, String codBodega) throws IntegracionExternaException{
		loggerDebug("validaBodegaDTS: inicio");
		boolean resultado = traspasoMasivoDAO.validaBodegaDTS(codCliente, codBodega);
		loggerDebug("validaBodegaDTS: fin");
		return resultado;
	}
	
	/**
     * Metodo que obtiene lista de las series con error
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public SalidaConsultaTraspasoDTO obtieneSeriesErrorTM(SalidaConsultaTraspasoDTO traspasoDTO, String tipConsulta) throws IntegracionExternaException{
		loggerDebug("obtieneSeriesErrorTM: inicio");
		SalidaConsultaTraspasoDTO resultado = traspasoMasivoDAO.obtieneSeriesErrorTM(traspasoDTO, tipConsulta);
		loggerDebug("obtieneSeriesErrorTM: fin");
		return resultado;
	}
	
	/**
     * Metodo que elimina traspaso masivo
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void eliminaTraspasoMasivo(String nomTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("eliminaTraspasoMasivo: inicio");
		traspasoMasivoDAO.eliminaTraspasoMasivo(nomTraspasoMasivo);
		loggerDebug("eliminaTraspasoMasivo: fin");
	}
	
	/**
     * Metodo que valida que la serie pertenesca a la bodega origen ingresada
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void validaSerieBodega(String nomTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("validaSerieBodega: inicio");
		traspasoMasivoDAO.validaSerieBodega(nomTraspasoMasivo);
		loggerDebug("validaSerieBodega: fin");
	}

}
