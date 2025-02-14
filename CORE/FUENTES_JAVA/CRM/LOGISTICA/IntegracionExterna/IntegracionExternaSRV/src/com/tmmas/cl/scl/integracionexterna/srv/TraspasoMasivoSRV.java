package com.tmmas.cl.scl.integracionexterna.srv;

import com.tmmas.cl.scl.integracionexterna.bo.TraspasoMasivoBO;
import com.tmmas.cl.scl.integracionexterna.common.dto.TraspasoMasivoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.dto.ws.TraspasoMasivoInDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;

public class TraspasoMasivoSRV extends IntegracionExternaSRV {
	TraspasoMasivoBO traspasoMasivoBO = new TraspasoMasivoBO();
	private GlobalProperties global = GlobalProperties.getInstance();
	
	/**
     * Funcion que Realiza el traspaso masivo de las series informadas
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public TraspasoMasivoDTO traspasoMasivoSeries(TraspasoMasivoInDTO traspasoMasivoInDTO) throws IntegracionExternaException, Exception{
		TraspasoMasivoDTO masivoDTO = new TraspasoMasivoDTO();
		String nomUsuario = null;
		String codError = null;
		int numEvento = -1;
		String msgError = null;
		try {
			masivoDTO.setMasivoInDTO(traspasoMasivoInDTO);			
			//Se Obtiene el numero de traspaso Masivo
			loggerDebug("Se Obtiene el numero de traspaso Masivo");
			masivoDTO.setNumTraspasoMasivo(traspasoMasivoBO.obtNumSecuencia(global.getValor("AL.TraspasoMasivo")));		
			
			//Se obtiene el numero de traspaso
			loggerDebug("Se obtiene el numero de traspaso");
			masivoDTO.setNumTraspaso(traspasoMasivoBO.obtNumSecuencia(global.getValor("AL.Traspaso")));
			
			//Se actualiza tabla AL_TRASPASOS_OP_TD
			traspasoMasivoBO.actualizaTraspasoOP(masivoDTO.getNumTraspasoMasivo(), masivoDTO.getMasivoInDTO().getNumSecuencia(), global.getValor("AL.estadoProcesando"));
			
			//Se obtiene Nombre de Usuario traspaso Masivo
			loggerDebug("Se obtiene Nombre de Usuario traspaso Masivo");
			nomUsuario = traspasoMasivoBO.consultaParametros(global.getValor("AL.usuarioTrasMas"), global.getValor("AL.codModulo"), global.getValor("AL.codProducto")); 
			
			//Se obtiene el tip_stock, el cod_estado y el cod_uso de las series si no son informados
			loggerDebug("Se obtiene el tip_stock, el cod_estado y el cod_uso de las series si no son informados");
			masivoDTO = traspasoMasivoBO.obtDatosSeries(masivoDTO);
			
			//Registra series en la tabla AL_TRASPASOS_MASIVO
			loggerDebug("Registra series en la tabla AL_TRASPASOS_MASIVO");
			traspasoMasivoBO.registraTraspasoMasivo(masivoDTO, nomUsuario);
			
			//Valida que la serie pertenesca a la bodega origen y el tipo stock sea valido
			traspasoMasivoBO.validaSerieBodega(masivoDTO.getNumTraspasoMasivo());
			
			//Se validan las series ejecutando el PLSQL AL_TRASPASOCLS_PG.P_VALIDA_MASIVO_PR
			loggerDebug("Se validan las series ejecutando el PLSQL AL_TRASPASOCLS_PG.P_VALIDA_MASIVO_PR");
			traspasoMasivoBO.validaTraspasoMasivo(masivoDTO.getNumTraspasoMasivo());
			
			//Se validan errores criticos
			
			loggerDebug("Se validan errores criticos");
			if(!traspasoMasivoBO.consultaSeriesError(masivoDTO.getNumTraspasoMasivo(), global.getValor("AL.ErroresCriticos"))){
				traspasoMasivoBO.actualizaTraspasoOP(masivoDTO.getNumTraspasoMasivo(), masivoDTO.getMasivoInDTO().getNumSecuencia(), global.getValor("AL.estadoError"));
				codError = "ERR.0005";
				numEvento = Integer.parseInt(masivoDTO.getNumTraspasoMasivo());
				msgError = global.getValor("ERR.0005");
				throw new IntegracionExternaException(codError,numEvento,msgError);
			}
			
		    /*
			//Se validan errores
			loggerDebug("Se validan errores normales");
			if(!traspasoMasivoBO.consultaSeriesError(masivoDTO.getNumTraspasoMasivo(), global.getValor("AL.ErroresNormal"))){
				traspasoMasivoBO.actualizaTraspasoOP(masivoDTO.getNumTraspasoMasivo(), masivoDTO.getMasivoInDTO().getNumSecuencia(), global.getValor("AL.estadoError"));
				codError = "ERR.0006";
				numEvento = Integer.parseInt(masivoDTO.getNumTraspasoMasivo());
				msgError = global.getValor("ERR.0006");
				throw new IntegracionExternaException(codError,numEvento,msgError);
			}*/
			
			//Si no existen error se ejecuta el PLSQL AL_TRASPASO_MASIVO_WS_PG.al_tratamiento_masivo
			loggerDebug("Se realiza tratamiento traspaso masivo");
			traspasoMasivoBO.tratamientoTraspasoMasivo(masivoDTO.getNumTraspasoMasivo(), global.getValor("AL.obsTraspaso"));	
			
			//Si no existen error se ejecuta el PLSQL AL_TRASPASO_MASIVO_WS_PG.al_hist_traspasos_mas
			loggerDebug("Se realiza tratamiento traspaso masivo");
			traspasoMasivoBO.traspasoHistoricoMasivo(masivoDTO.getNumTraspasoMasivo());
			
			//Se actualiza tabla AL_TRASPASOS_OP_TD
			traspasoMasivoBO.actualizaTraspasoOP(masivoDTO.getNumTraspasoMasivo(), masivoDTO.getMasivoInDTO().getNumSecuencia(), global.getValor("AL.estadoFinalizado"));
			
		}catch(IntegracionExternaException e){
			//Se actualiza tabla AL_TRASPASOS_OP_TD
			traspasoMasivoBO.actualizaTraspasoOP(masivoDTO.getNumTraspasoMasivo(), masivoDTO.getMasivoInDTO().getNumSecuencia(), global.getValor("AL.estadoError"));
			loggerError("IntegracionExternaException: " + e);
			throw e;			
		}
		return masivoDTO;
	}
	
	/**
     * Metodo que registra traspaso masivo operador logisitico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void insertaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException, Exception{
		loggerDebug("insertaTraspasoOP: inicio");
		loggerDebug("numTraspaso: "+ numTraspaso);
		loggerDebug("numSecuencia: "+ numSecuencia);
		loggerDebug("codEstado: "+ codEstado);		
		traspasoMasivoBO.insertaTraspasoOP(numTraspaso, numSecuencia, codEstado);
		loggerDebug("insertaTraspasoOP: fin");
	}
	
	/**
     * Funcion que Obtiene el numero de secuencia del parametro ingresado
     * 
     * @author Jorge González
     * @throws IntegracionExternaException
     */
	public String obtNumSecuencia(String nomSecuencia)throws IntegracionExternaException{
        loggerDebug("obtNumSecuencia: inicio");
        String resultado = traspasoMasivoBO.obtNumSecuencia(nomSecuencia);
        loggerDebug("obtNumSecuencia: fin");
        return resultado;
	}
	
	/**
     * Metodo que valida el numero de secuencia del operador logistico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean validaTraspOP(String numSecuencia) throws IntegracionExternaException, Exception{
		loggerDebug("validaTraspOP: inicio");
		boolean resultado = traspasoMasivoBO.validaTraspOP(numSecuencia);
		loggerDebug("validaTraspOP: fin");
		return resultado;
	}
	
	/**
     * Metodo que actualiza estado traspaso masivo operador logisitico
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public void actualizaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException, Exception{
		loggerDebug("actualizaTraspasoOP: inicio");
		traspasoMasivoBO.actualizaTraspasoOP(numTraspaso, numSecuencia, codEstado);
		loggerDebug("actualizaTraspasoOP: fin");
	}
	
	/**
     * Metodo que consulta estado del traspaso masivo
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public SalidaConsultaTraspasoDTO consultaEstadoTraspOP(String numSecuencia) throws IntegracionExternaException, Exception{
		loggerDebug("consultaEstadoTraspOP: Inicio");
		SalidaConsultaTraspasoDTO respuesta = traspasoMasivoBO.consultaEstadoTraspOP(numSecuencia);
		loggerDebug("consultaEstadoTraspOP: Fin");
		return respuesta;
	}
	
	/**
     * Metodo que valida que la bodega sea del distribuidor
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean validaBodegaDTS(String codCliente, String codBodega) throws IntegracionExternaException, Exception{
		loggerDebug("validaBodegaDTS: inicio");
		boolean resultado = traspasoMasivoBO.validaBodegaDTS(codCliente, codBodega);
		loggerDebug("validaBodegaDTS: fin");
		return resultado;
	}
	
	/**
     * Metodo que consulta parametros
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public String consultaParametros(String nomParametro, String codModulo, String codProducto) throws IntegracionExternaException, Exception{
		loggerDebug("consultaParametros: inicio");
		String resultado = traspasoMasivoBO.consultaParametros(nomParametro, codModulo, codProducto);
		loggerDebug("consultaParametros: fin");
		return resultado;
	}
	
	/**
     * Metodo que obtiene lista de las series con error
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public SalidaConsultaTraspasoDTO obtieneSeriesErrorTM(SalidaConsultaTraspasoDTO traspasoDTO, String tipConsulta) throws IntegracionExternaException, Exception{
		loggerDebug("obtieneSeriesErrorTM: inicio");
		SalidaConsultaTraspasoDTO resultado = traspasoMasivoBO.obtieneSeriesErrorTM(traspasoDTO, tipConsulta);
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
		traspasoMasivoBO.eliminaTraspasoMasivo(nomTraspasoMasivo);
		loggerDebug("eliminaTraspasoMasivo: fin");
	}
	
	/**
     * Metodo que consulta las series que se encuentran con error
     * 
     * @author Jorge González 
     * @throws IntegracionExternaException
     */	
	public boolean consultaSeriesError(String numTraspasoMasivo, String tipConsulta) throws IntegracionExternaException{
		loggerDebug("consultaSeriesError: inicio");
		boolean resultado = traspasoMasivoBO.consultaSeriesError(numTraspasoMasivo, tipConsulta);
		loggerDebug("consultaSeriesError: fin");
		return resultado;
	}
	
}
