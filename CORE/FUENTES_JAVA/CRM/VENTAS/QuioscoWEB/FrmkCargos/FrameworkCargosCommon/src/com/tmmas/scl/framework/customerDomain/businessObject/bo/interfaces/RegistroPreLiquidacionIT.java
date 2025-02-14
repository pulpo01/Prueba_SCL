package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import java.util.ArrayList;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroDetPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;


public interface RegistroPreLiquidacionIT {
	
	public void actualizaMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)throws CustomerBillException;
	
	public ArrayList getMercaderiaEnConsignacion(RegistroPreliquidacionDTO preliquidacion) throws CustomerBillException;
	
	public void registraDetallePreliquidacion (RegistroDetPreliquidacionDTO detpreliquidacion,RegistroPreliquidacionDTO cabpreliquidacion) throws CustomerBillException;
	
	public void registraMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion) throws CustomerBillException;
	
	
		
}
