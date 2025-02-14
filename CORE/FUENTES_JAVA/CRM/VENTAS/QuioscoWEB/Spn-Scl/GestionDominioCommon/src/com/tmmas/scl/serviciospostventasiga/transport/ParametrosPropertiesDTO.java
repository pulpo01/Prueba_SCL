package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class ParametrosPropertiesDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String codCatTribut;
	private String tipPlantarif;
	private String tipTerminal;
	private String codSituacion;
	private String numSerieHex;
	private String codigoEstado;
	private String CodEstadoSimcard; //OOSS.Migracion.prepago.postpago.CodEstadoSimcard
	private Integer indSuperTel;
	private Integer indPrepago;
	private Integer indPlexSys;
	private Integer numPerContrato;
	private String indProcEqSimcard;
	private String equipoSimcard;
	private String equipoTerminal;
	private String codTipContrato;
	private Integer indSuspen;
	private Integer indReHabi;
	private Integer insGuias;
	private String indEqPrestadoTerminal;
	private String indEqPrestadoSimcard;
	private Integer codCuota;
	private String codTecnologia;
	private String CodEstadoTerminal;
	private String IndProcAlta;
	private String indPropiedad;     //OOSS.Migracion.prepago.postpago.IndPropiedad
	private String tipStock;         //OOSS.Migracion.prepago.postpago.TipStock
	private String indEquiacc;       //OOSS.Migracion.prepago.postpago.IndEquiacc
	private String indEstVenta;      //OOSS.Migracion.prepago.postpago.IndEstVenta
	private String codMoneda;        //OOSS.Migracion.prepago.postpago.CodMoneda
	private String tipFoliacion;     //OOSS.Migracion.prepago.postpago.TipFoliacion
	private String codOperadora;     //OOSS.Migracion.prepago.postpago.codoperadora
	private String codTipDocum;      //OOSS.Migracion.prepago.postpago.codTipDocum
	private String indFactur;        //MPP.Nombre.Parametro.indfactur
	private String codModVenta;      //MPP.Nombre.Parametro.codmodventa
	private String codBodega;        //MPP.Nombre.Parametro.codBodega
	private String codArtSim;        //MPP.Nombre.Parametro.codArtSim
	private String desArtSim;        //MPP.Nombre.Parametro.desArtSim
	private String codIndemnizacion; //MPP.Nombre.Parametro.codIndemnizacion
	private String carga;			 //MPP.Nombre.Parametro.carga
	private String codModulo;        //OOSS.Migracion.prepago.postpago.codModulo
	private String codProducto;      //OOSS.Migracion.prepago.postpago.codProducto
	private String ParametroBaja;    //MPP.Nombre.ParametroBaja
	private String codPlanServ;		 //OOSS.Migracion.prepago.postpago.codPlanServ
	private String tipVenta;         //OOSS.Migracion.prepago.postpago.tipVenta
	private String codGrpServ;	     //OOSS.Migracion.prepago.postpago.codGrpServ
	private String chkDicom;         //OOSS.Migracion.prepago.postpago.chkDicom
	
	private String actaboBajaPrepago; //OOSS.Migracion.prepago.postpago.actabo.baja.prepago
	private String actaboAltaHibrido; //OOSS.Migracion.prepago.postpago.actabo.alta.hibrido
	private String actaboAltaPospago; //OOSS.Migracion.prepago.postpago.actabo.alta.postpago
	private String tipInter;          //OOSS.Migracion.prepago.postpago.tipInter
	
	private String codOOSS;	         //OOSS.Migracion.prepago.postpago.codOOSS
	private String comentario;       //OOSS.Migracion.prepago.postpago.comentario
	
	public String getChkDicom() {
		return chkDicom;
	}
	public void setChkDicom(String chkDicom) {
		this.chkDicom = chkDicom;
	}
	public String getTipVenta() {
		return tipVenta;
	}
	public void setTipVenta(String tipVenta) {
		this.tipVenta = tipVenta;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getParametroBaja() {
		return ParametroBaja;
	}
	public void setParametroBaja(String parametroBaja) {
		ParametroBaja = parametroBaja;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getIndEquiacc() {
		return indEquiacc;
	}
	public void setIndEquiacc(String indEquiacc) {
		this.indEquiacc = indEquiacc;
	}
	public String getTipStock() {
		return tipStock;
	}
	public void setTipStock(String tipStock) {
		this.tipStock = tipStock;
	}
	public Integer getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(Integer codCuota) {
		this.codCuota = codCuota;
	}
	public String getCodigoEstado() {
		return codigoEstado;
	}
	public void setCodigoEstado(String codigoEstado) {
		this.codigoEstado = codigoEstado;
	}
	public String getCodSituacion() {
		return codSituacion;
	}
	public void setCodSituacion(String codSituacion) {
		this.codSituacion = codSituacion;
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
	public String getEquipoSimcard() {
		return equipoSimcard;
	}
	public void setEquipoSimcard(String equipoSimcard) {
		this.equipoSimcard = equipoSimcard;
	}
	public String getEquipoTerminal() {
		return equipoTerminal;
	}
	public void setEquipoTerminal(String equipoTerminal) {
		this.equipoTerminal = equipoTerminal;
	}
	public String getIndEqPrestadoSimcard() {
		return indEqPrestadoSimcard;
	}
	public void setIndEqPrestadoSimcard(String indEqPrestadoSimcard) {
		this.indEqPrestadoSimcard = indEqPrestadoSimcard;
	}
	public String getIndEqPrestadoTerminal() {
		return indEqPrestadoTerminal;
	}
	public void setIndEqPrestadoTerminal(String indEqPrestadoTerminal) {
		this.indEqPrestadoTerminal = indEqPrestadoTerminal;
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
	public String getIndProcEqSimcard() {
		return indProcEqSimcard;
	}
	public void setIndProcEqSimcard(String indProcEqSimcard) {
		this.indProcEqSimcard = indProcEqSimcard;
	}
	public Integer getIndReHabi() {
		return indReHabi;
	}
	public void setIndReHabi(Integer indReHabi) {
		this.indReHabi = indReHabi;
	}
	public Integer getIndSuperTel() {
		return indSuperTel;
	}
	public void setIndSuperTel(Integer indSuperTel) {
		this.indSuperTel = indSuperTel;
	}
	public Integer getIndSuspen() {
		return indSuspen;
	}
	public void setIndSuspen(Integer indSuspen) {
		this.indSuspen = indSuspen;
	}
	public Integer getInsGuias() {
		return insGuias;
	}
	public void setInsGuias(Integer insGuias) {
		this.insGuias = insGuias;
	}
	public Integer getNumPerContrato() {
		return numPerContrato;
	}
	public void setNumPerContrato(Integer numPerContrato) {
		this.numPerContrato = numPerContrato;
	}
	public String getNumSerieHex() {
		return numSerieHex;
	}
	public void setNumSerieHex(String numSerieHex) {
		this.numSerieHex = numSerieHex;
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
	public String getCodEstadoSimcard() {
		return CodEstadoSimcard;
	}
	public void setCodEstadoSimcard(String codEstadoSimcard) {
		CodEstadoSimcard = codEstadoSimcard;
	}
	public String getCodEstadoTerminal() {
		return CodEstadoTerminal;
	}
	public void setCodEstadoTerminal(String codEstadoTerminal) {
		CodEstadoTerminal = codEstadoTerminal;
	}
	public String getIndPropiedad() {
		return indPropiedad;
	}
	public void setIndPropiedad(String indPropiedad) {
		this.indPropiedad = indPropiedad;
	}
	public String getIndProcAlta() {
		return IndProcAlta;
	}
	public void setIndProcAlta(String indProcAlta) {
		IndProcAlta = indProcAlta;
	}
	public String getIndEstVenta() {
		return indEstVenta;
	}
	public void setIndEstVenta(String indEstVenta) {
		this.indEstVenta = indEstVenta;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getTipFoliacion() {
		return tipFoliacion;
	}
	public void setTipFoliacion(String tipFoliacion) {
		this.tipFoliacion = tipFoliacion;
	}
	public String getCodOperadora() {
		return codOperadora;
	}
	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}
	public String getCodTipDocum() {
		return codTipDocum;
	}
	public void setCodTipDocum(String codTipDocum) {
		this.codTipDocum = codTipDocum;
	}
	public String getCodArtSim() {
		return codArtSim;
	}
	public void setCodArtSim(String codArtSim) {
		this.codArtSim = codArtSim;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(String codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getDesArtSim() {
		return desArtSim;
	}
	public void setDesArtSim(String desArtSim) {
		this.desArtSim = desArtSim;
	}
	public String getIndFactur() {
		return indFactur;
	}
	public void setIndFactur(String indFactur) {
		this.indFactur = indFactur;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodGrpServ() {
		return codGrpServ;
	}
	public void setCodGrpServ(String codGrpServ) {
		this.codGrpServ = codGrpServ;
	}
	public String getActaboAltaHibrido() {
		return actaboAltaHibrido;
	}
	public void setActaboAltaHibrido(String actaboAltaHibrido) {
		this.actaboAltaHibrido = actaboAltaHibrido;
	}
	public String getActaboAltaPospago() {
		return actaboAltaPospago;
	}
	public void setActaboAltaPospago(String actaboAltaPospago) {
		this.actaboAltaPospago = actaboAltaPospago;
	}
	public String getActaboBajaPrepago() {
		return actaboBajaPrepago;
	}
	public void setActaboBajaPrepago(String actaboBajaPrepago) {
		this.actaboBajaPrepago = actaboBajaPrepago;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getTipInter() {
		return tipInter;
	}
	public void setTipInter(String tipInter) {
		this.tipInter = tipInter;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public String getCodIndemnizacion() {
		return codIndemnizacion;
	}
	public void setCodIndemnizacion(String codIndemnizacion) {
		this.codIndemnizacion = codIndemnizacion;
	}
	public String getCarga() {
		return carga;
	}
	public void setCarga(String carga) {
		this.carga = carga;
	}
	public String getCodCatTribut() {
		return codCatTribut;
	}
	public void setCodCatTribut(String codCatTribut) {
		this.codCatTribut = codCatTribut;
	}
	
	
}
