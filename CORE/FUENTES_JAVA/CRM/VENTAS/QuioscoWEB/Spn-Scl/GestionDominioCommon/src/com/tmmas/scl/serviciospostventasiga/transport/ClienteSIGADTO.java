/* Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 23/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;


public class ClienteSIGADTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;


	
	private String codigoCliente;

	private String codigoCuenta;

	private String codigoSubCuenta;

	private String nombreCliente;

	private String nombreApellido1;

	private String nombreApellido2;

	private String fechaNacimiento;

	private String indicadorEstadoCivil;

	private String indicadorSexo;

	private String codigoActividad;

	private String codigoTipoIdentificacion;

	private String numeroIdentificacion;

	private String tipoCliente;

	private String codigoCelda;

	private String codigoCalidadCliente;

	private double limiteCredito;

	private int indicativoFacturable;

	private int codigoCiclo;

	private int existeCliente;

	private DireccionDTO direccion;

	private long codigoEmpresa;

	private String planComercial;

	private String categoriaTributaria;

	private long totalAbonados;

	private String codRegion;

	private String codCiudad;

	private String codProvincia;

	private int indFactur;
	
	private String indSituacion;

	

	public String getPlanComercial() {
		return planComercial;
	}

	public void setPlanComercial(String planComercial) {
		this.planComercial = planComercial;
	}

	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}

	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}

	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}

	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}

	public String getCodigoCliente() {
		return codigoCliente;
	}

	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public int getExisteCliente() {
		return existeCliente;
	}

	public void setExisteCliente(int existeCliente) {
		this.existeCliente = existeCliente;
	}

	public String getTipoCliente() {
		return tipoCliente;
	}

	public void setTipoCliente(String tipoCliente) {
		this.tipoCliente = tipoCliente;
	}

	public String getCodigoActividad() {
		return codigoActividad;
	}

	public void setCodigoActividad(String codigoActividad) {
		this.codigoActividad = codigoActividad;
	}

	public String getCodigoCuenta() {
		return codigoCuenta;
	}

	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}

	public String getCodigoSubCuenta() {
		return codigoSubCuenta;
	}

	public void setCodigoSubCuenta(String codigoSubCuenta) {
		this.codigoSubCuenta = codigoSubCuenta;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public String getIndicadorEstadoCivil() {
		return indicadorEstadoCivil;
	}

	public void setIndicadorEstadoCivil(String indicadorEstadoCivil) {
		this.indicadorEstadoCivil = indicadorEstadoCivil;
	}

	public String getIndicadorSexo() {
		return indicadorSexo;
	}

	public void setIndicadorSexo(String indicadorSexo) {
		this.indicadorSexo = indicadorSexo;
	}

	public String getNombreApellido1() {
		return nombreApellido1;
	}

	public void setNombreApellido1(String nombreApellido1) {
		this.nombreApellido1 = nombreApellido1;
	}

	public String getNombreApellido2() {
		return nombreApellido2;
	}

	public void setNombreApellido2(String nombreApellido2) {
		this.nombreApellido2 = nombreApellido2;
	}

	public String getCodigoCalidadCliente() {
		return codigoCalidadCliente;
	}

	public void setCodigoCalidadCliente(String codigoCalidadCliente) {
		this.codigoCalidadCliente = codigoCalidadCliente;
	}

	public String getCodigoCelda() {
		return codigoCelda;
	}

	public void setCodigoCelda(String codigoCelda) {
		this.codigoCelda = codigoCelda;
	}

	public int getCodigoCiclo() {
		return codigoCiclo;
	}

	public void setCodigoCiclo(int codigoCiclo) {
		this.codigoCiclo = codigoCiclo;
	}

	public int getIndicativoFacturable() {
		return indicativoFacturable;
	}

	public void setIndicativoFacturable(int indicativoFacturable) {
		this.indicativoFacturable = indicativoFacturable;
	}

	public DireccionDTO getDireccion() {
		return direccion;
	}

	public void setDireccion(DireccionDTO direccion) {
		this.direccion = direccion;
	}

	public long getCodigoEmpresa() {
		return codigoEmpresa;
	}

	public void setCodigoEmpresa(long codigoEmpresa) {
		this.codigoEmpresa = codigoEmpresa;
	}

	public double getLimiteCredito() {
		return limiteCredito;
	}

	public void setLimiteCredito(double limiteCredito) {
		this.limiteCredito = limiteCredito;
	}

	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}

	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}

	public long getTotalAbonados() {
		return totalAbonados;
	}

	public void setTotalAbonados(long totalAbonados) {
		this.totalAbonados = totalAbonados;
	}

	public String getCodCiudad() {
		return codCiudad;
	}

	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}

	public String getCodProvincia() {
		return codProvincia;
	}

	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}

	public String getCodRegion() {
		return codRegion;
	}

	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}

	public int getIndFactur() {
		return indFactur;
	}

	public void setIndFactur(int indFactur) {
		this.indFactur = indFactur;
	}

	public String getIndSituacion() {
		return indSituacion;
	}

	public void setIndSituacion(String indSituacion) {
		this.indSituacion = indSituacion;
	}

}
