package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosComercialesVendExtDTO extends ConceptoVenta implements Serializable 
{
	
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	ConceptoVenta conceptos[];
	
    
    public ParametrosComercialesVendExtDTO(int codigo, String descripcion) 
	{
		super(codigo, descripcion);
	}
	
	public ConceptoVenta[] getConceptos() {
		return conceptos;
	}


	public void setConceptos(ConceptoVenta[] conceptos) {
		this.conceptos = conceptos;
	}


	

}
