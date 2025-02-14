/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dao.BodegaDAO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class Bodega extends ProductComponent{
	
	private BodegaDAO bodegaDAO  = new BodegaDAO();
	private static Category cat = Category.getInstance(Bodega.class);
	Global global = Global.getInstance();
	

	public BodegaDTO[] getBodegas(BodegaDTO entrada)
		throws ProductDomainException
	{
		cat.debug("Inicio:getArticulo()");
		BodegaDTO[] resultado = bodegaDAO.getBodegas(entrada); 
		cat.debug("Fin:getArticulo()");
		return resultado;
	}//fin getArticulo

	
	
}//fin class Bodega
