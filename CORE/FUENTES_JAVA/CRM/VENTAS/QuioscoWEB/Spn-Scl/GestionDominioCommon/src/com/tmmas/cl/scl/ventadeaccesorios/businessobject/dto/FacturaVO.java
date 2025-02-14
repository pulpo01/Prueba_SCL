package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class FacturaVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String cliente = "";
	private String tipoIdentificacion = "";
	private String identificacion = "";
	private String direccion = "";
	private String comuna = "";
	private String ciudad = "";
	private String region = "";
	private String codCliente = "";
	private String  numFactura = "";
	private int 	numPago = 0;
	private String  cajero = "";
	private int 	numCaja = 0;
	private String  caja = "";
	private Float 	subTotal = new Float("0");
	private Float	iva = new Float("0");
	private Float	otrosCargos = new Float("0");
	private Float 	cruzRoja = new Float("0");
	private Float 	total = new Float("0");
	private Boolean soloAccesorios;
	
	private DetalleFacturaVO[] detalleFacturaVO;
	
	//Inicio Inc. 177348 - 06/11/2011 -  FADL 
	private Float numero911 = new Float("0");
	private Float impuestoVenta = new Float("0");
	private Float descuento = new Float("0");
	private int serie = 0;
	//Fin Inc. 177348 - 06/11/2011 -  FADL 
	
	public DetalleFacturaVO[] getDetalleFacturaVO() {
		return detalleFacturaVO;
	}
	public void setDetalleFacturaVO(DetalleFacturaVO[] detalleFacturaVO) {
		this.detalleFacturaVO = detalleFacturaVO;
	}
	public int getNumCaja() {
		return numCaja;
	}
	public void setNumCaja(int numCaja) {
		this.numCaja = numCaja;
	}
	public String getNumFactura() {
		return numFactura;
	}
	public void setNumFactura(String numFactura) {
		this.numFactura = numFactura;
	}
	public int getNumPago() {
		return numPago;
	}
	public void setNumPago(int numPago) {
		this.numPago = numPago;
	}
	public String getCliente() {
		return cliente;
	}
	public void setCliente(String cliente) {
		this.cliente = cliente;
	}
	public String getCaja() {
		return caja;
	}
	public void setCaja(String caja) {
		this.caja = caja;
	}
	public String getCajero() {
		return cajero;
	}
	public void setCajero(String cajero) {
		this.cajero = cajero;
	}
	public String getCiudad() {
		return ciudad;
	}
	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getComuna() {
		return comuna;
	}
	public void setComuna(String comuna) {
		this.comuna = comuna;
	}
	public Float getCruzRoja() {
		return cruzRoja;
	}
	public void setCruzRoja(Float cruzRoja) {
		this.cruzRoja = cruzRoja;
	}
	public String getDireccion() {
		return direccion;
	}
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	public String getIdentificacion() {
		return identificacion;
	}
	public void setIdentificacion(String identificacion) {
		this.identificacion = identificacion;
	}
	public Float getIva() {
		return iva;
	}
	public void setIva(Float iva) {
		this.iva = iva;
	}
	public Float getOtrosCargos() {
		return otrosCargos;
	}
	public void setOtrosCargos(Float otrosCargos) {
		this.otrosCargos = otrosCargos;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public Float getSubTotal() {
		return subTotal;
	}
	public void setSubTotal(Float subTotal) {
		this.subTotal = subTotal;
	}
	public Float getTotal() {
		return total;
	}
	public void setTotal(Float total) {
		this.total = total;
	}
	public String getTipoIdentificacion() {
		return tipoIdentificacion;
	}
	public void setTipoIdentificacion(String tipoIdentificacion) {
		this.tipoIdentificacion = tipoIdentificacion;
	}
	public Boolean getSoloAccesorios() {
		return soloAccesorios;
	}
	public void setSoloAccesorios(Boolean soloAccesorios) {
		this.soloAccesorios = soloAccesorios;
	}	
	
	//Inicio Inc. 177348 - 06/11/2011 -  FADL
	public Float getNumero911(){
		return numero911;
	}
	public void setNumero911(Float numero911){
		this.numero911 = numero911;
	}
	public Float getImpuestoVenta(){
		return impuestoVenta;
	}
	public void setImpuestoVenta(Float impuestoVenta){
		this.impuestoVenta = impuestoVenta;
	}
	public Float getDescuento(){
		return descuento;
	}
	public void setDescuento(Float descuento){
		this.descuento = descuento;
	}
	public int getSerie(){
		return serie;
	}
	public void setSerie(int serie){
		this.serie = serie;
	}
	//Fin Inc. 177348 - 06/11/2011 -  FADL 
}
