package com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;



public class ParamMantencionFrecuentesDTO extends OrdenServicioBaseDTO implements Serializable {


	private static final long serialVersionUID = 1L;
	
	private NumeroListDTO numeroListAdd;
	private NumeroListDTO numeroListDel;
	public NumeroListDTO getNumeroListAdd() {
		return numeroListAdd;
	}
	public void setNumeroListAdd(NumeroListDTO numeroListAdd) {
		this.numeroListAdd = numeroListAdd;
	}
	public NumeroListDTO getNumeroListDel() {
		return numeroListDel;
	}
	public void setNumeroListDel(NumeroListDTO numeroListDel) {
		this.numeroListDel = numeroListDel;
	}


}
