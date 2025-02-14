package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class LstConceptoFacturaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private ConceptoFacturasDTO[] listadoConcFactura;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public ConceptoFacturasDTO[] getListadoConcFactura() {
		return listadoConcFactura;
	}
	public void setListadoConcFactura(ConceptoFacturasDTO[] listadoConcFactura) {
		this.listadoConcFactura = listadoConcFactura;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
		
}
