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
 * 11-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.AprovisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.BajaAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaPlanTarifDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.GestorCorpDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.LimiteConsumoDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ListaActivaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.MovAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public interface EspecificacionProvisionamientoDAOIT 
{
	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espSerCliList) throws ServiceSpecEntitiesException;
	
	public RetornoDTO consultaPrepago(ConsultaPrepagosDTO consulta) throws ServiceSpecEntitiesException;
	
	public RetornoDTO registraProrrateo() throws ServiceSpecEntitiesException;
	
	public ParametroDTO obtieneAtlantida(ClienteDTO cliente) throws ServiceSpecEntitiesException;
	
	public RetornoDTO validaBajaAtlantida(BajaAtlantidaDTO param) throws ServiceSpecEntitiesException;
	
	public GestorCorpDTO validaGestorCorp(GestorCorpDTO param) throws ServiceSpecEntitiesException;
	
	public RetornoDTO aprovisionamiento(AprovisionamientoDTO param) throws ServiceSpecEntitiesException;
	
	public RetornoDTO actualizarLimiteConsumo(LimiteConsumoDTO param) throws ServiceSpecEntitiesException;	
	
	public SaldoDTO consultaSaldo(SaldoDTO consulta) throws ServiceSpecEntitiesException;	
	
	public PlanTarifarioDTO consultaPlanActual(ConsultaPlanTarifDTO consulta) throws ServiceSpecEntitiesException;
	
	public ListaActivaListDTO consultaListaActivas(ConsultaPlanTarifDTO consulta) throws ServiceSpecEntitiesException;
	
	public RetornoDTO obtenerPlanAtlantida(AbonadoDTO abonado) throws ServiceSpecEntitiesException;	
	
	public RetornoDTO insertaMovAtl(MovAtlantidaDTO mov) throws ServiceSpecEntitiesException;
	
	public AbonadoDTO obtenerServContrato(AbonadoDTO abonado) throws ServiceSpecEntitiesException;
	
	public RetornoDTO registrarServContrato(AbonadoDTO abonado) throws ServiceSpecEntitiesException;
	
	public RetornoDTO generarMovimiento(ProductoContratadoListDTO listProductoContratado) throws ServiceSpecEntitiesException;
	
	public BodegaListDTO obtenerListaBodegas(ConsultaBodegaDTO param) throws ServiceSpecEntitiesException;
}
