package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;


public class ParamMantencionProductoDTO extends OrdenServicioBaseDTO implements Serializable {


	private static final long serialVersionUID = 1L;
	
	//private ProductoOfertadoListDTO prodOfertList;
	private OfertaComercialDTO ofertaComercial;
	private ProductoContratadoListDTO prodContList;
	private ProductoContratadoListDTO listaProdContraMantenidosLC;
	
	public ProductoContratadoListDTO getListaProdContraMantenidosLC() {
		return listaProdContraMantenidosLC;
	}
	public void setListaProdContraMantenidosLC(
			ProductoContratadoListDTO listaProdContraMantenidosLC) {
		this.listaProdContraMantenidosLC = listaProdContraMantenidosLC;
	}
	public ProductoContratadoListDTO getProdContList() {
		return prodContList;
	}
	public void setProdContList(ProductoContratadoListDTO prodContList) {
		this.prodContList = prodContList;
	}
	public OfertaComercialDTO getOfertaComercial() {
		return ofertaComercial;
	}
	public void setOfertaComercial(OfertaComercialDTO ofertaComercial) {
		this.ofertaComercial = ofertaComercial;
	}


}
