package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosCambioSerieDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numCelular;
	private String numSerieEquipo;
	private String numSerieSimcard;
	private long codVendedor;
	private String nomUsuario;
	private String codCentral;
	private float impCargo;
	private long codTipContrato;
	private String numContrato;
	private String numAnexo;
	private String codCausa;
	private String numTransBloqSerie;
	private String numTransBloqEquipo;
	private String flagBloqueoEquipoEx;
	private String codArticulo;
	private String usoVentaEquip;
	private String descrEquipoEx;
	
	/**
	 * @author rlozano
	 * @description Se agregan nuevos parametros para la validacion de la causa
	 * @return
	 */
	
	private long numAbonado;
	private String indProcEquipo;
	private String nomTabla;
	
	/***
	 * @author rlozano
	 * @description Se almacena el valor del importe por la simcard.
	 * @date 08-10-2009.
	 */
	protected String mntoSimcard; 
	
	/***
	 * @author santiago ventura
	 * @description Se agraga nuevos atributos para el manejo del tipo descuento y decuento.
	 * @date 26-05-2010.
	 */	
	private String tipoDescuento;
	private String descuentoUnitario;
	
	
	/***
	 * @author rlozano
	 * @description Se almacena el valor del importe por la terminal.
	 * @date 08-10-2009.
	 */
	protected String mntoTerminal;
	
	
	public String getMntoSimcard() {
		return mntoSimcard;
	}
	public void setMntoSimcard(String mntoSimcard) {
		this.mntoSimcard = mntoSimcard;
	}
	public String getMntoTerminal() {
		return mntoTerminal;
	}
	public void setMntoTerminal(String mntoTerminal) {
		this.mntoTerminal = mntoTerminal;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getFlagBloqueoEquipoEx() {
		return flagBloqueoEquipoEx;
	}
	public void setFlagBloqueoEquipoEx(String flagBloqueoEquipoEx) {
		this.flagBloqueoEquipoEx = flagBloqueoEquipoEx;
	}
	public String getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public long getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(long codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public float getImpCargo() {
		return impCargo;
	}
	public void setImpCargo(float impCargo) {
		this.impCargo = impCargo;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public String getNumSerieEquipo() {
		return numSerieEquipo;
	}
	public void setNumSerieEquipo(String numSerieEquipo) {
		this.numSerieEquipo = numSerieEquipo;
	}
	public String getNumSerieSimcard() {
		return numSerieSimcard;
	}
	public void setNumSerieSimcard(String numSerieSimcard) {
		this.numSerieSimcard = numSerieSimcard;
	}
	public String getNumTransBloqEquipo() {
		return numTransBloqEquipo;
	}
	public void setNumTransBloqEquipo(String numTransBloqEquipo) {
		this.numTransBloqEquipo = numTransBloqEquipo;
	}
	public String getNumTransBloqSerie() {
		return numTransBloqSerie;
	}
	public void setNumTransBloqSerie(String numTransBloqSerie) {
		this.numTransBloqSerie = numTransBloqSerie;
	}
	public String getUsoVentaEquip() {
		return usoVentaEquip;
	}
	public void setUsoVentaEquip(String usoVentaEquip) {
		this.usoVentaEquip = usoVentaEquip;
	}
	public String getDescrEquipoEx() {
		return descrEquipoEx;
	}
	public void setDescrEquipoEx(String descrEquipoEx) {
		this.descrEquipoEx = descrEquipoEx;
	}
	public String getIndProcEquipo() {
		return indProcEquipo;
	}
	public void setIndProcEquipo(String indProcEquipo) {
		this.indProcEquipo = indProcEquipo;
	}
	public String getNomTabla() {
		return nomTabla;
	}
	public void setNomTabla(String nomTabla) {
		this.nomTabla = nomTabla;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipoDescuento() {
		return tipoDescuento;
	}
	public void setTipoDescuento(String tipoDescuento) {
		this.tipoDescuento = tipoDescuento;
	}
	public String getDescuentoUnitario() {
		return descuentoUnitario;
	}
	public void setDescuentoUnitario(String descuentoUnitario) {
		this.descuentoUnitario = descuentoUnitario;
	}
	
		
}
