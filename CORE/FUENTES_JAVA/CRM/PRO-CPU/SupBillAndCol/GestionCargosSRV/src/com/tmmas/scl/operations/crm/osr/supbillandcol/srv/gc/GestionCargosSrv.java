package com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.CatalogoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.CatalogoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.CatalogoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.exception.ProductOfferingPriceException;
import com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.helper.Global;
import com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.interfaces.GestionCargosSrvIF;

public class GestionCargosSrv implements GestionCargosSrvIF 
{
	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(GestionCargosSrv.class);
	
	CatalogoBOFactoryIT boObjectFactory=new CatalogoBOFactory();
	CatalogoIT catalogoBO=  boObjectFactory.getBusinessObject1();
	
	public CargoListDTO obtenerCargosProductos(ProductoOfertadoListDTO prodOfeProdList) throws  ProductOfferingException, ProductOfferingPriceException {
		CargoListDTO retorno = null;
		try {
			String log = global.getValor("service.log");;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCargosProductos():start");
			retorno = catalogoBO.obtenerCargosProductos(prodOfeProdList);
			logger.debug("obtenerCargosProductos():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}
		return retorno;	
	}

	public CargoListDTO obtenerDescuentos(CargoListDTO cargoList) throws ProductOfferingException, ProductOfferingPriceException {
		// PENDIENTE
		return null;
	}

}
