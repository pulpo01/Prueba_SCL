package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;
public class LstPTaPlanTarifarioOutDTO implements Serializable{
	private static final long serialVersionUID = 1L;

	private String codigoPlanTarifario;
	private String descripcionPlanTarifario;
	private String tipoProducto;
	private String tipoPlan;
	private Long canLineas;
	
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getDescripcionPlanTarifario() {
		return descripcionPlanTarifario;
	}
	public void setDescripcionPlanTarifario(String descripcionPlanTarifario) {
		this.descripcionPlanTarifario = descripcionPlanTarifario;
	}
	public String getTipoPlan() {
		return tipoPlan;
	}
	public void setTipoPlan(String tipoPlan) {
		this.tipoPlan = tipoPlan;
	}
	public String getTipoProducto() {
		return tipoProducto;
	}
	public void setTipoProducto(String tipoProducto) {
		this.tipoProducto = tipoProducto;
	}
	public Long getCanLineas() {
		return canLineas;
	}
	public void setCanLineas(Long canLineas) {
		this.canLineas = canLineas;
	}
	
}//fin class LstPTaPlanTarifarioOutDTO

