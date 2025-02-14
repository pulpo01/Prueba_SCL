
package com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.bo.Interface;

import com.tmmas.scl.framework.CustomerDomain.CustomerABE.dto.ClienteDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;

public interface ClienteBOIT {
	public ClienteDTO obtenerDatosCliente(String codCliente,String fechaActual)
			throws RateUsageRecordsException;

}
