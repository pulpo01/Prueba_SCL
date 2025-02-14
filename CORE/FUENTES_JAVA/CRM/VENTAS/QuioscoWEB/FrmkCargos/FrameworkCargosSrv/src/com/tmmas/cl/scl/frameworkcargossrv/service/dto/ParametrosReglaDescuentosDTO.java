package com.tmmas.cl.scl.frameworkcargossrv.service.dto;
import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioDTO;

public class ParametrosReglaDescuentosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codigoModulo;
	private String codigoProducto;
	private String indicadorCiclo;
	private String numeroMesesFact;
	private long codCliente;
	private float valorPromedioFact;
	private String codigoPromedioFacturable;
	private String nombreClaseDescuento; 
	private String codigoConceptoCargo;
	private String tipoConceptoDescuento;
	private PrecioDTO precioDTO;
	
	public String getTipoConceptoDescuento() {
		return tipoConceptoDescuento;
	}
	public void setTipoConceptoDescuento(String tipoConceptoDescuento) {
		this.tipoConceptoDescuento = tipoConceptoDescuento;
	}
	public String getCodigoConceptoCargo() {
		return codigoConceptoCargo;
	}
	public void setCodigoConceptoCargo(String codigoConceptoCargo) {
		this.codigoConceptoCargo = codigoConceptoCargo;
	}
	public String getNombreClaseDescuento() {
		return nombreClaseDescuento;
	}
	public void setNombreClaseDescuento(String nombreClaseDescuento) {
		this.nombreClaseDescuento = nombreClaseDescuento;
	}
	public String getCodigoPromedioFacturable() {
		return codigoPromedioFacturable;
	}
	public void setCodigoPromedioFacturable(String codigoPromedioFacturable) {
		this.codigoPromedioFacturable = codigoPromedioFacturable;
	}
	public float getValorPromedioFact() {
		return valorPromedioFact;
	}
	public void setValorPromedioFact(float _valorPromedioFact) {
		this.valorPromedioFact = _valorPromedioFact;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getIndicadorCiclo() {
		return indicadorCiclo;
	}
	public void setIndicadorCiclo(String indicadorCiclo) {
		this.indicadorCiclo = indicadorCiclo;
	}
	public String getNumeroMesesFact() {
		return numeroMesesFact;
	}
	public void setNumeroMesesFact(String numeroMesesFact) {
		this.numeroMesesFact = numeroMesesFact;
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
	public PrecioDTO getPrecioDTO() {
		return precioDTO;
	}
	public void setPrecioDTO(PrecioDTO precioDTO) {
		this.precioDTO = precioDTO;
	}

}
