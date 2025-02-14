package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.sql.Timestamp;

public class AbonadoVetadoDTO extends AbonadoDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tipo_Comportamiento;
	private Timestamp fec_Inicio_Vigencia;
	private Timestamp fec_Termino_Vigencia;
	
	public Timestamp getFec_Inicio_Vigencia() {
		return fec_Inicio_Vigencia;
	}
	public void setFec_Inicio_Vigencia(Timestamp fec_Inicio_Vigencia) {
		this.fec_Inicio_Vigencia = fec_Inicio_Vigencia;
	}
	public Timestamp getFec_Termino_Vigencia() {
		return fec_Termino_Vigencia;
	}
	public void setFec_Termino_Vigencia(Timestamp fec_Termino_Vigencia) {
		this.fec_Termino_Vigencia = fec_Termino_Vigencia;
	}
	
	public String getTipo_Comportamiento() {
		return tipo_Comportamiento;
	}
	public void setTipo_Comportamiento(String tipo_Comportamiento) {
		this.tipo_Comportamiento = tipo_Comportamiento;
	}
	
	public Object[] toStruct_SV_LISTA_ABONADO_VETADO_TO_QT()
	{			
		Object[] obj={	String.valueOf(this.getCodCliente()),
						String.valueOf(this.getNumAbonado()),
						tipo_Comportamiento,
						fec_Inicio_Vigencia,
						String.valueOf(this.getNumAbonado()),						
						fec_Termino_Vigencia,
						String.valueOf(this.getNumCelular()),
						this.getNombre()
					 };
		
		return obj;
	}

}
