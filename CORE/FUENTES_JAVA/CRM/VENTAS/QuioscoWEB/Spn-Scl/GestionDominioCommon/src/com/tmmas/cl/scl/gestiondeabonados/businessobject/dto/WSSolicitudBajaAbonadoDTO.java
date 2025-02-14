package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WSSolicitudBajaAbonadoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private String numCelular;
    private String codCausaBaja;
	private String idUsuario;
	private String codVendedor;
	private String codOficina;
	private String codTipComis;	
    private String tieneGarantia;
    private String fechaVencOoss;
    private String codMod;
    private String comentario;
    
    
	public String getCodCausaBaja() {
		return codCausaBaja;
	}
	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}
/*	public Long getCodigoError() {
		return codigoError;
	}
	public void setCodigoError(Long codigoError) {
		this.codigoError = codigoError;
	}*/
	public String getCodMod() {
		return codMod;
	}
	public void setCodMod(String codMod) {
		this.codMod = codMod;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}	
	public String getCodTipComis() {
		return codTipComis;
	}
	public void setCodTipComis(String codTipComis) {
		this.codTipComis = codTipComis;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	/*public String getDescripcionError() {
		return descripcionError;
	}
	public void setDescripcionError(String descripcionError) {
		this.descripcionError = descripcionError;
	}*/
	public String getFechaVencOoss() {
		return fechaVencOoss;
	}
	public void setFechaVencOoss(String fechaVencOoss) {
		this.fechaVencOoss = fechaVencOoss;
	}
	public String getIdUsuario() {
		return idUsuario;
	}
	public void setIdUsuario(String idUsuario) {
		this.idUsuario = idUsuario;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}	
	public String getTieneGarantia() {
		return tieneGarantia;
	}
	public void setTieneGarantia(String tieneGarantia) {
		this.tieneGarantia = tieneGarantia;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
}
