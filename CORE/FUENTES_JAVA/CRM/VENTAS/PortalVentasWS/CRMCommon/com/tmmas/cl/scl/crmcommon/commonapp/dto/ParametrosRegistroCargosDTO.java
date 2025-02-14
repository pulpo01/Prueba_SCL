/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 25/04/2007        Héctor Hermosilla              		Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.dto.ProgramaDTO;


public class ParametrosRegistroCargosDTO implements Serializable {
	
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
	private String nombreUsuario;	
	private int numeroDecimalesBD;
	private int numeroDecimalesPorDesc;
	
	private Long num_terminal;
	private Long num_abonado;	
	
	private CargosDTO[] cargos;
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getNumeroTransaccion() {
		return numeroTransaccion;
	}
	public void setNumeroTransaccion(String numeroTransaccion) {
		this.numeroTransaccion = numeroTransaccion;
	}
	public String getCodigoPlanComercial() {
		return codigoPlanComercial;
	}
	public void setCodigoPlanComercial(String codigoPlanComercial) {
		this.codigoPlanComercial = codigoPlanComercial;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getCodigoDocumento() {
		return codigoDocumento;
	}
	public void setCodigoDocumento(String codigoDocumento) {
		this.codigoDocumento = codigoDocumento;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public String getTipoFoliacion() {
		return tipoFoliacion;
	}
	public void setTipoFoliacion(String tipoFoliacion) {
		this.tipoFoliacion = tipoFoliacion;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public boolean isFacturacionaCiclo() {
		return facturacionaCiclo;
	}
	public void setFacturacionaCiclo(boolean facturacionaCiclo) {
		this.facturacionaCiclo = facturacionaCiclo;
	}

	public CargosDTO[] getCargos() {
		return cargos;
	}
	public void setCargos(CargosDTO[] cargos) {
		this.cargos = cargos;
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
	public ProgramaDTO getDatosPrograma() {
		return datosPrograma;
	}
	public void setDatosPrograma(ProgramaDTO datosPrograma) {
		this.datosPrograma = datosPrograma;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public Long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(Long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public Long getNum_terminal() {
		return num_terminal;
	}
	public void setNum_terminal(Long num_terminal) {
		this.num_terminal = num_terminal;
	}
	public int getNumeroDecimalesBD() {
		return numeroDecimalesBD;
	}
	public void setNumeroDecimalesBD(int numeroDecimalesBD) {
		this.numeroDecimalesBD = numeroDecimalesBD;
	}
	public int getNumeroDecimalesPorDesc() {
		return numeroDecimalesPorDesc;
	}
	public void setNumeroDecimalesPorDesc(int numeroDecimalesPorDesc) {
		this.numeroDecimalesPorDesc = numeroDecimalesPorDesc;
	}	
	
}
