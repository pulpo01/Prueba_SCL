/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;
import java.sql.Timestamp;

public class OOSSDatosBasicosClienteVO implements Serializable {
	
	/**
	 * long
	 * OOSSDatosBasicosClienteVO.java
	 */
	private static final long serialVersionUID = 1L;
		
	private Long codCliente;
	private String nomCliente;
	private String apellido1;
	private String apellido2;
	private Long codCuenta;
	private String numIdent;
	private String desCuenta;
	private String codTipIdent;
	private String desTipIdent;	
	private String codPinCliente;
	private int    codNpi;
	private String codTipident2;
	private String numIdent2;
	private String indTraspaso;
	private String numFax;	
	private Integer codActividad;
	private String codPais;
	private String numTelefono;
	private String numTelefono2;
	private String desIndDebito;
	private String email;
	private String codTipIdentTrib;
	private String numIdentTrib;
	private String codOficina;

//	COD_CALCLIEN
	private String codCalClien;
//	IND_SITUACION
	private String indSituacion;
//	FEC_ALTA
	private Timestamp fecAlta;
//	IND_FACTUR
	private Integer indFactur;
//	IND_AGENTE
	private String indAgente;
//	FEC_ULTMOD
	private Timestamp fecUltmod;
//	IND_MANDATO
	private Integer indMandato;
//	NOM_USUARORA
	private String nomUsuarora;
//	IND_ALTA
	private String indAlta;
//	IND_ACEPVENT
	private String indAcepVent;
//	COD_ABC
	private String codAbc;
//	COD_123
	private Integer cod123;
//	NUM_ABOCEL
	private Integer numAbocel;
//	NUM_ABOBEEP
	private Integer numAboBeep;
//	NUM_ABOTRUNK
	private Integer numAbotrunk;
//	COD_PROSPECTO
	private Integer codProspecto;
//	NUM_ABOTREK
	private Integer numAbotrek;
//	COD_SISPAGO
	private Integer codSisPago;
//	NUM_ABORENT
	private Integer numAborent;
//	NUM_ABOROAMING
	private Integer numAboroaming;
//	FEC_ACEPVENT
	private Timestamp fecAcepVent;
//	IMP_STOPDEBIT
	private Double impStopDebit;
//	COD_BANCO
	private String codBanco;
//	COD_SUCURSAL
	private String codSucursal;
//	IND_TIPCUENTA
	private String indTipCuenta;
//	COD_TIPTARJETA
	private String codTipTarjeta;
//	NUM_CTACORR
	private String numCtaCorr;
//	NUM_TARJETA
	private String numTarjeta;
//	FEC_VENCITARJ
	private Timestamp fecVenciTarj;
//	COD_BANCOTARJ
	private String codBancoTarj;
//	COD_TIPIDENTAPOR
	private String codTipIdentApor;
//	NUM_IDENTAPOR
	private String numIdentApor;
//	NOM_APODERADO
	private String nomApoderado;
//	FEC_BAJA
	private Timestamp fecBaja;
//	COD_COBRADOR
	private Integer codCobrador;
//	COD_CICLO
	private Integer codCiclo;
//	NUM_CELULAR
	private Integer numCelular;
//	IND_TIPPERSONA  
	private String indTipPersona;
//	COD_CICLONUE
	private Integer codCicloNue;
//	COD_CATEGORIA
	private Integer codCategoria;
//	COD_SECTOR
	private Integer codSector;
//	COD_SUPERVISOR
	private Integer codSupervisor;
//	IND_ESTCIVIL
	private String indEstCivil;
//	FEC_NACIMIEN
	private Timestamp fecNacimien;
//	IND_SEXO
	private String indSexo;
//	NUM_INT_GRUP_FAM
	private Integer numIntGrupFam;
//	COD_SUBCATEGORIA
	private String codSubCategoria;
//	COD_USO
	private String codUso;
//	COD_IDIOMA
	private String codIdioma;
//	NOM_USUARIO_ASESOR
	private String nomUsuarioAsesor;
//	COD_OPERADORA
	private String codOperadora;
//	IND_TIPDEBITO
	private String indTipDebito;
//	MONTO_DEBITO
	private Double montoDebito;
	
	//GA_MODCLI.COD_TIPMODI
	private String codTipModi;
	//GA_MODCLI.DES_REFDOC
	private String desRefDoc;	
	
	private Timestamp fechaModificaOOSS;
	
	/**
	 * 
	 */
	public OOSSDatosBasicosClienteVO() {
		// TODO Auto-generated constructor stub
	}

	
	/**
	 * @return
	 * 08/07/2008 17:48:24
	 */
	public String getNumIdent() {
		return numIdent;
	}


	/**
	 * @param numIdent
	 * 08/07/2008 17:48:27
	 */
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}


	/**
	 * @return Long con el codigo del cliente
	 * 08/07/2008 16:14:10
	 */
	public Long getCodCliente() {
		return codCliente;
	}

	/**
	 * @param codCliente
	 * 08/07/2008 16:14:06
	 */
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}

	/**
	 * @return String con el nombre del cliente
	 * 08/07/2008 16:14:04
	 */
	public String getNomCliente() {
		return nomCliente;
	}

	/**
	 * @param nomCliente
	 * 08/07/2008 16:14:01
	 */
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}

	/**
	 * @return String con el primer apellido del cliente
	 * 08/07/2008 16:13:59
	 */
	public String getApellido1() {
		return apellido1;
	}

	/**
	 * @param apellido1
	 * 08/07/2008 16:13:57
	 */
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}

	/**
	 * @return String con el segundo apellido del cliente
	 * 08/07/2008 16:13:55
	 */
	public String getApellido2() {
		return apellido2;
	}

	/**
	 * @param apellido2
	 * 08/07/2008 16:13:52
	 */
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}

	/**
	 * @return Long con el codigo de cuenta del cliente
	 * 08/07/2008 16:13:49
	 */
	public Long getCodCuenta() {
		return codCuenta;
	}

	/**
	 * @param codCuenta
	 * 08/07/2008 16:13:46
	 */
	public void setCodCuenta(Long codCuenta) {
		this.codCuenta = codCuenta;
	}

	/**
	 * @return String con la descripcion de cuenta del cliente
	 * 08/07/2008 16:13:44
	 */
	public String getDesCuenta() {
		return desCuenta;
	}

	/**
	 * @param desCuenta
	 * 08/07/2008 16:13:42
	 */
	public void setDesCuenta(String desCuenta) {
		this.desCuenta = desCuenta;
	}

	/**
	 * @return Long con el codigo de tipo de identificacion
	 * 08/07/2008 16:13:40
	 */
	public String getCodTipIdent() {
		return codTipIdent;
	}

	/**
	 * @param codTipIdent
	 * 08/07/2008 16:13:37
	 */
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}

	/**
	 * @return String con la descripcion del tipo de identificacon
	 * 08/07/2008 16:13:35
	 */
	public String getDesTipIdent() {
		return desTipIdent;
	}

	/**
	 * @param desTipIdent
	 * 08/07/2008 16:13:28
	 */
	public void setDesTipIdent(String desTipIdent) {
		this.desTipIdent = desTipIdent;
	}


	/**
	 * @return the codPinCliente
	 */
	public String getCodPinCliente() {
		return codPinCliente;
	}


	/**
	 * @param codPinCliente the codPinCliente to set
	 */
	public void setCodPinCliente(String codPinCliente) {
		this.codPinCliente = codPinCliente;
	}


	/**
	 * @return the codNpi
	 */
	public int getCodNpi() {
		return codNpi;
	}


	/**
	 * @param codNpi the codNpi to set
	 */
	public void setCodNpi(int codNpi) {
		this.codNpi = codNpi;
	}


	/**
	 * @return the codTipident2
	 */
	public String getCodTipident2() {
		return codTipident2;
	}


	/**
	 * @param codTipident2 the codTipident2 to set
	 */
	public void setCodTipident2(String codTipident2) {
		this.codTipident2 = codTipident2;
	}


	/**
	 * @return the numIdent2
	 */
	public String getNumIdent2() {
		return numIdent2;
	}


	/**
	 * @param numIdent2 the numIdent2 to set
	 */
	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}


	/**
	 * @return the indTraspaso
	 */
	public String getIndTraspaso() {
		return indTraspaso;
	}


	/**
	 * @param indTraspaso the indTraspaso to set
	 */
	public void setIndTraspaso(String indTraspaso) {
		this.indTraspaso = indTraspaso;
	}


	/**
	 * @return the numFax
	 */
	public String getNumFax() {
		return numFax;
	}


	/**
	 * @param numFax the numFax to set
	 */
	public void setNumFax(String numFax) {
		this.numFax = numFax;
	}


	/**
	 * @return the codActividad
	 */
	public Integer getCodActividad() {
		return codActividad;
	}


	/**
	 * @param codActividad the codActividad to set
	 */
	public void setCodActividad(Integer codActividad) {
		this.codActividad = codActividad;
	}


	/**
	 * @return the codPais
	 */
	public String getCodPais() {
		return codPais;
	}


	/**
	 * @param codPais the codPais to set
	 */
	public void setCodPais(String codPais) {
		this.codPais = codPais;
	}


	/**
	 * @return the numTelefono
	 */
	public String getNumTelefono() {
		return numTelefono;
	}


	/**
	 * @param numTelefono the numTelefono to set
	 */
	public void setNumTelefono(String numTelefono) {
		this.numTelefono = numTelefono;
	}


	/**
	 * @return the numTelefono2
	 */
	public String getNumTelefono2() {
		return numTelefono2;
	}


	/**
	 * @param numTelefono2 the numTelefono2 to set
	 */
	public void setNumTelefono2(String numTelefono2) {
		this.numTelefono2 = numTelefono2;
	}


	/**
	 * @return the desIndDebito
	 */
	public String getDesIndDebito() {
		return desIndDebito;
	}


	/**
	 * @param desIndDebito the desIndDebito to set
	 */
	public void setDesIndDebito(String desIndDebito) {
		this.desIndDebito = desIndDebito;
	}


	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}


	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}


	/**
	 * @return the codTipIdentTrib
	 */
	public String getCodTipIdentTrib() {
		return codTipIdentTrib;
	}


	/**
	 * @param codTipIdentTrib the codTipIdentTrib to set
	 */
	public void setCodTipIdentTrib(String codTipIdentTrib) {
		this.codTipIdentTrib = codTipIdentTrib;
	}


	/**
	 * @return the numIdentTrib
	 */
	public String getNumIdentTrib() {
		return numIdentTrib;
	}


	/**
	 * @param numIdentTrib the numIdentTrib to set
	 */
	public void setNumIdentTrib(String numIdentTrib) {
		this.numIdentTrib = numIdentTrib;
	}


	/**
	 * @return the codOficina
	 */
	public String getCodOficina() {
		return codOficina;
	}


	/**
	 * @param codOficina the codOficina to set
	 */
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}


	/**
	 * @return the codCalClien
	 */
	public String getCodCalClien() {
		return codCalClien;
	}


	/**
	 * @param codCalClien the codCalClien to set
	 */
	public void setCodCalClien(String codCalClien) {
		this.codCalClien = codCalClien;
	}


	/**
	 * @return the indSituacion
	 */
	public String getIndSituacion() {
		return indSituacion;
	}


	/**
	 * @param indSituacion the indSituacion to set
	 */
	public void setIndSituacion(String indSituacion) {
		this.indSituacion = indSituacion;
	}


	/**
	 * @return the fecAlta
	 */
	public Timestamp getFecAlta() {
		return fecAlta;
	}


	/**
	 * @param fecAlta the fecAlta to set
	 */
	public void setFecAlta(Timestamp fecAlta) {
		this.fecAlta = fecAlta;
	}


	/**
	 * @return the indFactur
	 */
	public Integer getIndFactur() {
		return indFactur;
	}


	/**
	 * @param indFactur the indFactur to set
	 */
	public void setIndFactur(Integer indFactur) {
		this.indFactur = indFactur;
	}


	/**
	 * @return the indAgente
	 */
	public String getIndAgente() {
		return indAgente;
	}


	/**
	 * @param indAgente the indAgente to set
	 */
	public void setIndAgente(String indAgente) {
		this.indAgente = indAgente;
	}


	/**
	 * @return the fecUltmod
	 */
	public Timestamp getFecUltmod() {
		return fecUltmod;
	}


	/**
	 * @param fecUltmod the fecUltmod to set
	 */
	public void setFecUltmod(Timestamp fecUltmod) {
		this.fecUltmod = fecUltmod;
	}


	/**
	 * @return the indMandato
	 */
	public Integer getIndMandato() {
		return indMandato;
	}


	/**
	 * @param indMandato the indMandato to set
	 */
	public void setIndMandato(Integer indMandato) {
		this.indMandato = indMandato;
	}


	/**
	 * @return the nomUsuarora
	 */
	public String getNomUsuarora() {
		return nomUsuarora;
	}


	/**
	 * @param nomUsuarora the nomUsuarora to set
	 */
	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}


	/**
	 * @return the indAlta
	 */
	public String getIndAlta() {
		return indAlta;
	}


	/**
	 * @param indAlta the indAlta to set
	 */
	public void setIndAlta(String indAlta) {
		this.indAlta = indAlta;
	}


	/**
	 * @return the indAcepVent
	 */
	public String getIndAcepVent() {
		return indAcepVent;
	}


	/**
	 * @param indAcepVent the indAcepVent to set
	 */
	public void setIndAcepVent(String indAcepVent) {
		this.indAcepVent = indAcepVent;
	}


	/**
	 * @return the codAbc
	 */
	public String getCodAbc() {
		return codAbc;
	}


	/**
	 * @param codAbc the codAbc to set
	 */
	public void setCodAbc(String codAbc) {
		this.codAbc = codAbc;
	}


	/**
	 * @return the cod123
	 */
	public Integer getCod123() {
		return cod123;
	}


	/**
	 * @param cod123 the cod123 to set
	 */
	public void setCod123(Integer cod123) {
		this.cod123 = cod123;
	}


	/**
	 * @return the numAbocel
	 */
	public Integer getNumAbocel() {
		return numAbocel;
	}


	/**
	 * @param numAbocel the numAbocel to set
	 */
	public void setNumAbocel(Integer numAbocel) {
		this.numAbocel = numAbocel;
	}


	/**
	 * @return the numAboBeep
	 */
	public Integer getNumAboBeep() {
		return numAboBeep;
	}


	/**
	 * @param numAboBeep the numAboBeep to set
	 */
	public void setNumAboBeep(Integer numAboBeep) {
		this.numAboBeep = numAboBeep;
	}


	/**
	 * @return the numAbotrunk
	 */
	public Integer getNumAbotrunk() {
		return numAbotrunk;
	}


	/**
	 * @param numAbotrunk the numAbotrunk to set
	 */
	public void setNumAbotrunk(Integer numAbotrunk) {
		this.numAbotrunk = numAbotrunk;
	}


	/**
	 * @return the codProspecto
	 */
	public Integer getCodProspecto() {
		return codProspecto;
	}


	/**
	 * @param codProspecto the codProspecto to set
	 */
	public void setCodProspecto(Integer codProspecto) {
		this.codProspecto = codProspecto;
	}


	/**
	 * @return the numAbotrek
	 */
	public Integer getNumAbotrek() {
		return numAbotrek;
	}


	/**
	 * @param numAbotrek the numAbotrek to set
	 */
	public void setNumAbotrek(Integer numAbotrek) {
		this.numAbotrek = numAbotrek;
	}


	/**
	 * @return the codSisPago
	 */
	public Integer getCodSisPago() {
		return codSisPago;
	}


	/**
	 * @param codSisPago the codSisPago to set
	 */
	public void setCodSisPago(Integer codSisPago) {
		this.codSisPago = codSisPago;
	}


	/**
	 * @return the numAborent
	 */
	public Integer getNumAborent() {
		return numAborent;
	}


	/**
	 * @param numAborent the numAborent to set
	 */
	public void setNumAborent(Integer numAborent) {
		this.numAborent = numAborent;
	}


	/**
	 * @return the numAboroaming
	 */
	public Integer getNumAboroaming() {
		return numAboroaming;
	}


	/**
	 * @param numAboroaming the numAboroaming to set
	 */
	public void setNumAboroaming(Integer numAboroaming) {
		this.numAboroaming = numAboroaming;
	}


	/**
	 * @return the fecAcepVent
	 */
	public Timestamp getFecAcepVent() {
		return fecAcepVent;
	}


	/**
	 * @param fecAcepVent the fecAcepVent to set
	 */
	public void setFecAcepVent(Timestamp fecAcepVent) {
		this.fecAcepVent = fecAcepVent;
	}


	/**
	 * @return the impStopDebit
	 */
	public Double getImpStopDebit() {
		return impStopDebit;
	}


	/**
	 * @param impStopDebit the impStopDebit to set
	 */
	public void setImpStopDebit(Double impStopDebit) {
		this.impStopDebit = impStopDebit;
	}


	/**
	 * @return the codBanco
	 */
	public String getCodBanco() {
		return codBanco;
	}


	/**
	 * @param codBanco the codBanco to set
	 */
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}


	/**
	 * @return the codSucursal
	 */
	public String getCodSucursal() {
		return codSucursal;
	}


	/**
	 * @param codSucursal the codSucursal to set
	 */
	public void setCodSucursal(String codSucursal) {
		this.codSucursal = codSucursal;
	}


	/**
	 * @return the indTipCuenta
	 */
	public String getIndTipCuenta() {
		return indTipCuenta;
	}


	/**
	 * @param indTipCuenta the indTipCuenta to set
	 */
	public void setIndTipCuenta(String indTipCuenta) {
		this.indTipCuenta = indTipCuenta;
	}


	/**
	 * @return the codTipTarjeta
	 */
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}


	/**
	 * @param codTipTarjeta the codTipTarjeta to set
	 */
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}


	/**
	 * @return the numCtaCorr
	 */
	public String getNumCtaCorr() {
		return numCtaCorr;
	}


	/**
	 * @param numCtaCorr the numCtaCorr to set
	 */
	public void setNumCtaCorr(String numCtaCorr) {
		this.numCtaCorr = numCtaCorr;
	}


	/**
	 * @return the numTarjeta
	 */
	public String getNumTarjeta() {
		return numTarjeta;
	}


	/**
	 * @param numTarjeta the numTarjeta to set
	 */
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}


	/**
	 * @return the fecVenciTarj
	 */
	public Timestamp getFecVenciTarj() {
		return fecVenciTarj;
	}


	/**
	 * @param fecVenciTarj the fecVenciTarj to set
	 */
	public void setFecVenciTarj(Timestamp fecVenciTarj) {
		this.fecVenciTarj = fecVenciTarj;
	}


	/**
	 * @return the codBancoTarj
	 */
	public String getCodBancoTarj() {
		return codBancoTarj;
	}


	/**
	 * @param codBancoTarj the codBancoTarj to set
	 */
	public void setCodBancoTarj(String codBancoTarj) {
		this.codBancoTarj = codBancoTarj;
	}


	/**
	 * @return the codTipIdentApor
	 */
	public String getCodTipIdentApor() {
		return codTipIdentApor;
	}


	/**
	 * @param codTipIdentApor the codTipIdentApor to set
	 */
	public void setCodTipIdentApor(String codTipIdentApor) {
		this.codTipIdentApor = codTipIdentApor;
	}


	/**
	 * @return the numIdentApor
	 */
	public String getNumIdentApor() {
		return numIdentApor;
	}


	/**
	 * @param numIdentApor the numIdentApor to set
	 */
	public void setNumIdentApor(String numIdentApor) {
		this.numIdentApor = numIdentApor;
	}


	/**
	 * @return the nomApoderado
	 */
	public String getNomApoderado() {
		return nomApoderado;
	}


	/**
	 * @param nomApoderado the nomApoderado to set
	 */
	public void setNomApoderado(String nomApoderado) {
		this.nomApoderado = nomApoderado;
	}


	/**
	 * @return the fecBaja
	 */
	public Timestamp getFecBaja() {
		return fecBaja;
	}


	/**
	 * @param fecBaja the fecBaja to set
	 */
	public void setFecBaja(Timestamp fecBaja) {
		this.fecBaja = fecBaja;
	}


	/**
	 * @return the codCobrador
	 */
	public Integer getCodCobrador() {
		return codCobrador;
	}


	/**
	 * @param codCobrador the codCobrador to set
	 */
	public void setCodCobrador(Integer codCobrador) {
		this.codCobrador = codCobrador;
	}


	/**
	 * @return the codCiclo
	 */
	public Integer getCodCiclo() {
		return codCiclo;
	}


	/**
	 * @param codCiclo the codCiclo to set
	 */
	public void setCodCiclo(Integer codCiclo) {
		this.codCiclo = codCiclo;
	}


	/**
	 * @return the numCelular
	 */
	public Integer getNumCelular() {
		return numCelular;
	}


	/**
	 * @param numCelular the numCelular to set
	 */
	public void setNumCelular(Integer numCelular) {
		this.numCelular = numCelular;
	}


	/**
	 * @return the indTipPersona
	 */
	public String getIndTipPersona() {
		return indTipPersona;
	}


	/**
	 * @param indTipPersona the indTipPersona to set
	 */
	public void setIndTipPersona(String indTipPersona) {
		this.indTipPersona = indTipPersona;
	}


	/**
	 * @return the codCicloNue
	 */
	public Integer getCodCicloNue() {
		return codCicloNue;
	}


	/**
	 * @param codCicloNue the codCicloNue to set
	 */
	public void setCodCicloNue(Integer codCicloNue) {
		this.codCicloNue = codCicloNue;
	}


	/**
	 * @return the codCategoria
	 */
	public Integer getCodCategoria() {
		return codCategoria;
	}


	/**
	 * @param codCategoria the codCategoria to set
	 */
	public void setCodCategoria(Integer codCategoria) {
		this.codCategoria = codCategoria;
	}


	/**
	 * @return the codSector
	 */
	public Integer getCodSector() {
		return codSector;
	}


	/**
	 * @param codSector the codSector to set
	 */
	public void setCodSector(Integer codSector) {
		this.codSector = codSector;
	}


	/**
	 * @return the codSupervisor
	 */
	public Integer getCodSupervisor() {
		return codSupervisor;
	}


	/**
	 * @param codSupervisor the codSupervisor to set
	 */
	public void setCodSupervisor(Integer codSupervisor) {
		this.codSupervisor = codSupervisor;
	}


	/**
	 * @return the indEstCivil
	 */
	public String getIndEstCivil() {
		return indEstCivil;
	}


	/**
	 * @param indEstCivil the indEstCivil to set
	 */
	public void setIndEstCivil(String indEstCivil) {
		this.indEstCivil = indEstCivil;
	}


	/**
	 * @return the fecNacimien
	 */
	public Timestamp getFecNacimien() {
		return fecNacimien;
	}


	/**
	 * @param fecNacimien the fecNacimien to set
	 */
	public void setFecNacimien(Timestamp fecNacimien) {
		this.fecNacimien = fecNacimien;
	}


	/**
	 * @return the indSexo
	 */
	public String getIndSexo() {
		return indSexo;
	}


	/**
	 * @param indSexo the indSexo to set
	 */
	public void setIndSexo(String indSexo) {
		this.indSexo = indSexo;
	}


	/**
	 * @return the numIntGrupFam
	 */
	public Integer getNumIntGrupFam() {
		return numIntGrupFam;
	}


	/**
	 * @param numIntGrupFam the numIntGrupFam to set
	 */
	public void setNumIntGrupFam(Integer numIntGrupFam) {
		this.numIntGrupFam = numIntGrupFam;
	}


	/**
	 * @return the codSubCategoria
	 */
	public String getCodSubCategoria() {
		return codSubCategoria;
	}


	/**
	 * @param codSubCategoria the codSubCategoria to set
	 */
	public void setCodSubCategoria(String codSubCategoria) {
		this.codSubCategoria = codSubCategoria;
	}


	/**
	 * @return the codUso
	 */
	public String getCodUso() {
		return codUso;
	}


	/**
	 * @param codUso the codUso to set
	 */
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}


	/**
	 * @return the codIdioma
	 */
	public String getCodIdioma() {
		return codIdioma;
	}


	/**
	 * @param codIdioma the codIdioma to set
	 */
	public void setCodIdioma(String codIdioma) {
		this.codIdioma = codIdioma;
	}


	/**
	 * @return the nomUsuarioAsesor
	 */
	public String getNomUsuarioAsesor() {
		return nomUsuarioAsesor;
	}


	/**
	 * @param nomUsuarioAsesor the nomUsuarioAsesor to set
	 */
	public void setNomUsuarioAsesor(String nomUsuarioAsesor) {
		this.nomUsuarioAsesor = nomUsuarioAsesor;
	}


	/**
	 * @return the codOperadora
	 */
	public String getCodOperadora() {
		return codOperadora;
	}


	/**
	 * @param codOperadora the codOperadora to set
	 */
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}


	/**
	 * @return the indTipDebito
	 */
	public String getIndTipDebito() {
		return indTipDebito;
	}


	/**
	 * @param indTipDebito the indTipDebito to set
	 */
	public void setIndTipDebito(String indTipDebito) {
		this.indTipDebito = indTipDebito;
	}


	/**
	 * @return the montoDebito
	 */
	public Double getMontoDebito() {
		return montoDebito;
	}


	/**
	 * @param montoDebito the montoDebito to set
	 */
	public void setMontoDebito(Double montoDebito) {
		this.montoDebito = montoDebito;
	}


	/**
	 * GA_MODCLI.COD_TIPMODI
	 * @return the codTipModi
	 */
	public String getCodTipModi() {
		return codTipModi;
	}


	/**
	 * GA_MODCLI.COD_TIPMODI
	 * @param codTipModi the codTipModi to set
	 */
	public void setCodTipModi(String codTipModi) {
		this.codTipModi = codTipModi;
	}


	/**
	 * GA_MODCLI.DES_REFDOC
	 * @return the desRefDoc
	 */
	public String getDesRefDoc() {
		return desRefDoc;
	}


	/**
	 * GA_MODCLI.DES_REFDOC
	 * @param desRefDoc the desRefDoc to set
	 */
	public void setDesRefDoc(String desRefDoc) {
		this.desRefDoc = desRefDoc;
	}


	/**
	 * @return the fechaModificaOOSS
	 */
	public Timestamp getFechaModificaOOSS() {
		return fechaModificaOOSS;
	}


	/**
	 * @param fechaModificaOOSS the fechaModificaOOSS to set
	 */
	public void setFechaModificaOOSS(Timestamp fechaModificaOOSS) {
		this.fechaModificaOOSS = fechaModificaOOSS;
	}

	
}
