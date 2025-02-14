package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;

public class ContenedorPlanesAdicionalesDTO implements Serializable 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ProductoContratadoListDTO listaProductosDescontratar;
	private OfertaComercialDTO	ofComercialContratar;
	private AbonadoBeneficiarioListDTO abonadosADesbenificiar;
	//private AbonadoVetadoListDTO sdsd; **pendiente**
	
	public AbonadoBeneficiarioListDTO getAbonadosADesbenificiar() {
		return abonadosADesbenificiar;
	}
	public void setAbonadosADesbenificiar(
			AbonadoBeneficiarioListDTO abonadosADesbenificiar) {
		this.abonadosADesbenificiar = abonadosADesbenificiar;
	}
	public ProductoContratadoListDTO getListaProductosDescontratar() {
		return listaProductosDescontratar;
	}
	public void setListaProductosDescontratar(
			ProductoContratadoListDTO listaProductosDescontratar) {
		this.listaProductosDescontratar = listaProductosDescontratar;
	}
	public OfertaComercialDTO getOfComercialContratar() {
		return ofComercialContratar;
	}
	public void setOfComercialContratar(OfertaComercialDTO ofComercialContratar) {
		this.ofComercialContratar = ofComercialContratar;
	}	
}
