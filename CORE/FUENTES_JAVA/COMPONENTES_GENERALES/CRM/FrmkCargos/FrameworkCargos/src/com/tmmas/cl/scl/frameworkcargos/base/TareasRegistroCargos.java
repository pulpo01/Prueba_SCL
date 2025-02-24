/**
 * Copyright � 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal informaci�n y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/04/2007     H�ctor Hermosilla      					Versi�n Inicial
 */
package com.tmmas.cl.scl.frameworkcargos.base;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ConfiguradorTareasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrebillingDTO;

//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ConfiguradorTareasDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrebillingDTO;

public abstract class TareasRegistroCargos {
	public TareasRegistroCargos(ConfiguradorTareasDTO parametros){
	}
	abstract public boolean validaciones();
	abstract public boolean esPrebilling();
	abstract public void tarea();
	abstract public void tarea(PrebillingDTO prebillingDTO);
	
}
