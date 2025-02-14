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

package com.tmmas.cl.scl.frameworkcargos.interfaces;

//import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioDTO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;


public interface ReglaInterfaz  {
	
	public boolean validacion() throws FrameworkCargosException;
	public PrecioDTO[] seleccionPrecios() throws FrameworkCargosException, GeneralException;
	public DescuentoDTO[] seleccionDescuentos() throws FrameworkCargosException;
	public ParametrosReglaDTO getAtributos() throws FrameworkCargosException;
}
