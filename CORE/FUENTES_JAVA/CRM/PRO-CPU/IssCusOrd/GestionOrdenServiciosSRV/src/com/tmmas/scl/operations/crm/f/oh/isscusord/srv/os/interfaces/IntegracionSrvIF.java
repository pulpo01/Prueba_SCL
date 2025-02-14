package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraCPUPDTDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;

public interface IntegracionSrvIF {
	
	public RetornoDTO quitarPlanes(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException;
	
	public RetornoDTO contratarPlanesPorDefecto(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException;
	
	public RetornoDTO integrarCPUPDT(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException;
	
	public RetornoDTO provisionarAbonado(IntegraCPUPDTDTO integraCPUPDTDTO) throws IssCusOrdException;
	
	public RetornoDTO validaPrimerAbonadoActivo(AbonadoDTO abonadoDTO) throws IssCusOrdException;
	
}
