/**
 * ClienteDTO.java
 *
 * This file was auto-generated from WSDL
 * by the Apache Axis 1.4 Apr 22, 2006 (06:55:48 PDT) WSDL2Java emitter.
 */

package dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com;

public class ClienteDTO  implements java.io.Serializable {
    private java.lang.String categoriaTributaria;

    private java.lang.String codigo123;

    private java.lang.String codigoABC;

    private java.lang.String codigoActividad;

    private java.lang.String codigoBanco;

    private java.lang.String codigoBancoTarjeta;

    private java.lang.String codigoCalidadCliente;

    private java.lang.String codigoCargoBasico;

    private java.lang.String codigoCategImpos;

    private java.lang.String codigoCategoria;

    private java.lang.String codigoCategoriaEmpresa;

    private java.lang.String codigoCelda;

    private int codigoCiclo;

    private java.lang.String codigoCicloFacturacion;

    private java.lang.String codigoCicloNuevo;

    private java.lang.String codigoCliente;

    private java.lang.String codigoCobrador;

    private java.lang.String codigoCuenta;

    private java.lang.String codigoDespacho;

    private long codigoEmpresa;

    private java.lang.String codigoIdentificacionCliente;

    private java.lang.String codigoIdioma;

    private java.lang.String codigoLimiteConsumo;

    private java.lang.String codigoModificacion;

    private java.lang.String codigoNPI;

    private java.lang.String codigoOficina;

    private java.lang.String codigoOperadora;

    private java.lang.String codigoPais;

    private java.lang.String codigoPincli;

    private java.lang.String codigoPlanComercial;

    private java.lang.String codigoPlanTarifario;

    private java.lang.String codigoPlaza;

    private int codigoProducto;

    private java.lang.String codigoProspecto;

    private java.lang.String codigoSector;

    private java.lang.String codigoSistemaPago;

    private java.lang.String codigoSubCategImpos;

    private java.lang.String codigoSubCategoria;

    private java.lang.String codigoSubCuenta;

    private java.lang.String codigoSucursal;

    private java.lang.String codigoSupervisor;

    private java.lang.String codigoTipIdent2;

    private java.lang.String codigoTipoCliente;

    private java.lang.String codigoTipoIdentificacion;

    private java.lang.String codigoTipoIdentificacionApoderado;

    private java.lang.String codigoTipoIdentificacionTributaria;

    private java.lang.String codigoTipoTarjeta;

    private java.lang.String codigoUso;

    private int codigoVendedor;

    private java.lang.String descripcionCategImpos;

    private java.lang.String descripcionCategoria;

    private java.lang.String descripcionEmpresa;

    private java.lang.String descripcionReferenciaDocumento;

    private java.lang.String descripcionSubCategImpos;

    private java.lang.String direccionEMail;

    private dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionNegocioDTO[] direcciones;

    private int existeCliente;

    private java.lang.String fechaAcepVenta;

    private java.lang.String fechaBaja;

    private java.lang.String fechaDesde;

    private java.lang.String fechaHasta;

    private java.lang.String fechaNacimiento;

    private java.lang.String fechaVencimientoTarjeta;

    private java.lang.String importeLimiteDebito;

    private java.lang.String indentificadorSegmento;

    private java.lang.String indicadirTipPersona;

    private java.lang.String indicadorAcepVenta;

    private java.lang.String indicadorAgente;

    private java.lang.String indicadorAlta;

    private java.lang.String indicadorDebito;

    private java.lang.String indicadorEstadoCivil;

    private java.lang.String indicadorMandato;

    private java.lang.String indicadorPrivacidad;

    private java.lang.String indicadorSexo;

    private java.lang.String indicadorSituacion;

    private java.lang.String indicadorTipoCuenta;

    private java.lang.String indicadorTraspaso;

    private int indicativoFacturable;

    private double limiteCredito;

    private java.lang.String nombreApellido1;

    private java.lang.String nombreApellido2;

    private java.lang.String nombreApoderado;

    private java.lang.String nombreCliente;

    private java.lang.String nombreUsuarOra;

    private java.lang.String nombreUsuarioAsesor;

    private java.lang.String numIdent2;

    private long numMesesCobro;

    private java.lang.String numeroAbobeep;

    private java.lang.String numeroAbocel;

    private int numeroAbonados;

    private java.lang.String numeroAborent;

    private java.lang.String numeroAboroaming;

    private java.lang.String numeroAbotrek;

    private java.lang.String numeroAbotrunk;

    private java.lang.String numeroCelular;

    private java.lang.String numeroCiclos;

    private java.lang.String numeroCuentaCorriente;

    private java.lang.String numeroFax;

    private java.lang.String numeroIdentificacion;

    private java.lang.String numeroIdentificacionApoderado;

    private java.lang.String numeroIdentificacionTributaria;

    private java.lang.String numeroIntGrupoFam;

    private java.lang.String numeroMinutos;

    private int numeroOrdenRepresentanteLegal;

    private java.lang.String numeroOrdenServicio;

    private java.lang.String numeroTarjeta;

    private java.lang.String numeroTelefono;

    private java.lang.String numeroTelefono1;

    private java.lang.String numeroTelefono2;

    private java.lang.String planComercial;

    private java.lang.String planTarifario;

    private dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RepresentanteLegalDTO[] representanteLegalDTO;

    private java.lang.String tipoCliente;

    private java.lang.String tipoPlanTarifario;

    private java.lang.String usuario;

    public ClienteDTO() {
    }

    public ClienteDTO(
           java.lang.String categoriaTributaria,
           java.lang.String codigo123,
           java.lang.String codigoABC,
           java.lang.String codigoActividad,
           java.lang.String codigoBanco,
           java.lang.String codigoBancoTarjeta,
           java.lang.String codigoCalidadCliente,
           java.lang.String codigoCargoBasico,
           java.lang.String codigoCategImpos,
           java.lang.String codigoCategoria,
           java.lang.String codigoCategoriaEmpresa,
           java.lang.String codigoCelda,
           int codigoCiclo,
           java.lang.String codigoCicloFacturacion,
           java.lang.String codigoCicloNuevo,
           java.lang.String codigoCliente,
           java.lang.String codigoCobrador,
           java.lang.String codigoCuenta,
           java.lang.String codigoDespacho,
           long codigoEmpresa,
           java.lang.String codigoIdentificacionCliente,
           java.lang.String codigoIdioma,
           java.lang.String codigoLimiteConsumo,
           java.lang.String codigoModificacion,
           java.lang.String codigoNPI,
           java.lang.String codigoOficina,
           java.lang.String codigoOperadora,
           java.lang.String codigoPais,
           java.lang.String codigoPincli,
           java.lang.String codigoPlanComercial,
           java.lang.String codigoPlanTarifario,
           java.lang.String codigoPlaza,
           int codigoProducto,
           java.lang.String codigoProspecto,
           java.lang.String codigoSector,
           java.lang.String codigoSistemaPago,
           java.lang.String codigoSubCategImpos,
           java.lang.String codigoSubCategoria,
           java.lang.String codigoSubCuenta,
           java.lang.String codigoSucursal,
           java.lang.String codigoSupervisor,
           java.lang.String codigoTipIdent2,
           java.lang.String codigoTipoCliente,
           java.lang.String codigoTipoIdentificacion,
           java.lang.String codigoTipoIdentificacionApoderado,
           java.lang.String codigoTipoIdentificacionTributaria,
           java.lang.String codigoTipoTarjeta,
           java.lang.String codigoUso,
           int codigoVendedor,
           java.lang.String descripcionCategImpos,
           java.lang.String descripcionCategoria,
           java.lang.String descripcionEmpresa,
           java.lang.String descripcionReferenciaDocumento,
           java.lang.String descripcionSubCategImpos,
           java.lang.String direccionEMail,
           dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionNegocioDTO[] direcciones,
           int existeCliente,
           java.lang.String fechaAcepVenta,
           java.lang.String fechaBaja,
           java.lang.String fechaDesde,
           java.lang.String fechaHasta,
           java.lang.String fechaNacimiento,
           java.lang.String fechaVencimientoTarjeta,
           java.lang.String importeLimiteDebito,
           java.lang.String indentificadorSegmento,
           java.lang.String indicadirTipPersona,
           java.lang.String indicadorAcepVenta,
           java.lang.String indicadorAgente,
           java.lang.String indicadorAlta,
           java.lang.String indicadorDebito,
           java.lang.String indicadorEstadoCivil,
           java.lang.String indicadorMandato,
           java.lang.String indicadorPrivacidad,
           java.lang.String indicadorSexo,
           java.lang.String indicadorSituacion,
           java.lang.String indicadorTipoCuenta,
           java.lang.String indicadorTraspaso,
           int indicativoFacturable,
           double limiteCredito,
           java.lang.String nombreApellido1,
           java.lang.String nombreApellido2,
           java.lang.String nombreApoderado,
           java.lang.String nombreCliente,
           java.lang.String nombreUsuarOra,
           java.lang.String nombreUsuarioAsesor,
           java.lang.String numIdent2,
           long numMesesCobro,
           java.lang.String numeroAbobeep,
           java.lang.String numeroAbocel,
           int numeroAbonados,
           java.lang.String numeroAborent,
           java.lang.String numeroAboroaming,
           java.lang.String numeroAbotrek,
           java.lang.String numeroAbotrunk,
           java.lang.String numeroCelular,
           java.lang.String numeroCiclos,
           java.lang.String numeroCuentaCorriente,
           java.lang.String numeroFax,
           java.lang.String numeroIdentificacion,
           java.lang.String numeroIdentificacionApoderado,
           java.lang.String numeroIdentificacionTributaria,
           java.lang.String numeroIntGrupoFam,
           java.lang.String numeroMinutos,
           int numeroOrdenRepresentanteLegal,
           java.lang.String numeroOrdenServicio,
           java.lang.String numeroTarjeta,
           java.lang.String numeroTelefono,
           java.lang.String numeroTelefono1,
           java.lang.String numeroTelefono2,
           java.lang.String planComercial,
           java.lang.String planTarifario,
           dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RepresentanteLegalDTO[] representanteLegalDTO,
           java.lang.String tipoCliente,
           java.lang.String tipoPlanTarifario,
           java.lang.String usuario) {
           this.categoriaTributaria = categoriaTributaria;
           this.codigo123 = codigo123;
           this.codigoABC = codigoABC;
           this.codigoActividad = codigoActividad;
           this.codigoBanco = codigoBanco;
           this.codigoBancoTarjeta = codigoBancoTarjeta;
           this.codigoCalidadCliente = codigoCalidadCliente;
           this.codigoCargoBasico = codigoCargoBasico;
           this.codigoCategImpos = codigoCategImpos;
           this.codigoCategoria = codigoCategoria;
           this.codigoCategoriaEmpresa = codigoCategoriaEmpresa;
           this.codigoCelda = codigoCelda;
           this.codigoCiclo = codigoCiclo;
           this.codigoCicloFacturacion = codigoCicloFacturacion;
           this.codigoCicloNuevo = codigoCicloNuevo;
           this.codigoCliente = codigoCliente;
           this.codigoCobrador = codigoCobrador;
           this.codigoCuenta = codigoCuenta;
           this.codigoDespacho = codigoDespacho;
           this.codigoEmpresa = codigoEmpresa;
           this.codigoIdentificacionCliente = codigoIdentificacionCliente;
           this.codigoIdioma = codigoIdioma;
           this.codigoLimiteConsumo = codigoLimiteConsumo;
           this.codigoModificacion = codigoModificacion;
           this.codigoNPI = codigoNPI;
           this.codigoOficina = codigoOficina;
           this.codigoOperadora = codigoOperadora;
           this.codigoPais = codigoPais;
           this.codigoPincli = codigoPincli;
           this.codigoPlanComercial = codigoPlanComercial;
           this.codigoPlanTarifario = codigoPlanTarifario;
           this.codigoPlaza = codigoPlaza;
           this.codigoProducto = codigoProducto;
           this.codigoProspecto = codigoProspecto;
           this.codigoSector = codigoSector;
           this.codigoSistemaPago = codigoSistemaPago;
           this.codigoSubCategImpos = codigoSubCategImpos;
           this.codigoSubCategoria = codigoSubCategoria;
           this.codigoSubCuenta = codigoSubCuenta;
           this.codigoSucursal = codigoSucursal;
           this.codigoSupervisor = codigoSupervisor;
           this.codigoTipIdent2 = codigoTipIdent2;
           this.codigoTipoCliente = codigoTipoCliente;
           this.codigoTipoIdentificacion = codigoTipoIdentificacion;
           this.codigoTipoIdentificacionApoderado = codigoTipoIdentificacionApoderado;
           this.codigoTipoIdentificacionTributaria = codigoTipoIdentificacionTributaria;
           this.codigoTipoTarjeta = codigoTipoTarjeta;
           this.codigoUso = codigoUso;
           this.codigoVendedor = codigoVendedor;
           this.descripcionCategImpos = descripcionCategImpos;
           this.descripcionCategoria = descripcionCategoria;
           this.descripcionEmpresa = descripcionEmpresa;
           this.descripcionReferenciaDocumento = descripcionReferenciaDocumento;
           this.descripcionSubCategImpos = descripcionSubCategImpos;
           this.direccionEMail = direccionEMail;
           this.direcciones = direcciones;
           this.existeCliente = existeCliente;
           this.fechaAcepVenta = fechaAcepVenta;
           this.fechaBaja = fechaBaja;
           this.fechaDesde = fechaDesde;
           this.fechaHasta = fechaHasta;
           this.fechaNacimiento = fechaNacimiento;
           this.fechaVencimientoTarjeta = fechaVencimientoTarjeta;
           this.importeLimiteDebito = importeLimiteDebito;
           this.indentificadorSegmento = indentificadorSegmento;
           this.indicadirTipPersona = indicadirTipPersona;
           this.indicadorAcepVenta = indicadorAcepVenta;
           this.indicadorAgente = indicadorAgente;
           this.indicadorAlta = indicadorAlta;
           this.indicadorDebito = indicadorDebito;
           this.indicadorEstadoCivil = indicadorEstadoCivil;
           this.indicadorMandato = indicadorMandato;
           this.indicadorPrivacidad = indicadorPrivacidad;
           this.indicadorSexo = indicadorSexo;
           this.indicadorSituacion = indicadorSituacion;
           this.indicadorTipoCuenta = indicadorTipoCuenta;
           this.indicadorTraspaso = indicadorTraspaso;
           this.indicativoFacturable = indicativoFacturable;
           this.limiteCredito = limiteCredito;
           this.nombreApellido1 = nombreApellido1;
           this.nombreApellido2 = nombreApellido2;
           this.nombreApoderado = nombreApoderado;
           this.nombreCliente = nombreCliente;
           this.nombreUsuarOra = nombreUsuarOra;
           this.nombreUsuarioAsesor = nombreUsuarioAsesor;
           this.numIdent2 = numIdent2;
           this.numMesesCobro = numMesesCobro;
           this.numeroAbobeep = numeroAbobeep;
           this.numeroAbocel = numeroAbocel;
           this.numeroAbonados = numeroAbonados;
           this.numeroAborent = numeroAborent;
           this.numeroAboroaming = numeroAboroaming;
           this.numeroAbotrek = numeroAbotrek;
           this.numeroAbotrunk = numeroAbotrunk;
           this.numeroCelular = numeroCelular;
           this.numeroCiclos = numeroCiclos;
           this.numeroCuentaCorriente = numeroCuentaCorriente;
           this.numeroFax = numeroFax;
           this.numeroIdentificacion = numeroIdentificacion;
           this.numeroIdentificacionApoderado = numeroIdentificacionApoderado;
           this.numeroIdentificacionTributaria = numeroIdentificacionTributaria;
           this.numeroIntGrupoFam = numeroIntGrupoFam;
           this.numeroMinutos = numeroMinutos;
           this.numeroOrdenRepresentanteLegal = numeroOrdenRepresentanteLegal;
           this.numeroOrdenServicio = numeroOrdenServicio;
           this.numeroTarjeta = numeroTarjeta;
           this.numeroTelefono = numeroTelefono;
           this.numeroTelefono1 = numeroTelefono1;
           this.numeroTelefono2 = numeroTelefono2;
           this.planComercial = planComercial;
           this.planTarifario = planTarifario;
           this.representanteLegalDTO = representanteLegalDTO;
           this.tipoCliente = tipoCliente;
           this.tipoPlanTarifario = tipoPlanTarifario;
           this.usuario = usuario;
    }


    /**
     * Gets the categoriaTributaria value for this ClienteDTO.
     * 
     * @return categoriaTributaria
     */
    public java.lang.String getCategoriaTributaria() {
        return categoriaTributaria;
    }


    /**
     * Sets the categoriaTributaria value for this ClienteDTO.
     * 
     * @param categoriaTributaria
     */
    public void setCategoriaTributaria(java.lang.String categoriaTributaria) {
        this.categoriaTributaria = categoriaTributaria;
    }


    /**
     * Gets the codigo123 value for this ClienteDTO.
     * 
     * @return codigo123
     */
    public java.lang.String getCodigo123() {
        return codigo123;
    }


    /**
     * Sets the codigo123 value for this ClienteDTO.
     * 
     * @param codigo123
     */
    public void setCodigo123(java.lang.String codigo123) {
        this.codigo123 = codigo123;
    }


    /**
     * Gets the codigoABC value for this ClienteDTO.
     * 
     * @return codigoABC
     */
    public java.lang.String getCodigoABC() {
        return codigoABC;
    }


    /**
     * Sets the codigoABC value for this ClienteDTO.
     * 
     * @param codigoABC
     */
    public void setCodigoABC(java.lang.String codigoABC) {
        this.codigoABC = codigoABC;
    }


    /**
     * Gets the codigoActividad value for this ClienteDTO.
     * 
     * @return codigoActividad
     */
    public java.lang.String getCodigoActividad() {
        return codigoActividad;
    }


    /**
     * Sets the codigoActividad value for this ClienteDTO.
     * 
     * @param codigoActividad
     */
    public void setCodigoActividad(java.lang.String codigoActividad) {
        this.codigoActividad = codigoActividad;
    }


    /**
     * Gets the codigoBanco value for this ClienteDTO.
     * 
     * @return codigoBanco
     */
    public java.lang.String getCodigoBanco() {
        return codigoBanco;
    }


    /**
     * Sets the codigoBanco value for this ClienteDTO.
     * 
     * @param codigoBanco
     */
    public void setCodigoBanco(java.lang.String codigoBanco) {
        this.codigoBanco = codigoBanco;
    }


    /**
     * Gets the codigoBancoTarjeta value for this ClienteDTO.
     * 
     * @return codigoBancoTarjeta
     */
    public java.lang.String getCodigoBancoTarjeta() {
        return codigoBancoTarjeta;
    }


    /**
     * Sets the codigoBancoTarjeta value for this ClienteDTO.
     * 
     * @param codigoBancoTarjeta
     */
    public void setCodigoBancoTarjeta(java.lang.String codigoBancoTarjeta) {
        this.codigoBancoTarjeta = codigoBancoTarjeta;
    }


    /**
     * Gets the codigoCalidadCliente value for this ClienteDTO.
     * 
     * @return codigoCalidadCliente
     */
    public java.lang.String getCodigoCalidadCliente() {
        return codigoCalidadCliente;
    }


    /**
     * Sets the codigoCalidadCliente value for this ClienteDTO.
     * 
     * @param codigoCalidadCliente
     */
    public void setCodigoCalidadCliente(java.lang.String codigoCalidadCliente) {
        this.codigoCalidadCliente = codigoCalidadCliente;
    }


    /**
     * Gets the codigoCargoBasico value for this ClienteDTO.
     * 
     * @return codigoCargoBasico
     */
    public java.lang.String getCodigoCargoBasico() {
        return codigoCargoBasico;
    }


    /**
     * Sets the codigoCargoBasico value for this ClienteDTO.
     * 
     * @param codigoCargoBasico
     */
    public void setCodigoCargoBasico(java.lang.String codigoCargoBasico) {
        this.codigoCargoBasico = codigoCargoBasico;
    }


    /**
     * Gets the codigoCategImpos value for this ClienteDTO.
     * 
     * @return codigoCategImpos
     */
    public java.lang.String getCodigoCategImpos() {
        return codigoCategImpos;
    }


    /**
     * Sets the codigoCategImpos value for this ClienteDTO.
     * 
     * @param codigoCategImpos
     */
    public void setCodigoCategImpos(java.lang.String codigoCategImpos) {
        this.codigoCategImpos = codigoCategImpos;
    }


    /**
     * Gets the codigoCategoria value for this ClienteDTO.
     * 
     * @return codigoCategoria
     */
    public java.lang.String getCodigoCategoria() {
        return codigoCategoria;
    }


    /**
     * Sets the codigoCategoria value for this ClienteDTO.
     * 
     * @param codigoCategoria
     */
    public void setCodigoCategoria(java.lang.String codigoCategoria) {
        this.codigoCategoria = codigoCategoria;
    }


    /**
     * Gets the codigoCategoriaEmpresa value for this ClienteDTO.
     * 
     * @return codigoCategoriaEmpresa
     */
    public java.lang.String getCodigoCategoriaEmpresa() {
        return codigoCategoriaEmpresa;
    }


    /**
     * Sets the codigoCategoriaEmpresa value for this ClienteDTO.
     * 
     * @param codigoCategoriaEmpresa
     */
    public void setCodigoCategoriaEmpresa(java.lang.String codigoCategoriaEmpresa) {
        this.codigoCategoriaEmpresa = codigoCategoriaEmpresa;
    }


    /**
     * Gets the codigoCelda value for this ClienteDTO.
     * 
     * @return codigoCelda
     */
    public java.lang.String getCodigoCelda() {
        return codigoCelda;
    }


    /**
     * Sets the codigoCelda value for this ClienteDTO.
     * 
     * @param codigoCelda
     */
    public void setCodigoCelda(java.lang.String codigoCelda) {
        this.codigoCelda = codigoCelda;
    }


    /**
     * Gets the codigoCiclo value for this ClienteDTO.
     * 
     * @return codigoCiclo
     */
    public int getCodigoCiclo() {
        return codigoCiclo;
    }


    /**
     * Sets the codigoCiclo value for this ClienteDTO.
     * 
     * @param codigoCiclo
     */
    public void setCodigoCiclo(int codigoCiclo) {
        this.codigoCiclo = codigoCiclo;
    }


    /**
     * Gets the codigoCicloFacturacion value for this ClienteDTO.
     * 
     * @return codigoCicloFacturacion
     */
    public java.lang.String getCodigoCicloFacturacion() {
        return codigoCicloFacturacion;
    }


    /**
     * Sets the codigoCicloFacturacion value for this ClienteDTO.
     * 
     * @param codigoCicloFacturacion
     */
    public void setCodigoCicloFacturacion(java.lang.String codigoCicloFacturacion) {
        this.codigoCicloFacturacion = codigoCicloFacturacion;
    }


    /**
     * Gets the codigoCicloNuevo value for this ClienteDTO.
     * 
     * @return codigoCicloNuevo
     */
    public java.lang.String getCodigoCicloNuevo() {
        return codigoCicloNuevo;
    }


    /**
     * Sets the codigoCicloNuevo value for this ClienteDTO.
     * 
     * @param codigoCicloNuevo
     */
    public void setCodigoCicloNuevo(java.lang.String codigoCicloNuevo) {
        this.codigoCicloNuevo = codigoCicloNuevo;
    }


    /**
     * Gets the codigoCliente value for this ClienteDTO.
     * 
     * @return codigoCliente
     */
    public java.lang.String getCodigoCliente() {
        return codigoCliente;
    }


    /**
     * Sets the codigoCliente value for this ClienteDTO.
     * 
     * @param codigoCliente
     */
    public void setCodigoCliente(java.lang.String codigoCliente) {
        this.codigoCliente = codigoCliente;
    }


    /**
     * Gets the codigoCobrador value for this ClienteDTO.
     * 
     * @return codigoCobrador
     */
    public java.lang.String getCodigoCobrador() {
        return codigoCobrador;
    }


    /**
     * Sets the codigoCobrador value for this ClienteDTO.
     * 
     * @param codigoCobrador
     */
    public void setCodigoCobrador(java.lang.String codigoCobrador) {
        this.codigoCobrador = codigoCobrador;
    }


    /**
     * Gets the codigoCuenta value for this ClienteDTO.
     * 
     * @return codigoCuenta
     */
    public java.lang.String getCodigoCuenta() {
        return codigoCuenta;
    }


    /**
     * Sets the codigoCuenta value for this ClienteDTO.
     * 
     * @param codigoCuenta
     */
    public void setCodigoCuenta(java.lang.String codigoCuenta) {
        this.codigoCuenta = codigoCuenta;
    }


    /**
     * Gets the codigoDespacho value for this ClienteDTO.
     * 
     * @return codigoDespacho
     */
    public java.lang.String getCodigoDespacho() {
        return codigoDespacho;
    }


    /**
     * Sets the codigoDespacho value for this ClienteDTO.
     * 
     * @param codigoDespacho
     */
    public void setCodigoDespacho(java.lang.String codigoDespacho) {
        this.codigoDespacho = codigoDespacho;
    }


    /**
     * Gets the codigoEmpresa value for this ClienteDTO.
     * 
     * @return codigoEmpresa
     */
    public long getCodigoEmpresa() {
        return codigoEmpresa;
    }


    /**
     * Sets the codigoEmpresa value for this ClienteDTO.
     * 
     * @param codigoEmpresa
     */
    public void setCodigoEmpresa(long codigoEmpresa) {
        this.codigoEmpresa = codigoEmpresa;
    }


    /**
     * Gets the codigoIdentificacionCliente value for this ClienteDTO.
     * 
     * @return codigoIdentificacionCliente
     */
    public java.lang.String getCodigoIdentificacionCliente() {
        return codigoIdentificacionCliente;
    }


    /**
     * Sets the codigoIdentificacionCliente value for this ClienteDTO.
     * 
     * @param codigoIdentificacionCliente
     */
    public void setCodigoIdentificacionCliente(java.lang.String codigoIdentificacionCliente) {
        this.codigoIdentificacionCliente = codigoIdentificacionCliente;
    }


    /**
     * Gets the codigoIdioma value for this ClienteDTO.
     * 
     * @return codigoIdioma
     */
    public java.lang.String getCodigoIdioma() {
        return codigoIdioma;
    }


    /**
     * Sets the codigoIdioma value for this ClienteDTO.
     * 
     * @param codigoIdioma
     */
    public void setCodigoIdioma(java.lang.String codigoIdioma) {
        this.codigoIdioma = codigoIdioma;
    }


    /**
     * Gets the codigoLimiteConsumo value for this ClienteDTO.
     * 
     * @return codigoLimiteConsumo
     */
    public java.lang.String getCodigoLimiteConsumo() {
        return codigoLimiteConsumo;
    }


    /**
     * Sets the codigoLimiteConsumo value for this ClienteDTO.
     * 
     * @param codigoLimiteConsumo
     */
    public void setCodigoLimiteConsumo(java.lang.String codigoLimiteConsumo) {
        this.codigoLimiteConsumo = codigoLimiteConsumo;
    }


    /**
     * Gets the codigoModificacion value for this ClienteDTO.
     * 
     * @return codigoModificacion
     */
    public java.lang.String getCodigoModificacion() {
        return codigoModificacion;
    }


    /**
     * Sets the codigoModificacion value for this ClienteDTO.
     * 
     * @param codigoModificacion
     */
    public void setCodigoModificacion(java.lang.String codigoModificacion) {
        this.codigoModificacion = codigoModificacion;
    }


    /**
     * Gets the codigoNPI value for this ClienteDTO.
     * 
     * @return codigoNPI
     */
    public java.lang.String getCodigoNPI() {
        return codigoNPI;
    }


    /**
     * Sets the codigoNPI value for this ClienteDTO.
     * 
     * @param codigoNPI
     */
    public void setCodigoNPI(java.lang.String codigoNPI) {
        this.codigoNPI = codigoNPI;
    }


    /**
     * Gets the codigoOficina value for this ClienteDTO.
     * 
     * @return codigoOficina
     */
    public java.lang.String getCodigoOficina() {
        return codigoOficina;
    }


    /**
     * Sets the codigoOficina value for this ClienteDTO.
     * 
     * @param codigoOficina
     */
    public void setCodigoOficina(java.lang.String codigoOficina) {
        this.codigoOficina = codigoOficina;
    }


    /**
     * Gets the codigoOperadora value for this ClienteDTO.
     * 
     * @return codigoOperadora
     */
    public java.lang.String getCodigoOperadora() {
        return codigoOperadora;
    }


    /**
     * Sets the codigoOperadora value for this ClienteDTO.
     * 
     * @param codigoOperadora
     */
    public void setCodigoOperadora(java.lang.String codigoOperadora) {
        this.codigoOperadora = codigoOperadora;
    }


    /**
     * Gets the codigoPais value for this ClienteDTO.
     * 
     * @return codigoPais
     */
    public java.lang.String getCodigoPais() {
        return codigoPais;
    }


    /**
     * Sets the codigoPais value for this ClienteDTO.
     * 
     * @param codigoPais
     */
    public void setCodigoPais(java.lang.String codigoPais) {
        this.codigoPais = codigoPais;
    }


    /**
     * Gets the codigoPincli value for this ClienteDTO.
     * 
     * @return codigoPincli
     */
    public java.lang.String getCodigoPincli() {
        return codigoPincli;
    }


    /**
     * Sets the codigoPincli value for this ClienteDTO.
     * 
     * @param codigoPincli
     */
    public void setCodigoPincli(java.lang.String codigoPincli) {
        this.codigoPincli = codigoPincli;
    }


    /**
     * Gets the codigoPlanComercial value for this ClienteDTO.
     * 
     * @return codigoPlanComercial
     */
    public java.lang.String getCodigoPlanComercial() {
        return codigoPlanComercial;
    }


    /**
     * Sets the codigoPlanComercial value for this ClienteDTO.
     * 
     * @param codigoPlanComercial
     */
    public void setCodigoPlanComercial(java.lang.String codigoPlanComercial) {
        this.codigoPlanComercial = codigoPlanComercial;
    }


    /**
     * Gets the codigoPlanTarifario value for this ClienteDTO.
     * 
     * @return codigoPlanTarifario
     */
    public java.lang.String getCodigoPlanTarifario() {
        return codigoPlanTarifario;
    }


    /**
     * Sets the codigoPlanTarifario value for this ClienteDTO.
     * 
     * @param codigoPlanTarifario
     */
    public void setCodigoPlanTarifario(java.lang.String codigoPlanTarifario) {
        this.codigoPlanTarifario = codigoPlanTarifario;
    }


    /**
     * Gets the codigoPlaza value for this ClienteDTO.
     * 
     * @return codigoPlaza
     */
    public java.lang.String getCodigoPlaza() {
        return codigoPlaza;
    }


    /**
     * Sets the codigoPlaza value for this ClienteDTO.
     * 
     * @param codigoPlaza
     */
    public void setCodigoPlaza(java.lang.String codigoPlaza) {
        this.codigoPlaza = codigoPlaza;
    }


    /**
     * Gets the codigoProducto value for this ClienteDTO.
     * 
     * @return codigoProducto
     */
    public int getCodigoProducto() {
        return codigoProducto;
    }


    /**
     * Sets the codigoProducto value for this ClienteDTO.
     * 
     * @param codigoProducto
     */
    public void setCodigoProducto(int codigoProducto) {
        this.codigoProducto = codigoProducto;
    }


    /**
     * Gets the codigoProspecto value for this ClienteDTO.
     * 
     * @return codigoProspecto
     */
    public java.lang.String getCodigoProspecto() {
        return codigoProspecto;
    }


    /**
     * Sets the codigoProspecto value for this ClienteDTO.
     * 
     * @param codigoProspecto
     */
    public void setCodigoProspecto(java.lang.String codigoProspecto) {
        this.codigoProspecto = codigoProspecto;
    }


    /**
     * Gets the codigoSector value for this ClienteDTO.
     * 
     * @return codigoSector
     */
    public java.lang.String getCodigoSector() {
        return codigoSector;
    }


    /**
     * Sets the codigoSector value for this ClienteDTO.
     * 
     * @param codigoSector
     */
    public void setCodigoSector(java.lang.String codigoSector) {
        this.codigoSector = codigoSector;
    }


    /**
     * Gets the codigoSistemaPago value for this ClienteDTO.
     * 
     * @return codigoSistemaPago
     */
    public java.lang.String getCodigoSistemaPago() {
        return codigoSistemaPago;
    }


    /**
     * Sets the codigoSistemaPago value for this ClienteDTO.
     * 
     * @param codigoSistemaPago
     */
    public void setCodigoSistemaPago(java.lang.String codigoSistemaPago) {
        this.codigoSistemaPago = codigoSistemaPago;
    }


    /**
     * Gets the codigoSubCategImpos value for this ClienteDTO.
     * 
     * @return codigoSubCategImpos
     */
    public java.lang.String getCodigoSubCategImpos() {
        return codigoSubCategImpos;
    }


    /**
     * Sets the codigoSubCategImpos value for this ClienteDTO.
     * 
     * @param codigoSubCategImpos
     */
    public void setCodigoSubCategImpos(java.lang.String codigoSubCategImpos) {
        this.codigoSubCategImpos = codigoSubCategImpos;
    }


    /**
     * Gets the codigoSubCategoria value for this ClienteDTO.
     * 
     * @return codigoSubCategoria
     */
    public java.lang.String getCodigoSubCategoria() {
        return codigoSubCategoria;
    }


    /**
     * Sets the codigoSubCategoria value for this ClienteDTO.
     * 
     * @param codigoSubCategoria
     */
    public void setCodigoSubCategoria(java.lang.String codigoSubCategoria) {
        this.codigoSubCategoria = codigoSubCategoria;
    }


    /**
     * Gets the codigoSubCuenta value for this ClienteDTO.
     * 
     * @return codigoSubCuenta
     */
    public java.lang.String getCodigoSubCuenta() {
        return codigoSubCuenta;
    }


    /**
     * Sets the codigoSubCuenta value for this ClienteDTO.
     * 
     * @param codigoSubCuenta
     */
    public void setCodigoSubCuenta(java.lang.String codigoSubCuenta) {
        this.codigoSubCuenta = codigoSubCuenta;
    }


    /**
     * Gets the codigoSucursal value for this ClienteDTO.
     * 
     * @return codigoSucursal
     */
    public java.lang.String getCodigoSucursal() {
        return codigoSucursal;
    }


    /**
     * Sets the codigoSucursal value for this ClienteDTO.
     * 
     * @param codigoSucursal
     */
    public void setCodigoSucursal(java.lang.String codigoSucursal) {
        this.codigoSucursal = codigoSucursal;
    }


    /**
     * Gets the codigoSupervisor value for this ClienteDTO.
     * 
     * @return codigoSupervisor
     */
    public java.lang.String getCodigoSupervisor() {
        return codigoSupervisor;
    }


    /**
     * Sets the codigoSupervisor value for this ClienteDTO.
     * 
     * @param codigoSupervisor
     */
    public void setCodigoSupervisor(java.lang.String codigoSupervisor) {
        this.codigoSupervisor = codigoSupervisor;
    }


    /**
     * Gets the codigoTipIdent2 value for this ClienteDTO.
     * 
     * @return codigoTipIdent2
     */
    public java.lang.String getCodigoTipIdent2() {
        return codigoTipIdent2;
    }


    /**
     * Sets the codigoTipIdent2 value for this ClienteDTO.
     * 
     * @param codigoTipIdent2
     */
    public void setCodigoTipIdent2(java.lang.String codigoTipIdent2) {
        this.codigoTipIdent2 = codigoTipIdent2;
    }


    /**
     * Gets the codigoTipoCliente value for this ClienteDTO.
     * 
     * @return codigoTipoCliente
     */
    public java.lang.String getCodigoTipoCliente() {
        return codigoTipoCliente;
    }


    /**
     * Sets the codigoTipoCliente value for this ClienteDTO.
     * 
     * @param codigoTipoCliente
     */
    public void setCodigoTipoCliente(java.lang.String codigoTipoCliente) {
        this.codigoTipoCliente = codigoTipoCliente;
    }


    /**
     * Gets the codigoTipoIdentificacion value for this ClienteDTO.
     * 
     * @return codigoTipoIdentificacion
     */
    public java.lang.String getCodigoTipoIdentificacion() {
        return codigoTipoIdentificacion;
    }


    /**
     * Sets the codigoTipoIdentificacion value for this ClienteDTO.
     * 
     * @param codigoTipoIdentificacion
     */
    public void setCodigoTipoIdentificacion(java.lang.String codigoTipoIdentificacion) {
        this.codigoTipoIdentificacion = codigoTipoIdentificacion;
    }


    /**
     * Gets the codigoTipoIdentificacionApoderado value for this ClienteDTO.
     * 
     * @return codigoTipoIdentificacionApoderado
     */
    public java.lang.String getCodigoTipoIdentificacionApoderado() {
        return codigoTipoIdentificacionApoderado;
    }


    /**
     * Sets the codigoTipoIdentificacionApoderado value for this ClienteDTO.
     * 
     * @param codigoTipoIdentificacionApoderado
     */
    public void setCodigoTipoIdentificacionApoderado(java.lang.String codigoTipoIdentificacionApoderado) {
        this.codigoTipoIdentificacionApoderado = codigoTipoIdentificacionApoderado;
    }


    /**
     * Gets the codigoTipoIdentificacionTributaria value for this ClienteDTO.
     * 
     * @return codigoTipoIdentificacionTributaria
     */
    public java.lang.String getCodigoTipoIdentificacionTributaria() {
        return codigoTipoIdentificacionTributaria;
    }


    /**
     * Sets the codigoTipoIdentificacionTributaria value for this ClienteDTO.
     * 
     * @param codigoTipoIdentificacionTributaria
     */
    public void setCodigoTipoIdentificacionTributaria(java.lang.String codigoTipoIdentificacionTributaria) {
        this.codigoTipoIdentificacionTributaria = codigoTipoIdentificacionTributaria;
    }


    /**
     * Gets the codigoTipoTarjeta value for this ClienteDTO.
     * 
     * @return codigoTipoTarjeta
     */
    public java.lang.String getCodigoTipoTarjeta() {
        return codigoTipoTarjeta;
    }


    /**
     * Sets the codigoTipoTarjeta value for this ClienteDTO.
     * 
     * @param codigoTipoTarjeta
     */
    public void setCodigoTipoTarjeta(java.lang.String codigoTipoTarjeta) {
        this.codigoTipoTarjeta = codigoTipoTarjeta;
    }


    /**
     * Gets the codigoUso value for this ClienteDTO.
     * 
     * @return codigoUso
     */
    public java.lang.String getCodigoUso() {
        return codigoUso;
    }


    /**
     * Sets the codigoUso value for this ClienteDTO.
     * 
     * @param codigoUso
     */
    public void setCodigoUso(java.lang.String codigoUso) {
        this.codigoUso = codigoUso;
    }


    /**
     * Gets the codigoVendedor value for this ClienteDTO.
     * 
     * @return codigoVendedor
     */
    public int getCodigoVendedor() {
        return codigoVendedor;
    }


    /**
     * Sets the codigoVendedor value for this ClienteDTO.
     * 
     * @param codigoVendedor
     */
    public void setCodigoVendedor(int codigoVendedor) {
        this.codigoVendedor = codigoVendedor;
    }


    /**
     * Gets the descripcionCategImpos value for this ClienteDTO.
     * 
     * @return descripcionCategImpos
     */
    public java.lang.String getDescripcionCategImpos() {
        return descripcionCategImpos;
    }


    /**
     * Sets the descripcionCategImpos value for this ClienteDTO.
     * 
     * @param descripcionCategImpos
     */
    public void setDescripcionCategImpos(java.lang.String descripcionCategImpos) {
        this.descripcionCategImpos = descripcionCategImpos;
    }


    /**
     * Gets the descripcionCategoria value for this ClienteDTO.
     * 
     * @return descripcionCategoria
     */
    public java.lang.String getDescripcionCategoria() {
        return descripcionCategoria;
    }


    /**
     * Sets the descripcionCategoria value for this ClienteDTO.
     * 
     * @param descripcionCategoria
     */
    public void setDescripcionCategoria(java.lang.String descripcionCategoria) {
        this.descripcionCategoria = descripcionCategoria;
    }


    /**
     * Gets the descripcionEmpresa value for this ClienteDTO.
     * 
     * @return descripcionEmpresa
     */
    public java.lang.String getDescripcionEmpresa() {
        return descripcionEmpresa;
    }


    /**
     * Sets the descripcionEmpresa value for this ClienteDTO.
     * 
     * @param descripcionEmpresa
     */
    public void setDescripcionEmpresa(java.lang.String descripcionEmpresa) {
        this.descripcionEmpresa = descripcionEmpresa;
    }


    /**
     * Gets the descripcionReferenciaDocumento value for this ClienteDTO.
     * 
     * @return descripcionReferenciaDocumento
     */
    public java.lang.String getDescripcionReferenciaDocumento() {
        return descripcionReferenciaDocumento;
    }


    /**
     * Sets the descripcionReferenciaDocumento value for this ClienteDTO.
     * 
     * @param descripcionReferenciaDocumento
     */
    public void setDescripcionReferenciaDocumento(java.lang.String descripcionReferenciaDocumento) {
        this.descripcionReferenciaDocumento = descripcionReferenciaDocumento;
    }


    /**
     * Gets the descripcionSubCategImpos value for this ClienteDTO.
     * 
     * @return descripcionSubCategImpos
     */
    public java.lang.String getDescripcionSubCategImpos() {
        return descripcionSubCategImpos;
    }


    /**
     * Sets the descripcionSubCategImpos value for this ClienteDTO.
     * 
     * @param descripcionSubCategImpos
     */
    public void setDescripcionSubCategImpos(java.lang.String descripcionSubCategImpos) {
        this.descripcionSubCategImpos = descripcionSubCategImpos;
    }


    /**
     * Gets the direccionEMail value for this ClienteDTO.
     * 
     * @return direccionEMail
     */
    public java.lang.String getDireccionEMail() {
        return direccionEMail;
    }


    /**
     * Sets the direccionEMail value for this ClienteDTO.
     * 
     * @param direccionEMail
     */
    public void setDireccionEMail(java.lang.String direccionEMail) {
        this.direccionEMail = direccionEMail;
    }


    /**
     * Gets the direcciones value for this ClienteDTO.
     * 
     * @return direcciones
     */
    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionNegocioDTO[] getDirecciones() {
        return direcciones;
    }


    /**
     * Sets the direcciones value for this ClienteDTO.
     * 
     * @param direcciones
     */
    public void setDirecciones(dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionNegocioDTO[] direcciones) {
        this.direcciones = direcciones;
    }

    public dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionNegocioDTO getDirecciones(int i) {
        return this.direcciones[i];
    }

    public void setDirecciones(int i, dto.businessobject.gestiondedirecciones.scl.cl.tmmas.com.DireccionNegocioDTO _value) {
        this.direcciones[i] = _value;
    }


    /**
     * Gets the existeCliente value for this ClienteDTO.
     * 
     * @return existeCliente
     */
    public int getExisteCliente() {
        return existeCliente;
    }


    /**
     * Sets the existeCliente value for this ClienteDTO.
     * 
     * @param existeCliente
     */
    public void setExisteCliente(int existeCliente) {
        this.existeCliente = existeCliente;
    }


    /**
     * Gets the fechaAcepVenta value for this ClienteDTO.
     * 
     * @return fechaAcepVenta
     */
    public java.lang.String getFechaAcepVenta() {
        return fechaAcepVenta;
    }


    /**
     * Sets the fechaAcepVenta value for this ClienteDTO.
     * 
     * @param fechaAcepVenta
     */
    public void setFechaAcepVenta(java.lang.String fechaAcepVenta) {
        this.fechaAcepVenta = fechaAcepVenta;
    }


    /**
     * Gets the fechaBaja value for this ClienteDTO.
     * 
     * @return fechaBaja
     */
    public java.lang.String getFechaBaja() {
        return fechaBaja;
    }


    /**
     * Sets the fechaBaja value for this ClienteDTO.
     * 
     * @param fechaBaja
     */
    public void setFechaBaja(java.lang.String fechaBaja) {
        this.fechaBaja = fechaBaja;
    }


    /**
     * Gets the fechaDesde value for this ClienteDTO.
     * 
     * @return fechaDesde
     */
    public java.lang.String getFechaDesde() {
        return fechaDesde;
    }


    /**
     * Sets the fechaDesde value for this ClienteDTO.
     * 
     * @param fechaDesde
     */
    public void setFechaDesde(java.lang.String fechaDesde) {
        this.fechaDesde = fechaDesde;
    }


    /**
     * Gets the fechaHasta value for this ClienteDTO.
     * 
     * @return fechaHasta
     */
    public java.lang.String getFechaHasta() {
        return fechaHasta;
    }


    /**
     * Sets the fechaHasta value for this ClienteDTO.
     * 
     * @param fechaHasta
     */
    public void setFechaHasta(java.lang.String fechaHasta) {
        this.fechaHasta = fechaHasta;
    }


    /**
     * Gets the fechaNacimiento value for this ClienteDTO.
     * 
     * @return fechaNacimiento
     */
    public java.lang.String getFechaNacimiento() {
        return fechaNacimiento;
    }


    /**
     * Sets the fechaNacimiento value for this ClienteDTO.
     * 
     * @param fechaNacimiento
     */
    public void setFechaNacimiento(java.lang.String fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }


    /**
     * Gets the fechaVencimientoTarjeta value for this ClienteDTO.
     * 
     * @return fechaVencimientoTarjeta
     */
    public java.lang.String getFechaVencimientoTarjeta() {
        return fechaVencimientoTarjeta;
    }


    /**
     * Sets the fechaVencimientoTarjeta value for this ClienteDTO.
     * 
     * @param fechaVencimientoTarjeta
     */
    public void setFechaVencimientoTarjeta(java.lang.String fechaVencimientoTarjeta) {
        this.fechaVencimientoTarjeta = fechaVencimientoTarjeta;
    }


    /**
     * Gets the importeLimiteDebito value for this ClienteDTO.
     * 
     * @return importeLimiteDebito
     */
    public java.lang.String getImporteLimiteDebito() {
        return importeLimiteDebito;
    }


    /**
     * Sets the importeLimiteDebito value for this ClienteDTO.
     * 
     * @param importeLimiteDebito
     */
    public void setImporteLimiteDebito(java.lang.String importeLimiteDebito) {
        this.importeLimiteDebito = importeLimiteDebito;
    }


    /**
     * Gets the indentificadorSegmento value for this ClienteDTO.
     * 
     * @return indentificadorSegmento
     */
    public java.lang.String getIndentificadorSegmento() {
        return indentificadorSegmento;
    }


    /**
     * Sets the indentificadorSegmento value for this ClienteDTO.
     * 
     * @param indentificadorSegmento
     */
    public void setIndentificadorSegmento(java.lang.String indentificadorSegmento) {
        this.indentificadorSegmento = indentificadorSegmento;
    }


    /**
     * Gets the indicadirTipPersona value for this ClienteDTO.
     * 
     * @return indicadirTipPersona
     */
    public java.lang.String getIndicadirTipPersona() {
        return indicadirTipPersona;
    }


    /**
     * Sets the indicadirTipPersona value for this ClienteDTO.
     * 
     * @param indicadirTipPersona
     */
    public void setIndicadirTipPersona(java.lang.String indicadirTipPersona) {
        this.indicadirTipPersona = indicadirTipPersona;
    }


    /**
     * Gets the indicadorAcepVenta value for this ClienteDTO.
     * 
     * @return indicadorAcepVenta
     */
    public java.lang.String getIndicadorAcepVenta() {
        return indicadorAcepVenta;
    }


    /**
     * Sets the indicadorAcepVenta value for this ClienteDTO.
     * 
     * @param indicadorAcepVenta
     */
    public void setIndicadorAcepVenta(java.lang.String indicadorAcepVenta) {
        this.indicadorAcepVenta = indicadorAcepVenta;
    }


    /**
     * Gets the indicadorAgente value for this ClienteDTO.
     * 
     * @return indicadorAgente
     */
    public java.lang.String getIndicadorAgente() {
        return indicadorAgente;
    }


    /**
     * Sets the indicadorAgente value for this ClienteDTO.
     * 
     * @param indicadorAgente
     */
    public void setIndicadorAgente(java.lang.String indicadorAgente) {
        this.indicadorAgente = indicadorAgente;
    }


    /**
     * Gets the indicadorAlta value for this ClienteDTO.
     * 
     * @return indicadorAlta
     */
    public java.lang.String getIndicadorAlta() {
        return indicadorAlta;
    }


    /**
     * Sets the indicadorAlta value for this ClienteDTO.
     * 
     * @param indicadorAlta
     */
    public void setIndicadorAlta(java.lang.String indicadorAlta) {
        this.indicadorAlta = indicadorAlta;
    }


    /**
     * Gets the indicadorDebito value for this ClienteDTO.
     * 
     * @return indicadorDebito
     */
    public java.lang.String getIndicadorDebito() {
        return indicadorDebito;
    }


    /**
     * Sets the indicadorDebito value for this ClienteDTO.
     * 
     * @param indicadorDebito
     */
    public void setIndicadorDebito(java.lang.String indicadorDebito) {
        this.indicadorDebito = indicadorDebito;
    }


    /**
     * Gets the indicadorEstadoCivil value for this ClienteDTO.
     * 
     * @return indicadorEstadoCivil
     */
    public java.lang.String getIndicadorEstadoCivil() {
        return indicadorEstadoCivil;
    }


    /**
     * Sets the indicadorEstadoCivil value for this ClienteDTO.
     * 
     * @param indicadorEstadoCivil
     */
    public void setIndicadorEstadoCivil(java.lang.String indicadorEstadoCivil) {
        this.indicadorEstadoCivil = indicadorEstadoCivil;
    }


    /**
     * Gets the indicadorMandato value for this ClienteDTO.
     * 
     * @return indicadorMandato
     */
    public java.lang.String getIndicadorMandato() {
        return indicadorMandato;
    }


    /**
     * Sets the indicadorMandato value for this ClienteDTO.
     * 
     * @param indicadorMandato
     */
    public void setIndicadorMandato(java.lang.String indicadorMandato) {
        this.indicadorMandato = indicadorMandato;
    }


    /**
     * Gets the indicadorPrivacidad value for this ClienteDTO.
     * 
     * @return indicadorPrivacidad
     */
    public java.lang.String getIndicadorPrivacidad() {
        return indicadorPrivacidad;
    }


    /**
     * Sets the indicadorPrivacidad value for this ClienteDTO.
     * 
     * @param indicadorPrivacidad
     */
    public void setIndicadorPrivacidad(java.lang.String indicadorPrivacidad) {
        this.indicadorPrivacidad = indicadorPrivacidad;
    }


    /**
     * Gets the indicadorSexo value for this ClienteDTO.
     * 
     * @return indicadorSexo
     */
    public java.lang.String getIndicadorSexo() {
        return indicadorSexo;
    }


    /**
     * Sets the indicadorSexo value for this ClienteDTO.
     * 
     * @param indicadorSexo
     */
    public void setIndicadorSexo(java.lang.String indicadorSexo) {
        this.indicadorSexo = indicadorSexo;
    }


    /**
     * Gets the indicadorSituacion value for this ClienteDTO.
     * 
     * @return indicadorSituacion
     */
    public java.lang.String getIndicadorSituacion() {
        return indicadorSituacion;
    }


    /**
     * Sets the indicadorSituacion value for this ClienteDTO.
     * 
     * @param indicadorSituacion
     */
    public void setIndicadorSituacion(java.lang.String indicadorSituacion) {
        this.indicadorSituacion = indicadorSituacion;
    }


    /**
     * Gets the indicadorTipoCuenta value for this ClienteDTO.
     * 
     * @return indicadorTipoCuenta
     */
    public java.lang.String getIndicadorTipoCuenta() {
        return indicadorTipoCuenta;
    }


    /**
     * Sets the indicadorTipoCuenta value for this ClienteDTO.
     * 
     * @param indicadorTipoCuenta
     */
    public void setIndicadorTipoCuenta(java.lang.String indicadorTipoCuenta) {
        this.indicadorTipoCuenta = indicadorTipoCuenta;
    }


    /**
     * Gets the indicadorTraspaso value for this ClienteDTO.
     * 
     * @return indicadorTraspaso
     */
    public java.lang.String getIndicadorTraspaso() {
        return indicadorTraspaso;
    }


    /**
     * Sets the indicadorTraspaso value for this ClienteDTO.
     * 
     * @param indicadorTraspaso
     */
    public void setIndicadorTraspaso(java.lang.String indicadorTraspaso) {
        this.indicadorTraspaso = indicadorTraspaso;
    }


    /**
     * Gets the indicativoFacturable value for this ClienteDTO.
     * 
     * @return indicativoFacturable
     */
    public int getIndicativoFacturable() {
        return indicativoFacturable;
    }


    /**
     * Sets the indicativoFacturable value for this ClienteDTO.
     * 
     * @param indicativoFacturable
     */
    public void setIndicativoFacturable(int indicativoFacturable) {
        this.indicativoFacturable = indicativoFacturable;
    }


    /**
     * Gets the limiteCredito value for this ClienteDTO.
     * 
     * @return limiteCredito
     */
    public double getLimiteCredito() {
        return limiteCredito;
    }


    /**
     * Sets the limiteCredito value for this ClienteDTO.
     * 
     * @param limiteCredito
     */
    public void setLimiteCredito(double limiteCredito) {
        this.limiteCredito = limiteCredito;
    }


    /**
     * Gets the nombreApellido1 value for this ClienteDTO.
     * 
     * @return nombreApellido1
     */
    public java.lang.String getNombreApellido1() {
        return nombreApellido1;
    }


    /**
     * Sets the nombreApellido1 value for this ClienteDTO.
     * 
     * @param nombreApellido1
     */
    public void setNombreApellido1(java.lang.String nombreApellido1) {
        this.nombreApellido1 = nombreApellido1;
    }


    /**
     * Gets the nombreApellido2 value for this ClienteDTO.
     * 
     * @return nombreApellido2
     */
    public java.lang.String getNombreApellido2() {
        return nombreApellido2;
    }


    /**
     * Sets the nombreApellido2 value for this ClienteDTO.
     * 
     * @param nombreApellido2
     */
    public void setNombreApellido2(java.lang.String nombreApellido2) {
        this.nombreApellido2 = nombreApellido2;
    }


    /**
     * Gets the nombreApoderado value for this ClienteDTO.
     * 
     * @return nombreApoderado
     */
    public java.lang.String getNombreApoderado() {
        return nombreApoderado;
    }


    /**
     * Sets the nombreApoderado value for this ClienteDTO.
     * 
     * @param nombreApoderado
     */
    public void setNombreApoderado(java.lang.String nombreApoderado) {
        this.nombreApoderado = nombreApoderado;
    }


    /**
     * Gets the nombreCliente value for this ClienteDTO.
     * 
     * @return nombreCliente
     */
    public java.lang.String getNombreCliente() {
        return nombreCliente;
    }


    /**
     * Sets the nombreCliente value for this ClienteDTO.
     * 
     * @param nombreCliente
     */
    public void setNombreCliente(java.lang.String nombreCliente) {
        this.nombreCliente = nombreCliente;
    }


    /**
     * Gets the nombreUsuarOra value for this ClienteDTO.
     * 
     * @return nombreUsuarOra
     */
    public java.lang.String getNombreUsuarOra() {
        return nombreUsuarOra;
    }


    /**
     * Sets the nombreUsuarOra value for this ClienteDTO.
     * 
     * @param nombreUsuarOra
     */
    public void setNombreUsuarOra(java.lang.String nombreUsuarOra) {
        this.nombreUsuarOra = nombreUsuarOra;
    }


    /**
     * Gets the nombreUsuarioAsesor value for this ClienteDTO.
     * 
     * @return nombreUsuarioAsesor
     */
    public java.lang.String getNombreUsuarioAsesor() {
        return nombreUsuarioAsesor;
    }


    /**
     * Sets the nombreUsuarioAsesor value for this ClienteDTO.
     * 
     * @param nombreUsuarioAsesor
     */
    public void setNombreUsuarioAsesor(java.lang.String nombreUsuarioAsesor) {
        this.nombreUsuarioAsesor = nombreUsuarioAsesor;
    }


    /**
     * Gets the numIdent2 value for this ClienteDTO.
     * 
     * @return numIdent2
     */
    public java.lang.String getNumIdent2() {
        return numIdent2;
    }


    /**
     * Sets the numIdent2 value for this ClienteDTO.
     * 
     * @param numIdent2
     */
    public void setNumIdent2(java.lang.String numIdent2) {
        this.numIdent2 = numIdent2;
    }


    /**
     * Gets the numMesesCobro value for this ClienteDTO.
     * 
     * @return numMesesCobro
     */
    public long getNumMesesCobro() {
        return numMesesCobro;
    }


    /**
     * Sets the numMesesCobro value for this ClienteDTO.
     * 
     * @param numMesesCobro
     */
    public void setNumMesesCobro(long numMesesCobro) {
        this.numMesesCobro = numMesesCobro;
    }


    /**
     * Gets the numeroAbobeep value for this ClienteDTO.
     * 
     * @return numeroAbobeep
     */
    public java.lang.String getNumeroAbobeep() {
        return numeroAbobeep;
    }


    /**
     * Sets the numeroAbobeep value for this ClienteDTO.
     * 
     * @param numeroAbobeep
     */
    public void setNumeroAbobeep(java.lang.String numeroAbobeep) {
        this.numeroAbobeep = numeroAbobeep;
    }


    /**
     * Gets the numeroAbocel value for this ClienteDTO.
     * 
     * @return numeroAbocel
     */
    public java.lang.String getNumeroAbocel() {
        return numeroAbocel;
    }


    /**
     * Sets the numeroAbocel value for this ClienteDTO.
     * 
     * @param numeroAbocel
     */
    public void setNumeroAbocel(java.lang.String numeroAbocel) {
        this.numeroAbocel = numeroAbocel;
    }


    /**
     * Gets the numeroAbonados value for this ClienteDTO.
     * 
     * @return numeroAbonados
     */
    public int getNumeroAbonados() {
        return numeroAbonados;
    }


    /**
     * Sets the numeroAbonados value for this ClienteDTO.
     * 
     * @param numeroAbonados
     */
    public void setNumeroAbonados(int numeroAbonados) {
        this.numeroAbonados = numeroAbonados;
    }


    /**
     * Gets the numeroAborent value for this ClienteDTO.
     * 
     * @return numeroAborent
     */
    public java.lang.String getNumeroAborent() {
        return numeroAborent;
    }


    /**
     * Sets the numeroAborent value for this ClienteDTO.
     * 
     * @param numeroAborent
     */
    public void setNumeroAborent(java.lang.String numeroAborent) {
        this.numeroAborent = numeroAborent;
    }


    /**
     * Gets the numeroAboroaming value for this ClienteDTO.
     * 
     * @return numeroAboroaming
     */
    public java.lang.String getNumeroAboroaming() {
        return numeroAboroaming;
    }


    /**
     * Sets the numeroAboroaming value for this ClienteDTO.
     * 
     * @param numeroAboroaming
     */
    public void setNumeroAboroaming(java.lang.String numeroAboroaming) {
        this.numeroAboroaming = numeroAboroaming;
    }


    /**
     * Gets the numeroAbotrek value for this ClienteDTO.
     * 
     * @return numeroAbotrek
     */
    public java.lang.String getNumeroAbotrek() {
        return numeroAbotrek;
    }


    /**
     * Sets the numeroAbotrek value for this ClienteDTO.
     * 
     * @param numeroAbotrek
     */
    public void setNumeroAbotrek(java.lang.String numeroAbotrek) {
        this.numeroAbotrek = numeroAbotrek;
    }


    /**
     * Gets the numeroAbotrunk value for this ClienteDTO.
     * 
     * @return numeroAbotrunk
     */
    public java.lang.String getNumeroAbotrunk() {
        return numeroAbotrunk;
    }


    /**
     * Sets the numeroAbotrunk value for this ClienteDTO.
     * 
     * @param numeroAbotrunk
     */
    public void setNumeroAbotrunk(java.lang.String numeroAbotrunk) {
        this.numeroAbotrunk = numeroAbotrunk;
    }


    /**
     * Gets the numeroCelular value for this ClienteDTO.
     * 
     * @return numeroCelular
     */
    public java.lang.String getNumeroCelular() {
        return numeroCelular;
    }


    /**
     * Sets the numeroCelular value for this ClienteDTO.
     * 
     * @param numeroCelular
     */
    public void setNumeroCelular(java.lang.String numeroCelular) {
        this.numeroCelular = numeroCelular;
    }


    /**
     * Gets the numeroCiclos value for this ClienteDTO.
     * 
     * @return numeroCiclos
     */
    public java.lang.String getNumeroCiclos() {
        return numeroCiclos;
    }


    /**
     * Sets the numeroCiclos value for this ClienteDTO.
     * 
     * @param numeroCiclos
     */
    public void setNumeroCiclos(java.lang.String numeroCiclos) {
        this.numeroCiclos = numeroCiclos;
    }


    /**
     * Gets the numeroCuentaCorriente value for this ClienteDTO.
     * 
     * @return numeroCuentaCorriente
     */
    public java.lang.String getNumeroCuentaCorriente() {
        return numeroCuentaCorriente;
    }


    /**
     * Sets the numeroCuentaCorriente value for this ClienteDTO.
     * 
     * @param numeroCuentaCorriente
     */
    public void setNumeroCuentaCorriente(java.lang.String numeroCuentaCorriente) {
        this.numeroCuentaCorriente = numeroCuentaCorriente;
    }


    /**
     * Gets the numeroFax value for this ClienteDTO.
     * 
     * @return numeroFax
     */
    public java.lang.String getNumeroFax() {
        return numeroFax;
    }


    /**
     * Sets the numeroFax value for this ClienteDTO.
     * 
     * @param numeroFax
     */
    public void setNumeroFax(java.lang.String numeroFax) {
        this.numeroFax = numeroFax;
    }


    /**
     * Gets the numeroIdentificacion value for this ClienteDTO.
     * 
     * @return numeroIdentificacion
     */
    public java.lang.String getNumeroIdentificacion() {
        return numeroIdentificacion;
    }


    /**
     * Sets the numeroIdentificacion value for this ClienteDTO.
     * 
     * @param numeroIdentificacion
     */
    public void setNumeroIdentificacion(java.lang.String numeroIdentificacion) {
        this.numeroIdentificacion = numeroIdentificacion;
    }


    /**
     * Gets the numeroIdentificacionApoderado value for this ClienteDTO.
     * 
     * @return numeroIdentificacionApoderado
     */
    public java.lang.String getNumeroIdentificacionApoderado() {
        return numeroIdentificacionApoderado;
    }


    /**
     * Sets the numeroIdentificacionApoderado value for this ClienteDTO.
     * 
     * @param numeroIdentificacionApoderado
     */
    public void setNumeroIdentificacionApoderado(java.lang.String numeroIdentificacionApoderado) {
        this.numeroIdentificacionApoderado = numeroIdentificacionApoderado;
    }


    /**
     * Gets the numeroIdentificacionTributaria value for this ClienteDTO.
     * 
     * @return numeroIdentificacionTributaria
     */
    public java.lang.String getNumeroIdentificacionTributaria() {
        return numeroIdentificacionTributaria;
    }


    /**
     * Sets the numeroIdentificacionTributaria value for this ClienteDTO.
     * 
     * @param numeroIdentificacionTributaria
     */
    public void setNumeroIdentificacionTributaria(java.lang.String numeroIdentificacionTributaria) {
        this.numeroIdentificacionTributaria = numeroIdentificacionTributaria;
    }


    /**
     * Gets the numeroIntGrupoFam value for this ClienteDTO.
     * 
     * @return numeroIntGrupoFam
     */
    public java.lang.String getNumeroIntGrupoFam() {
        return numeroIntGrupoFam;
    }


    /**
     * Sets the numeroIntGrupoFam value for this ClienteDTO.
     * 
     * @param numeroIntGrupoFam
     */
    public void setNumeroIntGrupoFam(java.lang.String numeroIntGrupoFam) {
        this.numeroIntGrupoFam = numeroIntGrupoFam;
    }


    /**
     * Gets the numeroMinutos value for this ClienteDTO.
     * 
     * @return numeroMinutos
     */
    public java.lang.String getNumeroMinutos() {
        return numeroMinutos;
    }


    /**
     * Sets the numeroMinutos value for this ClienteDTO.
     * 
     * @param numeroMinutos
     */
    public void setNumeroMinutos(java.lang.String numeroMinutos) {
        this.numeroMinutos = numeroMinutos;
    }


    /**
     * Gets the numeroOrdenRepresentanteLegal value for this ClienteDTO.
     * 
     * @return numeroOrdenRepresentanteLegal
     */
    public int getNumeroOrdenRepresentanteLegal() {
        return numeroOrdenRepresentanteLegal;
    }


    /**
     * Sets the numeroOrdenRepresentanteLegal value for this ClienteDTO.
     * 
     * @param numeroOrdenRepresentanteLegal
     */
    public void setNumeroOrdenRepresentanteLegal(int numeroOrdenRepresentanteLegal) {
        this.numeroOrdenRepresentanteLegal = numeroOrdenRepresentanteLegal;
    }


    /**
     * Gets the numeroOrdenServicio value for this ClienteDTO.
     * 
     * @return numeroOrdenServicio
     */
    public java.lang.String getNumeroOrdenServicio() {
        return numeroOrdenServicio;
    }


    /**
     * Sets the numeroOrdenServicio value for this ClienteDTO.
     * 
     * @param numeroOrdenServicio
     */
    public void setNumeroOrdenServicio(java.lang.String numeroOrdenServicio) {
        this.numeroOrdenServicio = numeroOrdenServicio;
    }


    /**
     * Gets the numeroTarjeta value for this ClienteDTO.
     * 
     * @return numeroTarjeta
     */
    public java.lang.String getNumeroTarjeta() {
        return numeroTarjeta;
    }


    /**
     * Sets the numeroTarjeta value for this ClienteDTO.
     * 
     * @param numeroTarjeta
     */
    public void setNumeroTarjeta(java.lang.String numeroTarjeta) {
        this.numeroTarjeta = numeroTarjeta;
    }


    /**
     * Gets the numeroTelefono value for this ClienteDTO.
     * 
     * @return numeroTelefono
     */
    public java.lang.String getNumeroTelefono() {
        return numeroTelefono;
    }


    /**
     * Sets the numeroTelefono value for this ClienteDTO.
     * 
     * @param numeroTelefono
     */
    public void setNumeroTelefono(java.lang.String numeroTelefono) {
        this.numeroTelefono = numeroTelefono;
    }


    /**
     * Gets the numeroTelefono1 value for this ClienteDTO.
     * 
     * @return numeroTelefono1
     */
    public java.lang.String getNumeroTelefono1() {
        return numeroTelefono1;
    }


    /**
     * Sets the numeroTelefono1 value for this ClienteDTO.
     * 
     * @param numeroTelefono1
     */
    public void setNumeroTelefono1(java.lang.String numeroTelefono1) {
        this.numeroTelefono1 = numeroTelefono1;
    }


    /**
     * Gets the numeroTelefono2 value for this ClienteDTO.
     * 
     * @return numeroTelefono2
     */
    public java.lang.String getNumeroTelefono2() {
        return numeroTelefono2;
    }


    /**
     * Sets the numeroTelefono2 value for this ClienteDTO.
     * 
     * @param numeroTelefono2
     */
    public void setNumeroTelefono2(java.lang.String numeroTelefono2) {
        this.numeroTelefono2 = numeroTelefono2;
    }


    /**
     * Gets the planComercial value for this ClienteDTO.
     * 
     * @return planComercial
     */
    public java.lang.String getPlanComercial() {
        return planComercial;
    }


    /**
     * Sets the planComercial value for this ClienteDTO.
     * 
     * @param planComercial
     */
    public void setPlanComercial(java.lang.String planComercial) {
        this.planComercial = planComercial;
    }


    /**
     * Gets the planTarifario value for this ClienteDTO.
     * 
     * @return planTarifario
     */
    public java.lang.String getPlanTarifario() {
        return planTarifario;
    }


    /**
     * Sets the planTarifario value for this ClienteDTO.
     * 
     * @param planTarifario
     */
    public void setPlanTarifario(java.lang.String planTarifario) {
        this.planTarifario = planTarifario;
    }


    /**
     * Gets the representanteLegalDTO value for this ClienteDTO.
     * 
     * @return representanteLegalDTO
     */
    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RepresentanteLegalDTO[] getRepresentanteLegalDTO() {
        return representanteLegalDTO;
    }


    /**
     * Sets the representanteLegalDTO value for this ClienteDTO.
     * 
     * @param representanteLegalDTO
     */
    public void setRepresentanteLegalDTO(dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RepresentanteLegalDTO[] representanteLegalDTO) {
        this.representanteLegalDTO = representanteLegalDTO;
    }

    public dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RepresentanteLegalDTO getRepresentanteLegalDTO(int i) {
        return this.representanteLegalDTO[i];
    }

    public void setRepresentanteLegalDTO(int i, dto.commonapp.gestiondeclientescommon.scl.cl.tmmas.com.RepresentanteLegalDTO _value) {
        this.representanteLegalDTO[i] = _value;
    }


    /**
     * Gets the tipoCliente value for this ClienteDTO.
     * 
     * @return tipoCliente
     */
    public java.lang.String getTipoCliente() {
        return tipoCliente;
    }


    /**
     * Sets the tipoCliente value for this ClienteDTO.
     * 
     * @param tipoCliente
     */
    public void setTipoCliente(java.lang.String tipoCliente) {
        this.tipoCliente = tipoCliente;
    }


    /**
     * Gets the tipoPlanTarifario value for this ClienteDTO.
     * 
     * @return tipoPlanTarifario
     */
    public java.lang.String getTipoPlanTarifario() {
        return tipoPlanTarifario;
    }


    /**
     * Sets the tipoPlanTarifario value for this ClienteDTO.
     * 
     * @param tipoPlanTarifario
     */
    public void setTipoPlanTarifario(java.lang.String tipoPlanTarifario) {
        this.tipoPlanTarifario = tipoPlanTarifario;
    }


    /**
     * Gets the usuario value for this ClienteDTO.
     * 
     * @return usuario
     */
    public java.lang.String getUsuario() {
        return usuario;
    }


    /**
     * Sets the usuario value for this ClienteDTO.
     * 
     * @param usuario
     */
    public void setUsuario(java.lang.String usuario) {
        this.usuario = usuario;
    }

    private java.lang.Object __equalsCalc = null;
    public synchronized boolean equals(java.lang.Object obj) {
        if (!(obj instanceof ClienteDTO)) return false;
        ClienteDTO other = (ClienteDTO) obj;
        if (obj == null) return false;
        if (this == obj) return true;
        if (__equalsCalc != null) {
            return (__equalsCalc == obj);
        }
        __equalsCalc = obj;
        boolean _equals;
        _equals = true && 
            ((this.categoriaTributaria==null && other.getCategoriaTributaria()==null) || 
             (this.categoriaTributaria!=null &&
              this.categoriaTributaria.equals(other.getCategoriaTributaria()))) &&
            ((this.codigo123==null && other.getCodigo123()==null) || 
             (this.codigo123!=null &&
              this.codigo123.equals(other.getCodigo123()))) &&
            ((this.codigoABC==null && other.getCodigoABC()==null) || 
             (this.codigoABC!=null &&
              this.codigoABC.equals(other.getCodigoABC()))) &&
            ((this.codigoActividad==null && other.getCodigoActividad()==null) || 
             (this.codigoActividad!=null &&
              this.codigoActividad.equals(other.getCodigoActividad()))) &&
            ((this.codigoBanco==null && other.getCodigoBanco()==null) || 
             (this.codigoBanco!=null &&
              this.codigoBanco.equals(other.getCodigoBanco()))) &&
            ((this.codigoBancoTarjeta==null && other.getCodigoBancoTarjeta()==null) || 
             (this.codigoBancoTarjeta!=null &&
              this.codigoBancoTarjeta.equals(other.getCodigoBancoTarjeta()))) &&
            ((this.codigoCalidadCliente==null && other.getCodigoCalidadCliente()==null) || 
             (this.codigoCalidadCliente!=null &&
              this.codigoCalidadCliente.equals(other.getCodigoCalidadCliente()))) &&
            ((this.codigoCargoBasico==null && other.getCodigoCargoBasico()==null) || 
             (this.codigoCargoBasico!=null &&
              this.codigoCargoBasico.equals(other.getCodigoCargoBasico()))) &&
            ((this.codigoCategImpos==null && other.getCodigoCategImpos()==null) || 
             (this.codigoCategImpos!=null &&
              this.codigoCategImpos.equals(other.getCodigoCategImpos()))) &&
            ((this.codigoCategoria==null && other.getCodigoCategoria()==null) || 
             (this.codigoCategoria!=null &&
              this.codigoCategoria.equals(other.getCodigoCategoria()))) &&
            ((this.codigoCategoriaEmpresa==null && other.getCodigoCategoriaEmpresa()==null) || 
             (this.codigoCategoriaEmpresa!=null &&
              this.codigoCategoriaEmpresa.equals(other.getCodigoCategoriaEmpresa()))) &&
            ((this.codigoCelda==null && other.getCodigoCelda()==null) || 
             (this.codigoCelda!=null &&
              this.codigoCelda.equals(other.getCodigoCelda()))) &&
            this.codigoCiclo == other.getCodigoCiclo() &&
            ((this.codigoCicloFacturacion==null && other.getCodigoCicloFacturacion()==null) || 
             (this.codigoCicloFacturacion!=null &&
              this.codigoCicloFacturacion.equals(other.getCodigoCicloFacturacion()))) &&
            ((this.codigoCicloNuevo==null && other.getCodigoCicloNuevo()==null) || 
             (this.codigoCicloNuevo!=null &&
              this.codigoCicloNuevo.equals(other.getCodigoCicloNuevo()))) &&
            ((this.codigoCliente==null && other.getCodigoCliente()==null) || 
             (this.codigoCliente!=null &&
              this.codigoCliente.equals(other.getCodigoCliente()))) &&
            ((this.codigoCobrador==null && other.getCodigoCobrador()==null) || 
             (this.codigoCobrador!=null &&
              this.codigoCobrador.equals(other.getCodigoCobrador()))) &&
            ((this.codigoCuenta==null && other.getCodigoCuenta()==null) || 
             (this.codigoCuenta!=null &&
              this.codigoCuenta.equals(other.getCodigoCuenta()))) &&
            ((this.codigoDespacho==null && other.getCodigoDespacho()==null) || 
             (this.codigoDespacho!=null &&
              this.codigoDespacho.equals(other.getCodigoDespacho()))) &&
            this.codigoEmpresa == other.getCodigoEmpresa() &&
            ((this.codigoIdentificacionCliente==null && other.getCodigoIdentificacionCliente()==null) || 
             (this.codigoIdentificacionCliente!=null &&
              this.codigoIdentificacionCliente.equals(other.getCodigoIdentificacionCliente()))) &&
            ((this.codigoIdioma==null && other.getCodigoIdioma()==null) || 
             (this.codigoIdioma!=null &&
              this.codigoIdioma.equals(other.getCodigoIdioma()))) &&
            ((this.codigoLimiteConsumo==null && other.getCodigoLimiteConsumo()==null) || 
             (this.codigoLimiteConsumo!=null &&
              this.codigoLimiteConsumo.equals(other.getCodigoLimiteConsumo()))) &&
            ((this.codigoModificacion==null && other.getCodigoModificacion()==null) || 
             (this.codigoModificacion!=null &&
              this.codigoModificacion.equals(other.getCodigoModificacion()))) &&
            ((this.codigoNPI==null && other.getCodigoNPI()==null) || 
             (this.codigoNPI!=null &&
              this.codigoNPI.equals(other.getCodigoNPI()))) &&
            ((this.codigoOficina==null && other.getCodigoOficina()==null) || 
             (this.codigoOficina!=null &&
              this.codigoOficina.equals(other.getCodigoOficina()))) &&
            ((this.codigoOperadora==null && other.getCodigoOperadora()==null) || 
             (this.codigoOperadora!=null &&
              this.codigoOperadora.equals(other.getCodigoOperadora()))) &&
            ((this.codigoPais==null && other.getCodigoPais()==null) || 
             (this.codigoPais!=null &&
              this.codigoPais.equals(other.getCodigoPais()))) &&
            ((this.codigoPincli==null && other.getCodigoPincli()==null) || 
             (this.codigoPincli!=null &&
              this.codigoPincli.equals(other.getCodigoPincli()))) &&
            ((this.codigoPlanComercial==null && other.getCodigoPlanComercial()==null) || 
             (this.codigoPlanComercial!=null &&
              this.codigoPlanComercial.equals(other.getCodigoPlanComercial()))) &&
            ((this.codigoPlanTarifario==null && other.getCodigoPlanTarifario()==null) || 
             (this.codigoPlanTarifario!=null &&
              this.codigoPlanTarifario.equals(other.getCodigoPlanTarifario()))) &&
            ((this.codigoPlaza==null && other.getCodigoPlaza()==null) || 
             (this.codigoPlaza!=null &&
              this.codigoPlaza.equals(other.getCodigoPlaza()))) &&
            this.codigoProducto == other.getCodigoProducto() &&
            ((this.codigoProspecto==null && other.getCodigoProspecto()==null) || 
             (this.codigoProspecto!=null &&
              this.codigoProspecto.equals(other.getCodigoProspecto()))) &&
            ((this.codigoSector==null && other.getCodigoSector()==null) || 
             (this.codigoSector!=null &&
              this.codigoSector.equals(other.getCodigoSector()))) &&
            ((this.codigoSistemaPago==null && other.getCodigoSistemaPago()==null) || 
             (this.codigoSistemaPago!=null &&
              this.codigoSistemaPago.equals(other.getCodigoSistemaPago()))) &&
            ((this.codigoSubCategImpos==null && other.getCodigoSubCategImpos()==null) || 
             (this.codigoSubCategImpos!=null &&
              this.codigoSubCategImpos.equals(other.getCodigoSubCategImpos()))) &&
            ((this.codigoSubCategoria==null && other.getCodigoSubCategoria()==null) || 
             (this.codigoSubCategoria!=null &&
              this.codigoSubCategoria.equals(other.getCodigoSubCategoria()))) &&
            ((this.codigoSubCuenta==null && other.getCodigoSubCuenta()==null) || 
             (this.codigoSubCuenta!=null &&
              this.codigoSubCuenta.equals(other.getCodigoSubCuenta()))) &&
            ((this.codigoSucursal==null && other.getCodigoSucursal()==null) || 
             (this.codigoSucursal!=null &&
              this.codigoSucursal.equals(other.getCodigoSucursal()))) &&
            ((this.codigoSupervisor==null && other.getCodigoSupervisor()==null) || 
             (this.codigoSupervisor!=null &&
              this.codigoSupervisor.equals(other.getCodigoSupervisor()))) &&
            ((this.codigoTipIdent2==null && other.getCodigoTipIdent2()==null) || 
             (this.codigoTipIdent2!=null &&
              this.codigoTipIdent2.equals(other.getCodigoTipIdent2()))) &&
            ((this.codigoTipoCliente==null && other.getCodigoTipoCliente()==null) || 
             (this.codigoTipoCliente!=null &&
              this.codigoTipoCliente.equals(other.getCodigoTipoCliente()))) &&
            ((this.codigoTipoIdentificacion==null && other.getCodigoTipoIdentificacion()==null) || 
             (this.codigoTipoIdentificacion!=null &&
              this.codigoTipoIdentificacion.equals(other.getCodigoTipoIdentificacion()))) &&
            ((this.codigoTipoIdentificacionApoderado==null && other.getCodigoTipoIdentificacionApoderado()==null) || 
             (this.codigoTipoIdentificacionApoderado!=null &&
              this.codigoTipoIdentificacionApoderado.equals(other.getCodigoTipoIdentificacionApoderado()))) &&
            ((this.codigoTipoIdentificacionTributaria==null && other.getCodigoTipoIdentificacionTributaria()==null) || 
             (this.codigoTipoIdentificacionTributaria!=null &&
              this.codigoTipoIdentificacionTributaria.equals(other.getCodigoTipoIdentificacionTributaria()))) &&
            ((this.codigoTipoTarjeta==null && other.getCodigoTipoTarjeta()==null) || 
             (this.codigoTipoTarjeta!=null &&
              this.codigoTipoTarjeta.equals(other.getCodigoTipoTarjeta()))) &&
            ((this.codigoUso==null && other.getCodigoUso()==null) || 
             (this.codigoUso!=null &&
              this.codigoUso.equals(other.getCodigoUso()))) &&
            this.codigoVendedor == other.getCodigoVendedor() &&
            ((this.descripcionCategImpos==null && other.getDescripcionCategImpos()==null) || 
             (this.descripcionCategImpos!=null &&
              this.descripcionCategImpos.equals(other.getDescripcionCategImpos()))) &&
            ((this.descripcionCategoria==null && other.getDescripcionCategoria()==null) || 
             (this.descripcionCategoria!=null &&
              this.descripcionCategoria.equals(other.getDescripcionCategoria()))) &&
            ((this.descripcionEmpresa==null && other.getDescripcionEmpresa()==null) || 
             (this.descripcionEmpresa!=null &&
              this.descripcionEmpresa.equals(other.getDescripcionEmpresa()))) &&
            ((this.descripcionReferenciaDocumento==null && other.getDescripcionReferenciaDocumento()==null) || 
             (this.descripcionReferenciaDocumento!=null &&
              this.descripcionReferenciaDocumento.equals(other.getDescripcionReferenciaDocumento()))) &&
            ((this.descripcionSubCategImpos==null && other.getDescripcionSubCategImpos()==null) || 
             (this.descripcionSubCategImpos!=null &&
              this.descripcionSubCategImpos.equals(other.getDescripcionSubCategImpos()))) &&
            ((this.direccionEMail==null && other.getDireccionEMail()==null) || 
             (this.direccionEMail!=null &&
              this.direccionEMail.equals(other.getDireccionEMail()))) &&
            ((this.direcciones==null && other.getDirecciones()==null) || 
             (this.direcciones!=null &&
              java.util.Arrays.equals(this.direcciones, other.getDirecciones()))) &&
            this.existeCliente == other.getExisteCliente() &&
            ((this.fechaAcepVenta==null && other.getFechaAcepVenta()==null) || 
             (this.fechaAcepVenta!=null &&
              this.fechaAcepVenta.equals(other.getFechaAcepVenta()))) &&
            ((this.fechaBaja==null && other.getFechaBaja()==null) || 
             (this.fechaBaja!=null &&
              this.fechaBaja.equals(other.getFechaBaja()))) &&
            ((this.fechaDesde==null && other.getFechaDesde()==null) || 
             (this.fechaDesde!=null &&
              this.fechaDesde.equals(other.getFechaDesde()))) &&
            ((this.fechaHasta==null && other.getFechaHasta()==null) || 
             (this.fechaHasta!=null &&
              this.fechaHasta.equals(other.getFechaHasta()))) &&
            ((this.fechaNacimiento==null && other.getFechaNacimiento()==null) || 
             (this.fechaNacimiento!=null &&
              this.fechaNacimiento.equals(other.getFechaNacimiento()))) &&
            ((this.fechaVencimientoTarjeta==null && other.getFechaVencimientoTarjeta()==null) || 
             (this.fechaVencimientoTarjeta!=null &&
              this.fechaVencimientoTarjeta.equals(other.getFechaVencimientoTarjeta()))) &&
            ((this.importeLimiteDebito==null && other.getImporteLimiteDebito()==null) || 
             (this.importeLimiteDebito!=null &&
              this.importeLimiteDebito.equals(other.getImporteLimiteDebito()))) &&
            ((this.indentificadorSegmento==null && other.getIndentificadorSegmento()==null) || 
             (this.indentificadorSegmento!=null &&
              this.indentificadorSegmento.equals(other.getIndentificadorSegmento()))) &&
            ((this.indicadirTipPersona==null && other.getIndicadirTipPersona()==null) || 
             (this.indicadirTipPersona!=null &&
              this.indicadirTipPersona.equals(other.getIndicadirTipPersona()))) &&
            ((this.indicadorAcepVenta==null && other.getIndicadorAcepVenta()==null) || 
             (this.indicadorAcepVenta!=null &&
              this.indicadorAcepVenta.equals(other.getIndicadorAcepVenta()))) &&
            ((this.indicadorAgente==null && other.getIndicadorAgente()==null) || 
             (this.indicadorAgente!=null &&
              this.indicadorAgente.equals(other.getIndicadorAgente()))) &&
            ((this.indicadorAlta==null && other.getIndicadorAlta()==null) || 
             (this.indicadorAlta!=null &&
              this.indicadorAlta.equals(other.getIndicadorAlta()))) &&
            ((this.indicadorDebito==null && other.getIndicadorDebito()==null) || 
             (this.indicadorDebito!=null &&
              this.indicadorDebito.equals(other.getIndicadorDebito()))) &&
            ((this.indicadorEstadoCivil==null && other.getIndicadorEstadoCivil()==null) || 
             (this.indicadorEstadoCivil!=null &&
              this.indicadorEstadoCivil.equals(other.getIndicadorEstadoCivil()))) &&
            ((this.indicadorMandato==null && other.getIndicadorMandato()==null) || 
             (this.indicadorMandato!=null &&
              this.indicadorMandato.equals(other.getIndicadorMandato()))) &&
            ((this.indicadorPrivacidad==null && other.getIndicadorPrivacidad()==null) || 
             (this.indicadorPrivacidad!=null &&
              this.indicadorPrivacidad.equals(other.getIndicadorPrivacidad()))) &&
            ((this.indicadorSexo==null && other.getIndicadorSexo()==null) || 
             (this.indicadorSexo!=null &&
              this.indicadorSexo.equals(other.getIndicadorSexo()))) &&
            ((this.indicadorSituacion==null && other.getIndicadorSituacion()==null) || 
             (this.indicadorSituacion!=null &&
              this.indicadorSituacion.equals(other.getIndicadorSituacion()))) &&
            ((this.indicadorTipoCuenta==null && other.getIndicadorTipoCuenta()==null) || 
             (this.indicadorTipoCuenta!=null &&
              this.indicadorTipoCuenta.equals(other.getIndicadorTipoCuenta()))) &&
            ((this.indicadorTraspaso==null && other.getIndicadorTraspaso()==null) || 
             (this.indicadorTraspaso!=null &&
              this.indicadorTraspaso.equals(other.getIndicadorTraspaso()))) &&
            this.indicativoFacturable == other.getIndicativoFacturable() &&
            this.limiteCredito == other.getLimiteCredito() &&
            ((this.nombreApellido1==null && other.getNombreApellido1()==null) || 
             (this.nombreApellido1!=null &&
              this.nombreApellido1.equals(other.getNombreApellido1()))) &&
            ((this.nombreApellido2==null && other.getNombreApellido2()==null) || 
             (this.nombreApellido2!=null &&
              this.nombreApellido2.equals(other.getNombreApellido2()))) &&
            ((this.nombreApoderado==null && other.getNombreApoderado()==null) || 
             (this.nombreApoderado!=null &&
              this.nombreApoderado.equals(other.getNombreApoderado()))) &&
            ((this.nombreCliente==null && other.getNombreCliente()==null) || 
             (this.nombreCliente!=null &&
              this.nombreCliente.equals(other.getNombreCliente()))) &&
            ((this.nombreUsuarOra==null && other.getNombreUsuarOra()==null) || 
             (this.nombreUsuarOra!=null &&
              this.nombreUsuarOra.equals(other.getNombreUsuarOra()))) &&
            ((this.nombreUsuarioAsesor==null && other.getNombreUsuarioAsesor()==null) || 
             (this.nombreUsuarioAsesor!=null &&
              this.nombreUsuarioAsesor.equals(other.getNombreUsuarioAsesor()))) &&
            ((this.numIdent2==null && other.getNumIdent2()==null) || 
             (this.numIdent2!=null &&
              this.numIdent2.equals(other.getNumIdent2()))) &&
            this.numMesesCobro == other.getNumMesesCobro() &&
            ((this.numeroAbobeep==null && other.getNumeroAbobeep()==null) || 
             (this.numeroAbobeep!=null &&
              this.numeroAbobeep.equals(other.getNumeroAbobeep()))) &&
            ((this.numeroAbocel==null && other.getNumeroAbocel()==null) || 
             (this.numeroAbocel!=null &&
              this.numeroAbocel.equals(other.getNumeroAbocel()))) &&
            this.numeroAbonados == other.getNumeroAbonados() &&
            ((this.numeroAborent==null && other.getNumeroAborent()==null) || 
             (this.numeroAborent!=null &&
              this.numeroAborent.equals(other.getNumeroAborent()))) &&
            ((this.numeroAboroaming==null && other.getNumeroAboroaming()==null) || 
             (this.numeroAboroaming!=null &&
              this.numeroAboroaming.equals(other.getNumeroAboroaming()))) &&
            ((this.numeroAbotrek==null && other.getNumeroAbotrek()==null) || 
             (this.numeroAbotrek!=null &&
              this.numeroAbotrek.equals(other.getNumeroAbotrek()))) &&
            ((this.numeroAbotrunk==null && other.getNumeroAbotrunk()==null) || 
             (this.numeroAbotrunk!=null &&
              this.numeroAbotrunk.equals(other.getNumeroAbotrunk()))) &&
            ((this.numeroCelular==null && other.getNumeroCelular()==null) || 
             (this.numeroCelular!=null &&
              this.numeroCelular.equals(other.getNumeroCelular()))) &&
            ((this.numeroCiclos==null && other.getNumeroCiclos()==null) || 
             (this.numeroCiclos!=null &&
              this.numeroCiclos.equals(other.getNumeroCiclos()))) &&
            ((this.numeroCuentaCorriente==null && other.getNumeroCuentaCorriente()==null) || 
             (this.numeroCuentaCorriente!=null &&
              this.numeroCuentaCorriente.equals(other.getNumeroCuentaCorriente()))) &&
            ((this.numeroFax==null && other.getNumeroFax()==null) || 
             (this.numeroFax!=null &&
              this.numeroFax.equals(other.getNumeroFax()))) &&
            ((this.numeroIdentificacion==null && other.getNumeroIdentificacion()==null) || 
             (this.numeroIdentificacion!=null &&
              this.numeroIdentificacion.equals(other.getNumeroIdentificacion()))) &&
            ((this.numeroIdentificacionApoderado==null && other.getNumeroIdentificacionApoderado()==null) || 
             (this.numeroIdentificacionApoderado!=null &&
              this.numeroIdentificacionApoderado.equals(other.getNumeroIdentificacionApoderado()))) &&
            ((this.numeroIdentificacionTributaria==null && other.getNumeroIdentificacionTributaria()==null) || 
             (this.numeroIdentificacionTributaria!=null &&
              this.numeroIdentificacionTributaria.equals(other.getNumeroIdentificacionTributaria()))) &&
            ((this.numeroIntGrupoFam==null && other.getNumeroIntGrupoFam()==null) || 
             (this.numeroIntGrupoFam!=null &&
              this.numeroIntGrupoFam.equals(other.getNumeroIntGrupoFam()))) &&
            ((this.numeroMinutos==null && other.getNumeroMinutos()==null) || 
             (this.numeroMinutos!=null &&
              this.numeroMinutos.equals(other.getNumeroMinutos()))) &&
            this.numeroOrdenRepresentanteLegal == other.getNumeroOrdenRepresentanteLegal() &&
            ((this.numeroOrdenServicio==null && other.getNumeroOrdenServicio()==null) || 
             (this.numeroOrdenServicio!=null &&
              this.numeroOrdenServicio.equals(other.getNumeroOrdenServicio()))) &&
            ((this.numeroTarjeta==null && other.getNumeroTarjeta()==null) || 
             (this.numeroTarjeta!=null &&
              this.numeroTarjeta.equals(other.getNumeroTarjeta()))) &&
            ((this.numeroTelefono==null && other.getNumeroTelefono()==null) || 
             (this.numeroTelefono!=null &&
              this.numeroTelefono.equals(other.getNumeroTelefono()))) &&
            ((this.numeroTelefono1==null && other.getNumeroTelefono1()==null) || 
             (this.numeroTelefono1!=null &&
              this.numeroTelefono1.equals(other.getNumeroTelefono1()))) &&
            ((this.numeroTelefono2==null && other.getNumeroTelefono2()==null) || 
             (this.numeroTelefono2!=null &&
              this.numeroTelefono2.equals(other.getNumeroTelefono2()))) &&
            ((this.planComercial==null && other.getPlanComercial()==null) || 
             (this.planComercial!=null &&
              this.planComercial.equals(other.getPlanComercial()))) &&
            ((this.planTarifario==null && other.getPlanTarifario()==null) || 
             (this.planTarifario!=null &&
              this.planTarifario.equals(other.getPlanTarifario()))) &&
            ((this.representanteLegalDTO==null && other.getRepresentanteLegalDTO()==null) || 
             (this.representanteLegalDTO!=null &&
              java.util.Arrays.equals(this.representanteLegalDTO, other.getRepresentanteLegalDTO()))) &&
            ((this.tipoCliente==null && other.getTipoCliente()==null) || 
             (this.tipoCliente!=null &&
              this.tipoCliente.equals(other.getTipoCliente()))) &&
            ((this.tipoPlanTarifario==null && other.getTipoPlanTarifario()==null) || 
             (this.tipoPlanTarifario!=null &&
              this.tipoPlanTarifario.equals(other.getTipoPlanTarifario()))) &&
            ((this.usuario==null && other.getUsuario()==null) || 
             (this.usuario!=null &&
              this.usuario.equals(other.getUsuario())));
        __equalsCalc = null;
        return _equals;
    }

    private boolean __hashCodeCalc = false;
    public synchronized int hashCode() {
        if (__hashCodeCalc) {
            return 0;
        }
        __hashCodeCalc = true;
        int _hashCode = 1;
        if (getCategoriaTributaria() != null) {
            _hashCode += getCategoriaTributaria().hashCode();
        }
        if (getCodigo123() != null) {
            _hashCode += getCodigo123().hashCode();
        }
        if (getCodigoABC() != null) {
            _hashCode += getCodigoABC().hashCode();
        }
        if (getCodigoActividad() != null) {
            _hashCode += getCodigoActividad().hashCode();
        }
        if (getCodigoBanco() != null) {
            _hashCode += getCodigoBanco().hashCode();
        }
        if (getCodigoBancoTarjeta() != null) {
            _hashCode += getCodigoBancoTarjeta().hashCode();
        }
        if (getCodigoCalidadCliente() != null) {
            _hashCode += getCodigoCalidadCliente().hashCode();
        }
        if (getCodigoCargoBasico() != null) {
            _hashCode += getCodigoCargoBasico().hashCode();
        }
        if (getCodigoCategImpos() != null) {
            _hashCode += getCodigoCategImpos().hashCode();
        }
        if (getCodigoCategoria() != null) {
            _hashCode += getCodigoCategoria().hashCode();
        }
        if (getCodigoCategoriaEmpresa() != null) {
            _hashCode += getCodigoCategoriaEmpresa().hashCode();
        }
        if (getCodigoCelda() != null) {
            _hashCode += getCodigoCelda().hashCode();
        }
        _hashCode += getCodigoCiclo();
        if (getCodigoCicloFacturacion() != null) {
            _hashCode += getCodigoCicloFacturacion().hashCode();
        }
        if (getCodigoCicloNuevo() != null) {
            _hashCode += getCodigoCicloNuevo().hashCode();
        }
        if (getCodigoCliente() != null) {
            _hashCode += getCodigoCliente().hashCode();
        }
        if (getCodigoCobrador() != null) {
            _hashCode += getCodigoCobrador().hashCode();
        }
        if (getCodigoCuenta() != null) {
            _hashCode += getCodigoCuenta().hashCode();
        }
        if (getCodigoDespacho() != null) {
            _hashCode += getCodigoDespacho().hashCode();
        }
        _hashCode += new Long(getCodigoEmpresa()).hashCode();
        if (getCodigoIdentificacionCliente() != null) {
            _hashCode += getCodigoIdentificacionCliente().hashCode();
        }
        if (getCodigoIdioma() != null) {
            _hashCode += getCodigoIdioma().hashCode();
        }
        if (getCodigoLimiteConsumo() != null) {
            _hashCode += getCodigoLimiteConsumo().hashCode();
        }
        if (getCodigoModificacion() != null) {
            _hashCode += getCodigoModificacion().hashCode();
        }
        if (getCodigoNPI() != null) {
            _hashCode += getCodigoNPI().hashCode();
        }
        if (getCodigoOficina() != null) {
            _hashCode += getCodigoOficina().hashCode();
        }
        if (getCodigoOperadora() != null) {
            _hashCode += getCodigoOperadora().hashCode();
        }
        if (getCodigoPais() != null) {
            _hashCode += getCodigoPais().hashCode();
        }
        if (getCodigoPincli() != null) {
            _hashCode += getCodigoPincli().hashCode();
        }
        if (getCodigoPlanComercial() != null) {
            _hashCode += getCodigoPlanComercial().hashCode();
        }
        if (getCodigoPlanTarifario() != null) {
            _hashCode += getCodigoPlanTarifario().hashCode();
        }
        if (getCodigoPlaza() != null) {
            _hashCode += getCodigoPlaza().hashCode();
        }
        _hashCode += getCodigoProducto();
        if (getCodigoProspecto() != null) {
            _hashCode += getCodigoProspecto().hashCode();
        }
        if (getCodigoSector() != null) {
            _hashCode += getCodigoSector().hashCode();
        }
        if (getCodigoSistemaPago() != null) {
            _hashCode += getCodigoSistemaPago().hashCode();
        }
        if (getCodigoSubCategImpos() != null) {
            _hashCode += getCodigoSubCategImpos().hashCode();
        }
        if (getCodigoSubCategoria() != null) {
            _hashCode += getCodigoSubCategoria().hashCode();
        }
        if (getCodigoSubCuenta() != null) {
            _hashCode += getCodigoSubCuenta().hashCode();
        }
        if (getCodigoSucursal() != null) {
            _hashCode += getCodigoSucursal().hashCode();
        }
        if (getCodigoSupervisor() != null) {
            _hashCode += getCodigoSupervisor().hashCode();
        }
        if (getCodigoTipIdent2() != null) {
            _hashCode += getCodigoTipIdent2().hashCode();
        }
        if (getCodigoTipoCliente() != null) {
            _hashCode += getCodigoTipoCliente().hashCode();
        }
        if (getCodigoTipoIdentificacion() != null) {
            _hashCode += getCodigoTipoIdentificacion().hashCode();
        }
        if (getCodigoTipoIdentificacionApoderado() != null) {
            _hashCode += getCodigoTipoIdentificacionApoderado().hashCode();
        }
        if (getCodigoTipoIdentificacionTributaria() != null) {
            _hashCode += getCodigoTipoIdentificacionTributaria().hashCode();
        }
        if (getCodigoTipoTarjeta() != null) {
            _hashCode += getCodigoTipoTarjeta().hashCode();
        }
        if (getCodigoUso() != null) {
            _hashCode += getCodigoUso().hashCode();
        }
        _hashCode += getCodigoVendedor();
        if (getDescripcionCategImpos() != null) {
            _hashCode += getDescripcionCategImpos().hashCode();
        }
        if (getDescripcionCategoria() != null) {
            _hashCode += getDescripcionCategoria().hashCode();
        }
        if (getDescripcionEmpresa() != null) {
            _hashCode += getDescripcionEmpresa().hashCode();
        }
        if (getDescripcionReferenciaDocumento() != null) {
            _hashCode += getDescripcionReferenciaDocumento().hashCode();
        }
        if (getDescripcionSubCategImpos() != null) {
            _hashCode += getDescripcionSubCategImpos().hashCode();
        }
        if (getDireccionEMail() != null) {
            _hashCode += getDireccionEMail().hashCode();
        }
        if (getDirecciones() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getDirecciones());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getDirecciones(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        _hashCode += getExisteCliente();
        if (getFechaAcepVenta() != null) {
            _hashCode += getFechaAcepVenta().hashCode();
        }
        if (getFechaBaja() != null) {
            _hashCode += getFechaBaja().hashCode();
        }
        if (getFechaDesde() != null) {
            _hashCode += getFechaDesde().hashCode();
        }
        if (getFechaHasta() != null) {
            _hashCode += getFechaHasta().hashCode();
        }
        if (getFechaNacimiento() != null) {
            _hashCode += getFechaNacimiento().hashCode();
        }
        if (getFechaVencimientoTarjeta() != null) {
            _hashCode += getFechaVencimientoTarjeta().hashCode();
        }
        if (getImporteLimiteDebito() != null) {
            _hashCode += getImporteLimiteDebito().hashCode();
        }
        if (getIndentificadorSegmento() != null) {
            _hashCode += getIndentificadorSegmento().hashCode();
        }
        if (getIndicadirTipPersona() != null) {
            _hashCode += getIndicadirTipPersona().hashCode();
        }
        if (getIndicadorAcepVenta() != null) {
            _hashCode += getIndicadorAcepVenta().hashCode();
        }
        if (getIndicadorAgente() != null) {
            _hashCode += getIndicadorAgente().hashCode();
        }
        if (getIndicadorAlta() != null) {
            _hashCode += getIndicadorAlta().hashCode();
        }
        if (getIndicadorDebito() != null) {
            _hashCode += getIndicadorDebito().hashCode();
        }
        if (getIndicadorEstadoCivil() != null) {
            _hashCode += getIndicadorEstadoCivil().hashCode();
        }
        if (getIndicadorMandato() != null) {
            _hashCode += getIndicadorMandato().hashCode();
        }
        if (getIndicadorPrivacidad() != null) {
            _hashCode += getIndicadorPrivacidad().hashCode();
        }
        if (getIndicadorSexo() != null) {
            _hashCode += getIndicadorSexo().hashCode();
        }
        if (getIndicadorSituacion() != null) {
            _hashCode += getIndicadorSituacion().hashCode();
        }
        if (getIndicadorTipoCuenta() != null) {
            _hashCode += getIndicadorTipoCuenta().hashCode();
        }
        if (getIndicadorTraspaso() != null) {
            _hashCode += getIndicadorTraspaso().hashCode();
        }
        _hashCode += getIndicativoFacturable();
        _hashCode += new Double(getLimiteCredito()).hashCode();
        if (getNombreApellido1() != null) {
            _hashCode += getNombreApellido1().hashCode();
        }
        if (getNombreApellido2() != null) {
            _hashCode += getNombreApellido2().hashCode();
        }
        if (getNombreApoderado() != null) {
            _hashCode += getNombreApoderado().hashCode();
        }
        if (getNombreCliente() != null) {
            _hashCode += getNombreCliente().hashCode();
        }
        if (getNombreUsuarOra() != null) {
            _hashCode += getNombreUsuarOra().hashCode();
        }
        if (getNombreUsuarioAsesor() != null) {
            _hashCode += getNombreUsuarioAsesor().hashCode();
        }
        if (getNumIdent2() != null) {
            _hashCode += getNumIdent2().hashCode();
        }
        _hashCode += new Long(getNumMesesCobro()).hashCode();
        if (getNumeroAbobeep() != null) {
            _hashCode += getNumeroAbobeep().hashCode();
        }
        if (getNumeroAbocel() != null) {
            _hashCode += getNumeroAbocel().hashCode();
        }
        _hashCode += getNumeroAbonados();
        if (getNumeroAborent() != null) {
            _hashCode += getNumeroAborent().hashCode();
        }
        if (getNumeroAboroaming() != null) {
            _hashCode += getNumeroAboroaming().hashCode();
        }
        if (getNumeroAbotrek() != null) {
            _hashCode += getNumeroAbotrek().hashCode();
        }
        if (getNumeroAbotrunk() != null) {
            _hashCode += getNumeroAbotrunk().hashCode();
        }
        if (getNumeroCelular() != null) {
            _hashCode += getNumeroCelular().hashCode();
        }
        if (getNumeroCiclos() != null) {
            _hashCode += getNumeroCiclos().hashCode();
        }
        if (getNumeroCuentaCorriente() != null) {
            _hashCode += getNumeroCuentaCorriente().hashCode();
        }
        if (getNumeroFax() != null) {
            _hashCode += getNumeroFax().hashCode();
        }
        if (getNumeroIdentificacion() != null) {
            _hashCode += getNumeroIdentificacion().hashCode();
        }
        if (getNumeroIdentificacionApoderado() != null) {
            _hashCode += getNumeroIdentificacionApoderado().hashCode();
        }
        if (getNumeroIdentificacionTributaria() != null) {
            _hashCode += getNumeroIdentificacionTributaria().hashCode();
        }
        if (getNumeroIntGrupoFam() != null) {
            _hashCode += getNumeroIntGrupoFam().hashCode();
        }
        if (getNumeroMinutos() != null) {
            _hashCode += getNumeroMinutos().hashCode();
        }
        _hashCode += getNumeroOrdenRepresentanteLegal();
        if (getNumeroOrdenServicio() != null) {
            _hashCode += getNumeroOrdenServicio().hashCode();
        }
        if (getNumeroTarjeta() != null) {
            _hashCode += getNumeroTarjeta().hashCode();
        }
        if (getNumeroTelefono() != null) {
            _hashCode += getNumeroTelefono().hashCode();
        }
        if (getNumeroTelefono1() != null) {
            _hashCode += getNumeroTelefono1().hashCode();
        }
        if (getNumeroTelefono2() != null) {
            _hashCode += getNumeroTelefono2().hashCode();
        }
        if (getPlanComercial() != null) {
            _hashCode += getPlanComercial().hashCode();
        }
        if (getPlanTarifario() != null) {
            _hashCode += getPlanTarifario().hashCode();
        }
        if (getRepresentanteLegalDTO() != null) {
            for (int i=0;
                 i<java.lang.reflect.Array.getLength(getRepresentanteLegalDTO());
                 i++) {
                java.lang.Object obj = java.lang.reflect.Array.get(getRepresentanteLegalDTO(), i);
                if (obj != null &&
                    !obj.getClass().isArray()) {
                    _hashCode += obj.hashCode();
                }
            }
        }
        if (getTipoCliente() != null) {
            _hashCode += getTipoCliente().hashCode();
        }
        if (getTipoPlanTarifario() != null) {
            _hashCode += getTipoPlanTarifario().hashCode();
        }
        if (getUsuario() != null) {
            _hashCode += getUsuario().hashCode();
        }
        __hashCodeCalc = false;
        return _hashCode;
    }

    // Type metadata
    private static org.apache.axis.description.TypeDesc typeDesc =
        new org.apache.axis.description.TypeDesc(ClienteDTO.class, true);

    static {
        typeDesc.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ClienteDTO"));
        org.apache.axis.description.ElementDesc elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("categoriaTributaria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CategoriaTributaria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigo123");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "Codigo123"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoABC");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoABC"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoActividad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoActividad"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoBanco");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoBanco"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoBancoTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoBancoTarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCalidadCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCalidadCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCargoBasico");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCargoBasico"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCategImpos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCategImpos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCategoria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCategoriaEmpresa");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCategoriaEmpresa"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCelda");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCelda"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCiclo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCiclo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCicloFacturacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCicloFacturacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCicloNuevo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCicloNuevo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCobrador");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCobrador"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoCuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoDespacho");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoDespacho"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoEmpresa");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoEmpresa"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoIdentificacionCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoIdentificacionCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoIdioma");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoIdioma"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoLimiteConsumo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoLimiteConsumo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoModificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoModificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoNPI");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoNPI"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoOficina");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoOficina"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoOperadora");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoOperadora"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoPais");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoPais"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoPincli");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoPincli"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoPlanComercial");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoPlanComercial"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoPlanTarifario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoPlanTarifario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoPlaza");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoPlaza"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoProducto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoProducto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoProspecto");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoProspecto"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoSector");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoSector"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoSistemaPago");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoSistemaPago"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoSubCategImpos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoSubCategImpos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoSubCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoSubCategoria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoSubCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoSubCuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoSucursal");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoSucursal"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoSupervisor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoSupervisor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipIdent2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipIdent2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipoCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoIdentificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipoIdentificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoIdentificacionApoderado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipoIdentificacionApoderado"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoIdentificacionTributaria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipoIdentificacionTributaria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoTipoTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoTipoTarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoUso");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoUso"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("codigoVendedor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "CodigoVendedor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionCategImpos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DescripcionCategImpos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionCategoria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DescripcionCategoria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionEmpresa");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DescripcionEmpresa"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionReferenciaDocumento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DescripcionReferenciaDocumento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("descripcionSubCategImpos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DescripcionSubCategImpos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("direccionEMail");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "DireccionEMail"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("direcciones");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "Direcciones"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto", "DireccionNegocioDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("existeCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ExisteCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaAcepVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "FechaAcepVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaBaja");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "FechaBaja"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaDesde");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "FechaDesde"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaHasta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "FechaHasta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaNacimiento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "FechaNacimiento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("fechaVencimientoTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "FechaVencimientoTarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("importeLimiteDebito");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "ImporteLimiteDebito"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indentificadorSegmento");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndentificadorSegmento"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadirTipPersona");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadirTipPersona"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorAcepVenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorAcepVenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorAgente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorAgente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorAlta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorAlta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorDebito");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorDebito"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorEstadoCivil");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorEstadoCivil"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorMandato");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorMandato"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorPrivacidad");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorPrivacidad"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorSexo");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorSexo"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorSituacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorSituacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorTipoCuenta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorTipoCuenta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicadorTraspaso");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicadorTraspaso"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("indicativoFacturable");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "IndicativoFacturable"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("limiteCredito");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "LimiteCredito"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "double"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreApellido1");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NombreApellido1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreApellido2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NombreApellido2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreApoderado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NombreApoderado"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NombreCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreUsuarOra");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NombreUsuarOra"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("nombreUsuarioAsesor");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NombreUsuarioAsesor"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numIdent2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumIdent2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numMesesCobro");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumMesesCobro"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "long"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAbobeep");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroAbobeep"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAbocel");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroAbocel"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAbonados");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroAbonados"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAborent");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroAborent"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAboroaming");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroAboroaming"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAbotrek");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroAbotrek"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroAbotrunk");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroAbotrunk"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroCelular");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroCelular"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroCiclos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroCiclos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroCuentaCorriente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroCuentaCorriente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroFax");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroFax"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIdentificacion");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroIdentificacion"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIdentificacionApoderado");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroIdentificacionApoderado"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIdentificacionTributaria");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroIdentificacionTributaria"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroIntGrupoFam");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroIntGrupoFam"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroMinutos");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroMinutos"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroOrdenRepresentanteLegal");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroOrdenRepresentanteLegal"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "int"));
        elemField.setNillable(false);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroOrdenServicio");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroOrdenServicio"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroTarjeta");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroTarjeta"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroTelefono");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroTelefono"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroTelefono1");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroTelefono1"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("numeroTelefono2");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "NumeroTelefono2"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("planComercial");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "PlanComercial"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("planTarifario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "PlanTarifario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("representanteLegalDTO");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RepresentanteLegalDTO"));
        elemField.setXmlType(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "RepresentanteLegalDTO"));
        elemField.setMinOccurs(0);
        elemField.setNillable(true);
        elemField.setMaxOccursUnbounded(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipoCliente");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipoCliente"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("tipoPlanTarifario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "TipoPlanTarifario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
        elemField = new org.apache.axis.description.ElementDesc();
        elemField.setFieldName("usuario");
        elemField.setXmlName(new javax.xml.namespace.QName("java:com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto", "Usuario"));
        elemField.setXmlType(new javax.xml.namespace.QName("http://www.w3.org/2001/XMLSchema", "string"));
        elemField.setNillable(true);
        typeDesc.addFieldDesc(elemField);
    }

    /**
     * Return type metadata object
     */
    public static org.apache.axis.description.TypeDesc getTypeDesc() {
        return typeDesc;
    }

    /**
     * Get Custom Serializer
     */
    public static org.apache.axis.encoding.Serializer getSerializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanSerializer(
            _javaType, _xmlType, typeDesc);
    }

    /**
     * Get Custom Deserializer
     */
    public static org.apache.axis.encoding.Deserializer getDeserializer(
           java.lang.String mechType, 
           java.lang.Class _javaType,  
           javax.xml.namespace.QName _xmlType) {
        return 
          new  org.apache.axis.encoding.ser.BeanDeserializer(
            _javaType, _xmlType, typeDesc);
    }

}
