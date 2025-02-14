package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ActParamComerInmDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CambioPlanComercialDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionRolUsuarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.PlanServicioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPlanTarifDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.LimiteConsumoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ListaActivaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.MovAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.SaldoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;

public interface GestionOrdenServiciosSrvIF {
	
	public RetornoDTO registroCambPlanComer(CambioPlanComercialDTO datos) throws IssCusOrdException;
	
	public RetornoDTO actualizarParamComerInm(ActParamComerInmDTO datos) throws IssCusOrdException;
	
	public RetornoDTO registroCambPlanServ(PlanServicioDTO plan) throws IssCusOrdException;
	
	public RetornoDTO actualizarLimiteConsumo(LimiteConsumoDTO param) throws IssCusOrdException;
	
	public RetornoDTO registraDesActSerFre(DesactServFreDTO param) throws IssCusOrdException;
	
	public RetornoDTO consultaPrepago(ConsultaPrepagosDTO consulta) throws IssCusOrdException;
	
	public SaldoDTO consultaSaldo(SaldoDTO consulta) throws IssCusOrdException;
	
	public PlanTarifarioDTO consultaPlanActual(ConsultaPlanTarifDTO consulta) throws IssCusOrdException;
	
	public ListaActivaListDTO consultaListaActivas(ConsultaPlanTarifDTO consulta) throws IssCusOrdException;
	
	public RetornoDTO obtenerPlanAtlantida(AbonadoDTO abonado) throws IssCusOrdException;
	
	public RetornoDTO insertaMovAtl(MovAtlantidaDTO mov) throws IssCusOrdException;	
	
	public AbonadoDTO obtenerServContrato(AbonadoDTO abonado) throws IssCusOrdException;
	
	public RetornoDTO registrarServContrato(AbonadoDTO abonado) throws IssCusOrdException;	
	
	public BodegaListDTO obtenerListaBodegas(ConsultaBodegaDTO param) throws IssCusOrdException;
	
	public RetornoDTO actualizarSituPerfil(AbonadoDTO abonado) throws IssCusOrdException;
	
	public IntarcelDTO obtenerFecDesdeCtaSeg(IntarcelDTO intarcel) throws IssCusOrdException;
	
	public CausaExcepcionListDTO obtenerCausaExcepcion() throws IssCusOrdException;
	
	public ObtencionRolUsuarioDTO obtenerRolUsuario(ObtencionRolUsuarioDTO obtRol) throws IssCusOrdException;
	
	public RetornoDTO actualizaGaIntarcelAccionesTo(IntarcelDTO intarcel) throws IssCusOrdException;//Inc 147444 HOM
	
}
