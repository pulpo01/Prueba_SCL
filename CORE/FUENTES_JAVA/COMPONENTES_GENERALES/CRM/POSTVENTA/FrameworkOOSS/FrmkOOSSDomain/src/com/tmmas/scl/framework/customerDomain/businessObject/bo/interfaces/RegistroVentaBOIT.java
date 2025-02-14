package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;


import com.tmmas.scl.framework.customerDomain.dataTransferObject.CelularDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosRegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;

public interface RegistroVentaBOIT {

	public RegistroVentaDTO existePlanFreedomEnVenta(ParametrosRegistroCargosDTO parametrosCargos,ParametrosGeneralesDTO parametroProporVta,ParametrosGeneralesDTO parametroProporc1,ParametrosGeneralesDTO parametroProporc2)
	throws CustomerBillException;
	
	public Long getCodPlazaCliente(Long CodCliente)throws CustomerBillException;
	
	public Long getCodPlazaOficina(Long CodOficina)throws CustomerBillException;
	
	public CelularDTO getNumeroCelularAut(CelularDTO celular)throws CustomerBillException;
	
	public String getNumUnidades(String numVentas)throws CustomerBillException;
	
	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada)throws CustomerBillException;
	
	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada)throws CustomerBillException;
	
	public RegistroVentaDTO getSecuenciaVenta(RegistroVentaDTO parametroEntrada)throws CustomerBillException;
	
	public CelularDTO setReservaNumeroCelular(CelularDTO celular)throws CustomerBillException;
	
	
}
