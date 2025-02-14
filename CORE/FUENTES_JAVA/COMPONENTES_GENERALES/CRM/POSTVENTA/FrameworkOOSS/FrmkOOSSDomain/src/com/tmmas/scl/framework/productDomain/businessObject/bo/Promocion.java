package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PromocionIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.PromocionDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.PromocionDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductPromotionException;

public class Promocion implements PromocionIT {

	private PromocionDAOIT promocionDAO = new PromocionDAO();
	
	private final Logger logger = Logger.getLogger(Promocion.class);
	private Global global = Global.getInstance();
	
	public RetornoDTO eliminarPromocion(EliminaPromocionDTO param)
			throws ProductPromotionException {
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminarPromocion():start");
			retorno = promocionDAO.eliminarPromocion(param);
			logger.debug("eliminarPromocion():end");
		} catch (ProductPromotionException e) {
			logger.debug("ProductPromotionException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductPromotionException(e);
		}		
		return retorno;
	}

}
