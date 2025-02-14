package com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.interfaces;

import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.exception.ProductOfferingPriceException;

public interface GestionCargosSrvIF 
{
  public CargoListDTO  obtenerDescuentos(CargoListDTO cargoList) throws ProductOfferingException, ProductOfferingPriceException;
  public CargoListDTO  obtenerCargosProductos(ProductoOfertadoListDTO prodOfeProdList) throws ProductOfferingException, ProductOfferingPriceException;
}
