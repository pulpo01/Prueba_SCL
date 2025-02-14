package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class AbonadoVtaDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private Long numAbonado;
	private long numCelular;
	private int codProducto;
	private long codCliente;
	private Long codCuenta;
	private String codSubCuenta;
	private long codUsuario;
	private String codCelda;
	private int codUsoSimcard;
	private int codUsoTerminal;
	private String codSituacion;
	private String indProcAlta;
	private long codVendedor;
	private long codVendedorAgente;
	private String tipPlantarif;
	private String tipTerminal;
	private String codPlanTarif;
	private String codTipPlanTarif;
	private String codCargoBasico;
	private String codPlanServ;
	private String codLimConsumo;
	private String numSerieSimcard;
	private String numSerieTerminal;
	private String numSerieHex;
	private String nomUsuarOra;
	private String fecAlta;
	private int numPerContrato;
	private String codEstadoSimcard;
	private String codEstadoTerminal;
	private String numSerieMec;
	private long codHolding;
	private Long codEmpresa;
	private String codGrpSrv;
	private int indSuperTel;
	private String numTeleFija;
	private long codOpRedFija;
	private long codCarrier;
	private int indPrepago;
	private int indPlexSys;
	private int codCentralPlex;
	private long numCelularPlex;
	private long numVenta;
	private long codModVenta;
	private String codTipContrato;
	private String numContrato;
	private String numAnexo;
	private String FecCumPlan;
	private Integer codCredMor;
	private Integer codCredCon;
	private Integer codCiclo;
	private int codFactur;
	private int indSuspen;
	private int indReHabi;
	private int insGuias;
	private String fecFinContra;
	private String fecRecDocu;
	private String fecCumplimen;
	private String fecAcepVenta;
	private String fecActCen;
	private String fecBaja;
	private String fecBajaCen;
	private String fecUltMod;
	private String codCausaBaja;
	private String numPersonal;
	private int indSeguro;
	private String claseServicio;
	private String perfilAbonado;
	private String numMin;
	private long codVendealer;
	private int indDisp;
	private String codPassword;
	private String indPassword;
	private int codAfinidad;
	private String fecProrroga;
	private String indEqPrestadoSimcard;
	private String indEqPrestadoTerminal;
	private String flgContDigi;
	private String fecAltanTras;
	private int codIndemnizacion;
	private String numImei;
	private String codTecnologia;
	private String numMinMdn;
	private String FecActivacion;
	private int indTelefono;
	private String codOficinaPrincipal;
	private String codCausaVenta;
	private String codOperacion;
	private String codBodegaTerminal;
	private String codBodegaSimcard;
	private String desBodega;
	private long tipoStockSimcard;
	private long tipoStockTerminal;
	private String indicadorEquiAcc;
	private String tipTerminalSimcard;
	private String tipTerminalEquipo;
	private int codCuota;
	private String indComodato;
	private String codUso;
	private String indProcEqTerminal;
	private String indProcEqSimcard;
	private Integer codigoArticuloTerminal;
	private String tipoArticuloTerminal;
	private Integer codigoArticuloSimcard;
	private String tipoArticuloSimcard;
	private String capcodeTerminal;
	private String capcodeSimcard;
	private String desArticuloTerminal;
	private String desArticuloSimcard;
	private String indPropiedad;
	private String codigoEstado;
	private String codigoSecuencia;	
	/*-- para la actualizacion de stock--*/
	private long   tipoStock;
	private String codigoBodega;
	private Integer codigoArticulo;
	private String numeroSerie;
	private long   tipoStockOriginal;
	private String codigoBodegaActual;
	private String numeroMovimiento;
	private String codOficina;
	private String codError;
	private String desError;
	private Integer prefijo;
	private Integer indPortado;
	private Integer codCentral;
	private String codCalClien;
	
	private String numSerieAux;//Se asigna valor de serie simcard o terminal en el metodo obtieneSerie del DAO
	private DireccionDTO direccionDTO;
	
	private String usoLinea;
	
	
	
	
	

	public String getUsoLinea() {
		return usoLinea;
	}

	public void setUsoLinea(String usoLinea) {
		this.usoLinea = usoLinea;
	}

	public Integer getCodCentral() {
		return codCentral;
	}

	public Integer getIndPortado() {
		return indPortado;
	}

	public void setIndPortado(Integer indPortado) {
		this.indPortado = indPortado;
	}

	public void setCodCentral(Integer codCentral) {
		this.codCentral = codCentral;
	}

	public String getNumSerieAux() {
		return numSerieAux;
	}

	public void setNumSerieAux(String numSerieAux) {
		this.numSerieAux = numSerieAux;
	}

	public DireccionDTO getDireccionDTO() {
		return direccionDTO;
	}

	public void setDireccionDTO(DireccionDTO direccionDTO) {
		this.direccionDTO = direccionDTO;
	}

	public Integer getPrefijo() {
		return prefijo;
	}

	public void setPrefijo(Integer prefijo) {
		this.prefijo = prefijo;
	}

	public String getCodError() {
		return codError;
	}

	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getDesError() {
		return desError;
	}

	public void setDesError(String desError) {
		this.desError = desError;
	}

	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}

	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}

	public String getCodigoEstado() {
		return codigoEstado;
	}

	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}

	public String getIndPropiedad() {
		return indPropiedad;
	}

	public void setIndPropiedad(String indPropiedad) {
		this.indPropiedad = indPropiedad;
	}

	public String getDesArticuloSimcard() {
		return desArticuloSimcard;
	}

	public void setDesArticuloSimcard(String desArticuloSimcard) {
		this.desArticuloSimcard = desArticuloSimcard;
	}

	public String getDesArticuloTerminal() {
		return desArticuloTerminal;
	}

	public void setDesArticuloTerminal(String desArticuloTerminal) {
		this.desArticuloTerminal = desArticuloTerminal;
	}

	public String getCodBodegaSimcard() {
		return codBodegaSimcard;
	}

	public String getCodUso() {
		return codUso;
	}

	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}

	public String getIndComodato() {
		return indComodato;
	}

	public void setIndComodato(String indComodato) {
		this.indComodato = indComodato;
	}

	public String getClaseServicio() {
		return claseServicio;
	}

	public void setClaseServicio(String claseServicio) {
		this.claseServicio = claseServicio;
	}

	public int getCodAfinidad() {
		return codAfinidad;
	}

	public void setCodAfinidad(int codAfinidad) {
		this.codAfinidad = codAfinidad;
	}

	public String getCodCargoBasico() {
		return codCargoBasico;
	}

	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}

	public long getCodCarrier() {
		return codCarrier;
	}

	public void setCodCarrier(long codCarrier) {
		this.codCarrier = codCarrier;
	}

	public String getCodCausaBaja() {
		return codCausaBaja;
	}

	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}

	public String getCodCausaVenta() {
		return codCausaVenta;
	}

	public void setCodCausaVenta(String codCausaVenta) {
		this.codCausaVenta = codCausaVenta;
	}

	public String getCodCelda() {
		return codCelda;
	}

	public void setCodCelda(String codCelda) {
		this.codCelda = codCelda;
	}

	
	public int getCodCentralPlex() {
		return codCentralPlex;
	}

	public void setCodCentralPlex(int codCentralPlex) {
		this.codCentralPlex = codCentralPlex;
	}

	public Integer getCodCiclo() {
		return codCiclo;
	}

	public void setCodCiclo(Integer codCiclo) {
		this.codCiclo = codCiclo;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public Integer getCodCredCon() {
		return codCredCon;
	}

	public void setCodCredCon(Integer codCredCon) {
		this.codCredCon = codCredCon;
	}

	public Integer getCodCredMor() {
		return codCredMor;
	}

	public void setCodCredMor(Integer codCredMor) {
		this.codCredMor = codCredMor;
	}

	public Long getCodCuenta() {
		return codCuenta;
	}

	public void setCodCuenta(Long codCuenta) {
		this.codCuenta = codCuenta;
	}

	public Long getCodEmpresa() {
		return codEmpresa;
	}

	public void setCodEmpresa(Long codEmpresa) {
		this.codEmpresa = codEmpresa;
	}

	public int getCodFactur() {
		return codFactur;
	}

	public void setCodFactur(int codFactur) {
		this.codFactur = codFactur;
	}

	public String getCodGrpSrv() {
		return codGrpSrv;
	}

	public void setCodGrpSrv(String codGrpSrv) {
		this.codGrpSrv = codGrpSrv;
	}

	public long getCodHolding() {
		return codHolding;
	}

	public void setCodHolding(long codHolding) {
		this.codHolding = codHolding;
	}

	public int getCodIndemnizacion() {
		return codIndemnizacion;
	}

	public void setCodIndemnizacion(int codIndemnizacion) {
		this.codIndemnizacion = codIndemnizacion;
	}

	public String getCodLimConsumo() {
		return codLimConsumo;
	}

	public void setCodLimConsumo(String codLimConsumo) {
		this.codLimConsumo = codLimConsumo;
	}

	public long getCodModVenta() {
		return codModVenta;
	}

	public void setCodModVenta(long codModVenta) {
		this.codModVenta = codModVenta;
	}

	public String getCodOficinaPrincipal() {
		return codOficinaPrincipal;
	}

	public void setCodOficinaPrincipal(String codOficinaPrincipal) {
		this.codOficinaPrincipal = codOficinaPrincipal;
	}

	public String getCodOperacion() {
		return codOperacion;
	}

	public void setCodOperacion(String codOperacion) {
		this.codOperacion = codOperacion;
	}

	public long getCodOpRedFija() {
		return codOpRedFija;
	}

	public void setCodOpRedFija(long codOpRedFija) {
		this.codOpRedFija = codOpRedFija;
	}

	public String getCodPassword() {
		return codPassword;
	}

	public void setCodPassword(String codPassword) {
		this.codPassword = codPassword;
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

	public int getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(int codProducto) {
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

	public String getCodTecnologia() {
		return codTecnologia;
	}

	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}

	public String getCodTipContrato() {
		return codTipContrato;
	}

	public void setCodTipContrato(String codTipContrato) {
		this.codTipContrato = codTipContrato;
	}

	public long getCodUsuario() {
		return codUsuario;
	}

	public void setCodUsuario(long codUsuario) {
		this.codUsuario = codUsuario;
	}

	public long getCodVendealer() {
		return codVendealer;
	}

	public void setCodVendealer(long codVendealer) {
		this.codVendealer = codVendealer;
	}

	public long getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

	public long getCodVendedorAgente() {
		return codVendedorAgente;
	}

	public void setCodVendedorAgente(long codVendedorAgente) {
		this.codVendedorAgente = codVendedorAgente;
	}

	public String getFecAcepVenta() {
		return fecAcepVenta;
	}

	public void setFecAcepVenta(String fecAcepVenta) {
		this.fecAcepVenta = fecAcepVenta;
	}

	public String getFecActCen() {
		return fecActCen;
	}

	public void setFecActCen(String fecActCen) {
		this.fecActCen = fecActCen;
	}

	public String getFecActivacion() {
		return FecActivacion;
	}

	public void setFecActivacion(String fecActivacion) {
		FecActivacion = fecActivacion;
	}

	public String getFecAlta() {
		return fecAlta;
	}

	public void setFecAlta(String fecAlta) {
		this.fecAlta = fecAlta;
	}

	public String getFecAltanTras() {
		return fecAltanTras;
	}

	public void setFecAltanTras(String fecAltanTras) {
		this.fecAltanTras = fecAltanTras;
	}

	public String getFecBaja() {
		return fecBaja;
	}

	public void setFecBaja(String fecBaja) {
		this.fecBaja = fecBaja;
	}

	public String getFecBajaCen() {
		return fecBajaCen;
	}

	public void setFecBajaCen(String fecBajaCen) {
		this.fecBajaCen = fecBajaCen;
	}

	public String getFecCumPlan() {
		return FecCumPlan;
	}

	public void setFecCumPlan(String fecCumPlan) {
		FecCumPlan = fecCumPlan;
	}

	public String getFecCumplimen() {
		return fecCumplimen;
	}

	public void setFecCumplimen(String fecCumplimen) {
		this.fecCumplimen = fecCumplimen;
	}

	public String getFecFinContra() {
		return fecFinContra;
	}

	public void setFecFinContra(String fecFinContra) {
		this.fecFinContra = fecFinContra;
	}

	public String getFecProrroga() {
		return fecProrroga;
	}

	public void setFecProrroga(String fecProrroga) {
		this.fecProrroga = fecProrroga;
	}

	public String getFecRecDocu() {
		return fecRecDocu;
	}

	public void setFecRecDocu(String fecRecDocu) {
		this.fecRecDocu = fecRecDocu;
	}

	public String getFecUltMod() {
		return fecUltMod;
	}

	public void setFecUltMod(String fecUltMod) {
		this.fecUltMod = fecUltMod;
	}

	public String getFlgContDigi() {
		return flgContDigi;
	}

	public void setFlgContDigi(String flgContDigi) {
		this.flgContDigi = flgContDigi;
	}

	public int getIndDisp() {
		return indDisp;
	}

	public void setIndDisp(int indDisp) {
		this.indDisp = indDisp;
	}

	public String getIndEqprestadoSimcard() {
		return indEqPrestadoSimcard;
	}

	public void setIndEqprestadoSimcard(String indEqprestadoSimcard) {
		this.indEqPrestadoSimcard = indEqprestadoSimcard;
	}

	public String getIndPassword() {
		return indPassword;
	}

	public void setIndPassword(String indPassword) {
		this.indPassword = indPassword;
	}

	public int getIndPlexSys() {
		return indPlexSys;
	}

	public void setIndPlexSys(int indPlexSys) {
		this.indPlexSys = indPlexSys;
	}

	public int getIndPrepago() {
		return indPrepago;
	}

	public void setIndPrepago(int indPrepago) {
		this.indPrepago = indPrepago;
	}

	public String getIndProcAlta() {
		return indProcAlta;
	}

	public void setIndProcAlta(String indProcAlta) {
		this.indProcAlta = indProcAlta;
	}

	public int getIndReHabi() {
		return indReHabi;
	}

	public void setIndReHabi(int indReHabi) {
		this.indReHabi = indReHabi;
	}

	public int getIndSeguro() {
		return indSeguro;
	}

	public void setIndSeguro(int indSeguro) {
		this.indSeguro = indSeguro;
	}

	public int getIndSuperTel() {
		return indSuperTel;
	}

	public void setIndSuperTel(int indSuperTel) {
		this.indSuperTel = indSuperTel;
	}

	public int getIndSuspen() {
		return indSuspen;
	}

	public void setIndSuspen(int indSuspen) {
		this.indSuspen = indSuspen;
	}

	public int getIndTelefono() {
		return indTelefono;
	}

	public void setIndTelefono(int indTelefono) {
		this.indTelefono = indTelefono;
	}

	public int getInsGuias() {
		return insGuias;
	}

	public void setInsGuias(int insGuias) {
		this.insGuias = insGuias;
	}

	public String getNomUsuarOra() {
		return nomUsuarOra;
	}

	public void setNomUsuarOra(String nomUsuarOra) {
		this.nomUsuarOra = nomUsuarOra;
	}

	public Long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getNumAnexo() {
		return numAnexo;
	}

	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}

	public long getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}

	public long getNumCelularPlex() {
		return numCelularPlex;
	}

	public void setNumCelularPlex(long numCelularPlex) {
		this.numCelularPlex = numCelularPlex;
	}

	public String getNumContrato() {
		return numContrato;
	}

	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}

	public String getNumImei() {
		return numImei;
	}

	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}

	public String getNumMin() {
		return numMin;
	}

	public void setNumMin(String numMin) {
		this.numMin = numMin;
	}

	public String getNumMinMdn() {
		return numMinMdn;
	}

	public void setNumMinMdn(String numMinMdn) {
		this.numMinMdn = numMinMdn;
	}

	public int getNumPerContrato() {
		return numPerContrato;
	}

	public void setNumPerContrato(int numPerContrato) {
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

	public String getNumSerieMec() {
		return numSerieMec;
	}

	public void setNumSerieMec(String numSerieMec) {
		this.numSerieMec = numSerieMec;
	}

	public String getNumTeleFija() {
		return numTeleFija;
	}

	public void setNumTeleFija(String numTeleFija) {
		this.numTeleFija = numTeleFija;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	public String getPerfilAbonado() {
		return perfilAbonado;
	}

	public void setPerfilAbonado(String perfilAbonado) {
		this.perfilAbonado = perfilAbonado;
	}

	public String getTipPlantarif() {
		return tipPlantarif;
	}

	public void setTipPlantarif(String tipPlantarif) {
		this.tipPlantarif = tipPlantarif;
	}

	public String getTipTerminal() {
		return tipTerminal;
	}

	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}

	public String getIndicadorEquiAcc() {
		return indicadorEquiAcc;
	}

	public void setIndicadorEquiAcc(String indicadorEquiAcc) {
		this.indicadorEquiAcc = indicadorEquiAcc;
	}

	public long getTipoStockSimcard() {
		return tipoStockSimcard;
	}

	public void setTipoStockSimcard(long tipoStockSimcard) {
		this.tipoStockSimcard = tipoStockSimcard;
	}

	public String getTipTerminalEquipo() {
		return tipTerminalEquipo;
	}

	public void setTipTerminalEquipo(String tipTerminalEquipo) {
		this.tipTerminalEquipo = tipTerminalEquipo;
	}

	public String getTipTerminalSimcard() {
		return tipTerminalSimcard;
	}

	public void setTipTerminalSimcard(String tipTerminalSimcard) {
		this.tipTerminalSimcard = tipTerminalSimcard;
	}

	public int getCodUsoSimcard() {
		return codUsoSimcard;
	}

	public void setCodUsoSimcard(int codUsoSimcard) {
		this.codUsoSimcard = codUsoSimcard;
	}

	public int getCodUsoTerminal() {
		return codUsoTerminal;
	}

	public void setCodUsoTerminal(int codUsoTerminal) {
		this.codUsoTerminal = codUsoTerminal;
	}

	public int getCodCuota() {
		return codCuota;
	}

	public void setCodCuota(int codCuota) {
		this.codCuota = codCuota;
	}

	public String getCapcodeSimcard() {
		return capcodeSimcard;
	}

	public void setCapcodeSimcard(String capcodeSimcard) {
		this.capcodeSimcard = capcodeSimcard;
	}

	public String getCapcodeTerminal() {
		return capcodeTerminal;
	}

	public void setCapcodeTerminal(String capcodeTerminal) {
		this.capcodeTerminal = capcodeTerminal;
	}

	
	public String getIndProcEqSimcard() {
		return indProcEqSimcard;
	}

	public void setIndProcEqSimcard(String indProcEqSimcard) {
		this.indProcEqSimcard = indProcEqSimcard;
	}

	public String getIndProcEqTerminal() {
		return indProcEqTerminal;
	}

	public void setIndProcEqTerminal(String indProcEqTerminal) {
		this.indProcEqTerminal = indProcEqTerminal;
	}

	public String getTipoArticuloSimcard() {
		return tipoArticuloSimcard;
	}

	public void setTipoArticuloSimcard(String tipoArticuloSimcard) {
		this.tipoArticuloSimcard = tipoArticuloSimcard;
	}

	public String getTipoArticuloTerminal() {
		return tipoArticuloTerminal;
	}

	public void setTipoArticuloTerminal(String tipoArticuloTerminal) {
		this.tipoArticuloTerminal = tipoArticuloTerminal;
	}

	public long getTipoStockTerminal() {
		return tipoStockTerminal;
	}

	public void setTipoStockTerminal(long tipoStockTerminal) {
		this.tipoStockTerminal = tipoStockTerminal;
	}

	public String getCodBodegaTerminal() {
		return codBodegaTerminal;
	}

	public void setCodBodegaTerminal(String codBodegaTerminal) {
		this.codBodegaTerminal = codBodegaTerminal;
	}

	public void setCodBodegaSimcard(String codBodegaSimcard) {
		this.codBodegaSimcard = codBodegaSimcard;
	}

	public String getIndEqPrestadoTerminal() {
		return indEqPrestadoTerminal;
	}

	public void setIndEqPrestadoTerminal(String indEqPrestadoTerminal) {
		this.indEqPrestadoTerminal = indEqPrestadoTerminal;
	}

	public String getIndEqPrestadoSimcard() {
		return indEqPrestadoSimcard;
	}

	public void setIndEqPrestadoSimcard(String indEqPrestadoSimcard) {
		this.indEqPrestadoSimcard = indEqPrestadoSimcard;
	}

	public String getCodEstadoSimcard() {
		return codEstadoSimcard;
	}

	public void setCodEstadoSimcard(String codEstadoSimcard) {
		this.codEstadoSimcard = codEstadoSimcard;
	}

	public String getCodEstadoTerminal() {
		return codEstadoTerminal;
	}

	public void setCodEstadoTerminal(String codEstadoTerminal) {
		this.codEstadoTerminal = codEstadoTerminal;
	}

	public String getNumSerieSimcard() {
		return numSerieSimcard;
	}

	public void setNumSerieSimcard(String numSerieSimcard) {
		this.numSerieSimcard = numSerieSimcard;
	}

	public String getNumSerieTerminal() {
		return numSerieTerminal;
	}

	public void setNumSerieTerminal(String numSerieTerminal) {
		this.numSerieTerminal = numSerieTerminal;
	}

	

	public Integer getCodigoArticulo() {
		return codigoArticulo;
	}

	public void setCodigoArticulo(Integer codigoArticulo) {
		this.codigoArticulo = codigoArticulo;
	}

	public Integer getCodigoArticuloSimcard() {
		return codigoArticuloSimcard;
	}

	public void setCodigoArticuloSimcard(Integer codigoArticuloSimcard) {
		this.codigoArticuloSimcard = codigoArticuloSimcard;
	}

	public Integer getCodigoArticuloTerminal() {
		return codigoArticuloTerminal;
	}

	public void setCodigoArticuloTerminal(Integer codigoArticuloTerminal) {
		this.codigoArticuloTerminal = codigoArticuloTerminal;
	}

	public String getCodigoBodega() {
		return codigoBodega;
	}

	public void setCodigoBodega(String codigoBodega) {
		this.codigoBodega = codigoBodega;
	}

	public String getCodigoBodegaActual() {
		return codigoBodegaActual;
	}

	public void setCodigoBodegaActual(String codigoBodegaActual) {
		this.codigoBodegaActual = codigoBodegaActual;
	}

	public String getNumeroMovimiento() {
		return numeroMovimiento;
	}

	public void setNumeroMovimiento(String numeroMovimiento) {
		this.numeroMovimiento = numeroMovimiento;
	}

	public String getNumeroSerie() {
		return numeroSerie;
	}

	public void setNumeroSerie(String numeroSerie) {
		this.numeroSerie = numeroSerie;
	}

	public long getTipoStock() {
		return tipoStock;
	}

	public void setTipoStock(long tipoStock) {
		this.tipoStock = tipoStock;
	}

	public long getTipoStockOriginal() {
		return tipoStockOriginal;
	}

	public void setTipoStockOriginal(long tipoStockOriginal) {
		this.tipoStockOriginal = tipoStockOriginal;
	}

	public String getCodTipPlanTarif() {
		return codTipPlanTarif;
	}

	public void setCodTipPlanTarif(String codTipPlanTarif) {
		this.codTipPlanTarif = codTipPlanTarif;
	}

	public String getCodOficina() {
		return codOficina;
	}

	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}

	public String getCodCalClien() {
		return codCalClien;
	}

	public void setCodCalClien(String codCalClien) {
		this.codCalClien = codCalClien;
	}

	public String getDesBodega() {
		return desBodega;
	}

	public void setDesBodega(String desBodega) {
		this.desBodega = desBodega;
	}

}
