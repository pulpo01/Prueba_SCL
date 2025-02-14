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

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.BitacoraDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.CargosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ImpuestosDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosEjecucionFacturacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.base.TareasRegistroCargos;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;

public interface ProcesadorCargosInterfaz {
	public void calcularCargos(ReglaListaPrecio[] reglasNegocio) throws FrameworkCargosException, ProductDomainException;
	public CargosDTO[] obtenerCargos() throws FrameworkCargosException;
	public void agruparCargos() throws FrameworkCargosException;
	public void registrarCargos(TareasRegistroCargos[] tareas) throws FrameworkCargosException, GeneralException;
	public void ejecutarFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws FrameworkCargosException;
	public void cancelarFacturacion() throws FrameworkCargosException;
	public ImpuestosDTO obtenerImpuestos() throws FrameworkCargosException;
	public void reconfigurarProcesosFacturacion() throws FrameworkCargosException;
	public BitacoraDTO obtenerBitacora() throws CustomerDomainException;
	
	
}
