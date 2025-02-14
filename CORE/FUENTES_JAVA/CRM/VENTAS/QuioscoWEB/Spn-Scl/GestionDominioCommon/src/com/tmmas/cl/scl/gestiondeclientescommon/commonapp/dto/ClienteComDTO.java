package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;


public class ClienteComDTO implements Serializable, Cloneable {
	private static final long serialVersionUID = 1L;

	
	
	public Object clone() 
    {
        Object clone = null;
         try 
         {
             clone = super.clone();
         }
         catch(CloneNotSupportedException e) 
         {
             // No debería ocurrir
         }
         return clone;
    }

	
	DatosGeneralesVentaDTO[]   lineaCDMA;	
	DatosGeneralesVentaDTO[]   lineaGSM;
	
	
	private String CodigoTipoPlan;
	private String codigoCliente;
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
	private String codigoTipoCliente;
	private String codigoCelda;
    private String codigoCalidadCliente;
    private double limiteCredito;
    private int indicativoFacturable;
    private int codigoCiclo;  
    private DireccionNegocioDTO[] direcciones;
    private long codigoEmpresa;
    private String planComercial;
    private String categoriaTributaria;
    private String numeroTelefono;
    private String numeroTelefono1;
    private String numeroTelefono2;
    private String numeroFax;
    private String direccionEMail;
    
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
    
    
    /*--Identifica los Datos devuelto por Buro--*/
    private int datosBuro; //Si el valor es 1 tomar nombre, apellido1, apellido2. Si es 0 tomar nombre y descripción nombre
    private String descripcionNombre;
    private boolean existeExcepcion;
    
    /*--Ciclo de facturación asignado al cliente--*/
    private int cicloFacturacion;
    
    /*-- Cliente Empresa --*/
    private String descripcionEmpresa;
	private String planTarifario;
    private int    codigoProducto;
	private int    numeroAbonados;
	private String numeroAbonadosPorPlan;
	


	/*-- Secuencia Despacho --*/
	private String codigoDespacho;
	private String fechaDesde;
	private String fechaHasta;
	private RepresentanteLegalComDTO[] representanteLegalComDTO;
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
	private String codCrediticia; //CSR-11002
	private String montoPreAutorizado; //CSR-11002

	
	/*De alta cliente common*/
	private CampanaVigenteComDTO campanaVigenteComDTO;
	private ModalidadCancelacionComDTO modalidadCancelacionComDTO;
    private PlanComercialComDTO planComercialComDTO;
    /* --Indice del objeto por defecto */ 
    public static int indiceDefectoTipoCliente = -1;
    public static int indiceDefectoCategoriaCliente = -1;
    public static int indiceDefectoCategoriaImpositiva = -1;
    public static String visibleSubCategoriaImpositiva = "FALSE";
	
	public CampanaVigenteComDTO getCampanaVigenteComDTO() {
		return campanaVigenteComDTO;
	}
	public void setCampanaVigenteComDTO(CampanaVigenteComDTO campanaVigenteComDTO) {
		this.campanaVigenteComDTO = campanaVigenteComDTO;
	}
	public ModalidadCancelacionComDTO getModalidadCancelacionComDTO() {
		return modalidadCancelacionComDTO;
	}
	public void setModalidadCancelacionComDTO(
			ModalidadCancelacionComDTO modalidadCancelacionComDTO) {
		this.modalidadCancelacionComDTO = modalidadCancelacionComDTO;
	}
	public String getCodigoDespacho() {
		return codigoDespacho;
	}
	public void setCodigoDespacho(String codigoDespacho) {
		this.codigoDespacho = codigoDespacho;
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
	public int getCicloFacturacion() {
		return cicloFacturacion;
	}
	public void setCicloFacturacion(int cicloFacturacion) {
		this.cicloFacturacion = cicloFacturacion;
	}
	public boolean isExisteExcepcion() {
		return existeExcepcion;
	}
	public void setExisteExcepcion(boolean existeExcepcion) {
		this.existeExcepcion = existeExcepcion;
	}
	public String getDescripcionNombre() {
		return descripcionNombre;
	}
	public void setDescripcionNombre(String descripcionNombre) {
		this.descripcionNombre = descripcionNombre;
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
	
	public DireccionNegocioDTO[] getDirecciones() {
		return direcciones;
	}
	public void setDirecciones(DireccionNegocioDTO[] direcciones) {
		this.direcciones = direcciones;
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
	public int getDatosBuro() {
		return datosBuro;
	}
	public void setDatosBuro(int datosBuro) {
		this.datosBuro = datosBuro;
	}
	public PlanComercialComDTO getPlanComercialComDTO() {
		return planComercialComDTO;
	}
	public void setPlanComercialComDTO(PlanComercialComDTO planComercialComDTO) {
		this.planComercialComDTO = planComercialComDTO;
	}
	public RepresentanteLegalComDTO[] getRepresentanteLegalComDTO() {
		return representanteLegalComDTO;
	}
	public void setRepresentanteLegalComDTO(
			RepresentanteLegalComDTO[] representanteLegalComDTO) {
		this.representanteLegalComDTO = representanteLegalComDTO;
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
	public String getCodigoModificacion() {
		return codigoModificacion;
	}
	public void setCodigoModificacion(String codigoModificacion) {
		this.codigoModificacion = codigoModificacion;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	public String getCodigoPais() {
		return codigoPais;
	}
	public void setCodigoPais(String codigoPais) {
		this.codigoPais = codigoPais;
	}
	public String getCodigoPlanComercial() {
		return codigoPlanComercial;
	}
	public void setCodigoPlanComercial(String codigoPlanComercial) {
		this.codigoPlanComercial = codigoPlanComercial;
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
	public String getCodigoSistemaPago() {
		return codigoSistemaPago;
	}
	public void setCodigoSistemaPago(String codigoSistemaPago) {
		this.codigoSistemaPago = codigoSistemaPago;
	}
	public String getCodigoSubCategoria() {
		return codigoSubCategoria;
	}
	public void setCodigoSubCategoria(String codigoSubCategoria) {
		this.codigoSubCategoria = codigoSubCategoria;
	}
	public String getCodigoSucursal() {
		return codigoSucursal;
	}
	public void setCodigoSucursal(String codigoSucursal) {
		this.codigoSucursal = codigoSucursal;
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
	public String getCodigoTipoTarjeta() {
		return codigoTipoTarjeta;
	}
	public void setCodigoTipoTarjeta(String codigoTipoTarjeta) {
		this.codigoTipoTarjeta = codigoTipoTarjeta;
	}
	public String getDescripcionReferenciaDocumento() {
		return descripcionReferenciaDocumento;
	}
	public void setDescripcionReferenciaDocumento(
			String descripcionReferenciaDocumento) {
		this.descripcionReferenciaDocumento = descripcionReferenciaDocumento;
	}
	public String getFechaVencimientoTarjeta() {
		return fechaVencimientoTarjeta;
	}
	public void setFechaVencimientoTarjeta(String fechaVencimientoTarjeta) {
		this.fechaVencimientoTarjeta = fechaVencimientoTarjeta;
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
	public String getIndicadorPrivacidad() {
		return indicadorPrivacidad;
	}
	public void setIndicadorPrivacidad(String indicadorPrivacidad) {
		this.indicadorPrivacidad = indicadorPrivacidad;
	}
	public String getIndicadorTipoCuenta() {
		return indicadorTipoCuenta;
	}
	public void setIndicadorTipoCuenta(String indicadorTipoCuenta) {
		this.indicadorTipoCuenta = indicadorTipoCuenta;
	}
	public String getIndicadorTraspaso() {
		return indicadorTraspaso;
	}
	public void setIndicadorTraspaso(String indicadorTraspaso) {
		this.indicadorTraspaso = indicadorTraspaso;
	}
	public String getNombreApoderado() {
		return nombreApoderado;
	}
	public void setNombreApoderado(String nombreApoderado) {
		this.nombreApoderado = nombreApoderado;
	}
	public String getNombreUsuarOra() {
		return nombreUsuarOra;
	}
	public void setNombreUsuarOra(String nombreUsuarOra) {
		this.nombreUsuarOra = nombreUsuarOra;
	}
	public String getNumeroCiclos() {
		return numeroCiclos;
	}
	public void setNumeroCiclos(String numeroCiclos) {
		this.numeroCiclos = numeroCiclos;
	}
	public String getNumeroCuentaCorriente() {
		return numeroCuentaCorriente;
	}
	public void setNumeroCuentaCorriente(String numeroCuentaCorriente) {
		this.numeroCuentaCorriente = numeroCuentaCorriente;
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
	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
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
	public String getCodigoCobrador() {
		return codigoCobrador;
	}
	public void setCodigoCobrador(String codigoCobrador) {
		this.codigoCobrador = codigoCobrador;
	}
	public String getFechaBaja() {
		return fechaBaja;
	}
	public void setFechaBaja(String fechaBaja) {
		this.fechaBaja = fechaBaja;
	}
	public String getNumeroFax() {
		return numeroFax;
	}
	public void setNumeroFax(String numeroFax) {
		this.numeroFax = numeroFax;
	}
	public String getDireccionEMail() {
		return direccionEMail;
	}
	public void setDireccionEMail(String direccionEMail) {
		this.direccionEMail = direccionEMail;
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
	public DatosGeneralesVentaDTO[] getLineaCDMA() {
		return lineaCDMA;
	}
	public void setLineaCDMA(DatosGeneralesVentaDTO[] lineaCDMA) {
		this.lineaCDMA = lineaCDMA;
	}
	public DatosGeneralesVentaDTO[] getLineaGSM() {
		return lineaGSM;
	}
	public void setLineaGSM(DatosGeneralesVentaDTO[] lineaGSM) {
		this.lineaGSM = lineaGSM;
	}
	public String getCodigoTipoPlan() {
		return CodigoTipoPlan;
	}
	public void setCodigoTipoPlan(String codigoTipoPlan) {
		CodigoTipoPlan = codigoTipoPlan;
	}
	public String getNumeroAbonadosPorPlan() {
		return numeroAbonadosPorPlan;
	}
	public void setNumeroAbonadosPorPlan(String numeroAbonadosPorPlan) {
		this.numeroAbonadosPorPlan = numeroAbonadosPorPlan;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	public String getMontoPreAutorizado() {
		return montoPreAutorizado;
	}
	public void setMontoPreAutorizado(String montoPreAutorizado) {
		this.montoPreAutorizado = montoPreAutorizado;
	}
	
}

