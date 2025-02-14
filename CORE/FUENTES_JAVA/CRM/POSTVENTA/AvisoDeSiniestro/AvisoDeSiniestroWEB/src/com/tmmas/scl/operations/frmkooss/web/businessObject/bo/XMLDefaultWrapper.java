package com.tmmas.scl.operations.frmkooss.web.businessObject.bo;

import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;

public class XMLDefaultWrapper {
	private XMLDefault xmlDefault;
	private int esVisibleControl; 
	private ValoresJSPPorDefectoDTO definicionPagina;
	
	
	public void setEsVisibleControl(int esVisibleControl) {
		this.esVisibleControl = esVisibleControl;
	}

	public XMLDefault getXmlDefault() {
		return xmlDefault;
	}

	public void setXmlDefault(XMLDefault xmlDefault) {
		
		this.xmlDefault = xmlDefault;
	}

	public ValoresJSPPorDefectoDTO getDefinicionPagina() {
		return definicionPagina;
	}

	public void setDefinicionPagina(ValoresJSPPorDefectoDTO definicionPagina) {
		this.definicionPagina = definicionPagina;
		
	}

	

		
	

}
