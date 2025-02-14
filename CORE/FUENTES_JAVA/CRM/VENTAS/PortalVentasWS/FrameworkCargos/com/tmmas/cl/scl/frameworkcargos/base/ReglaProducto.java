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
 * 04/04/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.frameworkcargos.base;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.frameworkcargos.interfaces.ReglaInterfaz;

public abstract class ReglaProducto implements ReglaInterfaz{
	
	public ReglaProducto(ParametrosReglaDTO parametro){
	}
	abstract public ProductDTO productoAsociado();
	abstract public void agregarProducto(ProductDTO producto);
	
	

}
