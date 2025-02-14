package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.ord.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productPromotionABE.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;

public interface GestionPromocionOrdenSrvIF {

	public RetornoDTO eliminarPromocion(EliminaPromocionDTO param)	throws IssCusOrdException;

}
