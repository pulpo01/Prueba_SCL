package com.tmmas.cl.scl.frameworkcargossrv.service.dto;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosReglaDTO;

public class ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO extends ParametrosReglaDTO{
	private static final long serialVersionUID = 1L;
	
	private long   cod_Producto;
	private String cod_Concepto;
	private String cod_Categoria;
	private String cod_TipContrato;
	private String num_Meses;
	private String cod_Antiguedad;
	private String cod_Operacion;
	private String ind_Causa;
	private String cod_Causa;
	private String cod_ModPago;
	private String cod_EstadDevolucion;
	private String estadoDevEquipo;
	private String codEquipoCargador;
	private String codModulo;
	private String indComodato;
	private String numAbonado;
	
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getIndComodato() {
		return indComodato;
	}
	public void setIndComodato(String indComodato) {
		this.indComodato = indComodato;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodEquipoCargador() {
		return codEquipoCargador;
	}
	public void setCodEquipoCargador(String codEquipoCargador) {
		this.codEquipoCargador = codEquipoCargador;
	}
	public String getEstadoDevEquipo() {
		return estadoDevEquipo;
	}
	public void setEstadoDevEquipo(String estadoDevEquipo) {
		this.estadoDevEquipo = estadoDevEquipo;
	}
	public String getCod_Antiguedad() {
		return cod_Antiguedad;
	}
	public void setCod_Antiguedad(String cod_Antiguedad) {
		this.cod_Antiguedad = cod_Antiguedad;
	}
	public String getCod_Categoria() {
		return cod_Categoria;
	}
	public void setCod_Categoria(String cod_Categoria) {
		this.cod_Categoria = cod_Categoria;
	}
	public String getCod_Concepto() {
		return cod_Concepto;
	}
	public void setCod_Concepto(String cod_Concepto) {
		this.cod_Concepto = cod_Concepto;
	}
	public String getCod_EstadDevolucion() {
		return cod_EstadDevolucion;
	}
	public void setCod_EstadDevolucion(String cod_EstadDevolucion) {
		this.cod_EstadDevolucion = cod_EstadDevolucion;
	}
	public String getCod_ModPago() {
		return cod_ModPago;
	}
	public void setCod_ModPago(String cod_ModPago) {
		this.cod_ModPago = cod_ModPago;
	}
	public String getCod_Operacion() {
		return cod_Operacion;
	}
	public void setCod_Operacion(String cod_Operacion) {
		this.cod_Operacion = cod_Operacion;
	}
	public long getCod_Producto() {
		return cod_Producto;
	}
	public void setCod_Producto(long cod_Producto) {
		this.cod_Producto = cod_Producto;
	}
	public String getCod_TipContrato() {
		return cod_TipContrato;
	}
	public void setCod_TipContrato(String cod_TipContrato) {
		this.cod_TipContrato = cod_TipContrato;
	}
	public String getInd_Causa() {
		return ind_Causa;
	}
	public void setInd_Causa(String ind_Causa) {
		this.ind_Causa = ind_Causa;
	}
	public String getNum_Meses() {
		return num_Meses;
	}
	public void setNum_Meses(String nu8m_Meses) {
		this.num_Meses = nu8m_Meses;
	}
	public String getCod_Causa() {
		return cod_Causa;
	}
	public void setCod_Causa(String cod_Causa) {
		this.cod_Causa = cod_Causa;
	}
	
	
	
	
	
}
