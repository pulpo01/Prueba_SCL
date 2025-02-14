package com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;

public interface GestionCuentaSrvIF {

	public ClienteTipoPlanListDTO obtenerDatosClienteCuenta(ClienteDTO cliente) throws ManConException;	
	
	public SubCuentaListDTO obtenerSubCuentas(ClienteDTO cliente) throws ManConException;
	
	public RetornoDTO crearSubCuenta(SubCuentaDTO cuenta) throws ManConException;

	public int obtenerInfoPer(CuentaPersonalDTO cuentaPersonalDTO)throws ManConException;
	
	public int validaPersonal(CuentaPersonalDTO cuentaPersonalDTO)throws ManConException;
	
	public Long obtenerNumClientesCuenta(ClienteDTO cliente)throws ManConException;
	
	public ClienteListDTO listarClientesCuenta(ClienteDTO cliente)throws ManConException;

}
