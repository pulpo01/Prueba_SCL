package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.FinCicloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public interface CiclosFacturacionIT {

	public RetornoDTO eliminaFinCiclo(FinCicloDTO finCiclo) throws CustomerBillException;
	
	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws CustomerBillException;	
	
	public RetornoDTO validarPeriodoFact(AbonadoDTO abonado) throws CustomerBillException;	
}
