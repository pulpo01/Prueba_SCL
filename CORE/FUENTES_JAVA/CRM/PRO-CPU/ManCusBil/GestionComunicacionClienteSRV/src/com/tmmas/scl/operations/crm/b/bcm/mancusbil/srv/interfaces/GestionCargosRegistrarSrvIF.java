package com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;

public interface GestionCargosRegistrarSrvIF {
	
	//public ResultadoRegistroCargosDTO registrarCargos(ParametrosRegistroCargosDTO cargos)throws ProyectoException,FrameworkCargosException;
	
	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO resultadoObtenerCargos) throws ManCusBilException;
	
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws ManCusBilException;
	 
}
