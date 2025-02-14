package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;


public class VendedorDTO extends RetornoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codigoVendedor;
	private String nombreVendedor;
	private TipoComisionistaDTO tipoComisionista[];
	private boolean vendedorInterno;
	private String codigoCliente;
	private String codigoCuenta;
	private String codigoAccionBloqueo;
	private long codigoVendedorRaiz;
	private long codigoVendedorDealer;
	private String nombreDealer;
	private DireccionNegocioDTO direccion;
	private String codigoOficina;
	private String codTipComisionista;
	private String desTipComisionista;
	private int indicadorTipoVenta;
	private float puntoDesctoInferior;
	private float puntoDesctoSuperior;
	private float porcentajeDesctoInferior;
	private float porcentajeDesctoSuperior;
	private boolean aplicaDescuento;
	private int indicadorBloqueo;
	
	/*-- Home Celular Vendedor --*/
	private boolean indicadorHomeVendCelular; // FALSE:No corresponde TRUE:Si corresponde
	private String numeroCelular;
	
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public int getIndicadorTipoVenta() {
		return indicadorTipoVenta;
	}
	public void setIndicadorTipoVenta(int indicadorTipoVenta) {
		this.indicadorTipoVenta = indicadorTipoVenta;
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
	
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public DireccionNegocioDTO getDireccion() {
		return direccion;
	}
	public void setDireccion(DireccionNegocioDTO direccion) {
		this.direccion = direccion;
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
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public boolean isVendedorInterno() {
		return vendedorInterno;
	}
	public void setVendedorInterno(boolean vendedorInterno) {
		this.vendedorInterno = vendedorInterno;
	}
	public TipoComisionistaDTO[] getTipoComisionista() {
		return tipoComisionista;
	}
	public void setTipoComisionista(TipoComisionistaDTO[] tipoComisionista) {
		this.tipoComisionista = tipoComisionista;
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
	public boolean isAplicaDescuento() {
		return aplicaDescuento;
	}
	public void setAplicaDescuento(boolean aplicaDescuento) {
		this.aplicaDescuento = aplicaDescuento;
	}
	public boolean isIndicadorHomeVendCelular() {
		return indicadorHomeVendCelular;
	}
	public void setIndicadorHomeVendCelular(boolean indicadorHomeVendCelular) {
		this.indicadorHomeVendCelular = indicadorHomeVendCelular;
	}
	public String getNombreDealer() {
		return nombreDealer;
	}
	public void setNombreDealer(String nombreDealer) {
		this.nombreDealer = nombreDealer;
	}
	public int getIndicadorBloqueo() {
		return indicadorBloqueo;
	}
	public void setIndicadorBloqueo(int indicadorBloqueo) {
		this.indicadorBloqueo = indicadorBloqueo;
	}
	public String getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	
}//fin VendedorDTO
