package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Hashtable;


public class DatosGeneralesVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String nombreSecuencia;
	private Long nroSecuencia;
	private String nomParametro;
	private String valParametro;
	private String codModulo;
	private long codProducto;
	private String desParametro;
	private String nomUsuario;
	private Timestamp fecAlta;
	private Timestamp fechaSistema;
	private String formatoFecha;
	private String formatoHora;
	private long codContado;
	private String codActAbo;
	private String codTecnologia;
	private String codActCen;
	
	private String sTipTerminalGSM;
	private String sTipTermSimc;
	
	private String codEstCobros;
	private String codAbc;
	private long cod123;
	private long codSisPagB;
	private long codSisPagT;
	private String codMonedaDef;
	private long numLinaNex;
	private long codUsoSegNum;
	private long numDiasReUtil;
	private String codDiasEspCel;
	private String codDiasEspBeep;
	private String codDiasEspTrek;
	private String codFyfCel;
	private long tipMovSalDn;
	private long tipMovSalDa;
	private long tipMovSalDs;
	private long tipMovSalt;
	private long tipMovRes;	
	private long tipMovDesRes;
	private long tipMovEntt;
	private long numDiasLiq;
	private long numResNum;
	private long numDiasEsp;
	private long numTelesp;
	private String codTipDiaCel;
	private String codSerConExcel;
	private long codEstNuevo;
	private long codTarj;
	private long codCheque;
	private long codDocAnex;
	private long codDocGuia;
	private long codDocFact;
	private String codDetCel;
	private String codDetBeep;
	private String codDetTrek;
	private String tipAnalog;
	private String tipDigital;
	private String codCautras;
	private String codCauRec;
	private long codCtrasCel;
	private long codCtrasBeep;
	private long codCtrasTrunk;
	private long codCtrasTrek;
	private int codEstUsado;
	private long codCdedCel;
	private long codCdedBeep;
	private long codCdedTrunk;
	private long codCdedTrek;
	private long codCnivQcel;
	private long codCniveQBeep;
	private long codCniveQCel;
	private long codCNiveQBeep;
	private long codCniveQTrunk;
	private long codCNiveQTrek;
	private int tipDeducible;
	private String codSerConexBeep;
	private String codSerConexTrunk;
	private String codSerConexTrek;
	private String codTipDiaBeep;
	private String codTipDiaTrek;
	private String codCalClien;
	private long tipMovDevCl;
	private int codUsoGrp;
	private String pathReport;
	private String codGrp1;
	private String codGrp2;
	private int codCredito;
	private int codLeasing;
	private int codArriendo;
	private int tipLocal;
	private String tipAlfa;
	private String tipNum;
	private String tipTono;
	private String tipFijo;
	private String tipMovil;
	private String codCSerCel;
	private String codCSerBeep;
	private String codCSerTrunk;
	private String codCSerTrek;
	private String codCauTrasBeep;
	private String codCserTrunk;
	private String codCserTrek;
	private String codCauTrasTrunk;
	private String codCauTrasTrek;
	private int indTipDicom;
	private String codSerCallerId;
	private int codCicloCControl;
	private String codSerCalleRid;
	private String codSerLlaminTer;
	private int codUsoControlada;
	private int codCartaGarant;	
	private String codCauBajaFinCel;
	private String codCauBajaFinBeep;
	private String codCaubajaFinTrek;
	private String codAmiPlanTarif;
	private String codAmiPlanServ;
	private String codAmiCargoBasico;
	private String codAmiCiclo;
	private String codAmiCauBaja;
	private String codAamiTipContra;
	private String codProcNoComer;
	private int codUsoMpp;	
	private String codCauLn;
	private int codPenalizaComodato;
	private String codSinServRoaming;
	private String codConServRoaming;
	private String codAmiTipContra;
	private String codRepPlantarif;
	private String codRepPlanserv;
	private String codRepCargoBasico;
	private long codRepCiclo;
	private String codRepCausaBaja;
	private String codRepTipContrato;
	private int codDocBoleta;
	private int codOrdCompra;
	private String codTipidNumIdent;
	
	//DatosGeneralesDAO consultaCodProcesoPlanesNoComercializables
	private String nomPerfilProceso;
	private String codProcesoNoComerciales;
	
	//DatosGeneralesDAO consultaVersionAplicacion
	private String codPrograma;
	private long numVersion;
	private long numSubVersion;
	
	//DatosGeneralesDAO consultaPermisoEjecucion
	private boolean permisoEjecucion;
    
	//DatosGeneralesDAO consultaCodigoOperadora
	private String codOperadora;
	
	private Hashtable formatosFecha;
	
	private int codTipdocum;
	private String codOficina;
    private int codCentremi;
	
	
	/**
	 * @return Hashtable the formatosFecha 
	 */
	public Hashtable getFormatosFecha() {
		return formatosFecha;
	}
	/**
	 * @param formatosFecha Hashtable the formatosFecha to set
	 */
	public void setFormatosFecha(Hashtable formatosFecha) {
		this.formatosFecha = formatosFecha;
	}
	public String getCodOperadora() {
		return codOperadora;
	}
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}
	/**
	 * @return String the codPrograma 
	 */
	public String getCodPrograma() {
		return codPrograma;
	}
	/**
	 * @param codPrograma String the codPrograma to set
	 */
	public void setCodPrograma(String codPrograma) {
		this.codPrograma = codPrograma;
	}
	/**
	 * @return long the numSubVersion 
	 */
	public long getNumSubVersion() {
		return numSubVersion;
	}
	/**
	 * @param numSubVersion long the numSubVersion to set
	 */
	public void setNumSubVersion(long numSubVersion) {
		this.numSubVersion = numSubVersion;
	}
	/**
	 * @return long the numVersion 
	 */
	public long getNumVersion() {
		return numVersion;
	}
	/**
	 * @param numVersion long the numVersion to set
	 */
	public void setNumVersion(long numVersion) {
		this.numVersion = numVersion;
	}
	public String getCodTipidNumIdent() {
		return codTipidNumIdent;
	}
	public void setCodTipidNumIdent(String codTipidNumIdent) {
		this.codTipidNumIdent = codTipidNumIdent;
	}
	public int getCodDocBoleta() {
		return codDocBoleta;
	}
	public void setCodDocBoleta(int codDocBoleta) {
		this.codDocBoleta = codDocBoleta;
	}
	public int getCodOrdCompra() {
		return codOrdCompra;
	}
	public void setCodOrdCompra(int codOrdCompra) {
		this.codOrdCompra = codOrdCompra;
	}
	public String getCodRepCausaBaja() {
		return codRepCausaBaja;
	}
	public void setCodRepCausaBaja(String codRepCausaBaja) {
		this.codRepCausaBaja = codRepCausaBaja;
	}
	public String getCodRepTipContrato() {
		return codRepTipContrato;
	}
	public void setCodRepTipContrato(String codRepTipContrato) {
		this.codRepTipContrato = codRepTipContrato;
	}
	public long getCodRepCiclo() {
		return codRepCiclo;
	}
	public void setCodRepCiclo(long codRepCiclo) {
		this.codRepCiclo = codRepCiclo;
	}
	public String getCodRepCargoBasico() {
		return codRepCargoBasico;
	}
	public void setCodRepCargoBasico(String codRepCargoBasico) {
		this.codRepCargoBasico = codRepCargoBasico;
	}
	public String getCodRepPlanserv() {
		return codRepPlanserv;
	}
	public void setCodRepPlanserv(String codRepPlanserv) {
		this.codRepPlanserv = codRepPlanserv;
	}
	public String getCodRepPlantarif() {
		return codRepPlantarif;
	}
	public void setCodRepPlantarif(String codRepPlantarif) {
		this.codRepPlantarif = codRepPlantarif;
	}
	public String getCodAmiTipContra() {
		return codAmiTipContra;
	}
	public void setCodAmiTipContra(String codAmiTipContra) {
		this.codAmiTipContra = codAmiTipContra;
	}
	public String getCodConServRoaming() {
		return codConServRoaming;
	}
	public void setCodConServRoaming(String codConServRoaming) {
		this.codConServRoaming = codConServRoaming;
	}
	public String getCodSinServRoaming() {
		return codSinServRoaming;
	}
	public void setCodSinServRoaming(String codSinServRoaming) {
		this.codSinServRoaming = codSinServRoaming;
	}
	public String getCodAamiTipContra() {
		return codAamiTipContra;
	}
	public void setCodAamiTipContra(String codAamiTipContra) {
		this.codAamiTipContra = codAamiTipContra;
	}
	public String getCodAmiCauBaja() {
		return codAmiCauBaja;
	}
	public void setCodAmiCauBaja(String codAmiCauBaja) {
		this.codAmiCauBaja = codAmiCauBaja;
	}
	public String getCodCauLn() {
		return codCauLn;
	}
	public void setCodCauLn(String codCauLn) {
		this.codCauLn = codCauLn;
	}
	public int getCodPenalizaComodato() {
		return codPenalizaComodato;
	}
	public void setCodPenalizaComodato(int codPenalizaComodato) {
		this.codPenalizaComodato = codPenalizaComodato;
	}
	public String getCodProcNoComer() {
		return codProcNoComer;
	}
	public void setCodProcNoComer(String codProcNoComer) {
		this.codProcNoComer = codProcNoComer;
	}
	public int getCodUsoMpp() {
		return codUsoMpp;
	}
	public void setCodUsoMpp(int codUsoMpp) {
		this.codUsoMpp = codUsoMpp;
	}
	public String getCodAmiCiclo() {
		return codAmiCiclo;
	}
	public void setCodAmiCiclo(String codAmiCiclo) {
		this.codAmiCiclo = codAmiCiclo;
	}
	public String getCodAmiCargoBasico() {
		return codAmiCargoBasico;
	}
	public void setCodAmiCargoBasico(String codAmiCargoBasico) {
		this.codAmiCargoBasico = codAmiCargoBasico;
	}
	public String getCodAmiPlanServ() {
		return codAmiPlanServ;
	}
	public void setCodAmiPlanServ(String codAmiPlanServ) {
		this.codAmiPlanServ = codAmiPlanServ;
	}
	public String getCodAmiPlanTarif() {
		return codAmiPlanTarif;
	}
	public void setCodAmiPlanTarif(String codAmiPlanTarif) {
		this.codAmiPlanTarif = codAmiPlanTarif;
	}
	public String getCodCauBajaFinBeep() {
		return codCauBajaFinBeep;
	}
	public void setCodCauBajaFinBeep(String codCauBajaFinBeep) {
		this.codCauBajaFinBeep = codCauBajaFinBeep;
	}
	public String getCodCauBajaFinCel() {
		return codCauBajaFinCel;
	}
	public void setCodCauBajaFinCel(String codCauBajaFinCel) {
		this.codCauBajaFinCel = codCauBajaFinCel;
	}
	public String getCodCaubajaFinTrek() {
		return codCaubajaFinTrek;
	}
	public void setCodCaubajaFinTrek(String codCaubajaFinTrek) {
		this.codCaubajaFinTrek = codCaubajaFinTrek;
	}
	public String getCodSerCalleRid() {
		return codSerCalleRid;
	}
	public void setCodSerCalleRid(String codSerCalleRid) {
		this.codSerCalleRid = codSerCalleRid;
	}
	public String getCodSerLlaminTer() {
		return codSerLlaminTer;
	}
	public void setCodSerLlaminTer(String codSerLlaminTer) {
		this.codSerLlaminTer = codSerLlaminTer;
	}
	public String getCodCauTrasTrek() {
		return codCauTrasTrek;
	}
	public void setCodCauTrasTrek(String codCauTrasTrek) {
		this.codCauTrasTrek = codCauTrasTrek;
	}
	public String getCodCauTrasTrunk() {
		return codCauTrasTrunk;
	}
	public void setCodCauTrasTrunk(String codCauTrasTrunk) {
		this.codCauTrasTrunk = codCauTrasTrunk;
	}
	public int getCodCicloCControl() {
		return codCicloCControl;
	}
	public void setCodCicloCControl(int codCicloCControl) {
		this.codCicloCControl = codCicloCControl;
	}
	public String getCodCserTrek() {
		return codCserTrek;
	}
	public void setCodCserTrek(String codCserTrek) {
		this.codCserTrek = codCserTrek;
	}
	public String getCodCserTrunk() {
		return codCserTrunk;
	}
	public void setCodCserTrunk(String codCserTrunk) {
		this.codCserTrunk = codCserTrunk;
	}
	public String getCodSerCallerId() {
		return codSerCallerId;
	}
	public void setCodSerCallerId(String codSerCallerId) {
		this.codSerCallerId = codSerCallerId;
	}
	public int getIndTipDicom() {
		return indTipDicom;
	}
	public void setIndTipDicom(int indTipDicom) {
		this.indTipDicom = indTipDicom;
	}
	public long getCod123() {
		return cod123;
	}
	public void setCod123(long cod123) {
		this.cod123 = cod123;
	}
	
	public String getCodAbc() {
		return codAbc;
	}
	public void setCodAbc(String codAbc) {
		this.codAbc = codAbc;
	}
	public int getCodArriendo() {
		return codArriendo;
	}
	public void setCodArriendo(int codArriendo) {
		this.codArriendo = codArriendo;
	}
	public String getCodCalClien() {
		return codCalClien;
	}
	public void setCodCalClien(String codCalClien) {
		this.codCalClien = codCalClien;
	}
	public String getCodCauRec() {
		return codCauRec;
	}
	public void setCodCauRec(String codCauRec) {
		this.codCauRec = codCauRec;
	}
	public String getCodCautras() {
		return codCautras;
	}
	public void setCodCautras(String codCautras) {
		this.codCautras = codCautras;
	}
	public String getCodCauTrasBeep() {
		return codCauTrasBeep;
	}
	public void setCodCauTrasBeep(String codCauTrasBeep) {
		this.codCauTrasBeep = codCauTrasBeep;
	}
	public long getCodCdedBeep() {
		return codCdedBeep;
	}
	public void setCodCdedBeep(long codCdedBeep) {
		this.codCdedBeep = codCdedBeep;
	}
	public long getCodCdedCel() {
		return codCdedCel;
	}
	public void setCodCdedCel(long codCdedCel) {
		this.codCdedCel = codCdedCel;
	}
	public long getCodCdedTrek() {
		return codCdedTrek;
	}
	public void setCodCdedTrek(long codCdedTrek) {
		this.codCdedTrek = codCdedTrek;
	}
	public long getCodCdedTrunk() {
		return codCdedTrunk;
	}
	public void setCodCdedTrunk(long codCdedTrunk) {
		this.codCdedTrunk = codCdedTrunk;
	}
	public long getCodCheque() {
		return codCheque;
	}
	public void setCodCheque(long codCheque) {
		this.codCheque = codCheque;
	}
	public long getCodCniveQBeep() {
		return codCniveQBeep;
	}
	public void setCodCniveQBeep(long codCniveQBeep) {
		this.codCniveQBeep = codCniveQBeep;
	}
	public long getCodCNiveQBeep() {
		return codCNiveQBeep;
	}
	public void setCodCNiveQBeep(long codCNiveQBeep) {
		this.codCNiveQBeep = codCNiveQBeep;
	}
	public long getCodCniveQCel() {
		return codCniveQCel;
	}
	public void setCodCniveQCel(long codCniveQCel) {
		this.codCniveQCel = codCniveQCel;
	}
	public long getCodCNiveQTrek() {
		return codCNiveQTrek;
	}
	public void setCodCNiveQTrek(long codCNiveQTrek) {
		this.codCNiveQTrek = codCNiveQTrek;
	}
	public long getCodCniveQTrunk() {
		return codCniveQTrunk;
	}
	public void setCodCniveQTrunk(long codCniveQTrunk) {
		this.codCniveQTrunk = codCniveQTrunk;
	}
	public long getCodCnivQcel() {
		return codCnivQcel;
	}
	public void setCodCnivQcel(long codCnivQcel) {
		this.codCnivQcel = codCnivQcel;
	}
	public int getCodCredito() {
		return codCredito;
	}
	public void setCodCredito(int codCredito) {
		this.codCredito = codCredito;
	}
	public String getCodCSerBeep() {
		return codCSerBeep;
	}
	public void setCodCSerBeep(String codCSerBeep) {
		this.codCSerBeep = codCSerBeep;
	}
	public String getCodCSerCel() {
		return codCSerCel;
	}
	public void setCodCSerCel(String codCSerCel) {
		this.codCSerCel = codCSerCel;
	}
	public String getCodCSerTrek() {
		return codCSerTrek;
	}
	public void setCodCSerTrek(String codCSerTrek) {
		this.codCSerTrek = codCSerTrek;
	}
	public String getCodCSerTrunk() {
		return codCSerTrunk;
	}
	public void setCodCSerTrunk(String codCSerTrunk) {
		this.codCSerTrunk = codCSerTrunk;
	}
	public long getCodCtrasBeep() {
		return codCtrasBeep;
	}
	public void setCodCtrasBeep(long codCtrasBeep) {
		this.codCtrasBeep = codCtrasBeep;
	}
	public long getCodCtrasCel() {
		return codCtrasCel;
	}
	public void setCodCtrasCel(long codCtrasCel) {
		this.codCtrasCel = codCtrasCel;
	}
	public long getCodCtrasTrek() {
		return codCtrasTrek;
	}
	public void setCodCtrasTrek(long codCtrasTrek) {
		this.codCtrasTrek = codCtrasTrek;
	}
	public long getCodCtrasTrunk() {
		return codCtrasTrunk;
	}
	public void setCodCtrasTrunk(long codCtrasTrunk) {
		this.codCtrasTrunk = codCtrasTrunk;
	}
	public String getCodDetBeep() {
		return codDetBeep;
	}
	public void setCodDetBeep(String codDetBeep) {
		this.codDetBeep = codDetBeep;
	}
	public String getCodDetCel() {
		return codDetCel;
	}
	public void setCodDetCel(String codDetCel) {
		this.codDetCel = codDetCel;
	}
	public String getCodDetTrek() {
		return codDetTrek;
	}
	public void setCodDetTrek(String codDetTrek) {
		this.codDetTrek = codDetTrek;
	}
	public String getCodDiasEspBeep() {
		return codDiasEspBeep;
	}
	public void setCodDiasEspBeep(String codDiasEspBeep) {
		this.codDiasEspBeep = codDiasEspBeep;
	}
	public String getCodDiasEspCel() {
		return codDiasEspCel;
	}
	public void setCodDiasEspCel(String codDiasEspCel) {
		this.codDiasEspCel = codDiasEspCel;
	}
	public String getCodDiasEspTrek() {
		return codDiasEspTrek;
	}
	public void setCodDiasEspTrek(String codDiasEspTrek) {
		this.codDiasEspTrek = codDiasEspTrek;
	}
	public long getCodDocAnex() {
		return codDocAnex;
	}
	public void setCodDocAnex(long codDocAnex) {
		this.codDocAnex = codDocAnex;
	}
	public long getCodDocFact() {
		return codDocFact;
	}
	public void setCodDocFact(long codDocFact) {
		this.codDocFact = codDocFact;
	}
	public long getCodDocGuia() {
		return codDocGuia;
	}
	public void setCodDocGuia(long codDocGuia) {
		this.codDocGuia = codDocGuia;
	}
	public String getCodEstCobros() {
		return codEstCobros;
	}
	public void setCodEstCobros(String codEstCobros) {
		this.codEstCobros = codEstCobros;
	}
	public long getCodEstNuevo() {
		return codEstNuevo;
	}
	public void setCodEstNuevo(long codEstNuevo) {
		this.codEstNuevo = codEstNuevo;
	}
	public int getCodEstUsado() {
		return codEstUsado;
	}
	public void setCodEstUsado(int codEstUsado) {
		this.codEstUsado = codEstUsado;
	}
	public String getCodFyfCel() {
		return codFyfCel;
	}
	public void setCodFyfCel(String codFyfCel) {
		this.codFyfCel = codFyfCel;
	}
	public String getCodGrp1() {
		return codGrp1;
	}
	public void setCodGrp1(String codGrp1) {
		this.codGrp1 = codGrp1;
	}
	public String getCodGrp2() {
		return codGrp2;
	}
	public void setCodGrp2(String codGrp2) {
		this.codGrp2 = codGrp2;
	}
	public int getCodLeasing() {
		return codLeasing;
	}
	public void setCodLeasing(int codLeasing) {
		this.codLeasing = codLeasing;
	}
	public String getCodMonedaDef() {
		return codMonedaDef;
	}
	public void setCodMonedaDef(String codMonedaDef) {
		this.codMonedaDef = codMonedaDef;
	}
	public String getCodSerConexBeep() {
		return codSerConexBeep;
	}
	public void setCodSerConexBeep(String codSerConexBeep) {
		this.codSerConexBeep = codSerConexBeep;
	}
	public String getCodSerConExcel() {
		return codSerConExcel;
	}
	public void setCodSerConExcel(String codSerConExcel) {
		this.codSerConExcel = codSerConExcel;
	}
	public String getCodSerConexTrek() {
		return codSerConexTrek;
	}
	public void setCodSerConexTrek(String codSerConexTrek) {
		this.codSerConexTrek = codSerConexTrek;
	}
	public String getCodSerConexTrunk() {
		return codSerConexTrunk;
	}
	public void setCodSerConexTrunk(String codSerConexTrunk) {
		this.codSerConexTrunk = codSerConexTrunk;
	}
	public long getCodSisPagB() {
		return codSisPagB;
	}
	public void setCodSisPagB(long codSisPagB) {
		this.codSisPagB = codSisPagB;
	}
	public long getCodSisPagT() {
		return codSisPagT;
	}
	public void setCodSisPagT(long codSisPagT) {
		this.codSisPagT = codSisPagT;
	}
	public long getCodTarj() {
		return codTarj;
	}
	public void setCodTarj(long codTarj) {
		this.codTarj = codTarj;
	}
	public String getCodTipDiaBeep() {
		return codTipDiaBeep;
	}
	public void setCodTipDiaBeep(String codTipDiaBeep) {
		this.codTipDiaBeep = codTipDiaBeep;
	}
	public String getCodTipDiaCel() {
		return codTipDiaCel;
	}
	public void setCodTipDiaCel(String codTipDiaCel) {
		this.codTipDiaCel = codTipDiaCel;
	}
	public String getCodTipDiaTrek() {
		return codTipDiaTrek;
	}
	public void setCodTipDiaTrek(String codTipDiaTrek) {
		this.codTipDiaTrek = codTipDiaTrek;
	}
	public int getCodUsoGrp() {
		return codUsoGrp;
	}
	public void setCodUsoGrp(int codUsoGrp) {
		this.codUsoGrp = codUsoGrp;
	}
	public long getCodUsoSegNum() {
		return codUsoSegNum;
	}
	public void setCodUsoSegNum(long codUsoSegNum) {
		this.codUsoSegNum = codUsoSegNum;
	}
	public long getNumDiasEsp() {
		return numDiasEsp;
	}
	public void setNumDiasEsp(long numDiasEsp) {
		this.numDiasEsp = numDiasEsp;
	}
	public long getNumDiasLiq() {
		return numDiasLiq;
	}
	public void setNumDiasLiq(long numDiasLiq) {
		this.numDiasLiq = numDiasLiq;
	}
	public long getNumDiasReUtil() {
		return numDiasReUtil;
	}
	public void setNumDiasReUtil(long numDiasReUtil) {
		this.numDiasReUtil = numDiasReUtil;
	}
	public long getNumLinaNex() {
		return numLinaNex;
	}
	public void setNumLinaNex(long numLinaNex) {
		this.numLinaNex = numLinaNex;
	}
	public long getNumResNum() {
		return numResNum;
	}
	public void setNumResNum(long numResNum) {
		this.numResNum = numResNum;
	}
	public long getNumTelesp() {
		return numTelesp;
	}
	public void setNumTelesp(long numTelesp) {
		this.numTelesp = numTelesp;
	}
	public String getPathReport() {
		return pathReport;
	}
	public void setPathReport(String pathReport) {
		this.pathReport = pathReport;
	}
	public String getTipAlfa() {
		return tipAlfa;
	}
	public void setTipAlfa(String tipAlfa) {
		this.tipAlfa = tipAlfa;
	}
	public String getTipAnalog() {
		return tipAnalog;
	}
	public void setTipAnalog(String tipAnalog) {
		this.tipAnalog = tipAnalog;
	}
	public int getTipDeducible() {
		return tipDeducible;
	}
	public void setTipDeducible(int tipDeducible) {
		this.tipDeducible = tipDeducible;
	}
	public String getTipDigital() {
		return tipDigital;
	}
	public void setTipDigital(String tipDigital) {
		this.tipDigital = tipDigital;
	}
	public String getTipFijo() {
		return tipFijo;
	}
	public void setTipFijo(String tipFijo) {
		this.tipFijo = tipFijo;
	}
	public int getTipLocal() {
		return tipLocal;
	}
	public void setTipLocal(int tipLocal) {
		this.tipLocal = tipLocal;
	}
	public long getTipMovDesRes() {
		return tipMovDesRes;
	}
	public void setTipMovDesRes(long tipMovDesRes) {
		this.tipMovDesRes = tipMovDesRes;
	}
	public long getTipMovDevCl() {
		return tipMovDevCl;
	}
	public void setTipMovDevCl(long tipMovDevCl) {
		this.tipMovDevCl = tipMovDevCl;
	}
	public long getTipMovEntt() {
		return tipMovEntt;
	}
	public void setTipMovEntt(long tipMovEntt) {
		this.tipMovEntt = tipMovEntt;
	}
	public String getTipMovil() {
		return tipMovil;
	}
	public void setTipMovil(String tipMovil) {
		this.tipMovil = tipMovil;
	}
	public long getTipMovRes() {
		return tipMovRes;
	}
	public void setTipMovRes(long tipMovRes) {
		this.tipMovRes = tipMovRes;
	}
	public long getTipMovSalDa() {
		return tipMovSalDa;
	}
	public void setTipMovSalDa(long tipMovSalDa) {
		this.tipMovSalDa = tipMovSalDa;
	}
	public long getTipMovSalDn() {
		return tipMovSalDn;
	}
	public void setTipMovSalDn(long tipMovSalDn) {
		this.tipMovSalDn = tipMovSalDn;
	}
	public long getTipMovSalDs() {
		return tipMovSalDs;
	}
	public void setTipMovSalDs(long tipMovSalDs) {
		this.tipMovSalDs = tipMovSalDs;
	}
	public long getTipMovSalt() {
		return tipMovSalt;
	}
	public void setTipMovSalt(long tipMovSalt) {
		this.tipMovSalt = tipMovSalt;
	}
	public String getTipNum() {
		return tipNum;
	}
	public void setTipNum(String tipNum) {
		this.tipNum = tipNum;
	}
	public String getTipTono() {
		return tipTono;
	}
	public void setTipTono(String tipTono) {
		this.tipTono = tipTono;
	}
	/**
	 * @return String the codActCen
	 */
	public String getCodActCen() {
		return codActCen;
	}
	/**
	 * @param codActCen String the codActCen to set
	 */
	public void setCodActCen(String codActCen) {
		this.codActCen = codActCen;
	}
	/**
	 * @return String the codActAbo
	 */
	public String getCodActAbo() {
		return codActAbo;
	}
	/**
	 * @param codActAbo String the codActAbo to set
	 */
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	/**
	 * @return String the codTecnologia
	 */
	public String getCodTecnologia() {
		return codTecnologia;
	}
	/**
	 * @param codTecnologia String the codTecnologia to set
	 */
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public Timestamp getFechaSistema() {
		return fechaSistema;
	}
	public void setFechaSistema(Timestamp fechaSistema) {
		this.fechaSistema = fechaSistema;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}
	public String getDesParametro() {
		return desParametro;
	}
	public void setDesParametro(String desParametro) {
		this.desParametro = desParametro;
	}
	public Timestamp getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Timestamp fecAlta) {
		this.fecAlta = fecAlta;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNomParametro() {
		return nomParametro;
	}
	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}
	public String getValParametro() {
		return valParametro;
	}
	public void setValParametro(String valParametro) {
		this.valParametro = valParametro;
	}
	public Long getNroSecuencia() {
		return nroSecuencia;
	}
	public void setNroSecuencia(Long nroSecuencia) {
		this.nroSecuencia = nroSecuencia;
	}
	public String getNombreSecuencia() {
		return nombreSecuencia;
	}
	public void setNombreSecuencia(String nombreSecuencia) {
		this.nombreSecuencia = nombreSecuencia;
	}
	/**
	 * @return String the formatoFecha 
	 */
	public String getFormatoFecha() {
		return formatoFecha;
	}
	/**
	 * @param formatoFecha String the formatoFecha to set
	 */
	public void setFormatoFecha(String formatoFecha) {
		this.formatoFecha = formatoFecha;
	}
	/**
	 * @return String the formatoHora 
	 */
	public String getFormatoHora() {
		return formatoHora;
	}
	/**
	 * @param formatoHora String the formatoHora to set
	 */
	public void setFormatoHora(String formatoHora) {
		this.formatoHora = formatoHora;
	}
	/**
	 * @return long the codContado 
	 */
	public long getCodContado() {
		return codContado;
	}
	/**
	 * @param codContado long the codContado to set
	 */
	public void setCodContado(long codContado) {
		this.codContado = codContado;
	}
	/**
	 * @return String the sTipTerminalGSM 
	 */
	public String getSTipTerminalGSM() {
		return sTipTerminalGSM;
	}
	/**
	 * @param sTipTerminalGSM String the sTipTerminalGSM to set
	 */
	public void setSTipTerminalGSM(String tipTerminal) {
		this.sTipTerminalGSM = tipTerminal;
	}
	/**
	 * @return String the sTipTermSimc 
	 */
	public String getSTipTermSimc() {
		return sTipTermSimc;
	}
	/**
	 * @param tipTermSimc String the sTipTermSimc to set
	 */
	public void setSTipTermSimc(String tipTermSimc) {
		sTipTermSimc = tipTermSimc;
	}
	/**
	 * @return int the codCartaGarant 
	 */
	public int getCodCartaGarant() {
		return codCartaGarant;
	}
	/**
	 * @param codCartaGarant int the codCartaGarant to set
	 */
	public void setCodCartaGarant(int codCartaGarant) {
		this.codCartaGarant = codCartaGarant;
	}
	/**
	 * @return int the codUsoControlada 
	 */
	public int getCodUsoControlada() {
		return codUsoControlada;
	}
	/**
	 * @param codUsoControlada int the codUsoControlada to set
	 */
	public void setCodUsoControlada(int codUsoControlada) {
		this.codUsoControlada = codUsoControlada;
	}
	/**
	 * @return String the codProcesoNoComerciales 
	 */
	public String getCodProcesoNoComerciales() {
		return codProcesoNoComerciales;
	}
	/**
	 * @param codProcesoNoComerciales String the codProcesoNoComerciales to set
	 */
	public void setCodProcesoNoComerciales(String codProceso) {
		this.codProcesoNoComerciales = codProceso;
	}
	/**
	 * @return String the nomPerfilProceso 
	 */
	public String getNomPerfilProceso() {
		return nomPerfilProceso;
	}
	/**
	 * @param nomPerfilProceso String the nomPerfilProceso to set
	 */
	public void setNomPerfilProceso(String nomPerfilProceso) {
		this.nomPerfilProceso = nomPerfilProceso;
	}
	/**
	 * @return boolean the permisoEjecucion 
	 */
	public boolean isPermisoEjecucion() {
		return permisoEjecucion;
	}
	/**
	 * @param permisoEjecucion boolean the permisoEjecucion to set
	 */
	public void setPermisoEjecucion(boolean permisoEjecucion) {
		this.permisoEjecucion = permisoEjecucion;
	}
	/**
	 * @return int the codCentremi 
	 */
	public int getCodCentremi() {
		return codCentremi;
	}
	/**
	 * @param codCentremi int the codCentremi to set
	 */
	public void setCodCentremi(int codCentremi) {
		this.codCentremi = codCentremi;
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
	 * @return int the codTipdocum 
	 */
	public int getCodTipdocum() {
		return codTipdocum;
	}
	/**
	 * @param codTipdocum int the codTipdocum to set
	 */
	public void setCodTipdocum(int codTipdocum) {
		this.codTipdocum = codTipdocum;
	}
	
	
}
