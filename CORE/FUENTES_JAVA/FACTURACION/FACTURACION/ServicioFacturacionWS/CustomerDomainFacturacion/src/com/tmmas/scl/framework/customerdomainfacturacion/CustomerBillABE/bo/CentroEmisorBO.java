package com.tmmas.scl.framework.customerdomainfacturacion.CustomerBillABE.bo;

import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerBillABE.bo.Interface.CentroEmisorBOIT;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerBillABE.dao.CentroEmisorDAO;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerBillABE.dao.Interface.CentroEmisorDAOIT;

public class CentroEmisorBO implements CentroEmisorBOIT {
	public String obtenerCentroEmisor(String codOficina, String codTipoDocto)
			throws RateUsageRecordsException {
		CentroEmisorDAOIT centroEmisorDAO = new CentroEmisorDAO();
		return centroEmisorDAO.obtenerCentroEmisor(codOficina, codTipoDocto);

	}
}
