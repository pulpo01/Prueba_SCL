package com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo;

import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;

public class XMLDefaultWrapper {
	private XMLDefault xmlDefault;
	private int esVisibleControl; 
	private DefaultPaginaCPUDTO definicionPagina;
	
	
	public void setEsVisibleControl(int esVisibleControl) {
		this.esVisibleControl = esVisibleControl;
	}

	public XMLDefault getXmlDefault() {
		return xmlDefault;
	}

	public void setXmlDefault(XMLDefault xmlDefault) {
		
		this.xmlDefault = xmlDefault;
	}

	public DefaultPaginaCPUDTO getDefinicionPagina() {
		return definicionPagina;
	}

	public void setDefinicionPagina(DefaultPaginaCPUDTO definicionPagina) {
		this.definicionPagina = definicionPagina;
		
	}

	

		
	

}
