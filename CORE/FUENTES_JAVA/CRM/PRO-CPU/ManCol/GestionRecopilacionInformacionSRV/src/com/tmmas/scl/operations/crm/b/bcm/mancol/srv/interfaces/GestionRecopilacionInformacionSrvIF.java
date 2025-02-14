package com.tmmas.scl.operations.crm.b.bcm.mancol.srv.interfaces;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.operations.crm.b.bcm.mancol.common.exception.ManColException;

public interface GestionRecopilacionInformacionSrvIF {

	public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws ManColException;
	
	public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws ManColException;
	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws ManColException;

	public int obtenerInfoAtl(CuentaPersonalDTO cuentaPersonalDTO)throws ManColException;
}
