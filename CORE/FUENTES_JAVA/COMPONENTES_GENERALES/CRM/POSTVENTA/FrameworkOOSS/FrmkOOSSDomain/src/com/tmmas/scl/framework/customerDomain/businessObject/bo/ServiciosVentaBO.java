package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.ServiciosVentaDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.ServiciosVentaDAOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipoComisionistaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;



public class ServiciosVentaBO implements ServiciosVentaBOIT{
	
	private ServiciosVentaDAOIT serviciosVentaDAO  = new ServiciosVentaDAO();
	private final Logger logger = Logger.getLogger(ServiciosVentaBO.class);
	
	public TipoComisionistaDTO ObtieneComisPorVendedor(VendedorDTO vendedorDTO) throws CustomerBillException{
		TipoComisionistaDTO retValue = new TipoComisionistaDTO();
		logger.debug("Inicio:ObtieneComisPorVendedor()");
		retValue =serviciosVentaDAO.ObtieneComisPorVendedor(vendedorDTO); 
		logger.debug("Fin:ObtieneComisPorVendedor()");
		return retValue;
	}

}
