package com.tmmas.scl.framework.customerDomain.dao.interfaces;

import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public interface VendedorDAOIT {

	public VendedorDTO obtenerEstadoVendedor(VendedorDTO Vendedor) throws CustomerException;
	public void bloquearVendedor(VendedorDTO Vendedor) throws CustomerException;
	public void desbloquearVendedor(VendedorDTO Vendedor)throws CustomerException;
	public void validaVendedorbodega(VendedorDTO vendedor, SesionDTO sesion, BodegaDTO bodega) throws CustomerException;		
}
