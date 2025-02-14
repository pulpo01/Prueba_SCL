package com.tmmas.scl.framework.productDomain.dataTransferObject;

public class Carta10120DTO  extends CartaGeneralDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	private static final String NOMBRE_STRUCT = "GE_CARTA_10120_QT";
	

    private Long   num_abonado;
    private String Servicios;
	private String referencia = "ACTIVACION/DESACTIVACION SERVICIOS SUPLEMENTARIOS";
	
	
	
	public String getNombreStruct() {
		return NOMBRE_STRUCT;
	}

	public Object[] toStruct() {
		Object[] obj={	getCodOOSS(),
				getTexCarta(),
				referencia,
			 };
		return obj;
	}

	public Long getNum_abonado() {
		return num_abonado;
	}

	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}

	public String getReferencia() {
		return referencia;
	}

	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}

	public String getServicios() {
		return Servicios;
	}

	public void setServicios(String servicios) {
		Servicios = servicios;
	}

}
