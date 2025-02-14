package com.tmmas.cl.scl.migracionmasiva.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.migracionmasiva.dao.MigracionDAO;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosEntradaDTO;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosSalidaDTO;
import com.tmmas.cl.scl.migracionmasiva.helper.LoggerHelper;
public class MigracionBO {
	 private final LoggerHelper logger = LoggerHelper.getInstance();
	 private final String nombreClase = this.getClass().getName();
	MigracionDAO migracionDAO=new MigracionDAO();
	
	public WSDatosSalidaDTO insertoDatosMigracion(WSDatosEntradaDTO datosDTO) throws GeneralException{
		logger.debug("inicio:insertoDatosMigracion",nombreClase);
		WSDatosSalidaDTO datos=migracionDAO.insertoDatosMigracion(datosDTO);
		logger.debug("fin:insertoDatosMigracion",nombreClase);
		return  datos;
	}
}
