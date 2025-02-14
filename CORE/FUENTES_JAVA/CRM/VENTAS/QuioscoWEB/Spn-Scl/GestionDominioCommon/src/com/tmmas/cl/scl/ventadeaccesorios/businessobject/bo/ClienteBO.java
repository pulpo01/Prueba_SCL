package com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao.ClienteDAO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.DatosClienteDTO;

public class ClienteBO {
	
	ClienteDAO clienteDAO = new ClienteDAO();
	private static Category cat = Category.getInstance(ClienteBO.class);	
	
	public DatosClienteDTO clientePorNumeroCelular (long numeroCelular)throws GeneralException{
		DatosClienteDTO datosClienteDTO = new DatosClienteDTO();
		cat.debug("Inicio:clientePorNumeroCelular()");
		datosClienteDTO = clienteDAO.clientePorNumeroCelular(numeroCelular);
		cat.debug("Inicio:clientePorNumeroCelular()");
		return datosClienteDTO;
	}
	
public IdentificadorCivilDTO[] getTiposIdentificacion()throws GeneralException{		
		
		cat.info("getTiposIdentificación():Inicio");
		return clienteDAO.getTiposIdentificacion();
}

}
