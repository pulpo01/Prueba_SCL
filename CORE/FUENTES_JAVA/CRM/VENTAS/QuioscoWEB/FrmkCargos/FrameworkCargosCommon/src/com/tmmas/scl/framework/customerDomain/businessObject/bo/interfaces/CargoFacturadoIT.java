/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 29-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;

public interface CargoFacturadoIT 
{
	public RetornoDTO informar(CargoOcasionalListDTO cargoOcacional) throws CustomerBillException;
	public RetornoDTO informar(CargoRecurrenteListDTO cargoRecurrente) throws CustomerBillException;
	public RetornoDTO eliminar(ProductoContratadoListDTO listProductosContratados) throws CustomerBillException;
	public RetornoDTO desactivar(ProductoContratadoListDTO listProductosContratados) throws CustomerBillException;
	
}
