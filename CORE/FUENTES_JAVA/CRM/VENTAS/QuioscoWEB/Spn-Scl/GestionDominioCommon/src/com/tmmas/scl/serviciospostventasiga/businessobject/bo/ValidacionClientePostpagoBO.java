package com.tmmas.scl.serviciospostventasiga.businessobject.bo;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.businessobject.dao.ValidacionClientePostpagoDAO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ResultadoValidacionDatosMigracionDTO;

public class ValidacionClientePostpagoBO {
	
	private ValidacionClientePostpagoDAO validacionClientePostpagoDAO = new ValidacionClientePostpagoDAO();
	
	public ResultadoValidacionDatosMigracionDTO validacionSituacionAbonadoAAA(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException
	{
		ResultadoValidacionDatosMigracionDTO resultado = null;
		resultado=validacionClientePostpagoDAO.estadoAbonadoSituacionAAA(datosMigracionClienteDTO);

		if (resultado.getResultadoBase() == 0) {
			resultado.setResultadoNumeroCelular(true);
		} else {
			resultado.setResultadoNumeroCelular(false);
		}
		resultado.setResultadoBase(0);
		return resultado;
	}

	public ResultadoValidacionDatosMigracionDTO validacionEstadoClienteSinAbonados(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException
	{
		ResultadoValidacionDatosMigracionDTO resultado = null;
		resultado=validacionClientePostpagoDAO.estadoClienteSinAbonados(datosMigracionClienteDTO);
		if (resultado.getResultadoBase() > 0) {
			resultado.setResultadoCodCliente(true);
		} else {
			resultado.setResultadoCodCliente(false);
		}
		resultado.setResultadoBase(0);
		return resultado;
	}
	
	public ResultadoValidacionDatosMigracionDTO validacionEstadoPlanVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException
	{
		ResultadoValidacionDatosMigracionDTO resultado = null;
		resultado=validacionClientePostpagoDAO.estadoPlanVigente(datosMigracionClienteDTO);
		if (resultado.getResultadoBase() > 0) {
			resultado.setResultadoPlanTarifario(true);
		} else {
			resultado.setResultadoPlanTarifario(false);
		}
		resultado.setResultadoBase(0);
		return resultado;
	}
	
	public ResultadoValidacionDatosMigracionDTO obtenerEstadoPlanVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException
	{
		return validacionClientePostpagoDAO.getEstadoPlanVigente(datosMigracionClienteDTO);
	}
	
	public ResultadoValidacionDatosMigracionDTO validacionEstadoIMEIVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException
	{
		ResultadoValidacionDatosMigracionDTO resultado = null;
		resultado=validacionClientePostpagoDAO.estadoIMEIVigente(datosMigracionClienteDTO);
		if (resultado.getResultadoBase() == 1) {
			resultado.setResultadoIMEI(true);
		} else {
			resultado.setResultadoIMEI(false);
		}
		resultado.setResultadoBase(0);
		return resultado;
	}
	
	public ResultadoValidacionDatosMigracionDTO validacionEstadoVendedorVigente(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException
	{
		ResultadoValidacionDatosMigracionDTO resultado = null;
		resultado=validacionClientePostpagoDAO.estadoVendedorVigente(datosMigracionClienteDTO);
		if (resultado.getResultadoBase() == 1) {
			resultado.setResultadoVendedor(true);
		} else if (resultado.getResultadoBase() == 0) {
			resultado.setResultadoVendedor(false);
		}
		resultado.setResultadoBase(0);
		return resultado;
	}
	
	public ResultadoValidacionDatosMigracionDTO validacionEstadoDatosExistentes(MigracionDTO datosMigracionClienteDTO)
	throws GeneralException
	{
		ResultadoValidacionDatosMigracionDTO resultado = null;
		resultado=validacionClientePostpagoDAO.estadoDatosExistentes(datosMigracionClienteDTO);
		if(resultado.getResultadoBase() == 1){
			resultado.setResultadoVariablesExistentes(true);
		} else if (resultado.getResultadoBase() == 0){
			resultado.setResultadoVariablesExistentes(false);
		}
		resultado.setResultadoBase(0);
		return resultado;
	}

}
