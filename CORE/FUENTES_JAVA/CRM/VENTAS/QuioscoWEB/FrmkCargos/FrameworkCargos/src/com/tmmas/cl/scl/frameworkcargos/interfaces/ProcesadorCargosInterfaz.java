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

package com.tmmas.cl.scl.frameworkcargos.interfaces;

//import com.tmmas.cl.scl.crmcommon.commonapp.dto.BitacoraDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargosDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosEjecucionFacturacionDTO;
//import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.BitacoraDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;

public interface ProcesadorCargosInterfaz {
	public void calcularCargos(ReglaListaPrecio[] reglasNegocio) throws FrameworkCargosException, GeneralException;
	public CargosDTO[] obtenerCargos() throws FrameworkCargosException;
	public void agruparCargos() throws FrameworkCargosException;
	public void registrarCargos(TareasRegistroCargos[] tareas) throws FrameworkCargosException;
	public void ejecutarFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws FrameworkCargosException;
	public void cancelarFacturacion() throws FrameworkCargosException;
	public ImpuestosDTO obtenerImpuestos() throws FrameworkCargosException;
	public void reconfigurarProcesosFacturacion() throws FrameworkCargosException;
	//public BitacoraDTO obtenerBitacora() throws CustomerDomainException;
	public BitacoraDTO obtenerBitacora() throws CustomerException;
	
}
