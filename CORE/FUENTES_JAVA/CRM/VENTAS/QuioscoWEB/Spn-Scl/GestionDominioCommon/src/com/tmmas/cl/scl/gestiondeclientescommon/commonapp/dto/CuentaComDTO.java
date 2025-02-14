package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;

public class CuentaComDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	WsRespuestaValidacionCuentaDTO[] erroresValidacion;
	private String IdentificadorTransaccion;
	private String codigoCuenta;
	private String descripcionCuenta;
	private String codigoCategoria;
	private int existeCuenta;
	private String codigoSubCuenta;
	private String nombreCuenta;
	private String descripcionSubCuenta;

	private String codigoTipIdentif;
	private String descripcionTipIdentif;
	private String numeroIdentificacion;
	
	/*-- Clasificacion --*/
	private String codigoClasificacion;
	private String descripcionClasificacion;
	 
	/*--Criterios de Busqueda de Cuenta --*/
	private String criterioBusqueda;
	private String filtroBusqueda;
	private String valorBusqueda;
	private String tipoIdentificacion;
	/*--En la interfaz se muestra el tipo de entidad (CUE cuenta,CLI cliente) --*/
	private String tipoEntidad;
	
	private ClienteComDTO clienteComDTO;
			  
    private DireccionNegocioDTO direccion;	

	/*-- Creacion Cuenta --*/
	private String tipoCuenta;
	private String responsable;

	private String fechaAlta;
	private String indicadorEstado;
	private String telefonoContacto;
	private String indicadorSector;
	private String codigoCategTributaria;
	private int    codigoSector;
	private String codigoSubCategoria;
	private String indicadorMultUso;
	private String clientePotencial;
	private String razonSocial;
	private String fechaInVPac;
	private String tipoComisionista;
	private String usuarioAsesor;
	private String fechaNacimiento;
	private String claseCuenta;
	private String tipoModulo;
	
	public String getClaseCuenta() {
		return claseCuenta;
	}
	public void setClaseCuenta(String claseCuenta) {
		this.claseCuenta = claseCuenta;
	}
	public String getTipoModulo() {
		return tipoModulo;
	}
	public void setTipoModulo(String tipoModulo) {
		this.tipoModulo = tipoModulo;
	}
	public String getCodigoClasificacion() {
		return codigoClasificacion;
	}
	public void setCodigoClasificacion(String codigoClasificacion) {
		this.codigoClasificacion = codigoClasificacion;
	}
	public String getDescripcionClasificacion() {
		return descripcionClasificacion;
	}
	public void setDescripcionClasificacion(String descripcionClasificacion) {
		this.descripcionClasificacion = descripcionClasificacion;
	}
	public int getExisteCuenta() {
		return existeCuenta;
	}
	public void setExisteCuenta(int existeCuenta) {
		this.existeCuenta = existeCuenta;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	public String getDescripcionCuenta() {
		return descripcionCuenta;
	}
	public void setDescripcionCuenta(String descripcionCuenta) {
		this.descripcionCuenta = descripcionCuenta;
	}
	public String getCodigoSubCuenta() {
		return codigoSubCuenta;
	}
	public void setCodigoSubCuenta(String codigoSubCuenta) {
		this.codigoSubCuenta = codigoSubCuenta;
	}
	public String getCriterioBusqueda() {
		return criterioBusqueda;
	}
	public void setCriterioBusqueda(String criterioBusqueda) {
		this.criterioBusqueda = criterioBusqueda;
	}
	public String getFiltroBusqueda() {
		return filtroBusqueda;
	}
	public void setFiltroBusqueda(String filtroBusqueda) {
		this.filtroBusqueda = filtroBusqueda;
	}
	public String getTipoIdentificacion() {
		return tipoIdentificacion;
	}
	public void setTipoIdentificacion(String tipoIdentificacion) {
		this.tipoIdentificacion = tipoIdentificacion;
	}
	public String getValorBusqueda() {
		return valorBusqueda;
	}
	public void setValorBusqueda(String valorBusqueda) {
		this.valorBusqueda = valorBusqueda;
	}
	public String getCodigoTipIdentif() {
		return codigoTipIdentif;
	}
	public void setCodigoTipIdentif(String codigoTipIdentif) {
		this.codigoTipIdentif = codigoTipIdentif;
	}
	public String getDescripcionTipIdentif() {
		return descripcionTipIdentif;
	}
	public void setDescripcionTipIdentif(String descripcionTipIdentif) {
		this.descripcionTipIdentif = descripcionTipIdentif;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	
	public String getTipoEntidad() {
		return tipoEntidad;
	}
	public void setTipoEntidad(String tipoEntidad) {
		this.tipoEntidad = tipoEntidad;
	}
	public String getClientePotencial() {
		return clientePotencial;
	}
	public void setClientePotencial(String clientePotencial) {
		this.clientePotencial = clientePotencial;
	}
	public String getCodigoCategTributaria() {
		return codigoCategTributaria;
	}
	public void setCodigoCategTributaria(String codigoCategTributaria) {
		this.codigoCategTributaria = codigoCategTributaria;
	}
	public int getCodigoSector() {
		return codigoSector;
	}
	public void setCodigoSector(int codigoSector) {
		this.codigoSector = codigoSector;
	}
	public String getCodigoSubCategoria() {
		return codigoSubCategoria;
	}
	public void setCodigoSubCategoria(String codigoSubCategoria) {
		this.codigoSubCategoria = codigoSubCategoria;
	}
	public String getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(String fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
	public String getFechaInVPac() {
		return fechaInVPac;
	}
	public void setFechaInVPac(String fechaInVPac) {
		this.fechaInVPac = fechaInVPac;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getIndicadorEstado() {
		return indicadorEstado;
	}
	public void setIndicadorEstado(String indicadorEstado) {
		this.indicadorEstado = indicadorEstado;
	}
	public String getIndicadorMultUso() {
		return indicadorMultUso;
	}
	public void setIndicadorMultUso(String indicadorMultUso) {
		this.indicadorMultUso = indicadorMultUso;
	}
	public String getIndicadorSector() {
		return indicadorSector;
	}
	public void setIndicadorSector(String indicadorSector) {
		this.indicadorSector = indicadorSector;
	}
	public String getRazonSocial() {
		return razonSocial;
	}
	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}
	public String getResponsable() {
		return responsable;
	}
	public void setResponsable(String responsable) {
		this.responsable = responsable;
	}
	public String getTelefonoContacto() {
		return telefonoContacto;
	}
	public void setTelefonoContacto(String telefonoContacto) {
		this.telefonoContacto = telefonoContacto;
	}
	public String getTipoComisionista() {
		return tipoComisionista;
	}
	public void setTipoComisionista(String tipoComisionista) {
		this.tipoComisionista = tipoComisionista;
	}
	public String getTipoCuenta() {
		return tipoCuenta;
	}
	public void setTipoCuenta(String tipoCuenta) {
		this.tipoCuenta = tipoCuenta;
	}
	public String getUsuarioAsesor() {
		return usuarioAsesor;
	}
	public void setUsuarioAsesor(String usuarioAsesor) {
		this.usuarioAsesor = usuarioAsesor;
	}
	public ClienteComDTO getClienteComDTO() {
		return clienteComDTO;
	}
	public void setClienteComDTO(ClienteComDTO clienteComDTO) {
		this.clienteComDTO = clienteComDTO;
	}
	public String getNombreCuenta() {
		return nombreCuenta;
	}
	public void setNombreCuenta(String nombreCuenta) {
		this.nombreCuenta = nombreCuenta;
	}
	public String getDescripcionSubCuenta() {
		return descripcionSubCuenta;
	}
	public void setDescripcionSubCuenta(String descripcionSubCuenta) {
		this.descripcionSubCuenta = descripcionSubCuenta;
	}
	public DireccionNegocioDTO getDireccion() {
		return direccion;
	}
	public void setDireccion(DireccionNegocioDTO direccion) {
		this.direccion = direccion;
	}
	public String getIdentificadorTransaccion() {
		return IdentificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		IdentificadorTransaccion = identificadorTransaccion;
	}
	public WsRespuestaValidacionCuentaDTO[] getErroresValidacion() {
		return erroresValidacion;
	}
	public void setErroresValidacion(
			WsRespuestaValidacionCuentaDTO[] erroresValidacion) {
		this.erroresValidacion = erroresValidacion;
	}


}