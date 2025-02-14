package com.tmmas.scl.operation.smo.ssir.RateUsageRecordsSrv.Interface;

import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaEntradaDTO;
import com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto.FacturaMiscelaneaSalidaDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;

public interface RateUsageRecordsSrvIT {

	public FacturaMiscelaneaSalidaDTO generarFacturaMiscelanea(
			FacturaMiscelaneaEntradaDTO facturaMiscelaneaEntradaDTO)throws RateUsageRecordsException;	
}
