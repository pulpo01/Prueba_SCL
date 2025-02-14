package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.soa.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;

public interface IssCusOrdORCSrvIT {
	
	public IntegraProdCPUListDTO registroReordenamientoAbonados(RegistroPlanDTO registro) throws IssCusOrdException;
	
	public RetornoDTO registroCargosAbonadosBatch(ParamRegistroOrdenServicioDTO entrada) throws IssCusOrdException;
	
	public RetornoDTO validarActDescRegistrarCambPlanBatch(RegistroPlanDTO registro) throws IssCusOrdException;
	
	public RetornoDTO registrarCambioPlanAbonados(RegistroPlanDTO registro) throws IssCusOrdException;
	
}
