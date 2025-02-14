package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;



public class ParametrosReglasServicioOcacionalPVDTO extends ParametrosReglaDTO {
	
	private static final long serialVersionUID = 1L;

	private String codProducto;
	private String codPlanTarifDestino;
	private String codActuacion;
	private String codUso;
	private String codTipoServicio;
	private String codConcepto;
	private String codPlanServicio;
	private String codModulo;
	private String prepagoPrepago;
	private String prepagoHibrido;
	private long codClienteDes;
	private String codigoModulo;
	private String codigoProducto;
	private String nombreClaseDescuento;
	private boolean isPrepagoPrepago;
	private boolean isHibridoHibrido;
	private String numAbonado;
	private String codigoTecnologia;
	private String codPlanTarifOrigen;
	private boolean aplicaConcepto;
	
	public boolean isAplicaConcepto() {
		return aplicaConcepto;
	}

	public void setAplicaConcepto(boolean aplicaConcepto) {
		this.aplicaConcepto = aplicaConcepto;
	}

	public String getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}

	public boolean isHibridoHibrido() {
		return isHibridoHibrido;
	}

	public void setHibridoHibrido(boolean isHibridoHibrido) {
		this.isHibridoHibrido = isHibridoHibrido;
	}

	public boolean isPrepagoPrepago() {
		return isPrepagoPrepago;
	}

	public void setPrepagoPrepago(boolean isPrepagoPrepago) {
		this.isPrepagoPrepago = isPrepagoPrepago;
	}

	public String getPrepagoHibrido() {
		return prepagoHibrido;
	}

	public void setPrepagoHibrido(String prepagoHibrido) {
		this.prepagoHibrido = prepagoHibrido;
	}

	public String getPrepagoPrepago() {
		return prepagoPrepago;
	}

	public void setPrepagoPrepago(String prepagoPrepago) {
		this.prepagoPrepago = prepagoPrepago;
	}

	public String getCodModulo() {
		return codModulo;
	}

	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}

	public String getCodActuacion() {
		return codActuacion;
	}

	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}

	public String getCodConcepto() {
		return codConcepto;
	}

	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}

	public String getCodPlanServicio() {
		return codPlanServicio;
	}

	public void setCodPlanServicio(String codPlanServicio) {
		this.codPlanServicio = codPlanServicio;
	}

	
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}

	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}

	public String getCodPlanTarifOrigen() {
		return codPlanTarifOrigen;
	}

	public void setCodPlanTarifOrigen(String codPlanTarifOrigen) {
		this.codPlanTarifOrigen = codPlanTarifOrigen;
	}

	public String getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}

	public String getCodTipoServicio() {
		return codTipoServicio;
	}

	public void setCodTipoServicio(String codTipoServicio) {
		this.codTipoServicio = codTipoServicio;
	}

	public String getCodUso() {
		return codUso;
	}

	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}

	public String getNombreClaseDescuento() {
		return nombreClaseDescuento;
	}

	public void setNombreClaseDescuento(String claseDescuento) {
		this.nombreClaseDescuento = claseDescuento;
	}

	public long getCodClienteDes() {
		return codClienteDes;
	}

	public void setCodClienteDes(long codClienteDes) {
		this.codClienteDes = codClienteDes;
	}

	public String getCodigoModulo() {
		return codigoModulo;
	}

	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}

	public String getCodigoProducto() {
		return codigoProducto;
	}

	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}

	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}

	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}

	
	
}//fin ParametrosReglasServicioOcacionalDTO
