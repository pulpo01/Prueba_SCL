package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;
import java.sql.Timestamp;


public class ClienteVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long codCliente; //COD_CLIENTE
	private String codPlanTarif;
	private String desPlanTarif;
	private String tipPlanTarif;
	private String nomCliente; //NOM_CLIENTE
	private String nomApeClien1; //NOM_APECLIEN1
	private String nomApeClien2; //NOM_APECLIEN2
	private String numIdent;//NUM_IDENT
	private String codTipIdent; //COD_TIPIDENT
	private Long codCuenta; //COD_CUENTA
	private long numAbonado;
	private String numTerminal;
	private String codPlanServ;
	private String codLimCon;
	private String desLimCon;
	private String codUmbral;
	private String desUmbral;
	private Integer codCiclo;//COD_CICLO
	private Integer codProducto;
	private Long codPlanCom;
	private String nombreCompletoCliente;
	private double saldo;
	private String plaza;
	
	private String codCalClien; //COD_CALCLIEN
	private String indSituacion; //IND_SITUACION 
	private Timestamp fecAlta;//FEC_ALTA 
	private int indFactur; //IND_FACTUR
    //IND_TRASPASO        VARCHAR2(1 BYTE)          NOT NULL,
	private String indTraspaso;
	//IND_AGENTE          VARCHAR2(1 BYTE)          NOT NULL,
	private String indAgente;
	//FEC_ULTMOD          DATE                      NOT NULL,
	private Timestamp fecUltmod;
	//NUM_FAX             VARCHAR2(15 BYTE),
	private String numFax;
	//IND_MANDATO         NUMBER(1),
	private int indMandato;
	//NOM_USUARORA        VARCHAR2(30 BYTE)         NOT NULL,
	private String nomUsuarora;
	//IND_ALTA            VARCHAR2(1 BYTE)          NOT NULL,
	private String indAlta;
	//IND_ACEPVENT        VARCHAR2(1 BYTE)          NOT NULL,
	private String indAcepvent;
	//COD_ABC             VARCHAR2(1 BYTE)          NOT NULL,
	private String codABC;
	//COD_123             NUMBER(1)                 NOT NULL,
	private int cod123;
	//COD_ACTIVIDAD       NUMBER(3),
	private int codActividad;
	//COD_PAIS            VARCHAR2(3 BYTE),
	private String codPais;
	//TEF_CLIENTE1        VARCHAR2(15 BYTE),
	private String tefCliente1;
	//NUM_ABOCEL          NUMBER(4),
	private int numAbocel;
	//TEF_CLIENTE2        VARCHAR2(15 BYTE),
	private String tefCliente2;
	//NUM_ABOBEEP         NUMBER(4),
	private int numAbobeep;
	//IND_DEBITO          VARCHAR2(1 BYTE),
	private String indDebito;
	//NUM_ABOTRUNK        NUMBER(4),
	private int numAbotrunk;
	//COD_PROSPECTO       NUMBER(8),
	private long codProspecto;
	//NUM_ABOTREK         NUMBER(4),
	private int numAbotrek;
	//COD_SISPAGO         NUMBER(2),
	private int codSispago;
	//NOM_EMAIL           VARCHAR2(255 BYTE),
	private String nomEmail;
	//NUM_ABORENT         NUMBER(4),
	private int numAborent;
	//NUM_ABOROAMING      NUMBER(4),
	private int numAboroaming;
	//FEC_ACEPVENT        DATE,
	private Timestamp fecAcepvent;
	//IMP_STOPDEBIT       NUMBER(12,4),
	private double impStopDebit;
	//COD_BANCO           VARCHAR2(15 BYTE),
	private String codBanco;
	//COD_SUCURSAL        VARCHAR2(4 BYTE),
	private String codSucursal;
	//IND_TIPCUENTA       VARCHAR2(1 BYTE),
	private String indTipCuenta;
	//COD_TIPTARJETA      VARCHAR2(3 BYTE),
	private String codTipTarjeta;
	//NUM_CTACORR         VARCHAR2(18 BYTE),
	private String numCtaCorr;
	//NUM_TARJETA         VARCHAR2(18 BYTE),
	private String numTarjeta;
	//FEC_VENCITARJ       DATE,
	private Timestamp fecVencitarj;
	//COD_BANCOTARJ       VARCHAR2(15 BYTE),
	private String codBancoTarj;
	//COD_TIPIDTRIB       VARCHAR2(2 BYTE),
	private String codTipIdTrib;
	//NUM_IDENTTRIB       VARCHAR2(20 BYTE),
	private String numIdentTrib;
	//COD_TIPIDENTAPOR    VARCHAR2(2 BYTE),
	private String codtipIdentaPor;
	//NUM_IDENTAPOR       VARCHAR2(20 BYTE),
	private String numIdentaPor;
	//NOM_APODERADO       VARCHAR2(40 BYTE),
	private String nomApoderado;
	//COD_OFICINA         VARCHAR2(2 BYTE),
	private String codOficina;
	//FEC_BAJA            DATE,
	private Timestamp fecBaja;
	//COD_COBRADOR        NUMBER(6),
	private long codCobrador;
	//COD_PINCLI          VARCHAR2(4 BYTE),
	private String codPinCli;
	//NUM_CELULAR         NUMBER(15),
	private long numCelular;
	//IND_TIPPERSONA      VARCHAR2(1 BYTE),
	private String indTipPersona;
	//COD_CICLONUE        NUMBER(2),
	private int codCicloNue;
	//COD_CATEGORIA       NUMBER(4),
	private int codCategoria;
	//COD_SECTOR          NUMBER(4),
	private int codSector;
	//COD_SUPERVISOR      NUMBER(6),
	private long codSupervisor;
	//IND_ESTCIVIL        CHAR(1 BYTE),
	private String indEstCivil;
	//FEC_NACIMIEN        DATE,
	private Timestamp fecNacimien;
	//IND_SEXO            CHAR(1 BYTE),
	private String indSexo;
	//NUM_INT_GRUP_FAM    NUMBER(2),
	private int numIntGrupFam;
	//COD_NPI             NUMBER(2),
	private int codNpi;
	//COD_SUBCATEGORIA    VARCHAR2(5 BYTE),
	private String codSubCategoria;
	//COD_USO             VARCHAR2(5 BYTE),
	private String codUso;
	//COD_IDIOMA          VARCHAR2(5 BYTE)          DEFAULT '1'                   NOT NULL,
	private String codIdioma;
	//COD_TIPIDENT2       VARCHAR2(2 BYTE),
	private String codTipIdent2;
	//NUM_IDENT2          VARCHAR2(20 BYTE),
	private String numIdent2;
	//NOM_USUARIO_ASESOR  VARCHAR2(30 BYTE),
	private String nomUsuarioAsesor;
	//COD_OPERADORA       VARCHAR2(5 BYTE)          NOT NULL,
	private String codOperadora;
	//IND_TIPDEBITO       VARCHAR2(1 BYTE),
	//private String indTipDebito;
	//MONTO_DEBITO        NUMBER(14,4)
	//private double montoDebito;
	
	private String operadora;
	
	public String getOperadora() {
		return operadora;
	}

	public void setOperadora(String operadora) {
		this.operadora = operadora;
	}

	/**
	 * @return String the plaza 
	 */
	public String getPlaza() {
		return plaza;
	}

	/**
	 * @param plaza String the plaza to set
	 */
	public void setPlaza(String plaza) {
		this.plaza = plaza;
	}

	/**
	 * @return String the nombreCompletoCliente 
	 */
	public String getNombreCompletoCliente() {
		return nombreCompletoCliente;
	}

	/**
	 * @param nombreCompletoCliente String the nombreCompletoCliente to set
	 */
	public void setNombreCompletoCliente(String nombreCompletoCliente) {
		this.nombreCompletoCliente = nombreCompletoCliente;
	}

	public Integer getCodCiclo() {
		return codCiclo;
	}

	public void setCodCiclo(Integer codCiclo) {
		this.codCiclo = codCiclo;
	}

	public String getCodPlanServ() {
		return codPlanServ;
	}

	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}

	public String getNumTerminal() {
		return numTerminal;
	}

	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public Long getCodCuenta() {
		return codCuenta;
	}

	public void setCodCuenta(Long codCuenta) {
		this.codCuenta = codCuenta;
	}

	public String getCodTipIdent() {
		return codTipIdent;
	}

	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}

	public String getNomApeClien1() {
		return nomApeClien1;
	}

	public void setNomApeClien1(String nomApeClien1) {
		this.nomApeClien1 = nomApeClien1;
	}

	public String getNomApeClien2() {
		return nomApeClien2;
	}

	public void setNomApeClien2(String nomApeClien2) {
		this.nomApeClien2 = nomApeClien2;
	}

	public String getNomCliente() {
		return nomCliente;
	}

	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}

	public String getNumIdent() {
		return numIdent;
	}

	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}

	public String getCodPlanTarif() {
		return codPlanTarif;
	}

	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}

	public String getDesPlanTarif() {
		return desPlanTarif;
	}

	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}

	public String getTipPlanTarif() {
		return tipPlanTarif;
	}

	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public String getCodLimCon() {
		return codLimCon;
	}

	public void setCodLimCon(String codLimCon) {
		this.codLimCon = codLimCon;
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

	public Integer getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(Integer codProducto) {
		this.codProducto = codProducto;
	}

	public Long getCodPlanCom() {
		return codPlanCom;
	}

	public void setCodPlanCom(Long codPlanCom) {
		this.codPlanCom = codPlanCom;
	}

	/**
	 * @return long the saldo 
	 */
	public double getSaldo() {
		return saldo;
	}

	/**
	 * @param saldo long the saldo to set
	 */
	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}

	
	/**
	 * @return int the cod123 
	 */
	public int getCod123() {
		return cod123;
	}

	/**
	 * @param cod123 int the cod123 to set
	 */
	public void setCod123(int cod123) {
		this.cod123 = cod123;
	}

	/**
	 * @return String the codABC 
	 */
	public String getCodABC() {
		return codABC;
	}

	/**
	 * @param codABC String the codABC to set
	 */
	public void setCodABC(String codABC) {
		this.codABC = codABC;
	}

	/**
	 * @return int the codActividad 
	 */
	public int getCodActividad() {
		return codActividad;
	}

	/**
	 * @param codActividad int the codActividad to set
	 */
	public void setCodActividad(int codActividad) {
		this.codActividad = codActividad;
	}

	/**
	 * @return String the codBanco 
	 */
	public String getCodBanco() {
		return codBanco;
	}

	/**
	 * @param codBanco String the codBanco to set
	 */
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}

	/**
	 * @return String the codCalClien 
	 */
	public String getCodCalClien() {
		return codCalClien;
	}

	/**
	 * @param codCalClien String the codCalClien to set
	 */
	public void setCodCalClien(String codCalClien) {
		this.codCalClien = codCalClien;
	}

	/**
	 * @return int the codCategoria 
	 */
	public int getCodCategoria() {
		return codCategoria;
	}

	/**
	 * @param codCategoria int the codCategoria to set
	 */
	public void setCodCategoria(int codCategoria) {
		this.codCategoria = codCategoria;
	}

	/**
	 * @return int the codCicloNue 
	 */
	public int getCodCicloNue() {
		return codCicloNue;
	}

	/**
	 * @param codCicloNue int the codCicloNue to set
	 */
	public void setCodCicloNue(int codCicloNue) {
		this.codCicloNue = codCicloNue;
	}

	/**
	 * @return long the codCobrador 
	 */
	public long getCodCobrador() {
		return codCobrador;
	}

	/**
	 * @param codCobrador long the codCobrador to set
	 */
	public void setCodCobrador(long codCobrador) {
		this.codCobrador = codCobrador;
	}

	/**
	 * @return String the codIdioma 
	 */
	public String getCodIdioma() {
		return codIdioma;
	}

	/**
	 * @param codIdioma String the codIdioma to set
	 */
	public void setCodIdioma(String codIdioma) {
		this.codIdioma = codIdioma;
	}

	/**
	 * @return int the codNpi 
	 */
	public int getCodNpi() {
		return codNpi;
	}

	/**
	 * @param codNpi int the codNpi to set
	 */
	public void setCodNpi(int codNpi) {
		this.codNpi = codNpi;
	}

	/**
	 * @return String the codOficina 
	 */
	public String getCodOficina() {
		return codOficina;
	}

	/**
	 * @param codOficina String the codOficina to set
	 */
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}

	/**
	 * @return String the codOperadora 
	 */
	public String getCodOperadora() {
		return codOperadora;
	}

	/**
	 * @param codOperadora String the codOperadora to set
	 */
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

	/**
	 * @return String the codPais 
	 */
	public String getCodPais() {
		return codPais;
	}

	/**
	 * @param codPais String the codPais to set
	 */
	public void setCodPais(String codPais) {
		this.codPais = codPais;
	}

	/**
	 * @return String the codPinCli 
	 */
	public String getCodPinCli() {
		return codPinCli;
	}

	/**
	 * @param codPinCli String the codPinCli to set
	 */
	public void setCodPinCli(String codPinCli) {
		this.codPinCli = codPinCli;
	}

	/**
	 * @return long the codProspecto 
	 */
	public long getCodProspecto() {
		return codProspecto;
	}

	/**
	 * @param codProspecto long the codProspecto to set
	 */
	public void setCodProspecto(long codProspecto) {
		this.codProspecto = codProspecto;
	}

	/**
	 * @return int the codSector 
	 */
	public int getCodSector() {
		return codSector;
	}

	/**
	 * @param codSector int the codSector to set
	 */
	public void setCodSector(int codSector) {
		this.codSector = codSector;
	}

	/**
	 * @return int the codSispago 
	 */
	public int getCodSispago() {
		return codSispago;
	}

	/**
	 * @param codSispago int the codSispago to set
	 */
	public void setCodSispago(int codSispago) {
		this.codSispago = codSispago;
	}

	/**
	 * @return String the codSubCategoria 
	 */
	public String getCodSubCategoria() {
		return codSubCategoria;
	}

	/**
	 * @param codSubCategoria String the codSubCategoria to set
	 */
	public void setCodSubCategoria(String codSubCategoria) {
		this.codSubCategoria = codSubCategoria;
	}

	/**
	 * @return String the codSucursal 
	 */
	public String getCodSucursal() {
		return codSucursal;
	}

	/**
	 * @param codSucursal String the codSucursal to set
	 */
	public void setCodSucursal(String codSucursal) {
		this.codSucursal = codSucursal;
	}

	/**
	 * @return long the codSupervisor 
	 */
	public long getCodSupervisor() {
		return codSupervisor;
	}

	/**
	 * @param codSupervisor long the codSupervisor to set
	 */
	public void setCodSupervisor(long codSupervisor) {
		this.codSupervisor = codSupervisor;
	}

	/**
	 * @return String the codTipIdent2 
	 */
	public String getCodTipIdent2() {
		return codTipIdent2;
	}

	/**
	 * @param codTipIdent2 String the codTipIdent2 to set
	 */
	public void setCodTipIdent2(String codTipIdent2) {
		this.codTipIdent2 = codTipIdent2;
	}

	/**
	 * @return String the codtipIdentaPor 
	 */
	public String getCodtipIdentaPor() {
		return codtipIdentaPor;
	}

	/**
	 * @param codtipIdentaPor String the codtipIdentaPor to set
	 */
	public void setCodtipIdentaPor(String codtipIdentaPor) {
		this.codtipIdentaPor = codtipIdentaPor;
	}

	/**
	 * @return String the codTipIdTrib 
	 */
	public String getCodTipIdTrib() {
		return codTipIdTrib;
	}

	/**
	 * @param codTipIdTrib String the codTipIdTrib to set
	 */
	public void setCodTipIdTrib(String codTipIdTrib) {
		this.codTipIdTrib = codTipIdTrib;
	}

	/**
	 * @return String the codTipTarjeta 
	 */
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}

	/**
	 * @param codTipTarjeta String the codTipTarjeta to set
	 */
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}

	/**
	 * @return String the codUso 
	 */
	public String getCodUso() {
		return codUso;
	}

	/**
	 * @param codUso String the codUso to set
	 */
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}

	/**
	 * @return Timestamp the fecAcepvent 
	 */
	public Timestamp getFecAcepvent() {
		return fecAcepvent;
	}

	/**
	 * @param fecAcepvent Timestamp the fecAcepvent to set
	 */
	public void setFecAcepvent(Timestamp fecAcepvent) {
		this.fecAcepvent = fecAcepvent;
	}

	/**
	 * @return Timestamp the fecAlta 
	 */
	public Timestamp getFecAlta() {
		return fecAlta;
	}

	/**
	 * @param fecAlta Timestamp the fecAlta to set
	 */
	public void setFecAlta(Timestamp fecAlta) {
		this.fecAlta = fecAlta;
	}

	/**
	 * @return Timestamp the fecBaja 
	 */
	public Timestamp getFecBaja() {
		return fecBaja;
	}

	/**
	 * @param fecBaja Timestamp the fecBaja to set
	 */
	public void setFecBaja(Timestamp fecBaja) {
		this.fecBaja = fecBaja;
	}

	/**
	 * @return Timestamp the fecNacimien 
	 */
	public Timestamp getFecNacimien() {
		return fecNacimien;
	}

	/**
	 * @param fecNacimien Timestamp the fecNacimien to set
	 */
	public void setFecNacimien(Timestamp fecNacimien) {
		this.fecNacimien = fecNacimien;
	}

	/**
	 * @return Timestamp the fecUltmod 
	 */
	public Timestamp getFecUltmod() {
		return fecUltmod;
	}

	/**
	 * @param fecUltmod Timestamp the fecUltmod to set
	 */
	public void setFecUltmod(Timestamp fecUltmod) {
		this.fecUltmod = fecUltmod;
	}

	/**
	 * @return Timestamp the fecVencitarj 
	 */
	public Timestamp getFecVencitarj() {
		return fecVencitarj;
	}

	/**
	 * @param fecVencitarj Timestamp the fecVencitarj to set
	 */
	public void setFecVencitarj(Timestamp fecVencitarj) {
		this.fecVencitarj = fecVencitarj;
	}	

	/**
	 * @return String the numIdentTrib 
	 */
	public String getNumIdentTrib() {
		return numIdentTrib;
	}

	/**
	 * @param numIdentTrib String the numIdentTrib to set
	 */
	public void setNumIdentTrib(String numIdentTrib) {
		this.numIdentTrib = numIdentTrib;
	}

	/**
	 * @return double the impStopDebit 
	 */
	public double getImpStopDebit() {
		return impStopDebit;
	}

	/**
	 * @param impStopDebit double the impStopDebit to set
	 */
	public void setImpStopDebit(double impStopDebit) {
		this.impStopDebit = impStopDebit;
	}

	/**
	 * @return String the indAcepvent 
	 */
	public String getIndAcepvent() {
		return indAcepvent;
	}

	/**
	 * @param indAcepvent String the indAcepvent to set
	 */
	public void setIndAcepvent(String indAcepvent) {
		this.indAcepvent = indAcepvent;
	}

	/**
	 * @return String the indAgente 
	 */
	public String getIndAgente() {
		return indAgente;
	}

	/**
	 * @param indAgente String the indAgente to set
	 */
	public void setIndAgente(String indAgente) {
		this.indAgente = indAgente;
	}

	/**
	 * @return String the indAlta 
	 */
	public String getIndAlta() {
		return indAlta;
	}

	/**
	 * @param indAlta String the indAlta to set
	 */
	public void setIndAlta(String indAlta) {
		this.indAlta = indAlta;
	}

	/**
	 * @return String the indDebito 
	 */
	public String getIndDebito() {
		return indDebito;
	}

	/**
	 * @param indDebito String the indDebito to set
	 */
	public void setIndDebito(String indDebito) {
		this.indDebito = indDebito;
	}

	/**
	 * @return String the indEstCivil 
	 */
	public String getIndEstCivil() {
		return indEstCivil;
	}

	/**
	 * @param indEstCivil String the indEstCivil to set
	 */
	public void setIndEstCivil(String indEstCivil) {
		this.indEstCivil = indEstCivil;
	}

	/**
	 * @return int the indFactur 
	 */
	public int getIndFactur() {
		return indFactur;
	}

	/**
	 * @param indFactur int the indFactur to set
	 */
	public void setIndFactur(int indFactur) {
		this.indFactur = indFactur;
	}

	/**
	 * @return int the indMandato 
	 */
	public int getIndMandato() {
		return indMandato;
	}

	/**
	 * @param indMandato int the indMandato to set
	 */
	public void setIndMandato(int indMandato) {
		this.indMandato = indMandato;
	}

	/**
	 * @return String the indSexo 
	 */
	public String getIndSexo() {
		return indSexo;
	}

	/**
	 * @param indSexo String the indSexo to set
	 */
	public void setIndSexo(String indSexo) {
		this.indSexo = indSexo;
	}

	/**
	 * @return String the indSituacion 
	 */
	public String getIndSituacion() {
		return indSituacion;
	}

	/**
	 * @param indSituacion String the indSituacion to set
	 */
	public void setIndSituacion(String indSituacion) {
		this.indSituacion = indSituacion;
	}

	/**
	 * @return String the indTipCuenta 
	 */
	public String getIndTipCuenta() {
		return indTipCuenta;
	}

	/**
	 * @param indTipCuenta String the indTipCuenta to set
	 */
	public void setIndTipCuenta(String indTipCuenta) {
		this.indTipCuenta = indTipCuenta;
	}

//	/**
//	 * @return String the indTipDebito 
//	 */
//	public String getIndTipDebito() {
//		return indTipDebito;
//	}
//
//	/**
//	 * @param indTipDebito String the indTipDebito to set
//	 */
//	public void setIndTipDebito(String indTipDebito) {
//		this.indTipDebito = indTipDebito;
//	}

	/**
	 * @return String the indTipPersona 
	 */
	public String getIndTipPersona() {
		return indTipPersona;
	}

	/**
	 * @param indTipPersona String the indTipPersona to set
	 */
	public void setIndTipPersona(String indTipPersona) {
		this.indTipPersona = indTipPersona;
	}

	/**
	 * @return String the indTraspaso 
	 */
	public String getIndTraspaso() {
		return indTraspaso;
	}

	/**
	 * @param indTraspaso String the indTraspaso to set
	 */
	public void setIndTraspaso(String indTraspaso) {
		this.indTraspaso = indTraspaso;
	}

	/**
	 * @return String the nomApoderado 
	 */
	public String getNomApoderado() {
		return nomApoderado;
	}

	/**
	 * @param nomApoderado String the nomApoderado to set
	 */
	public void setNomApoderado(String nomApoderado) {
		this.nomApoderado = nomApoderado;
	}

	/**
	 * @return String the nomEmail 
	 */
	public String getNomEmail() {
		return nomEmail;
	}

	/**
	 * @param nomEmail String the nomEmail to set
	 */
	public void setNomEmail(String nomEmail) {
		this.nomEmail = nomEmail;
	}

	/**
	 * @return String the nomUsuarioAsesor 
	 */
	public String getNomUsuarioAsesor() {
		return nomUsuarioAsesor;
	}

	/**
	 * @param nomUsuarioAsesor String the nomUsuarioAsesor to set
	 */
	public void setNomUsuarioAsesor(String nomUsuarioAsesor) {
		this.nomUsuarioAsesor = nomUsuarioAsesor;
	}

	/**
	 * @return String the nomUsuarora 
	 */
	public String getNomUsuarora() {
		return nomUsuarora;
	}

	/**
	 * @param nomUsuarora String the nomUsuarora to set
	 */
	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}

	/**
	 * @return int the numAbobeep 
	 */
	public int getNumAbobeep() {
		return numAbobeep;
	}

	/**
	 * @param numAbobeep int the numAbobeep to set
	 */
	public void setNumAbobeep(int numAbobeep) {
		this.numAbobeep = numAbobeep;
	}

	/**
	 * @return int the numAbocel 
	 */
	public int getNumAbocel() {
		return numAbocel;
	}

	/**
	 * @param numAbocel int the numAbocel to set
	 */
	public void setNumAbocel(int numAbocel) {
		this.numAbocel = numAbocel;
	}

	/**
	 * @return int the numAborent 
	 */
	public int getNumAborent() {
		return numAborent;
	}

	/**
	 * @param numAborent int the numAborent to set
	 */
	public void setNumAborent(int numAborent) {
		this.numAborent = numAborent;
	}

	/**
	 * @return int the numAboroaming 
	 */
	public int getNumAboroaming() {
		return numAboroaming;
	}

	/**
	 * @param numAboroaming int the numAboroaming to set
	 */
	public void setNumAboroaming(int numAboroaming) {
		this.numAboroaming = numAboroaming;
	}

	/**
	 * @return int the numAbotrek 
	 */
	public int getNumAbotrek() {
		return numAbotrek;
	}

	/**
	 * @param numAbotrek int the numAbotrek to set
	 */
	public void setNumAbotrek(int numAbotrek) {
		this.numAbotrek = numAbotrek;
	}

	/**
	 * @return int the numAbotrunk 
	 */
	public int getNumAbotrunk() {
		return numAbotrunk;
	}

	/**
	 * @param numAbotrunk int the numAbotrunk to set
	 */
	public void setNumAbotrunk(int numAbotrunk) {
		this.numAbotrunk = numAbotrunk;
	}

	/**
	 * @return long the numCelular 
	 */
	public long getNumCelular() {
		return numCelular;
	}

	/**
	 * @param numCelular long the numCelular to set
	 */
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}

	/**
	 * @return String the numCtaCorr 
	 */
	public String getNumCtaCorr() {
		return numCtaCorr;
	}

	/**
	 * @param numCtaCorr String the numCtaCorr to set
	 */
	public void setNumCtaCorr(String numCtaCorr) {
		this.numCtaCorr = numCtaCorr;
	}

	/**
	 * @return String the numFax 
	 */
	public String getNumFax() {
		return numFax;
	}

	/**
	 * @param numFax String the numFax to set
	 */
	public void setNumFax(String numFax) {
		this.numFax = numFax;
	}

	/**
	 * @return String the numIdent2 
	 */
	public String getNumIdent2() {
		return numIdent2;
	}

	/**
	 * @param numIdent2 String the numIdent2 to set
	 */
	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}

	/**
	 * @return String the numIdentaPor 
	 */
	public String getNumIdentaPor() {
		return numIdentaPor;
	}

	/**
	 * @param numIdentaPor String the numIdentaPor to set
	 */
	public void setNumIdentaPor(String numIdentaPor) {
		this.numIdentaPor = numIdentaPor;
	}

	/**
	 * @return int the numIntGrupFam 
	 */
	public int getNumIntGrupFam() {
		return numIntGrupFam;
	}

	/**
	 * @param numIntGrupFam int the numIntGrupFam to set
	 */
	public void setNumIntGrupFam(int numIntGrupFam) {
		this.numIntGrupFam = numIntGrupFam;
	}

	/**
	 * @return String the numTarjeta 
	 */
	public String getNumTarjeta() {
		return numTarjeta;
	}

	/**
	 * @param numTarjeta String the numTarjeta to set
	 */
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}

	/**
	 * @return String the tefCliente1 
	 */
	public String getTefCliente1() {
		return tefCliente1;
	}

	/**
	 * @param tefCliente1 String the tefCliente1 to set
	 */
	public void setTefCliente1(String tefCliente1) {
		this.tefCliente1 = tefCliente1;
	}

	/**
	 * @return String the tefCliente2 
	 */
	public String getTefCliente2() {
		return tefCliente2;
	}

	/**
	 * @param tefCliente2 String the tefCliente2 to set
	 */
	public void setTefCliente2(String tefCliente2) {
		this.tefCliente2 = tefCliente2;
	}

	/**
	 * @return String the codBancoTarj 
	 */
	public String getCodBancoTarj() {
		return codBancoTarj;
	}

	/**
	 * @param codBancoTarj String the codBancoTarj to set
	 */
	public void setCodBancoTarj(String codBancoTarj) {
		this.codBancoTarj = codBancoTarj;
	}

//	/**
//	 * @return double the montoDebito 
//	 */
//	public double getMontoDebito() {
//		return montoDebito;
//	}
//
//	/**
//	 * @param montoDebito double the montoDebito to set
//	 */
//	public void setMontoDebito(double montoDebito) {
//		this.montoDebito = montoDebito;
//	}

}
