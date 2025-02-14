package com.tmmas.scl.doblecuenta.businessobject.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.AbonadoBOIT;
import com.tmmas.scl.doblecuenta.businessobject.dao.AbonadoDAO;
import com.tmmas.scl.doblecuenta.businessobject.dao.interfaces.AbonadoDAOIT;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

public class AbonadoBO implements AbonadoBOIT{
	
	private AbonadoDAOIT abonadoDAO = new AbonadoDAO();
	private final Logger logger = Logger.getLogger(AbonadoBO.class);
	
	private CompositeConfiguration config; // MA
	
	private void setPropertieFile() {
//		  inicio MA
		     String strRuta = "/com/tmmas/cl/DobleCuentaBo/properties/";
		     String srtRutaDeploy = System.getProperty("user.dir");
		     String strArchivoProperties= "DobleCuentaBo.properties";
		     String strArchivoLog="DobleCuentaBo.log";
		     String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		     config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		     UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		     // fin MA           
	}
	
	public AbonadoDTO[] obtenerListaAbonado(AbonadoDTO abonado) throws ProyectoException{
		
		System.out.println("entramos con exito obtenerListaAbonadoBO");
		
		setPropertieFile(); // MA
		
		AbonadoDTO[] abonadosList = null;
		try{
			logger.debug("obtenerListaAbonadoBO():start");
			abonadosList = abonadoDAO.obtenerListaAbonado(abonado);
			logger.debug("obtenerListaAbonadoBO():end");
		} catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaAbonadoBO");
		return abonadosList;
	}
}
