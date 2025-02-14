package com.tmmas.cl.scl.spnsclorq.negocio.ejb.helper.validation;


import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;
import com.tmmas.scl.serviciospostventasiga.common.utils.Validaciones;

public class ComprobacionDatosObligatorios {


	
	
	public void validar(MigracionDTO datosMigracionClienteDTO) throws GeneralException
	{

		Validaciones.check(Validaciones.esLongValido(datosMigracionClienteDTO.getNumCelular(), false, 15),"NumCelular");
		Validaciones.check(Validaciones.esLongValido(datosMigracionClienteDTO.getCodCliente(), false, 8),"CodCliente");
		Validaciones.check(Validaciones.esStringValido(datosMigracionClienteDTO.getCodPlanTarif(), false, 3),"CodPlanTarif");
		
		if("E".equals(datosMigracionClienteDTO.getIndProcEqTerminal()))
		Validaciones.check(Validaciones.esStringValido(datosMigracionClienteDTO.getImei(), false, 25),"Imei");
		
		
		Validaciones.check(Validaciones.esStringValido(datosMigracionClienteDTO.getNomUsuarioVendedor(), false, 30),"NomUsuarioVendedor");
		Validaciones.check(Validaciones.esStringValido(datosMigracionClienteDTO.getIndProcEqTerminal(), false, 2),"IndProcEqTerminal");
		Validaciones.check(Validaciones.esStringValido(datosMigracionClienteDTO.getCodOficina(), false, 2),"codOficina");


	
	}
}
