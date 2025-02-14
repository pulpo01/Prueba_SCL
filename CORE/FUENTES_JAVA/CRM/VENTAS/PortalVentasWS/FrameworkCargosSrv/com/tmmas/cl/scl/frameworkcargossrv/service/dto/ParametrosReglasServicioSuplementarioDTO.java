package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosReglaDTO;

public class ParametrosReglasServicioSuplementarioDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;
	
	private String codigoProducto;
	private String codigoServicio;
	private String codigoPlanServicio;
	private String codigoPlanTarifario;
	private String codigoActuacion;
	private String esCargoInstalacion;
	
	public String getEsCargoInstalacion() {
		return esCargoInstalacion;
	}
	public void setEsCargoInstalacion(String esCargoInstalacion) {
		this.esCargoInstalacion = esCargoInstalacion;
	}
	public String getCodigoActuacion() {
		return codigoActuacion;
	}
	public void setCodigoActuacion(String codigoActuacion) {
		this.codigoActuacion = codigoActuacion;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getCodigoPlanServicio() {
		return codigoPlanServicio;
	}
	public void setCodigoPlanServicio(String codigoPlanServicio) {
		this.codigoPlanServicio = codigoPlanServicio;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoServicio() {
		return codigoServicio;
	}
	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}

}//fin ParametrosReglaServicioSuplementarioDTO
