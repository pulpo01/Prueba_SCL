package com.tmmas.cl.scl.migraciomasiva.srv;



import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.migracionmasiva.bo.MigracionBO;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosEntradaDTO;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosSalidaDTO;
import com.tmmas.cl.scl.migracionmasiva.helper.LoggerHelper;



public class MigracionSrv {
	 private final LoggerHelper logger = LoggerHelper.getInstance();
	 private final String nombreClase = this.getClass().getName();
	 private CompositeConfiguration config;
	 MigracionBO migBO= new MigracionBO();
	
	public MigracionSrv() {
		System.out.println("MigracionSrv(): Start");
		logger.debug("MigracionSrv():Start",nombreClase);
	}	

	
	public WSDatosSalidaDTO insertoDatosMigracion(WSDatosEntradaDTO datosDTO) throws GeneralException{
		logger.debug("insertoDatosMigracion:Start",nombreClase);
		WSDatosSalidaDTO respuesta=null;
		try{
			respuesta=migBO.insertoDatosMigracion(datosDTO);
		}catch(GeneralException e){
		//	UtilLog.setLog(config.getString("GestionDeClientesSrv.log"));
			logger.debug("GeneralException",nombreClase);
			e.printStackTrace();
			System.out.println("Problemas al llamar al BO.");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]",nombreClase);			
			throw  e;
		}
		logger.debug("insertoDatosMigracion:End",nombreClase);
		return respuesta;
	}
	
}
