package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.sql.Timestamp;

public class AbonadoBeneficiarioDTO extends AbonadoDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String tipo_Comportamiento;
	private Timestamp fec_Inicio_Vigencia;
	private long num_Abonado_Beneficiario;
	private Timestamp fec_Termino_Vigencia;
	private int ejecutarBenef=0;
	
	public AbonadoBeneficiarioDTO()
	{	
		tipo_Comportamiento=null;
		fec_Inicio_Vigencia=null;								
		fec_Termino_Vigencia=null;		
		this.setNombre(null);
	}	
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
	public long getNum_Abonado_Beneficiario() {
		return num_Abonado_Beneficiario;
	}
	public void setNum_Abonado_Beneficiario(long num_Abonado_Beneficiario) {
		this.num_Abonado_Beneficiario = num_Abonado_Beneficiario;
	}
	public String getTipo_Comportamiento() {
		return tipo_Comportamiento;
	}
	public void setTipo_Comportamiento(String tipo_Comportamiento) {
		this.tipo_Comportamiento = tipo_Comportamiento;
	}	
	
	public int getEjecutarBenef() {
		return ejecutarBenef;
	}
	public void setEjecutarBenef(int ejecutarBenef) {
		this.ejecutarBenef = ejecutarBenef;
	}
	public Object[] toStruct_SV_LISTA_ABONADO_BENEFICIARIO_TO_QT()
	{			
		Object[] obj={	String.valueOf(this.getCodCliente()),
						String.valueOf(this.getNumAbonado()),
						tipo_Comportamiento,
						fec_Inicio_Vigencia,
						String.valueOf(this.num_Abonado_Beneficiario),						
						fec_Termino_Vigencia,
						String.valueOf(this.getNumCelular()),
						this.getNombre()
					 };
		
		return obj;
	}
	
	public Object[] toStruct_CU_BENEF_PROD_QT()
	{			
		Object[] obj={	String.valueOf(this.getCodCliente()),
						String.valueOf(this.getNumAbonado()),
						tipo_Comportamiento,
						fec_Inicio_Vigencia,
						String.valueOf(this.num_Abonado_Beneficiario),						
						fec_Termino_Vigencia,
						String.valueOf(this.getNumCelular()),
						this.getNombre()
					 };
		
		return obj;
	}

}
