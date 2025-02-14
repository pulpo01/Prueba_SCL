package com.tmmas.cl.scl.tol.ServiceBundle.businessobject.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.FreeUnitStockDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.dao.ServiceBundleSpecSCLDAO;
import com.tmmas.cl.scl.tol.ServiceBundle.businessobject.dao.ServiceBundleSpecTOLDAO;

public class ServiceBundleSpec {
	private ServiceBundleSpecTOLDAO serviceBundleSpecTOLDAO = new ServiceBundleSpecTOLDAO();

	private ServiceBundleSpecSCLDAO serviceBundleSpecSCLDAO = new ServiceBundleSpecSCLDAO();

	private static Category cat = Category.getInstance(ServiceBundleSpec.class);
	
	private CompositeConfiguration config;
	
	private void setLogFile() {
//		 inicio MA
		String strArchivoLog;
		String strRuta = "com/tmmas/cl/tol/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + "tol.webservice.properties";
		System.out.println("strRutaArchivoExterno:"+strRutaArchivoExterno);
		//config = UtilProperty.getConfigurationfromExternalFile(strRutaArchivoExterno);
		config = UtilProperty.getConfiguration(strRutaArchivoExterno,strRutaArchivoExterno);
		System.out.println("config.isEmpty():" + config.isEmpty());
		strArchivoLog = config.getString("tol.bo.log");
		System.out.println("strArchivoLog:" + strRuta+strArchivoLog);
		UtilLog.setLog("/" +strRuta+strArchivoLog);
		// fin MA	
	}

	public ServiceBundleSpec() {
		setLogFile();
		cat.info("ServiceBundleSpec Constructor");
	}

	public void createFreeUnitStock(FreeUnitStockDTO[] list)
			throws TOLException {
		cat.debug("createFreeUnitStock():start");
		serviceBundleSpecTOLDAO.createFreeUnitStock(list);

		cat.debug("createFreeUnitStock():end");
	}

	public void installServiceBundle(ProductListDTO list) throws TOLException {
		cat.debug("installServiceBundle():start");
		serviceBundleSpecTOLDAO.installServiceBundle(list);
		cat.debug("Se ejecuto servicio ");
		serviceBundleSpecSCLDAO.createLimitProfileService(list);
		cat.debug("installServiceBundle():end");
	}
	
	public void setLimitProfileService(ProductListDTO list) throws TOLException {
		cat.debug("uninstallServiceBundle():start");
		serviceBundleSpecSCLDAO.setLimitProfileService(list);
		cat.debug("uninstallServiceBundle():end");
	}	
	
	public void uninstallServiceBundle(ProductListDTO list) throws TOLException {
		cat.debug("uninstallServiceBundle():start");
		serviceBundleSpecTOLDAO.uninstallServiceBundle(list);
		serviceBundleSpecSCLDAO.deleteLimitProfileService(list);
		cat.debug("uninstallServiceBundle():end");
	}
	
	/**/
	public void createStorageAndFreeUnitStock(DistribucionBolsaDTO dto)
			throws TOLException {
		cat.info("createStorageAndUnitStock:star");
		serviceBundleSpecTOLDAO.createStorageAndFreeUnitStock(dto);
		cat.info("createStorageAndUnitStock:end");
	}

	public void createStorageFreeUnitStock(DistribucionBolsaDTO dto)
			throws TOLException {
		cat.info("createStorageFreeUnitStock:star");
		serviceBundleSpecTOLDAO.createStorageFreeUnitStock(dto);
		cat.info("createStorageFreeUnitStock:end");
	}

	public void deleteFreeUnitStock(DistribucionBolsaDTO dto)
			throws TOLException {
		cat.info("deleteFreeUnitStock:star");
		serviceBundleSpecTOLDAO.deleteFreeUnitStock(dto);
		cat.info("deleteFreeUnitStock:end");
	}

	public void deleteStorageFreeUnitStock(DistribucionBolsaDTO dto)
			throws TOLException {
		cat.info("deleteStorageFreeUnitStock:star");
		serviceBundleSpecTOLDAO.deleteStorageFreeUnitStock(dto);
		cat.info("deleteStorageFreeUnitStock:end");
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
		LimiteConsumoDTO[] resultado = serviceBundleSpecSCLDAO
				.getServiceLimitProfiles(prod);
		cat.debug("getServiceLimitProfiles():end");
		return resultado;
	}

	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto)
			throws TOLException {
		cat.debug("getFreeUnitStock():start");
		BolsaAbonadoDTO[] resultado = serviceBundleSpecTOLDAO
				.getFreeUnitStock(dto);
		cat.debug("getFreeUnitStock():end");
		return resultado;
	}
	
	public void setFreeUnitStock(DistribucionBolsaDTO dto)
			throws TOLException {
		cat.debug("setFreeUnitStock():start");
		serviceBundleSpecTOLDAO.setFreeUnitStock(dto);
		cat.debug("setFreeUnitStock():end");
	}
	
	public CustomerAccountDTO getFreeUnitBagId(CustomerAccountDTO dto)
			throws TOLException {
		cat.debug("getFreeUnitBagId():start");
		CustomerAccountDTO cus;
		cus = serviceBundleSpecSCLDAO.getFreeUnitBagId(dto);
		cat.debug("getFreeUnitBagId():end");
		return cus;		
	}		

	/**
	 * Actualiza los atributos de los servicios suplementarios, luego elimina
	 * los limites de consumo en Tol y despues los crea
	 * 
	 * @param dto
	 * @return
	 * @throws TOLException
	 */
	public void setServiceBundleAttributes(ProductListDTO prodList)
			throws TOLException {
		cat.debug("setServiceBundleAttributes():start");
		serviceBundleSpecTOLDAO.uninstallServiceBundle(prodList);
		cat.debug("setServiceBundleAttributes():end");

		cat.debug("creaServiceBundleAttributes():start");
		serviceBundleSpecTOLDAO.createServiceBundleAttributes(prodList);
		cat.debug("creaServiceBundleAttributes():end");
		
		cat.debug("creaServiceBundleAttributes():start");
		serviceBundleSpecTOLDAO.modificaLimiteTOL(prodList);
		cat.debug("creaServiceBundleAttributes():end");
		
		cat.debug("deleteLimitProfileService():start");
		serviceBundleSpecSCLDAO.deleteLimitProfileService(prodList);
		cat.debug("deleteLimitProfileService():END");	
		
		cat.debug("createLimitProfileService():start");
		serviceBundleSpecSCLDAO.createLimitProfileService(prodList);
		cat.debug("createLimitProfileService():end");		
	}

	public void validServiceBundleAttributes(ProductListDTO prodList) throws TOLException
	{
		cat.debug("validServiceBundleAttributes():start");
		serviceBundleSpecTOLDAO.validServiceBundleAttributes(prodList);
		cat.debug("validServiceBundleAttributes():end");
	}
	
	public LimiteClienteDTO getServiceLimitProfileValue(LimiteClienteDTO dto) throws TOLException
	{
		cat.debug("getServiceLimitProfileValue():start");
		LimiteClienteDTO respuesta;
		respuesta = serviceBundleSpecTOLDAO.getServiceLimitProfileValue(dto);
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
		ProductListDTO respuesta = serviceBundleSpecSCLDAO.getDefaultServiceLimitProfile(prodList);
		cat.info("getDefaultServiceLimitProfile:end");
		return respuesta;
	}
	
	public void setServiceLimitTemporally(LimiteClienteDTO dto)  throws TOLException
	{
		cat.info("setServiceLimitTemporally:star");
		serviceBundleSpecSCLDAO.setServiceLimitTemporally(dto);
		cat.info("setServiceLimitTemporally:end");
	}
	
	public void creaLCdelPTPorAbonado(DistribucionBolsaDTO dto) throws TOLException
	{
		cat.info("creaLCdelPTPorAbonado:star");
		serviceBundleSpecSCLDAO.obtieneLCdelPT(dto);
		cat.info("Se obtuvo LC del Plan tarifario :"+ dto.getLimite_consumo());
		serviceBundleSpecSCLDAO.creaLCdelPTPorAbonado(dto);
		cat.info("creaLCdelPTPorAbonado:end");
	}
}
