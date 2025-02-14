package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;

public interface GestionAnulaOOSSSrvIF {

	public IOOSSDTO anulaOossPendPlan(IOOSSDTO ordenServicio) throws SupOrdHanException;
}
