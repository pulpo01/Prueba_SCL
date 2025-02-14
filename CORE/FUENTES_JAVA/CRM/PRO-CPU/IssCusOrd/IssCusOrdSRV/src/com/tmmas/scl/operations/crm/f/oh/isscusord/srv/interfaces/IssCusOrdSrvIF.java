package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloFactDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.FinCicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ListaFrecuentesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ReordenamientoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.TraspasoPlanDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.AprovisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BajaAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.GestorCorpDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;

public interface IssCusOrdSrvIF {

	public RetornoDTO actualizarCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws IssCusOrdException;
	
	public RetornoDTO eliminaFinCiclo(FinCicloDTO finCiclo) throws IssCusOrdException;
	
	public RetornoDTO registroHistoricoPlan(CicloFactDTO ciclo) throws IssCusOrdException;	
	
	public RetornoDTO validaDesacListaFrecuente(ListaFrecuentesDTO lista) throws IssCusOrdException;
	
	public RetornoDTO registraTraspasoPlan(TraspasoPlanDTO traspaso) throws IssCusOrdException;
	
	public RetornoDTO actualizaIntarcelAcciones(IntarcelDTO intarcel) throws IssCusOrdException;
	
	public RetornoDTO registraElimActIntarcel(IntarcelDTO intarcel) throws IssCusOrdException;
	
	public RetornoDTO actualizaSituaAbo(AbonadoDTO abonado) throws IssCusOrdException;
	
	public RetornoDTO registraReordenamientoPlan(ReordenamientoDTO datos) throws IssCusOrdException;
	
	public RetornoDTO registraProrrateo() throws IssCusOrdException;
	
	public ParametroDTO obtieneAtlantida(ClienteDTO cliente) throws IssCusOrdException;
	
	public RetornoDTO validaBajaAtlantida(BajaAtlantidaDTO param) throws IssCusOrdException;
	
	public GestorCorpDTO validaGestorCorp(GestorCorpDTO param) throws IssCusOrdException;
	
	public RetornoDTO aprovisionamiento(AprovisionamientoDTO param) throws IssCusOrdException;
	
}
