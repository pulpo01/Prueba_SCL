package com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.bo;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.framework.CustomerDomain.CustomerABE.dto.ClienteDTO;
import com.tmmas.scl.framework.CustomerDomain.exception.RateUsageRecordsException;
import com.tmmas.scl.framework.Sistema.bo.UsuarioBO;
import com.tmmas.scl.framework.Sistema.dao.ConfiguracionSistemaDAO;
import com.tmmas.scl.framework.Sistema.dao.Interface.ConfiguracionSistemaDAOIT;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.bo.Interface.ClienteBOIT;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.dao.ClienteDAO;
import com.tmmas.scl.framework.customerdomainfacturacion.CustomerABE.dao.Interface.ClienteDAOIT;

public class ClienteBO implements ClienteBOIT {

	private static Logger logger = Logger.getLogger(ClienteBO.class);

	private CompositeConfiguration config;

	public ClienteBO() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}

	public ClienteDTO obtenerDatosCliente(String codCliente,
			String fechaActual) throws RateUsageRecordsException {
		logger.debug("obtenerDatosCliente():start");
		ClienteDAOIT clienteDAO = new ClienteDAO();
		logger.debug("obtenerDatosCliente():end");		
		return clienteDAO.obtenerDatosCliente( codCliente, fechaActual);
		

	}

}
