package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductPromotionException;

public interface PromocionDAOIT {

	public RetornoDTO eliminarPromocion(EliminaPromocionDTO param) throws ProductPromotionException;
}
