package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;


import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroVentaDTO;

public interface RegistroVentaDAOIT {
	
	public RegistroVentaDTO getSecuenciaPaquete(RegistroVentaDTO parametroEntrada) throws CustomerBillException;
	
	public RegistroVentaDTO getSecuenciaTransacabo(RegistroVentaDTO parametroEntrada) throws CustomerBillException;
	
	public String getCodPlazaCliente(Long CodCliente)throws CustomerBillException;
	
	public String getCodPlazaOficina(String CodOficina)throws CustomerBillException;
	
	public void updateVentasEscenarioB(GaVentasDTO gaVentasDTO)throws CustomerBillException;
	
	public void updateVentasEscenarioC(GaVentasDTO gaVentasDTO)throws CustomerBillException;
	
	public void updateVentasEscenarioD(GaVentasDTO gaVentasDTO)throws CustomerBillException;
	
	public void updateVentasEscenarioA(GaVentasDTO gaVentasDTO)throws CustomerBillException;
	
	public void updateVenta(GaVentasDTO gaVentasDTO)throws CustomerBillException;
	
	public void desreservaCelular(GaVentasDTO entrada) throws CustomerBillException;
}
