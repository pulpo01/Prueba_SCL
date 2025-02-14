package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioReferenciaClienteDTO;

public class ClienteAltaDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String codigoCliente;
	private String codigoCuenta;
	private String nombreUsuarOra;
	private int codigoSupervisor;
	private int codigoVendedor;
	   
	//Direccion cuenta se llena estos datos con la direccion personal del cliente
	private String codMunicipio;
	private String codDepartamento;
	private String codZonaDistrito;
	private String locBarrio;
	private String codSiglaDomicilio;
	private String nombreCalle; 
	private String numeroCalle;
	private String observacionDireccion;
	private String codigoPostalDireccion;	
	private String desDirec2;
	
	/*De alta cliente common*/
	private CampanaVigenteComDTO campanaVigenteComDTO;
	private ModalidadCancelacionComDTO modalidadCancelacionComDTO;   
	private PlanComercialComDTO planComercialComDTO;
    
    /* Nuevos Guatemala - El Salvador */
	
	/* Clasificacion del cliente */
	private String codigoTipoCliente;
	private String codColor;
    private String codCrediticia;
    private String codSegmento;
    private String codCalificacion;
    private String codigoCategoria;    
    
    /* Datos Generales */
    private String codigoTipoIdentificacion;
    private String numeroIdentificacion;
    private String codigoTipIdent2;
    private String numIdent2;
    private String codigoCicloFacturacion;
    private String facturaElectronica;
    private String mensajePromocional;
    private String direccionEMail;
    private String codOperadoraAnterior;
    private String numeroTelefono1;
    
    /*Referencia del cliente */
    //(+)EV 02/11/2009
    //(+)---no usados---
    private String nombreReferenciaI;
    private String numeroReferenciaI;
    private String nombreReferenciaII;
    private String numeroReferenciaII;    
    //(-)---no usados---
    
    private FormularioReferenciaClienteDTO[] referenciasCliente;
    //(-)EV 02/11/2009
    
    /* Usuario LEGAL - AUTORIZADO  */
	private RepresentanteLegalComDTO[] representanteLegalComDTO;
	
    /* Cliente Particular */
	private String nombreApellido1;
	private String nombreApellido2;
	private String codigoPais;
	private String fechaNacimiento;
	private String indicadorSexo;
	private String indicadorEstadoCivil;	
    private String nomConyuge;
    private String nomEmpresaTrabaja;
    private String codigoActividad; //Profesion
    private String telefonoOficina;
    private String codCargo;
    private double ingresosMensuales;
    private String jefeInmediato;
    private Long cant_antLaborando;
    
    /* Cliente Empresa */    
    private String razonSocial;
    private String patenteComercio;
    private String codigoTipoIdentificacionApoderado;
    private String numeroIdentificacionApoderado;
    private String nombreApoderado;
    
    
    /* Factura a nombre de terceros */
    private String facturaNombreTercero;   
	private String nombreClienteFactura; 
	private String apellido1ClienteFactura;
	private String apellido2ClienteFactura;
	private String tipoIdentClienteFactura;			
	private String numeroIdentClienteFactura;
	private String tipoFacturaClienteFactura;
	private Long tipoDocumentoClienteFactura;
	private Long numVentaClienteFactura;
    	
	/* Datos adicionales */ 
	private String codigoOficina;
    private String codigoCategImpos;
    private String codigoSubCategImpos;
    private String categoriaTributaria;
    private String codigoTipoIdentificacionTributaria;
    private String numeroIdentificacionTributaria;
    
    /* Categoria de cambio*/
    private String codigoCategCambio;
    	
    /* Direcciones */
	private DireccionNegocioWebDTO[] direcciones;	    
            
	private String nombreCliente; //Toma el nombre de cliente particular u empresa segun corresponda
    
    
    /* datos de la cuenta */
    private String codigoSistemaPago;
    private String codigoBanco;
    private String codigoSucursal;
    private String indicadorTipoCuenta;
    private String codigoTipoTarjeta;
    private String numeroCuentaCorriente;
    private String numeroTarjeta;
    private String fechaVencimientoTarjeta;
    private String codigoBancoTarjeta;
    private String nomTipTarjeta;    
    private String obsPac;

    
    /*Datos necesario para el insert del cliente que no se encuentran en las paginas*/
    private String indicadorAgente;
    private String indicadorSituacion;
    private String indicadorTraspaso;
    private String codigoModificacion;   
    private String indicadorAcepVenta;
    private int codigoProducto;    
    private String codigoCalidadCliente;
    private String codigoABC;
    private String codigo123;
    private String codigoOperadora;
    private String codigoUso;
    private String codigoIdioma;    
    private int indicativoFacturable;
    private String codigoPlanComercial;
    
    private String numeroAbocel;			
    private String numeroAbobeep;			
    private String indicadorDebito;		    
    private String numeroAbotrunk;		    
    private String numeroAbotrek;
    private String numeroAborent;		    
    private String numeroAboroaming;			
    private String codigoNPI;
    private String indicadorAlta;
    private String numeroFax;
    private String indicadorMandato;    
    private String numeroTelefono2;
    private String codigoProspecto;
    private String fechaAcepVenta;
    private String importeLimiteDebito;
	private String fechaBaja;    
	private String codigoSubCategoria;
	private String nombreUsuarioAsesor;
	private String indentificadorSegmento;
	private String numeroIntGrupoFam;
	private String codigoCobrador;
	private String codigoPincli;
	private String numeroCelular;	
	private String indicadirTipPersona;
	private String codigoCicloNuevo;	
	private int codigoSector;
    private int numeroOrdenRepresentanteLegal;
    
    /* Datos adicionales empresa */
    private String planTarifario;
    private int numeroAbonados;
    private long codigoEmpresa;
    
	
    /* Datos adicionales modificacion del cliente no se encuentran en la pantalla de cliente */
    private String codigoIdentificacionCliente;
    private String indicadorPrivacidad;
    private String tipoPlanTarifario;
    private String codigoPlanTarifario;
    private String codigoCargoBasico;
    private String numeroOrdenServicio;
    private String numeroCiclos;
    private String numeroMinutos;
    private String codigoPlaza;
    private String descripcionReferenciaDocumento;
    private String codigoLimiteConsumo;
    
    //Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
    private String envioFacturaFisica;
    private String cuentaFacebook;
	private String cuentaTwitter;

	public String getEnvioFacturaFisica() {
		return envioFacturaFisica;
	}
	public void setEnvioFacturaFisica(String envioFacturaFisica) {
		this.envioFacturaFisica = envioFacturaFisica;
	}	
	public String getCuentaFacebook() {
		return cuentaFacebook;
	}
	public void setCuentaFacebook(String cuentaFacebook) {
		this.cuentaFacebook = cuentaFacebook;
	}
	public String getCuentaTwitter() {
		return cuentaTwitter;
	}
	public void setCuentaTwitter(String cuentaTwitter) {
		this.cuentaTwitter = cuentaTwitter;
	}    
	//Fin P-CSR-11002 JLGN 26-04-2011
	
	public String getPlanTarifario() {
		return planTarifario;
	}
	public void setPlanTarifario(String planTarifario) {
		this.planTarifario = planTarifario;
	}
	public int getCodigoSector() {
		return codigoSector;
	}
	public void setCodigoSector(int codigoSector) {
		this.codigoSector = codigoSector;
	}
	public CampanaVigenteComDTO getCampanaVigenteComDTO() {
		return campanaVigenteComDTO;
	}
	public void setCampanaVigenteComDTO(CampanaVigenteComDTO campanaVigenteComDTO) {
		this.campanaVigenteComDTO = campanaVigenteComDTO;
	}
	public Long getCant_antLaborando() {
		return cant_antLaborando;
	}
	public void setCant_antLaborando(Long cant_antLaborando) {
		this.cant_antLaborando = cant_antLaborando;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}	
	public String getCodCalificacion() {
		return codCalificacion;
	}
	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}
	public String getCodCargo() {
		return codCargo;
	}
	public void setCodCargo(String codCargo) {
		this.codCargo = codCargo;
	}
	public String getCodColor() {
		return codColor;
	}
	public void setCodColor(String codColor) {
		this.codColor = codColor;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	public String getCodDepartamento() {
		return codDepartamento;
	}
	public void setCodDepartamento(String codDepartamento) {
		this.codDepartamento = codDepartamento;
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
	public String getCodigoCalidadCliente() {
		return codigoCalidadCliente;
	}
	public void setCodigoCalidadCliente(String codigoCalidadCliente) {
		this.codigoCalidadCliente = codigoCalidadCliente;
	}
	public String getCodigoCategImpos() {
		return codigoCategImpos;
	}
	public void setCodigoCategImpos(String codigoCategImpos) {
		this.codigoCategImpos = codigoCategImpos;
	}
	public String getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(String codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	public String getCodigoIdioma() {
		return codigoIdioma;
	}
	public void setCodigoIdioma(String codigoIdioma) {
		this.codigoIdioma = codigoIdioma;
	}
	public String getCodigoModificacion() {
		return codigoModificacion;
	}
	public void setCodigoModificacion(String codigoModificacion) {
		this.codigoModificacion = codigoModificacion;
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
	public String getCodigoPlanComercial() {
		return codigoPlanComercial;
	}
	public void setCodigoPlanComercial(String codigoPlanComercial) {
		this.codigoPlanComercial = codigoPlanComercial;
	}
	public String getCodigoPostalDireccion() {
		return codigoPostalDireccion;
	}
	public void setCodigoPostalDireccion(String codigoPostalDireccion) {
		this.codigoPostalDireccion = codigoPostalDireccion;
	}	
	public String getCodigoSubCategImpos() {
		return codigoSubCategImpos;
	}
	public void setCodigoSubCategImpos(String codigoSubCategImpos) {
		this.codigoSubCategImpos = codigoSubCategImpos;
	}	
	public String getCodigoTipoCliente() {
		return codigoTipoCliente;
	}
	public void setCodigoTipoCliente(String codigoTipoCliente) {
		this.codigoTipoCliente = codigoTipoCliente;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getCodigoUso() {
		return codigoUso;
	}
	public void setCodigoUso(String codigoUso) {
		this.codigoUso = codigoUso;
	}
	public String getCodMunicipio() {
		return codMunicipio;
	}
	public void setCodMunicipio(String codMunicipio) {
		this.codMunicipio = codMunicipio;
	}
	public String getCodOperadoraAnterior() {
		return codOperadoraAnterior;
	}
	public void setCodOperadoraAnterior(String codOperadoraAnterior) {
		this.codOperadoraAnterior = codOperadoraAnterior;
	}	
	public String getCodSegmento() {
		return codSegmento;
	}
	public void setCodSegmento(String codSegmento) {
		this.codSegmento = codSegmento;
	}
	public String getCodSiglaDomicilio() {
		return codSiglaDomicilio;
	}
	public void setCodSiglaDomicilio(String codSiglaDomicilio) {
		this.codSiglaDomicilio = codSiglaDomicilio;
	}
	public String getCodZonaDistrito() {
		return codZonaDistrito;
	}
	public void setCodZonaDistrito(String codZonaDistrito) {
		this.codZonaDistrito = codZonaDistrito;
	}	
	public int getIndicativoFacturable() {
		return indicativoFacturable;
	}
	public void setIndicativoFacturable(int indicativoFacturable) {
		this.indicativoFacturable = indicativoFacturable;
	}	
	public DireccionNegocioWebDTO[] getDirecciones() {
		return direcciones;
	}
	public void setDirecciones(DireccionNegocioWebDTO[] direcciones) {
		this.direcciones = direcciones;
	}
	public String getFacturaNombreTercero() {
		return facturaNombreTercero;
	}
	public void setFacturaNombreTercero(String facturaNombreTercero) {
		this.facturaNombreTercero = facturaNombreTercero;
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
	public String getIndicadorDebito() {
		return indicadorDebito;
	}
	public void setIndicadorDebito(String indicadorDebito) {
		this.indicadorDebito = indicadorDebito;
	}
	public String getIndicadorSituacion() {
		return indicadorSituacion;
	}
	public void setIndicadorSituacion(String indicadorSituacion) {
		this.indicadorSituacion = indicadorSituacion;
	}
	public String getIndicadorTraspaso() {
		return indicadorTraspaso;
	}
	public void setIndicadorTraspaso(String indicadorTraspaso) {
		this.indicadorTraspaso = indicadorTraspaso;
	}
	public String getJefeInmediato() {
		return jefeInmediato;
	}
	public void setJefeInmediato(String jefeInmediato) {
		this.jefeInmediato = jefeInmediato;
	}
	public String getLocBarrio() {
		return locBarrio;
	}
	public void setLocBarrio(String locBarrio) {
		this.locBarrio = locBarrio;
	}
	public String getMensajePromocional() {
		return mensajePromocional;
	}
	public void setMensajePromocional(String mensajePromocional) {
		this.mensajePromocional = mensajePromocional;
	}
	public ModalidadCancelacionComDTO getModalidadCancelacionComDTO() {
		return modalidadCancelacionComDTO;
	}
	public void setModalidadCancelacionComDTO(
			ModalidadCancelacionComDTO modalidadCancelacionComDTO) {
		this.modalidadCancelacionComDTO = modalidadCancelacionComDTO;
	}
	public String getNombreCalle() {
		return nombreCalle;
	}
	public void setNombreCalle(String nombreCalle) {
		this.nombreCalle = nombreCalle;
	}
	public String getNombreReferenciaI() {
		return nombreReferenciaI;
	}
	public void setNombreReferenciaI(String nombreReferenciaI) {
		this.nombreReferenciaI = nombreReferenciaI;
	}
	public String getNombreReferenciaII() {
		return nombreReferenciaII;
	}
	public void setNombreReferenciaII(String nombreReferenciaII) {
		this.nombreReferenciaII = nombreReferenciaII;
	}
	public String getNombreUsuarOra() {
		return nombreUsuarOra;
	}
	public void setNombreUsuarOra(String nombreUsuarOra) {
		this.nombreUsuarOra = nombreUsuarOra;
	}
	public String getNomConyuge() {
		return nomConyuge;
	}
	public void setNomConyuge(String nomConyuge) {
		this.nomConyuge = nomConyuge;
	}
	public String getNomEmpresaTrabaja() {
		return nomEmpresaTrabaja;
	}
	public void setNomEmpresaTrabaja(String nomEmpresaTrabaja) {
		this.nomEmpresaTrabaja = nomEmpresaTrabaja;
	}
	public String getNomTipTarjeta() {
		return nomTipTarjeta;
	}
	public void setNomTipTarjeta(String nomTipTarjeta) {
		this.nomTipTarjeta = nomTipTarjeta;
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
	public String getNumeroCalle() {
		return numeroCalle;
	}
	public void setNumeroCalle(String numeroCalle) {
		this.numeroCalle = numeroCalle;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getNumeroReferenciaI() {
		return numeroReferenciaI;
	}
	public void setNumeroReferenciaI(String numeroReferenciaI) {
		this.numeroReferenciaI = numeroReferenciaI;
	}
	public String getNumeroReferenciaII() {
		return numeroReferenciaII;
	}
	public void setNumeroReferenciaII(String numeroReferenciaII) {
		this.numeroReferenciaII = numeroReferenciaII;
	}
	public String getObservacionDireccion() {
		return observacionDireccion;
	}
	public void setObservacionDireccion(String observacionDireccion) {
		this.observacionDireccion = observacionDireccion;
	}	
	public String getPatenteComercio() {
		return patenteComercio;
	}
	public void setPatenteComercio(String patenteComercio) {
		this.patenteComercio = patenteComercio;
	}
	public PlanComercialComDTO getPlanComercialComDTO() {
		return planComercialComDTO;
	}
	public void setPlanComercialComDTO(PlanComercialComDTO planComercialComDTO) {
		this.planComercialComDTO = planComercialComDTO;
	}	
	public String getRazonSocial() {
		return razonSocial;
	}
	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}
	public RepresentanteLegalComDTO[] getRepresentanteLegalComDTO() {
		return representanteLegalComDTO;
	}
	public void setRepresentanteLegalComDTO(
			RepresentanteLegalComDTO[] representanteLegalComDTO) {
		this.representanteLegalComDTO = representanteLegalComDTO;
	}	
	public String getTelefonoOficina() {
		return telefonoOficina;
	}
	public void setTelefonoOficina(String telefonoOficina) {
		this.telefonoOficina = telefonoOficina;
	}
	public String getIndicadorAlta() {
		return indicadorAlta;
	}
	public void setIndicadorAlta(String indicadorAlta) {
		this.indicadorAlta = indicadorAlta;
	}
	public String getCodigoCicloFacturacion() {
		return codigoCicloFacturacion;
	}
	public void setCodigoCicloFacturacion(String codigoCicloFacturacion) {
		this.codigoCicloFacturacion = codigoCicloFacturacion;
	}
	public int getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(int codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public int getNumeroOrdenRepresentanteLegal() {
		return numeroOrdenRepresentanteLegal;
	}
	public void setNumeroOrdenRepresentanteLegal(int numeroOrdenRepresentanteLegal) {
		this.numeroOrdenRepresentanteLegal = numeroOrdenRepresentanteLegal;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}	
	public String getFacturaElectronica() {
		return facturaElectronica;
	}
	public void setFacturaElectronica(String facturaElectronica) {
		this.facturaElectronica = facturaElectronica;
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
	public String getCodigoPais() {
		return codigoPais;
	}
	public void setCodigoPais(String codigoPais) {
		this.codigoPais = codigoPais;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getIndicadorSexo() {
		return indicadorSexo;
	}
	public void setIndicadorSexo(String indicadorSexo) {
		this.indicadorSexo = indicadorSexo;
	}
	public String getIndicadorEstadoCivil() {
		return indicadorEstadoCivil;
	}
	public void setIndicadorEstadoCivil(String indicadorEstadoCivil) {
		this.indicadorEstadoCivil = indicadorEstadoCivil;
	}	
	public String getCodigoActividad() {
		return codigoActividad;
	}
	public void setCodigoActividad(String codigoActividad) {
		this.codigoActividad = codigoActividad;
	}
	public String getNumeroFax() {
		return numeroFax;
	}
	public void setNumeroFax(String numeroFax) {
		this.numeroFax = numeroFax;
	}
	public String getIndicadorMandato() {
		return indicadorMandato;
	}
	public void setIndicadorMandato(String indicadorMandato) {
		this.indicadorMandato = indicadorMandato;
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
	public String getCodigoProspecto() {
		return codigoProspecto;
	}
	public void setCodigoProspecto(String codigoProspecto) {
		this.codigoProspecto = codigoProspecto;
	}
	public String getFechaAcepVenta() {
		return fechaAcepVenta;
	}
	public void setFechaAcepVenta(String fechaAcepVenta) {
		this.fechaAcepVenta = fechaAcepVenta;
	}
	public String getImporteLimiteDebito() {
		return importeLimiteDebito;
	}
	public void setImporteLimiteDebito(String importeLimiteDebito) {
		this.importeLimiteDebito = importeLimiteDebito;
	}
	public String getDireccionEMail() {
		return direccionEMail;
	}
	public void setDireccionEMail(String direccionEMail) {
		this.direccionEMail = direccionEMail;
	}
	public String getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	public String getCodigoTipoIdentificacionTributaria() {
		return codigoTipoIdentificacionTributaria;
	}
	public void setCodigoTipoIdentificacionTributaria(
			String codigoTipoIdentificacionTributaria) {
		this.codigoTipoIdentificacionTributaria = codigoTipoIdentificacionTributaria;
	}
	public String getNumeroIdentificacionTributaria() {
		return numeroIdentificacionTributaria;
	}
	public void setNumeroIdentificacionTributaria(
			String numeroIdentificacionTributaria) {
		this.numeroIdentificacionTributaria = numeroIdentificacionTributaria;
	}
	public String getCodigoTipoIdentificacionApoderado() {
		return codigoTipoIdentificacionApoderado;
	}
	public void setCodigoTipoIdentificacionApoderado(
			String codigoTipoIdentificacionApoderado) {
		this.codigoTipoIdentificacionApoderado = codigoTipoIdentificacionApoderado;
	}
	public String getNombreApoderado() {
		return nombreApoderado;
	}
	public void setNombreApoderado(String nombreApoderado) {
		this.nombreApoderado = nombreApoderado;
	}
	public String getNumeroIdentificacionApoderado() {
		return numeroIdentificacionApoderado;
	}
	public void setNumeroIdentificacionApoderado(
			String numeroIdentificacionApoderado) {
		this.numeroIdentificacionApoderado = numeroIdentificacionApoderado;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
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
	public String getNumIdent2() {
		return numIdent2;
	}
	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}
	public String getNombreUsuarioAsesor() {
		return nombreUsuarioAsesor;
	}
	public void setNombreUsuarioAsesor(String nombreUsuarioAsesor) {
		this.nombreUsuarioAsesor = nombreUsuarioAsesor;
	}
	public String getIndentificadorSegmento() {
		return indentificadorSegmento;
	}
	public void setIndentificadorSegmento(String indentificadorSegmento) {
		this.indentificadorSegmento = indentificadorSegmento;
	}
	public String getNumeroIntGrupoFam() {
		return numeroIntGrupoFam;
	}
	public void setNumeroIntGrupoFam(String numeroIntGrupoFam) {
		this.numeroIntGrupoFam = numeroIntGrupoFam;
	}
	public String getCodigoCicloNuevo() {
		return codigoCicloNuevo;
	}
	public void setCodigoCicloNuevo(String codigoCicloNuevo) {
		this.codigoCicloNuevo = codigoCicloNuevo;
	}
	public String getCodigoCobrador() {
		return codigoCobrador;
	}
	public void setCodigoCobrador(String codigoCobrador) {
		this.codigoCobrador = codigoCobrador;
	}
	public String getCodigoPincli() {
		return codigoPincli;
	}
	public void setCodigoPincli(String codigoPincli) {
		this.codigoPincli = codigoPincli;
	}
	
	public String getIndicadirTipPersona() {
		return indicadirTipPersona;
	}
	public void setIndicadirTipPersona(String indicadirTipPersona) {
		this.indicadirTipPersona = indicadirTipPersona;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public int getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(int codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public void setCodigoSupervisor(int codigoSupervisor) {
		this.codigoSupervisor = codigoSupervisor;
	}
	public String getCodigoBanco() {
		return codigoBanco;
	}
	public void setCodigoBanco(String codigoBanco) {
		this.codigoBanco = codigoBanco;
	}
	public String getCodigoBancoTarjeta() {
		return codigoBancoTarjeta;
	}
	public void setCodigoBancoTarjeta(String codigoBancoTarjeta) {
		this.codigoBancoTarjeta = codigoBancoTarjeta;
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
	public String getFechaVencimientoTarjeta() {
		return fechaVencimientoTarjeta;
	}
	public void setFechaVencimientoTarjeta(String fechaVencimientoTarjeta) {
		this.fechaVencimientoTarjeta = fechaVencimientoTarjeta;
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
	public String getCodigoSistemaPago() {
		return codigoSistemaPago;
	}
	public void setCodigoSistemaPago(String codigoSistemaPago) {
		this.codigoSistemaPago = codigoSistemaPago;
	}	
	public int getCodigoSupervisor() {
		return codigoSupervisor;
	}
	public int getNumeroAbonados() {
		return numeroAbonados;
	}
	public void setNumeroAbonados(int numeroAbonados) {
		this.numeroAbonados = numeroAbonados;
	}
	public long getCodigoEmpresa() {
		return codigoEmpresa;
	}
	public void setCodigoEmpresa(long codigoEmpresa) {
		this.codigoEmpresa = codigoEmpresa;
	}
	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}
	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}
	public String getCodigoIdentificacionCliente() {
		return codigoIdentificacionCliente;
	}
	public void setCodigoIdentificacionCliente(String codigoIdentificacionCliente) {
		this.codigoIdentificacionCliente = codigoIdentificacionCliente;
	}
	public String getCodigoLimiteConsumo() {
		return codigoLimiteConsumo;
	}
	public void setCodigoLimiteConsumo(String codigoLimiteConsumo) {
		this.codigoLimiteConsumo = codigoLimiteConsumo;
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
	public String getDescripcionReferenciaDocumento() {
		return descripcionReferenciaDocumento;
	}
	public void setDescripcionReferenciaDocumento(
			String descripcionReferenciaDocumento) {
		this.descripcionReferenciaDocumento = descripcionReferenciaDocumento;
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
	public String getTipoPlanTarifario() {
		return tipoPlanTarifario;
	}
	public void setTipoPlanTarifario(String tipoPlanTarifario) {
		this.tipoPlanTarifario = tipoPlanTarifario;
	}
	public String getApellido1ClienteFactura() {
		return apellido1ClienteFactura;
	}
	public void setApellido1ClienteFactura(String apellido1ClienteFactura) {
		this.apellido1ClienteFactura = apellido1ClienteFactura;
	}
	public String getApellido2ClienteFactura() {
		return apellido2ClienteFactura;
	}
	public void setApellido2ClienteFactura(String apellido2ClienteFactura) {
		this.apellido2ClienteFactura = apellido2ClienteFactura;
	}
	public String getNombreClienteFactura() {
		return nombreClienteFactura;
	}
	public void setNombreClienteFactura(String nombreClienteFactura) {
		this.nombreClienteFactura = nombreClienteFactura;
	}
	public String getNumeroIdentClienteFactura() {
		return numeroIdentClienteFactura;
	}
	public void setNumeroIdentClienteFactura(String numeroIdentClienteFactura) {
		this.numeroIdentClienteFactura = numeroIdentClienteFactura;
	}
	public String getTipoIdentClienteFactura() {
		return tipoIdentClienteFactura;
	}
	public void setTipoIdentClienteFactura(String tipoIdentClienteFactura) {
		this.tipoIdentClienteFactura = tipoIdentClienteFactura;
	}
	public double getIngresosMensuales() {
		return ingresosMensuales;
	}
	public void setIngresosMensuales(double ingresosMensuales) {
		this.ingresosMensuales = ingresosMensuales;
	}
	public String getObsPac() {
		return obsPac;
	}
	public void setObsPac(String obsPac) {
		this.obsPac = obsPac;
	}
	public String getTipoFacturaClienteFactura() {
		return tipoFacturaClienteFactura;
	}
	public void setTipoFacturaClienteFactura(String tipoFacturaClienteFactura) {
		this.tipoFacturaClienteFactura = tipoFacturaClienteFactura;
	}
	public Long getNumVentaClienteFactura() {
		return numVentaClienteFactura;
	}
	public void setNumVentaClienteFactura(Long numVentaClienteFactura) {
		this.numVentaClienteFactura = numVentaClienteFactura;
	}
	public Long getTipoDocumentoClienteFactura() {
		return tipoDocumentoClienteFactura;
	}
	public void setTipoDocumentoClienteFactura(Long tipoDocumentoClienteFactura) {
		this.tipoDocumentoClienteFactura = tipoDocumentoClienteFactura;
	}
	public FormularioReferenciaClienteDTO[] getReferenciasCliente() {
		return referenciasCliente;
	}
	public void setReferenciasCliente(
			FormularioReferenciaClienteDTO[] referenciasCliente) {
		this.referenciasCliente = referenciasCliente;
	}
	public String getCodigoCategCambio() {
		return codigoCategCambio;
	}
	public void setCodigoCategCambio(String codigoCategCambio) {
		this.codigoCategCambio = codigoCategCambio;
	}
	public String getDesDirec2() {
		return desDirec2;
	}
	public void setDesDirec2(String desDirec2) {
		this.desDirec2 = desDirec2;
	}
}//fin CuentaDTO
