/**
 * Copyright � 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11-07-2007     			 Cristian Toledo              		Versi�n Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public interface EspecificacionProductoDAOIT 
{
	public ProductoOfertadoDTO obtenerEspecificacionProducto(ProductoOfertadoDTO prodOfertado) throws ProductSpecificationException;
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws ProductSpecificationException;
	public ProductoOfertadoListDTO obtenerEspecificacionLista(ProductoOfertadoListDTO prodOfertadoList) throws ProductSpecificationException;	
	
}
