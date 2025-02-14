package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.cporc.interfaces;

import javax.ejb.SessionContext;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.AbonoLimiteConsumoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.LimiteConsumoPlanAdicionalListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;


public interface LimiteConsumoSrvOrcIF {
	
	public RetornoDTO mantenerLimiteDeConsumo(ProductoContratadoListDTO listaProdContraMantenidosLC) throws IssCusOrdException;
	public RetornoDTO abonoLimiteDeConsumo(AbonoLimiteConsumoListDTO listaAboLC) throws IssCusOrdException;
	public void setContext(SessionContext context);
}
