package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class AperturaRangoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/*	EN_cod_vendedor IN Number(6),
	EV_num_simcard  IN Varchar2(25),
	EN_mdn          IN Number(14),
	EN_cod_uso      IN Number(2),
	SN_cod_retorno   OUT Number(6),
	SV_mens_retorno  OUT Varchar2(3000),
	SN_num_evento    OUT Number(9)
	)
	*/
	
	private AperturaSimMdnDTO[] SimMdn;
	
	private long codVendedor;	
	private String codUso;
	private String IdentificadorTransaccion;
	
		
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getIdentificadorTransaccion() {
		return IdentificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		IdentificadorTransaccion = identificadorTransaccion;
	}
	/*public AperturaSimMdnDTO[] getSimMdn() {
		return SimMdn;
	}
	public void setSimMdn(AperturaSimMdnDTO[] simMdn) {
		SimMdn = simMdn;
	}*/
	public AperturaSimMdnDTO[] getSimMdn() {
		return SimMdn;
	}
	public void setSimMdn(AperturaSimMdnDTO[] simMdn) {
		SimMdn = simMdn;
	}
	

}
