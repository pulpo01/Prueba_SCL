package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosRegistroCargosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String codigoCliente;
	private String numeroVenta;
	private String numeroTransaccion;
	private String codigoPlanComercial;
	private String categoriaTributaria;
	private String modalidadVenta;
	private String codigoDocumento;
	private String tipoFoliacion;
	private String codigoOficina;
	private boolean facturacionaCiclo;
	private String codigoVendedor;
	private long codigoVendedorRaiz;
	
	private ProgramaDTO datosPrograma;
	private CargosDTO[] cargos;
	
	public CargosDTO[] getCargos() {
		return cargos;
	}
	public void setCargos(CargosDTO[] cargos) {
		this.cargos = cargos;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoDocumento() {
		return codigoDocumento;
	}
	public void setCodigoDocumento(String codigoDocumento) {
		this.codigoDocumento = codigoDocumento;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoPlanComercial() {
		return codigoPlanComercial;
	}
	public void setCodigoPlanComercial(String codigoPlanComercial) {
		this.codigoPlanComercial = codigoPlanComercial;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public long getCodigoVendedorRaiz() {
		return codigoVendedorRaiz;
	}
	public void setCodigoVendedorRaiz(long codigoVendedorRaiz) {
		this.codigoVendedorRaiz = codigoVendedorRaiz;
	}
	public boolean isFacturacionaCiclo() {
		return facturacionaCiclo;
	}
	public void setFacturacionaCiclo(boolean facturacionaCiclo) {
		this.facturacionaCiclo = facturacionaCiclo;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public String getNumeroTransaccion() {
		return numeroTransaccion;
	}
	public void setNumeroTransaccion(String numeroTransaccion) {
		this.numeroTransaccion = numeroTransaccion;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
	public ProgramaDTO getDatosPrograma() {
		return datosPrograma;
	}
	public void setDatosPrograma(ProgramaDTO datosPrograma) {
		this.datosPrograma = datosPrograma;
	}
	
	
	
}
