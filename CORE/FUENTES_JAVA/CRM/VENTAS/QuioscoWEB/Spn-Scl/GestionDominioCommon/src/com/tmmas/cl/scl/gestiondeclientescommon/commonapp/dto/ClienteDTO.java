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
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;


public class ClienteDTO implements Serializable {
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
	private String codigoTipoCliente;
	private String tipoCliente;
	private String codigoCelda;
    private String codigoCalidadCliente;
    private double limiteCredito;
    private int indicativoFacturable;
    private int codigoCiclo;
    private int existeCliente;
    private DireccionNegocioDTO[] direcciones;
    private long codigoEmpresa;
    private String planComercial;
    private String categoriaTributaria;
    private String numeroTelefono1;
    private String numeroTelefono2;
    private String numeroTelefono;
    
    private String numeroFax;
    private String direccionEMail;
    private RepresentanteLegalDTO[] representanteLegalDTO;
    private int numeroOrdenRepresentanteLegal;
    
    /*-- Categorias --*/
    private String codigoCategoria;
    private String descripcionCategoria;
    
    /*-- Categoria Impositiva --*/
    private String codigoCategImpos;
    private String descripcionCategImpos;
    
    /*-- Sub Categoria impositiva --*/
    private String codigoSubCategImpos;
    private String descripcionSubCategImpos;
    
    /*-- Relacion Cliente Vendedor --*/
    private String codigoSector;
    private String codigoSupervisor;
    private int codigoVendedor;    
    
    /*-- Cliente Empresa --*/
    private String descripcionEmpresa;
	private String planTarifario;
    private int    codigoProducto;
	private int    numeroAbonados;
	
	/*-- Secuencia Despacho --*/
	private String codigoDespacho;
	private String fechaDesde;
	private String fechaHasta;
	private String usuario;
	
	/*--Modificacion cliente--*/
	private String codigoModificacion;
	private String nombreUsuarOra;
	private String codigoPlanComercial;
	private String indicadorTraspaso;
	private String indicadorDebito;
	private String codigoSistemaPago;
	private String importeLimiteDebito;
	private String codigoBanco;
	private String codigoSucursal;
	private String indicadorTipoCuenta;
	private String codigoTipoTarjeta;
	private String numeroCuentaCorriente;
	private String numeroTarjeta;
	private String fechaVencimientoTarjeta;
	private String codigoBancoTarjeta;
	private String codigoTipoIdentificacionTributaria;
	private String numeroIdentificacionTributaria;
	private String codigoTipoIdentificacionApoderado;
	private String numeroIdentificacionApoderado;
	private String nombreApoderado;
	private String codigoOficina;
	private String codigoIdentificacionCliente;
	private String codigoCicloFacturacion;
	private String codigoCategoriaEmpresa;
	private String indicadorPrivacidad;
	private String tipoPlanTarifario;
	private String codigoPlanTarifario;
	private String codigoCargoBasico;
	private String numeroOrdenServicio;
	private String numeroCiclos;
	private String numeroMinutos;
	private String codigoIdioma;
	private String codigoTipIdent2;
	private String numIdent2;
	private String codigoPlaza;
	private String descripcionReferenciaDocumento;
	private String codigoLimiteConsumo;
	private String codigoSubCategoria;
	private String codigoPais;
	private String codigoCobrador;
	private String fechaBaja;
	
	private String indicadorSituacion;
	private String indicadorAgente;
	private String indicadorMandato;
	private String indicadorAlta;
	private String indicadorAcepVenta; 
	private String codigoABC; 
	private String codigo123; 
	private String numeroAbocel; 
	private String numeroAbobeep; 			
	private String numeroAbotrunk; 
	private String codigoProspecto; 
	private String numeroAbotrek; 			
	private String numeroAborent; 			
	private String numeroAboroaming; 
	private String fechaAcepVenta; 
	private String codigoPincli; 
	private String numeroCelular; 
	private String indicadirTipPersona; 
	private String codigoCicloNuevo; 
	private String numeroIntGrupoFam; 
	private String codigoNPI; 
	private String codigoUso; 
	private String nombreUsuarioAsesor; 
	private String codigoOperadora; 
	private String indentificadorSegmento;
	//Parametro para indicar el numero de meses a reportar por los pagos realizados por el cliente
	private long numMesesCobro;
	    
	public long getNumMesesCobro() {
		return numMesesCobro;
	}
	public void setNumMesesCobro(long numMesesCobro) {
		this.numMesesCobro = numMesesCobro;
	}
	public String getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	public String getCodigoPais() {
		return codigoPais;
	}
	public void setCodigoPais(String codigoPais) {
		this.codigoPais = codigoPais;
	}
	public String getCodigoBancoTarjeta() {
		return codigoBancoTarjeta;
	}
	public void setCodigoBancoTarjeta(String codigoBancoTarjeta) {
		this.codigoBancoTarjeta = codigoBancoTarjeta;
	}
	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}
	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}
	public String getCodigoCategoriaEmpresa() {
		return codigoCategoriaEmpresa;
	}
	public void setCodigoCategoriaEmpresa(String codigoCategoriaEmpresa) {
		this.codigoCategoriaEmpresa = codigoCategoriaEmpresa;
	}
	public String getCodigoCicloFacturacion() {
		return codigoCicloFacturacion;
	}
	public void setCodigoCicloFacturacion(String codigoCicloFacturacion) {
		this.codigoCicloFacturacion = codigoCicloFacturacion;
	}
	public String getCodigoIdentificacionCliente() {
		return codigoIdentificacionCliente;
	}
	public void setCodigoIdentificacionCliente(String codigoIdentificacionCliente) {
		this.codigoIdentificacionCliente = codigoIdentificacionCliente;
	}
	public String getCodigoIdioma() {
		return codigoIdioma;
	}
	public void setCodigoIdioma(String codigoIdioma) {
		this.codigoIdioma = codigoIdioma;
	}
	public String getCodigoLimiteConsumo() {
		return codigoLimiteConsumo;
	}
	public void setCodigoLimiteConsumo(String codigoLimiteConsumo) {
		this.codigoLimiteConsumo = codigoLimiteConsumo;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getCodigoPlaza() {
		return codigoPlaza;
	}
	public void setCodigoPlaza(String codigoPlaza) {
		this.codigoPlaza = codigoPlaza;
	}
	public String getCodigoSubCategoria() {
		return codigoSubCategoria;
	}
	public void setCodigoSubCategoria(String codigoSubCategoria) {
		this.codigoSubCategoria = codigoSubCategoria;
	}
	public String getCodigoTipIdent2() {
		return codigoTipIdent2;
	}
	public void setCodigoTipIdent2(String codigoTipIdent2) {
		this.codigoTipIdent2 = codigoTipIdent2;
	}
	public String getCodigoTipoIdentificacionApoderado() {
		return codigoTipoIdentificacionApoderado;
	}
	public void setCodigoTipoIdentificacionApoderado(
			String codigoTipoIdentificacionApoderado) {
		this.codigoTipoIdentificacionApoderado = codigoTipoIdentificacionApoderado;
	}
	public String getCodigoTipoIdentificacionTributaria() {
		return codigoTipoIdentificacionTributaria;
	}
	public void setCodigoTipoIdentificacionTributaria(
			String codigoTipoIdentificacionTributaria) {
		this.codigoTipoIdentificacionTributaria = codigoTipoIdentificacionTributaria;
	}
	public String getDescripcionReferenciaDocumento() {
		return descripcionReferenciaDocumento;
	}
	public void setDescripcionReferenciaDocumento(
			String descripcionReferenciaDocumento) {
		this.descripcionReferenciaDocumento = descripcionReferenciaDocumento;
	}
	public String getDireccionEMail() {
		return direccionEMail;
	}
	public void setDireccionEMail(String direccionEMail) {
		this.direccionEMail = direccionEMail;
	}
	public String getIndicadorPrivacidad() {
		return indicadorPrivacidad;
	}
	public void setIndicadorPrivacidad(String indicadorPrivacidad) {
		this.indicadorPrivacidad = indicadorPrivacidad;
	}
	public String getNumeroCiclos() {
		return numeroCiclos;
	}
	public void setNumeroCiclos(String numeroCiclos) {
		this.numeroCiclos = numeroCiclos;
	}
	public String getNumeroIdentificacionApoderado() {
		return numeroIdentificacionApoderado;
	}
	public void setNumeroIdentificacionApoderado(
			String numeroIdentificacionApoderado) {
		this.numeroIdentificacionApoderado = numeroIdentificacionApoderado;
	}
	public String getNumeroIdentificacionTributaria() {
		return numeroIdentificacionTributaria;
	}
	public void setNumeroIdentificacionTributaria(
			String numeroIdentificacionTributaria) {
		this.numeroIdentificacionTributaria = numeroIdentificacionTributaria;
	}
	public String getNumeroMinutos() {
		return numeroMinutos;
	}
	public void setNumeroMinutos(String numeroMinutos) {
		this.numeroMinutos = numeroMinutos;
	}
	public String getNumeroOrdenServicio() {
		return numeroOrdenServicio;
	}
	public void setNumeroOrdenServicio(String numeroOrdenServicio) {
		this.numeroOrdenServicio = numeroOrdenServicio;
	}
	public String getNumIdent2() {
		return numIdent2;
	}
	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}
	public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}
	public void setTipoPlanTarifario(String tipoPlanTarifario) {
		this.tipoPlanTarifario = tipoPlanTarifario;
	}
	public String getIndicadorTraspaso() {
		return indicadorTraspaso;
	}
	public void setIndicadorTraspaso(String indicadorTraspaso) {
		this.indicadorTraspaso = indicadorTraspaso;
	}
	public String getCodigoModificacion() {
		return codigoModificacion;
	}
	public void setCodigoModificacion(String codigoModificacion) {
		this.codigoModificacion = codigoModificacion;
	}
	public String getCodigoDespacho() {
		return codigoDespacho;
	}
	public void setCodigoDespacho(String codigoDespacho) {
		this.codigoDespacho = codigoDespacho;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getDescripcionEmpresa() {
		return descripcionEmpresa;
	}
	public void setDescripcionEmpresa(String descripcionEmpresa) {
		this.descripcionEmpresa = descripcionEmpresa;
	}
	public int getNumeroAbonados() {
		return numeroAbonados;
	}
	public void setNumeroAbonados(int numeroAbonados) {
		this.numeroAbonados = numeroAbonados;
	}
	public String getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}
	public String getCodigoSector() {
		return codigoSector;
	}
	public void setCodigoSector(String codigoSector) {
		this.codigoSector = codigoSector;
	}
	public String getCodigoSupervisor() {
		return codigoSupervisor;
	}
	public void setCodigoSupervisor(String codigoSupervisor) {
		this.codigoSupervisor = codigoSupervisor;
	}
	public int getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(int codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodigoCategImpos() {
		return codigoCategImpos;
	}
	public void setCodigoCategImpos(String codigoCategImpos) {
		this.codigoCategImpos = codigoCategImpos;
	}
	public String getCodigoSubCategImpos() {
		return codigoSubCategImpos;
	}
	public void setCodigoSubCategImpos(String codigoSubCategImpos) {
		this.codigoSubCategImpos = codigoSubCategImpos;
	}
	public String getDescripcionSubCategImpos() {
		return descripcionSubCategImpos;
	}
	public void setDescripcionSubCategImpos(String descripcionSubCategImpos) {
		this.descripcionSubCategImpos = descripcionSubCategImpos;
	}
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
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getDescripcionCategoria() {
		return descripcionCategoria;
	}
	public void setDescripcionCategoria(String descripcionCategoria) {
		this.descripcionCategoria = descripcionCategoria;
	}
	public String getDescripcionCategImpos() {
		return descripcionCategImpos;
	}
	public void setDescripcionCategImpos(String descripcionCategImpos) {
		this.descripcionCategImpos = descripcionCategImpos;
	}
	public String getCodigoTipoCliente() {
		return codigoTipoCliente;
	}
	public void setCodigoTipoCliente(String codigoTipoCliente) {
		this.codigoTipoCliente = codigoTipoCliente;
	}
	public String getNombreUsuarOra() {
		return nombreUsuarOra;
	}
	public void setNombreUsuarOra(String nombreUsuarOra) {
		this.nombreUsuarOra = nombreUsuarOra;
	}
	public String getCodigoPlanComercial() {
		return codigoPlanComercial;
	}
	public void setCodigoPlanComercial(String codigoPlanComercial) {
		this.codigoPlanComercial = codigoPlanComercial;
	}
	public String getNumeroTelefono1() {
		return numeroTelefono1;
	}
	public void setNumeroTelefono1(String numeroTelefono1) {
		this.numeroTelefono1 = numeroTelefono1;
	}
	public String getNumeroTelefono2() {
		return numeroTelefono2;
	}
	public void setNumeroTelefono2(String numeroTelefono2) {
		this.numeroTelefono2 = numeroTelefono2;
	}
	public String getNumeroFax() {
		return numeroFax;
	}
	public void setNumeroFax(String numeroFax) {
		this.numeroFax = numeroFax;
	}
	public String getCodigoBanco() {
		return codigoBanco;
	}
	public void setCodigoBanco(String codigoBanco) {
		this.codigoBanco = codigoBanco;
	}
	public String getCodigoSistemaPago() {
		return codigoSistemaPago;
	}
	public void setCodigoSistemaPago(String codigoSistemaPago) {
		this.codigoSistemaPago = codigoSistemaPago;
	}
	public String getCodigoSucursal() {
		return codigoSucursal;
	}
	public void setCodigoSucursal(String codigoSucursal) {
		this.codigoSucursal = codigoSucursal;
	}
	public String getCodigoTipoTarjeta() {
		return codigoTipoTarjeta;
	}
	public void setCodigoTipoTarjeta(String codigoTipoTarjeta) {
		this.codigoTipoTarjeta = codigoTipoTarjeta;
	}
	public String getImporteLimiteDebito() {
		return importeLimiteDebito;
	}
	public void setImporteLimiteDebito(String importeLimiteDebito) {
		this.importeLimiteDebito = importeLimiteDebito;
	}
	public String getIndicadorDebito() {
		return indicadorDebito;
	}
	public void setIndicadorDebito(String indicadorDebito) {
		this.indicadorDebito = indicadorDebito;
	}
	public String getIndicadorTipoCuenta() {
		return indicadorTipoCuenta;
	}
	public void setIndicadorTipoCuenta(String indicadorTipoCuenta) {
		this.indicadorTipoCuenta = indicadorTipoCuenta;
	}
	public String getNumeroCuentaCorriente() {
		return numeroCuentaCorriente;
	}
	public void setNumeroCuentaCorriente(String numeroCuentaCorriente) {
		this.numeroCuentaCorriente = numeroCuentaCorriente;
	}
	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}
	public String getFechaVencimientoTarjeta() {
		return fechaVencimientoTarjeta;
	}
	public void setFechaVencimientoTarjeta(String fechaVencimientoTarjeta) {
		this.fechaVencimientoTarjeta = fechaVencimientoTarjeta;
	}
	public String getNombreApoderado() {
		return nombreApoderado;
	}
	public void setNombreApoderado(String nombreApoderado) {
		this.nombreApoderado = nombreApoderado;
	}
	
	public RepresentanteLegalDTO[] getRepresentanteLegalDTO() {
		return representanteLegalDTO;
	}
	public void setRepresentanteLegalDTO(
			RepresentanteLegalDTO[] representanteLegalDTO) {
		this.representanteLegalDTO = representanteLegalDTO;
	}
	public int getNumeroOrdenRepresentanteLegal() {
		return numeroOrdenRepresentanteLegal;
	}
	public void setNumeroOrdenRepresentanteLegal(int numeroOrdenRepresentanteLegal) {
		this.numeroOrdenRepresentanteLegal = numeroOrdenRepresentanteLegal;
	}
	
	public DireccionNegocioDTO[] getDirecciones() {
		return direcciones;
	}
	public void setDirecciones(DireccionNegocioDTO[] direcciones) {
		this.direcciones = direcciones;
	}
	public String getCodigoCobrador() {
		return codigoCobrador;
	}
	public void setCodigoCobrador(String codigoCobrador) {
		this.codigoCobrador = codigoCobrador;
	}
	public String getCodigo123() {
		return codigo123;
	}
	public void setCodigo123(String codigo123) {
		this.codigo123 = codigo123;
	}
	public String getCodigoABC() {
		return codigoABC;
	}
	public void setCodigoABC(String codigoABC) {
		this.codigoABC = codigoABC;
	}
	public String getCodigoCicloNuevo() {
		return codigoCicloNuevo;
	}
	public void setCodigoCicloNuevo(String codigoCicloNuevo) {
		this.codigoCicloNuevo = codigoCicloNuevo;
	}
	public String getCodigoNPI() {
		return codigoNPI;
	}
	public void setCodigoNPI(String codigoNPI) {
		this.codigoNPI = codigoNPI;
	}
	public String getCodigoOperadora() {
		return codigoOperadora;
	}
	public void setCodigoOperadora(String codigoOperadora) {
		this.codigoOperadora = codigoOperadora;
	}
	public String getCodigoPincli() {
		return codigoPincli;
	}
	public void setCodigoPincli(String codigoPincli) {
		this.codigoPincli = codigoPincli;
	}
	public String getCodigoProspecto() {
		return codigoProspecto;
	}
	public void setCodigoProspecto(String codigoProspecto) {
		this.codigoProspecto = codigoProspecto;
	}
	public String getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	public String getFechaAcepVenta() {
		return fechaAcepVenta;
	}
	public void setFechaAcepVenta(String fechaAcepVenta) {
		this.fechaAcepVenta = fechaAcepVenta;
	}
	public String getIndentificadorSegmento() {
		return indentificadorSegmento;
	}
	public void setIndentificadorSegmento(String indentificadorSegmento) {
		this.indentificadorSegmento = indentificadorSegmento;
	}
	public String getIndicadirTipPersona() {
		return indicadirTipPersona;
	}
	public void setIndicadirTipPersona(String indicadirTipPersona) {
		this.indicadirTipPersona = indicadirTipPersona;
	}
	public String getIndicadorAcepVenta() {
		return indicadorAcepVenta;
	}
	public void setIndicadorAcepVenta(String indicadorAcepVenta) {
		this.indicadorAcepVenta = indicadorAcepVenta;
	}
	public String getIndicadorAgente() {
		return indicadorAgente;
	}
	public void setIndicadorAgente(String indicadorAgente) {
		this.indicadorAgente = indicadorAgente;
	}
	public String getIndicadorAlta() {
		return indicadorAlta;
	}
	public void setIndicadorAlta(String indicadorAlta) {
		this.indicadorAlta = indicadorAlta;
	}
	public String getIndicadorMandato() {
		return indicadorMandato;
	}
	public void setIndicadorMandato(String indicadorMandato) {
		this.indicadorMandato = indicadorMandato;
	}
	public String getIndicadorSituacion() {
		return indicadorSituacion;
	}
	public void setIndicadorSituacion(String indicadorSituacion) {
		this.indicadorSituacion = indicadorSituacion;
	}
	public String getNombreUsuarioAsesor() {
		return nombreUsuarioAsesor;
	}
	public void setNombreUsuarioAsesor(String nombreUsuarioAsesor) {
		this.nombreUsuarioAsesor = nombreUsuarioAsesor;
	}
	public String getNumeroAbobeep() {
		return numeroAbobeep;
	}
	public void setNumeroAbobeep(String numeroAbobeep) {
		this.numeroAbobeep = numeroAbobeep;
	}
	public String getNumeroAbocel() {
		return numeroAbocel;
	}
	public void setNumeroAbocel(String numeroAbocel) {
		this.numeroAbocel = numeroAbocel;
	}
	public String getNumeroAborent() {
		return numeroAborent;
	}
	public void setNumeroAborent(String numeroAborent) {
		this.numeroAborent = numeroAborent;
	}
	public String getNumeroAboroaming() {
		return numeroAboroaming;
	}
	public void setNumeroAboroaming(String numeroAboroaming) {
		this.numeroAboroaming = numeroAboroaming;
	}
	public String getNumeroAbotrek() {
		return numeroAbotrek;
	}
	public void setNumeroAbotrek(String numeroAbotrek) {
		this.numeroAbotrek = numeroAbotrek;
	}
	public String getNumeroAbotrunk() {
		return numeroAbotrunk;
	}
	public void setNumeroAbotrunk(String numeroAbotrunk) {
		this.numeroAbotrunk = numeroAbotrunk;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroIntGrupoFam() {
		return numeroIntGrupoFam;
	}
	public void setNumeroIntGrupoFam(String numeroIntGrupoFam) {
		this.numeroIntGrupoFam = numeroIntGrupoFam;
	}
	public String getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(String numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
}
