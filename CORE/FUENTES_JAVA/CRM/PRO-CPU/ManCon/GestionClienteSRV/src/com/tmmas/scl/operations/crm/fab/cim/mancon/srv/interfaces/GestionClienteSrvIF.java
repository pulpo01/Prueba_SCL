package com.tmmas.scl.operations.crm.fab.cim.mancon.srv.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.IntegracionInClasificacionDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.PlanEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;

public interface GestionClienteSrvIF {

	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws ManConException;	
	
	public ClienteListDTO buscarCliente(NumeroDTO numero) throws ManConException;
	
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws ManConException;
	
	public ClienteDTO buscarDatosClientePorVenta(VentaDTO venta) throws ManConException;

	public int validaAtlantidaCliente(ClienteDTO cliente) throws ManConException ;

	public int validaAtlantida(AbonadoDTO abonado)throws ManConException;
	
	public ClienteDTO obtenerCliente(CuentaPersonalDTO cuentaPersonalDTO)throws ManConException;
	
	public ClienteDTO obtenerNumAbonadosCliente(ClienteDTO cliente) throws ManConException;
	
	public RetornoDTO actualizarLineasPorPlan(PlanEvaluacionRiesgoDTO planEval) throws ManConException;
	
	public DatosClienteDTO obtenerDatosAdicCliente(Long codCliente) throws ManConException;

	public IntegracionInClasificacionDTO consultaClasificacionCliente(IntegracionInClasificacionDTO integracionInClasificacionDTO) throws ManConException;
	
	public ClienteDTO getCliente(ClienteDTO cliente) throws ManConException;
	
}
