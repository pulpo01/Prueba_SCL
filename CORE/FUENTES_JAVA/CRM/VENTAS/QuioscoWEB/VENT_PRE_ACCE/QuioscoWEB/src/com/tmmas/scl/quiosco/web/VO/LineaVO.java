package com.tmmas.scl.quiosco.web.VO;

public class LineaVO {
	
	private String codigoSim;
	private String simcard;
	private String celular;
	private String descripcionSim;
	private String precioSim;
	private String codigoImei;
	private String imei;
	private String descripcionImei;
	private String precioImei;
	private String total;
	private String itbm;
	private String isc;
	private String idLinea;
	private Boolean esOcupada = new Boolean(false);
	private String numKit;
	
	public String getNumKit() {
		return numKit;
	}
	public void setNumKit(String numKit) {
		this.numKit = numKit;
	}
	public String getCodigoSim() {
		return codigoSim;
	}
	public void setCodigoSim(String codigoSim) {
		this.codigoSim = codigoSim;
	}
	public String getSimcard() {
		return simcard;
	}
	public void setSimcard(String simcard) {
		this.simcard = simcard;
	}
	public String getCelular() {
		return celular;
	}
	public void setCelular(String celular) {
		this.celular = celular;
	}
	public String getDescripcionSim() {
		return descripcionSim;
	}
	public void setDescripcionSim(String descripcionSim) {
		this.descripcionSim = descripcionSim;
	}
	public String getPrecioSim() {
		return precioSim;
	}
	public void setPrecioSim(String precioSim) {
		this.precioSim = precioSim;
	}
	public String getCodigoImei() {
		return codigoImei;
	}
	public void setCodigoImei(String codigoImei) {
		this.codigoImei = codigoImei;
	}
	public String getImei() {
		return imei;
	}
	public void setImei(String imei) {
		this.imei = imei;
	}
	public String getDescripcionImei() {
		return descripcionImei;
	}
	public void setDescripcionImei(String descripcionImei) {
		this.descripcionImei = descripcionImei;
	}
	public String getPrecioImei() {
		return precioImei;
	}
	public void setPrecioImei(String precioImei) {
		this.precioImei = precioImei;
	}
	public String getTotal() {
		return total;
	}
	public void setTotal(String total) {
		this.total = total;
	}
	public String getIdLinea() {
		return idLinea;
	}
	public void setIdLinea(String idLinea) {
		this.idLinea = idLinea;
	}
	public Boolean getEsOcupada() {
		return esOcupada;
	}
	public void setEsOcupada(Boolean esOcupada) {
		this.esOcupada = esOcupada;
	}
	public String getItbm() {
		return itbm;
	}
	public void setItbm(String itbm) {
		this.itbm = itbm;
	}
	public String getIsc() {
		return isc;
	}
	public void setIsc(String isc) {
		this.isc = isc;
	}
	
	

}
