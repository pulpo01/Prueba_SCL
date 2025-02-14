package com.tmmas.scl.framework.productDomain.dataTransferObject;

public class Carta10060DTO extends CartaGeneralDTO{
	private static final long serialVersionUID = 1L;
	private static final String NOMBRE_STRUCT = "GE_CARTA_10060_QT";
	
	private Long   num_celular;
    private Long   num_abonado;
	private String referencia = "AVISO SINIESTRO DE EQUIPO";
	
	
	
	public String getNombreStruct() {
		return NOMBRE_STRUCT;
	}

	public Object[] toStruct() {
		Object[] obj={	getCodOOSS(),
				getTexCarta(),
				num_celular,
				num_abonado,
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

	public Long getNum_celular() {
		return num_celular;
	}

	public void setNum_celular(Long num_celular) {
		this.num_celular = num_celular;
	}

	public String getReferencia() {
		return referencia;
	}

	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}


}
