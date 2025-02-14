package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DireccionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipoComisionistaDTO;

public class VendedorDTO implements Serializable {
	
private static final long serialVersionUID = 1L;
	
	private String codigoVendedor;
	private String nombreVendedor;
	private TipoComisionistaDTO tipoComisionista[];
	private boolean vendedorInterno;
	private String codigoCliente;
	private String codigoAccionBloqueo;
	private long codigoVendedorRaiz;
	private long codigoVendedorDealer;
	private DireccionDTO direccion;
	private String codigoOficina;
	private String codTipComisionista;
	private String desTipComisionista;
	private int indicadorTipoVenta;
	private float puntoDesctoInferior;
	private float puntoDesctoSuperior;
	private float porcentajeDesctoInferior;
	private float porcentajeDesctoSuperior;
	private boolean aplicaDescuento;
	
	public boolean isAplicaDescuento() {
		return aplicaDescuento;
	}
	public void setAplicaDescuento(boolean aplicaDescuento) {
		this.aplicaDescuento = aplicaDescuento;
	}
	public String getCodigoAccionBloqueo() {
		return codigoAccionBloqueo;
	}
	public void setCodigoAccionBloqueo(String codigoAccionBloqueo) {
		this.codigoAccionBloqueo = codigoAccionBloqueo;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public long getCodigoVendedorDealer() {
		return codigoVendedorDealer;
	}
	public void setCodigoVendedorDealer(long codigoVendedorDealer) {
		this.codigoVendedorDealer = codigoVendedorDealer;
	}
	public long getCodigoVendedorRaiz() {
		return codigoVendedorRaiz;
	}
	public void setCodigoVendedorRaiz(long codigoVendedorRaiz) {
		this.codigoVendedorRaiz = codigoVendedorRaiz;
	}
	public String getCodTipComisionista() {
		return codTipComisionista;
	}
	public void setCodTipComisionista(String codTipComisionista) {
		this.codTipComisionista = codTipComisionista;
	}
	public String getDesTipComisionista() {
		return desTipComisionista;
	}
	public void setDesTipComisionista(String desTipComisionista) {
		this.desTipComisionista = desTipComisionista;
	}
	public int getIndicadorTipoVenta() {
		return indicadorTipoVenta;
	}
	public void setIndicadorTipoVenta(int indicadorTipoVenta) {
		this.indicadorTipoVenta = indicadorTipoVenta;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public float getPorcentajeDesctoInferior() {
		return porcentajeDesctoInferior;
	}
	public void setPorcentajeDesctoInferior(float porcentajeDesctoInferior) {
		this.porcentajeDesctoInferior = porcentajeDesctoInferior;
	}
	public float getPorcentajeDesctoSuperior() {
		return porcentajeDesctoSuperior;
	}
	public void setPorcentajeDesctoSuperior(float porcentajeDesctoSuperior) {
		this.porcentajeDesctoSuperior = porcentajeDesctoSuperior;
	}
	public float getPuntoDesctoInferior() {
		return puntoDesctoInferior;
	}
	public void setPuntoDesctoInferior(float puntoDesctoInferior) {
		this.puntoDesctoInferior = puntoDesctoInferior;
	}
	public float getPuntoDesctoSuperior() {
		return puntoDesctoSuperior;
	}
	public void setPuntoDesctoSuperior(float puntoDesctoSuperior) {
		this.puntoDesctoSuperior = puntoDesctoSuperior;
	}
	public TipoComisionistaDTO[] getTipoComisionista() {
		return tipoComisionista;
	}
	public void setTipoComisionista(TipoComisionistaDTO[] tipoComisionista) {
		this.tipoComisionista = tipoComisionista;
	}
	public boolean isVendedorInterno() {
		return vendedorInterno;
	}
	public void setVendedorInterno(boolean vendedorInterno) {
		this.vendedorInterno = vendedorInterno;
	}
	public DireccionDTO getDireccion() {
		return direccion;
	}
	public void setDireccion(DireccionDTO direccion) {
		this.direccion = direccion;
	}
	
	
}
