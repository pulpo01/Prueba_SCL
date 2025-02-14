package com.tmmas.cl.scl.pv.customerorder.service.servicios;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.bo.ServiceBundleSpec;


public class LogicalServiceSrv {
	private ServiceBundleSpec serviceBundleSpecBO = new ServiceBundleSpec();
	private static Category cat = Category.getInstance(LogicalServiceSrv.class);
	
	
// INICIO MA 69363 RRG 04-11-2008
	
	private CompositeConfiguration config;

	private void setPropFile() {
//		 inicio MA
		String strArchivoLog;
		String strRuta = "com/tmmas/cl/tol/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + "tol.webservice.properties";
		System.out.println("strRutaArchivoExterno:"+strRutaArchivoExterno);
		//config = UtilProperty.getConfigurationfromExternalFile(strRutaArchivoExterno);
		config = UtilProperty.getConfiguration(strRutaArchivoExterno,strRutaArchivoExterno);
		System.out.println("config.isEmpty():" + config.isEmpty());
		strArchivoLog = config.getString("tol.ejb.log");
		System.out.println("strArchivoLog:" + strRuta+strArchivoLog);
		UtilLog.setLog("/" +strRuta+strArchivoLog);
		// fin MA	
	}
//	 FIN MA 69363 RRG 04-11-2008
	
	public LogicalServiceSrv()
	{
		setPropFile();
		cat.info("LogicalServiceSrv Constructor");
	}
	
	
	 public void setFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException{
		  cat.debug("setFreeUnitStock():start");
		  serviceBundleSpecBO.setFreeUnitStock(dto);
		  cat.debug("setFreeUnitStock():end");
		 }
	
	public void installServiceBundle(ProductListDTO list) throws TOLException
	{
		cat.debug("installServiceBundle():start");
		serviceBundleSpecBO.installServiceBundle(list);
		cat.debug("installServiceBundle():end");
	}
	
	
	public void uninstallServiceBundle(ProductListDTO list) throws TOLException
	{
		cat.debug("uninstallServiceBundle():start");
		serviceBundleSpecBO.uninstallServiceBundle(list);
		cat.debug("uninstallServiceBundle():end");
	}
		
	
	/*
	 * 
	 */
	public void createStorageAndFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("createStorageAndUnitStock:star");
		
		cat.info("llamada a createStorageAndUnitStock()");
		serviceBundleSpecBO.createStorageAndFreeUnitStock(dto);
		
		cat.info("llamada a createStorageFreeUnitStock()");
		serviceBundleSpecBO.createStorageFreeUnitStock(dto);
		
		if(dto.isCreaLCAbonado())
		{
			cat.info("crear LC del Plan tarifario");
			serviceBundleSpecBO.creaLCdelPTPorAbonado(dto);
		}else
			cat.info("No se crearan los planes por abonado, ya que el WS no fue llamado desde la venta");
		
		cat.info("createStorageAndUnitStock:end");
	}

	
	public void deleteStorageAndFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("deleteStorageAndFreeUnitStock:star");
		
		cat.info("llamada a deleteFreeUnitStock()");
		serviceBundleSpecBO.deleteFreeUnitStock(dto);
		
		cat.info("llamada a deleteStorageFreeUnitStock()");
		serviceBundleSpecBO.deleteStorageFreeUnitStock(dto);
		
		cat.info("deleteStorageAndFreeUnitStock:end");		
	}

	public void deleteFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("deleteFreeUnitStock:star");
		serviceBundleSpecBO.deleteFreeUnitStock(dto);
		cat.info("deleteFreeUnitStock:end");		
	}
	
	
	/**
	 * Obtiene la lista de perfiles dado un servicio suplementario
	 * 
	 * @param prod
	 * @return
	 * @throws CustomerOrderException
	 */
	public LimiteConsumoDTO[] getServiceLimitProfiles(ProductDTO prod)
			throws TOLException {
		cat.debug("getServiceLimitProfiles():start");
		LimiteConsumoDTO[] resultado = serviceBundleSpecBO.getServiceLimitProfiles(prod);
		cat.debug("getServiceLimitProfiles():end");
		return resultado;
	}	
	
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto) throws TOLException{
			cat.debug("getFreeUnitStock():start");
			BolsaAbonadoDTO[] resultado = serviceBundleSpecBO.getFreeUnitStock(dto);
			cat.debug("getFreeUnitStock():end");
			return resultado;		
	}
	
		
	/**
	 * Actualiza los atributos de los servicios suplementarios, luego elimina
	 * los limites de consumo en Tol y despues los crea
	 * 
	 * @param dto
	 * @return
	 * @throws TOLException
	 */
	public void setServiceBundleAttributes(ProductListDTO prodList) throws TOLException{
		cat.debug("setServiceBundleAttributes():start");
		serviceBundleSpecBO.setServiceBundleAttributes(prodList);
		cat.debug("setServiceBundleAttributes():end");
	}	

	public void validServiceBundleAttributes(ProductListDTO prodList) throws TOLException{
		cat.debug("validServiceBundleAttributes():start");
		serviceBundleSpecBO.validServiceBundleAttributes(prodList);
		cat.debug("validServiceBundleAttributes():end");
	}	
	
	public CustomerAccountDTO getFreeUnitBagId(CustomerAccountDTO dto) throws TOLException{
		cat.debug("setServiceBundleAttributes():start");
		CustomerAccountDTO cus;
		cus = serviceBundleSpecBO.getFreeUnitBagId(dto);
		cat.debug("setServiceBundleAttributes():end");
		return cus;
	}
	
	public LimiteClienteDTO getServiceLimitProfileValue(LimiteClienteDTO dto) throws TOLException
	{
		cat.debug("getServiceLimitProfileValue():start");
		LimiteClienteDTO respuesta;
		respuesta = serviceBundleSpecBO.getServiceLimitProfileValue(dto);
		cat.debug("getServiceLimitProfileValue():end");
		return respuesta;
	}
	
	/**
	 * Obtiene los limites de consumo dado un codigo de plan
	 * @param prodList
	 * @return
	 * @throws TOLException
	 */
	public ProductListDTO getDefaultServiceLimitProfile(ProductListDTO prodList) throws TOLException
	{
		cat.info("getDefaultServiceLimitProfile:start");
		ProductListDTO respuesta = serviceBundleSpecBO.getDefaultServiceLimitProfile(prodList);
		cat.info("getDefaultServiceLimitProfile:end");
		return respuesta;
	}
	
	
	public void setServiceLimitTemporally(LimiteClienteDTO dto)  throws TOLException
	{
		cat.info("setServiceLimitTemporally:star");
		serviceBundleSpecBO.setServiceLimitTemporally(dto);
		cat.info("setServiceLimitTemporally:end");
	}
}
