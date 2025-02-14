package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

public class ParamObtCargOOSSDTO {
	private static final long serialVersionUID = 1L;
	
	private String [] codAbonado;
	private long codClienteDestino;
	private String codPlanTarifDestino;
	private String sinCondicionesComerciales;
	private String codActAbo;
	private String tipoPantallaPrevia;
	
	public String getTipoPantallaPrevia() {
		return tipoPantallaPrevia;
	}
	public void setTipoPantallaPrevia(String tipoPantallaPrevia) {
		this.tipoPantallaPrevia = tipoPantallaPrevia;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public String[] getCodAbonado() {
		return codAbonado;
	}
	public void setCodAbonado(String[] codAbonado) {
		this.codAbonado = codAbonado;
	}
	public long getCodClienteDestino() {
		return codClienteDestino;
	}
	public void setCodClienteDestino(long codClienteDestino) {
		this.codClienteDestino = codClienteDestino;
	}
	public String getSinCondicionesComerciales() {
		return sinCondicionesComerciales;
	}
	public void setSinCondicionesComerciales(String sinCondicionesComerciales) {
		this.sinCondicionesComerciales = sinCondicionesComerciales;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	
}
