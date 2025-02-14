package com.tmmas.scl.doblecuenta.businessobject.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.FacturaBOIT;
import com.tmmas.scl.doblecuenta.businessobject.dao.FacturaDAO;
import com.tmmas.scl.doblecuenta.businessobject.dao.interfaces.FacturaDAOIT;
import com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.FacturaDTO;
import com.tmmas.scl.doblecuenta.commonapp.dto.RetornoDTO;
import com.tmmas.scl.doblecuenta.commonapp.exception.ProyectoException;

public class FacturaBO implements FacturaBOIT {
	
	private final Logger logger = Logger.getLogger(FacturaBO.class);
	private FacturaDAOIT facturaDAO = new FacturaDAO();
	
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
	
	public ConceptoDTO[] obtenerListaConceptos() throws ProyectoException{
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito obtenerListaConceptosBO()");
		ConceptoDTO[] listaConcepFacturas = null;
		try{
			logger.debug("obtenerListaClientesAsociadosBO():start");
			listaConcepFacturas = facturaDAO.obtenerListaConceptos();
			logger.debug("obtenerListaClientesAsociadosBO():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito obtenerListaConceptosBO()");
		return listaConcepFacturas;
	}
	
	public RetornoDTO insertaFacturacionDiferenciadaCabecera(FacturaDTO factura, ClienteDTO cliente) throws ProyectoException{
		
		System.out.println("entramos con exito insertaFacturacionDiferenciadaCabeceraBO()");
		
		setPropertieFile();//MA
		
		RetornoDTO respuesta = null;
		try{
			logger.debug("insertaFacturacionDiferenciadaCabeceraBO():start");
			respuesta = facturaDAO.insertaFacturacionDiferenciadaCabecera(factura, cliente);
			logger.debug("insertaFacturacionDiferenciadaCabeceraBO():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito insertaFacturacionDiferenciadaCabeceraBO()");
		return respuesta;
	}
	
	public RetornoDTO insertarFacturacionDiferenciadaDetalle(FacturaDTO factura, AbonadoDTO abonado, ClienteDTO cliente, ConceptoDTO conceptos) throws ProyectoException{
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito insertarFacturacionDiferenciadaDetalleBO()");
		RetornoDTO respuesta = null;
		try{
			logger.debug("insertarFacturacionDiferenciadaDetalleBO():start");
			respuesta = facturaDAO.insertarFacturacionDiferenciadaDetalle(factura, abonado, cliente, conceptos);
			logger.debug("insertarFacturacionDiferenciadaDetalleBO():start");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito insertarFacturacionDiferenciadaDetalleBO()");
		return respuesta;
	}
	
	public RetornoDTO updateFacturacionDiferenciadaCabecera(ClienteDTO cliente, AbonadoDTO abonado, FacturaDTO factura) throws ProyectoException{
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito updateFacturacionDiferenciadaCabeceraBO()");
		RetornoDTO respuesta = null;
		try{
			logger.debug("updateFacturacionDiferenciadaCabeceraBO():start");
			respuesta = facturaDAO.updateFacturacionDiferenciadaCabecera(cliente, abonado, factura);
			logger.debug("updateFacturacionDiferenciadaCabeceraBO():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito updateFacturacionDiferenciadaCabeceraBO()");
		return respuesta;
	}
	
	public RetornoDTO bajaMasivaFacturacion(FacturaDTO factura) throws ProyectoException{
		
		setPropertieFile();//MA
		
		System.out.println("entramos con exito bajaMasivaFacturacionBO()");
		RetornoDTO respuesta = null;
		try{
			logger.debug("bajaMasivaFacturacionBO():start");
			respuesta = facturaDAO.bajaMasivaFacturacion(factura);
			logger.debug("bajaMasivaFacturacionBO():end");
		}catch (ProyectoException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProyectoException(e);
		}
		System.out.println("salimos con exito bajaMasivaFacturacionBO()");
		return respuesta;
	}
	
}
