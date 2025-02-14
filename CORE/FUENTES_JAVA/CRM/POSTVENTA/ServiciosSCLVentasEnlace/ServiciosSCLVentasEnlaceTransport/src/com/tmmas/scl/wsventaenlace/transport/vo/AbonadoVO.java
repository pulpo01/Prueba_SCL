package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;
import java.sql.Timestamp;


public class AbonadoVO implements Serializable {

	private static final long serialVersionUID = 1430633928199521622L;
	
	private long numAbonado;
	private long idAbonado;
	private String codProducto;
	private Long codCuenta;
	private String codSubCuenta;
	private long codCliente;
	private Long codUsuario;
	private String codSituacion;
	private String codEstado;
	private Long codVendedor;
	private Long codVendedorAgente;
	private String claseServicio;
	private String codCargoBasico;
	private Long codCredCon;
	private Long codCredMor;
	private String codLimCon;
	private String codPlanServ;
	private String codPlanTarif;
	private String codTipContrato;
	private Integer codUso;
	private Timestamp fecActCen;
	private Timestamp fecAlta;
	private Timestamp fecBaja;
	private Timestamp fecBajaCen;
	private Timestamp fecFinContra;
	private Timestamp fecUltMod;
	private Integer indFactur;
	private String indProcAlta;
	private String indProcEqui;
	private Integer indRehabi;
	private Integer indSeguro;
	private Integer indSuspen;
	private String nomusuarora;
	private String numContrato;
	private String numSerie;
	private String numSerieMec;
	private String perfilAbonado;
	private Integer codCentral;
	private Long numVenta;
	private Long codEmpresa;
	private Long codHolding;
	private Integer codModVenta;
	private String codCausaBaja;
	private Integer codCiclo;
	private String codGrpserv;
	private Timestamp fecAcepVenta;
	private Timestamp fecCumplan;
	private Integer numPerContrato;
	private String tipPlanTarif;
	private String tipTerminal;
	private Timestamp fecCumplimen;
	private Timestamp fecRecDocum;
	private Integer indInsguias;
	private Long numCelular;
	private Integer codCentralPlex;
	private String codRegion;
	private String codProvincia;
	private String codCiudad;
	private Integer indPlexSys;
	private Long numCelularPlex;
	private String numSerieHex;
	private String codCelda;
	private String numPersonal;
	private Long codCarrier;
	private Long codOpredFija;
	private Integer indPrepago;
	private Integer indSuperTel;
	private String numTeleFija;
	private Long codVendealer;
	private Integer indDisp;
	private String indEqPrestado;
	private Timestamp fecProrroga;
	private String numMin;
	private String desLimCon;
	private String codUmbral;
	private String desUmbral;
	private String codCicloFact;
	private Double montoLimConsumo;
	private String numAnexo;
	private String numImei;
	private String codTecnologia;
	private String nomTablaAbo; //RSIS001 CU-001 (14)
	private long codClienteDist;
	private String nombreGAUsuario;
	private	String	desTipContrato;
	private String numTerminal; 
	private String codTipSeguro;
	private String numPeriodo;
	private Timestamp fecHistorico;
	private String numReemplazos;
	private String numPeriodoReemp;
	private String formatFecha;
	private String indPropiedad;
	private String codBodega;
	private Integer tipStock;
	private Long codArticulo;
	private String indEquiAcc;
	private String codCuota;
	private Long capCode;
	private String codProtocolo;
	private Long numVelocidad;
	private Integer codFrecuencia;
	private Integer codVersion;
	private String desEquipo;
	private String codPaquete;
	private Long numMovimiento;
	private String codCausa;
	private String codTipModalidad;
	private String tipPlantarif; 
	private String numMeses;
	private Long numOOSS;
	private Long numCiclos;
	private String motRenovacion;
	private Integer tipVisita;
	private String codOficinaPrincipal;
	private Double umbral;
	private Long cantAvisos;
	private Long numDias;
	private Long codNotificacion;
	private String indPassword;
	private String codPassword;
	private Long numMinutos;
	//Utilizado en metodo consultaGrupoTecnologico de abonadoDAO (ReposicionVoluntariaServicioCel)
	private String codGrupoTecnologia;
	//Utilizado en metodo consultaSuspensionPendienteAbonado de abonadoDAO (SuspensionVoluntariaServicioCel)
	private long suspensionesPendiente;
	//consultaSuspensionPendienteCentralesAbonado
	private long suspensionesPendienteCtrls;
	//Cambio Serie Simcard
	private String numSerieNueva;
	private Timestamp fecAntiguedad;
	private Integer indDevAlmacen;
	private String codCategoria;
	private boolean seguro;
	
	public String getNumSerieNueva() {
		return numSerieNueva;
	}
	public void setNumSerieNueva(String numSerieNueva) {
		this.numSerieNueva = numSerieNueva;
	}
	public Long getNumMinutos() {
		return numMinutos;
	}
	public void setNumMinutos(Long numMinutos) {
		this.numMinutos = numMinutos;
	}
	/**
	 * @return String the codPassword 
	 */
	public String getCodPassword() {
		return codPassword;
	}
	/**
	 * @param codPassword String the codPassword to set
	 */
	public void setCodPassword(String codPassword) {
		this.codPassword = codPassword;
	}
	/**
	 * @return String the indPassword 
	 */
	public String getIndPassword() {
		return indPassword;
	}
	/**
	 * @param indPassword String the indPassword to set
	 */
	public void setIndPassword(String indPassword) {
		this.indPassword = indPassword;
	}
	public Long getCodNotificacion() {
		return codNotificacion;
	}
	public void setCodNotificacion(Long codNotificacion) {
		this.codNotificacion = codNotificacion;
	}
	public Long getNumDias() {
		return numDias;
	}
	public void setNumDias(Long numDias) {
		this.numDias = numDias;
	}
	public Long getCantAvisos() {
		return cantAvisos;
	}
	public void setCantAvisos(Long cantAvisos) {
		this.cantAvisos = cantAvisos;
	}
	public Double getUmbral() {
		return umbral;
	}
	public void setUmbral(Double umbral) {
		this.umbral = umbral;
	}
	public String getCodOficinaPrincipal() {
		return codOficinaPrincipal;
	}
	public void setCodOficinaPrincipal(String codOficinaPrincipal) {
		this.codOficinaPrincipal = codOficinaPrincipal;
	}
	public Integer getTipVisita() {
		return tipVisita;
	}
	public void setTipVisita(Integer tipVisita) {
		this.tipVisita = tipVisita;
	}
	public String getMotRenovacion() {
		return motRenovacion;
	}
	public void setMotRenovacion(String motRenovacion) {
		this.motRenovacion = motRenovacion;
	}
	public Long getNumCiclos() {
		return numCiclos;
	}
	public void setNumCiclos(Long numCiclos) {
		this.numCiclos = numCiclos;
	}
	public String getNumMeses() {
		return numMeses;
	}
	public void setNumMeses(String numMeses) {
		this.numMeses = numMeses;
	}
	public String getTipPlantarif() {
		return tipPlantarif;
	}
	public void setTipPlantarif(String tipPlantarif) {
		this.tipPlantarif = tipPlantarif;
	}
	public String getCodTipModalidad() {
		return codTipModalidad;
	}
	public void setCodTipModalidad(String codTipModalidad) {
		this.codTipModalidad = codTipModalidad;
	}
	public String getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}
	
	public String getCodPaquete() {
		return codPaquete;
	}
	public void setCodPaquete(String codPaquete) {
		this.codPaquete = codPaquete;
	}
	public String getDesEquipo() {
		return desEquipo;
	}
	public void setDesEquipo(String desEquipo) {
		this.desEquipo = desEquipo;
	}
	public Integer getCodVersion() {
		return codVersion;
	}
	public void setCodVersion(Integer codVersion) {
		this.codVersion = codVersion;
	}
	public Integer getCodFrecuencia() {
		return codFrecuencia;
	}
	public void setCodFrecuencia(Integer codFrecuencia) {
		this.codFrecuencia = codFrecuencia;
	}
	
	public String getCodProtocolo() {
		return codProtocolo;
	}
	public void setCodProtocolo(String codProtocolo) {
		this.codProtocolo = codProtocolo;
	}
	
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public String getIndEquiAcc() {
		return indEquiAcc;
	}
	public void setIndEquiAcc(String indEquiAcc) {
		this.indEquiAcc = indEquiAcc;
	}
	
	public Long getCapCode() {
		return capCode;
	}
	public void setCapCode(Long capCode) {
		this.capCode = capCode;
	}
	public Long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(Long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public Long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(Long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public Long getNumVelocidad() {
		return numVelocidad;
	}
	public void setNumVelocidad(Long numVelocidad) {
		this.numVelocidad = numVelocidad;
	}
	public Integer getTipStock() {
		return tipStock;
	}
	public void setTipStock(Integer tipStock) {
		this.tipStock = tipStock;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getNumPeriodoReemp() {
		return numPeriodoReemp;
	}
	public void setNumPeriodoReemp(String numPeriodoReemp) {
		this.numPeriodoReemp = numPeriodoReemp;
	}
	public String getNumReemplazos() {
		return numReemplazos;
	}
	public void setNumReemplazos(String numReemplazos) {
		this.numReemplazos = numReemplazos;
	}
	public Timestamp getFecHistorico() {
		return fecHistorico;
	}
	public void setFecHistorico(Timestamp fecHistorico) {
		this.fecHistorico = fecHistorico;
	}
	public String getCodTipSeguro() {
		return codTipSeguro;
	}
	public void setCodTipSeguro(String codTipSeguro) {
		this.codTipSeguro = codTipSeguro;
	}
	public String getNumPeriodo() {
		return numPeriodo;
	}
	public void setNumPeriodo(String numPeriodo) {
		this.numPeriodo = numPeriodo;
	}
	public String getNumTerminal() {
		return numTerminal;
	}
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	public String getFormatFecha() {
		return formatFecha;
	}
	public void setFormatFecha(String formatFecha) {
		this.formatFecha = formatFecha;
	}
	/**
	 * @return String the desTipContrato 
	 */
	public String getDesTipContrato() {
		return desTipContrato;
	}
	/**
	 * @param desTipContrato String the desTipContrato to set
	 */
	public void setDesTipContrato(String desTipContrato) {
		this.desTipContrato = desTipContrato;
	}
	public String getNomTablaAbo() {
		return nomTablaAbo;
	}	
	public void setNomTablaAbo(String nomTablaAbo) {
		this.nomTablaAbo = nomTablaAbo;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public Double getMontoLimConsumo() {
		return montoLimConsumo;
	}
	public void setMontoLimConsumo(Double montoLimConsumo) {
		this.montoLimConsumo = montoLimConsumo;
	}
	public String getCodCicloFact() {
		return codCicloFact;
	}
	public void setCodCicloFact(String codCicloFact) {
		this.codCicloFact = codCicloFact;
	}
	public String getCodUmbral() {
		return codUmbral;
	}
	public void setCodUmbral(String codUmbral) {
		this.codUmbral = codUmbral;
	}
	public String getDesLimCon() {
		return desLimCon;
	}
	public void setDesLimCon(String desLimCon) {
		this.desLimCon = desLimCon;
	}
	public String getDesUmbral() {
		return desUmbral;
	}
	public void setDesUmbral(String desUmbral) {
		this.desUmbral = desUmbral;
	}
	public Long getCodCarrier() {
		return codCarrier;
	}
	public void setCodCarrier(Long codCarrier) {
		this.codCarrier = codCarrier;
	}
	public String getCodCausaBaja() {
		return codCausaBaja;
	}
	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}
	public String getCodCelda() {
		return codCelda;
	}
	public void setCodCelda(String codCelda) {
		this.codCelda = codCelda;
	}
	public Integer getCodCentralPlex() {
		return codCentralPlex;
	}
	public void setCodCentralPlex(Integer codCentralPlex) {
		this.codCentralPlex = codCentralPlex;
	}
	public Integer getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(Integer codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public Long getCodEmpresa() {
		return codEmpresa;
	}
	public void setCodEmpresa(Long codEmpresa) {
		this.codEmpresa = codEmpresa;
	}
	public String getCodGrpserv() {
		return codGrpserv;
	}
	public void setCodGrpserv(String codGrpserv) {
		this.codGrpserv = codGrpserv;
	}
	public Long getCodHolding() {
		return codHolding;
	}
	public void setCodHolding(Long codHolding) {
		this.codHolding = codHolding;
	}
	public Integer getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(Integer codModVenta) {
		this.codModVenta = codModVenta;
	}
	public Long getCodOpredFija() {
		return codOpredFija;
	}
	public void setCodOpredFija(Long codOpredFija) {
		this.codOpredFija = codOpredFija;
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
	public Long getCodVendealer() {
		return codVendealer;
	}
	public void setCodVendealer(Long codVendealer) {
		this.codVendealer = codVendealer;
	}
	
	public Timestamp getFecAcepVenta() {
		return fecAcepVenta;
	}
	public void setFecAcepVenta(Timestamp fecAcepVenta) {
		this.fecAcepVenta = fecAcepVenta;
	}
	public Timestamp getFecCumplan() {
		return fecCumplan;
	}
	public void setFecCumplan(Timestamp fecCumplan) {
		this.fecCumplan = fecCumplan;
	}
	public Timestamp getFecCumplimen() {
		return fecCumplimen;
	}
	public void setFecCumplimen(Timestamp fecCumplimen) {
		this.fecCumplimen = fecCumplimen;
	}
	public Timestamp getFecProrroga() {
		return fecProrroga;
	}
	public void setFecProrroga(Timestamp fecProrroga) {
		this.fecProrroga = fecProrroga;
	}
	public Timestamp getFecRecDocum() {
		return fecRecDocum;
	}
	public void setFecRecDocum(Timestamp fecRecDocum) {
		this.fecRecDocum = fecRecDocum;
	}
	public Integer getIndDisp() {
		return indDisp;
	}
	public void setIndDisp(Integer indDisp) {
		this.indDisp = indDisp;
	}
	public String getIndEqPrestado() {
		return indEqPrestado;
	}
	public void setIndEqPrestado(String indEqPrestado) {
		this.indEqPrestado = indEqPrestado;
	}
	public Integer getIndInsguias() {
		return indInsguias;
	}
	public void setIndInsguias(Integer indInsguias) {
		this.indInsguias = indInsguias;
	}
	public Integer getIndPlexSys() {
		return indPlexSys;
	}
	public void setIndPlexSys(Integer indPlexSys) {
		this.indPlexSys = indPlexSys;
	}
	public Integer getIndPrepago() {
		return indPrepago;
	}
	public void setIndPrepago(Integer indPrepago) {
		this.indPrepago = indPrepago;
	}
	public Integer getIndSuperTel() {
		return indSuperTel;
	}
	public void setIndSuperTel(Integer indSuperTel) {
		this.indSuperTel = indSuperTel;
	}
	public Long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}
	public Long getNumCelularPlex() {
		return numCelularPlex;
	}
	public void setNumCelularPlex(Long numCelularPlex) {
		this.numCelularPlex = numCelularPlex;
	}
	public String getNumMin() {
		return numMin;
	}
	public void setNumMin(String numMin) {
		this.numMin = numMin;
	}
	public Integer getNumPerContrato() {
		return numPerContrato;
	}
	public void setNumPerContrato(Integer numPerContrato) {
		this.numPerContrato = numPerContrato;
	}
	public String getNumPersonal() {
		return numPersonal;
	}
	public void setNumPersonal(String numPersonal) {
		this.numPersonal = numPersonal;
	}
	public String getNumSerieHex() {
		return numSerieHex;
	}
	public void setNumSerieHex(String numSerieHex) {
		this.numSerieHex = numSerieHex;
	}
	public String getNumTeleFija() {
		return numTeleFija;
	}
	public void setNumTeleFija(String numTeleFija) {
		this.numTeleFija = numTeleFija;
	}
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public String getClaseServicio() {
		return claseServicio;
	}
	public void setClaseServicio(String claseServicio) {
		this.claseServicio = claseServicio;
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public Integer getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(Integer codCentral) {
		this.codCentral = codCentral;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public Long getCodCredCon() {
		return codCredCon;
	}
	public void setCodCredCon(Long codCredCon) {
		this.codCredCon = codCredCon;
	}
	public Long getCodCredMor() {
		return codCredMor;
	}
	public void setCodCredMor(Long codCredMor) {
		this.codCredMor = codCredMor;
	}
	public Long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(Long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodLimCon() {
		return codLimCon;
	}
	public void setCodLimCon(String codLimCon) {
		this.codLimCon = codLimCon;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodSituacion() {
		return codSituacion;
	}
	public void setCodSituacion(String codSituacion) {
		this.codSituacion = codSituacion;
	}
	public String getCodSubCuenta() {
		return codSubCuenta;
	}
	public void setCodSubCuenta(String codSubCuenta) {
		this.codSubCuenta = codSubCuenta;
	}
	public String getCodTipContrato() {
		return codTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}
	public Integer getCodUso() {
		return codUso;
	}
	public void setCodUso(Integer codUso) {
		this.codUso = codUso;
	}
	public Long getCodUsuario() {
		return codUsuario;
	}
	public void setCodUsuario(Long codUsuario) {
		this.codUsuario = codUsuario;
	}
	public Long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(Long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public Long getCodVendedorAgente() {
		return codVendedorAgente;
	}
	public void setCodVendedorAgente(Long codVendedorAgente) {
		this.codVendedorAgente = codVendedorAgente;
	}
	public Integer getIndFactur() {
		return indFactur;
	}
	public void setIndFactur(Integer indFactur) {
		this.indFactur = indFactur;
	}
	public String getIndProcAlta() {
		return indProcAlta;
	}
	public void setIndProcAlta(String indProcAlta) {
		this.indProcAlta = indProcAlta;
	}
	public String getIndProcEqui() {
		return indProcEqui;
	}
	public void setIndProcEqui(String indProcEqui) {
		this.indProcEqui = indProcEqui;
	}
	public Integer getIndRehabi() {
		return indRehabi;
	}
	public void setIndRehabi(Integer indRehabi) {
		this.indRehabi = indRehabi;
	}
	public Integer getIndSeguro() {
		return indSeguro;
	}
	public void setIndSeguro(Integer indSeguro) {
		this.indSeguro = indSeguro;
	}
	public Integer getIndSuspen() {
		return indSuspen;
	}
	public void setIndSuspen(Integer indSuspen) {
		this.indSuspen = indSuspen;
	}
	public String getNomusuarora() {
		return nomusuarora;
	}
	public void setNomusuarora(String nomusuarora) {
		this.nomusuarora = nomusuarora;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getNumSerieMec() {
		return numSerieMec;
	}
	public void setNumSerieMec(String numSerieMec) {
		this.numSerieMec = numSerieMec;
	}
	public Long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(Long numVenta) {
		this.numVenta = numVenta;
	}
	public String getPerfilAbonado() {
		return perfilAbonado;
	}
	public void setPerfilAbonado(String perfilAbonado) {
		this.perfilAbonado = perfilAbonado;
	}
	public Timestamp getFecActCen() {
		return fecActCen;
	}
	public void setFecActCen(Timestamp fecActCen) {
		this.fecActCen = fecActCen;
	}
	public Timestamp getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Timestamp fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Timestamp getFecBaja() {
		return fecBaja;
	}
	public void setFecBaja(Timestamp fecBaja) {
		this.fecBaja = fecBaja;
	}
	public Timestamp getFecBajaCen() {
		return fecBajaCen;
	}
	public void setFecBajaCen(Timestamp fecBajaCen) {
		this.fecBajaCen = fecBajaCen;
	}
	public Timestamp getFecFinContra() {
		return fecFinContra;
	}
	public void setFecFinContra(Timestamp fecFinContra) {
		this.fecFinContra = fecFinContra;
	}
	public Timestamp getFecUltMod() {
		return fecUltMod;
	}
	public void setFecUltMod(Timestamp fecUltMod) {
		this.fecUltMod = fecUltMod;
	}
	/**
	 * @return Long the codClienteDist 
	 */
	public long getCodClienteDist() {
		return codClienteDist;
	}
	/**
	 * @param codClienteDist Long the codClienteDist to set
	 */
	public void setCodClienteDist(long codClienteDist) {
		this.codClienteDist = codClienteDist;
	}
	/**
	 * @return String the nombreGAUsuario 
	 */
	public String getNombreGAUsuario() {
		return nombreGAUsuario;
	}
	/**
	 * @param nombreGAUsuario String the nombreGAUsuario to set
	 */
	public void setNombreGAUsuario(String nombreGAUsuario) {
		this.nombreGAUsuario = nombreGAUsuario;
	}
	public long getIdAbonado() {
		return idAbonado;
	}
	public void setIdAbonado(long idAbonado) {
		this.idAbonado = idAbonado;
	}
	public String getIndPropiedad() {
		return indPropiedad;
	}
	public void setIndPropiedad(String indPropiedad) {
		this.indPropiedad = indPropiedad;
	}
	public Long getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(Long numOOSS) {
		this.numOOSS = numOOSS;
	}
	public String getCodGrupoTecnologia() {
		return codGrupoTecnologia;
	}
	public void setCodGrupoTecnologia(String codGrupoTecnologia) {
		this.codGrupoTecnologia = codGrupoTecnologia;
	}
	/**
	 * @return long the suspensionesPendiente 
	 */
	public long getSuspensionesPendiente() {
		return suspensionesPendiente;
	}
	/**
	 * @param suspensionesPendiente long the suspensionesPendiente to set
	 */
	public void setSuspensionesPendiente(long suspensionesPendiente) {
		this.suspensionesPendiente = suspensionesPendiente;
	}
	/**
	 * @return long the suspensionesPendienteCtrls 
	 */
	public long getSuspensionesPendienteCtrls() {
		return suspensionesPendienteCtrls;
	}
	/**
	 * @param suspensionesPendienteCtrls long the suspensionesPendienteCtrls to set
	 */
	public void setSuspensionesPendienteCtrls(long suspensionesPendienteCtrls) {
		this.suspensionesPendienteCtrls = suspensionesPendienteCtrls;
	}
	/**
	 * @return the fecAntiguedad
	 */
	public Timestamp getFecAntiguedad() {
		return fecAntiguedad;
	}
	/**
	 * @param fecAntiguedad the fecAntiguedad to set
	 */
	public void setFecAntiguedad(Timestamp fecAntiguedad) {
		this.fecAntiguedad = fecAntiguedad;
	}
	/**
	 * @return the indDevAlmacen
	 */
	public Integer getIndDevAlmacen() {
		return indDevAlmacen;
	}
	/**
	 * @param indDevAlmacen the indDevAlmacen to set
	 */
	public void setIndDevAlmacen(Integer indDevAlmacen) {
		this.indDevAlmacen = indDevAlmacen;
	}
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public boolean isSeguro() {
		return seguro;
	}
	public void setSeguro(boolean seguro) {
		this.seguro = seguro;
	}
	
	
}
