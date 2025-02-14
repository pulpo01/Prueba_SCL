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
 * 17/10/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CambioPlanComercialDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ListaFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TraspasoPlanDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface SCLProductoContratadoDAOIT 
{
	public CausaBajaListDTO obtenerCausaBaja() throws ProductException;
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws ProductException;
	public RetornoDTO validaCuentaPersonal(CuentaPersonalDTO cuenta) throws ProductException;
	public RetornoDTO registraTraspasoPlan(TraspasoPlanDTO traspaso) throws ProductException;
	public RetornoDTO validaDesacListaFrecuente(ListaFrecuentesDTO lista) throws ProductException;
	public RetornoDTO registroCambPlanServ(PlanServicioDTO plan) throws ProductException;
	public RetornoDTO registraReordenamientoPlan(ReordenamientoDTO datos) throws ProductException;
	public RetornoDTO registroCambPlanComer(CambioPlanComercialDTO datos) throws ProductException;
	public RetornoDTO registraDesActSerFre(DesactServFreDTO param) throws ProductException;
	
}
