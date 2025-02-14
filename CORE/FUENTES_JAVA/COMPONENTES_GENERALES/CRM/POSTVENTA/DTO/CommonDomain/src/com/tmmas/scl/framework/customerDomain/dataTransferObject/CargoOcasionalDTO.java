package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoListDTO;

public class CargoOcasionalDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String seqCargo;
	private String codCliente;
	private String numAbonado;
	private String codProdContratado;
	private String idCargo;
	private String codConcepto;
	private String columna;
	private Date fecAlta;
	private String impCargo;
	private String codMoneda;
	private String codPlanCom;
	private String numUnidades;
	private String indFactur;
	private String numTransaccion;
	private String numVenta;
	private String numPaquete;
	private String numTerminal;
	private String codCiclFact;
	private String numSerie;
	private String numSerieMec;
	private String capCode;
	private String mesGarantia;
	private String numPreguia;
	private String numGuia;
	private String codConcerel;
	private String columnaRel;	
	private String codConceptoDescuento;
	private String valDescuento;
	private String tipDescuento;
	private String indCuota;
	private String numCuotas;
	private String ordCuota;
	private String indSupertel;
	private String indManual;
	private String prefPlaza;
	private String codTecnologia;
	private String glsDescrip;
	private String numFactura;
	private Date   fecUltMod;
	private String nomUsuario;
	
	DescuentoProductoListDTO descuentos;
	
	/**
 SEQ_CARGO         	NUMBER  (9)
,COD_CLIENTE            NUMBER  (10)
,NUM_ABONADO            NUMBER  (10)
,COD_PROD_CONTRATADO    NUMBER  (9)
,COD_PRODUCTO	        NUMBER  (1)
,ID_CARGO               NUMBER  (9)
,COD_CONCEPTO           NUMBER  (9)
,COLUMNA                NUMBER  (6)
,FEC_ALTA               DATE
,IMP_CARGO              NUMBER  (14,4)
,COD_MONEDA             VARCHAR2(3)
,COD_PLANCOM            NUMBER  (6)
,NUM_UNIDADES           NUMBER  (6)
,IND_FACTUR             NUMBER  (1)
,NUM_TRANSACCION        NUMBER  (9)
,NUM_VENTA              NUMBER  (8)
,NUM_PAQUETE            NUMBER  (3)
,NUM_TERMINAL           VARCHAR2(15)
,COD_CICLFACT           NUMBER  (6)
,NUM_SERIE              VARCHAR2 (25)
,NUM_SERIEMEC           VARCHAR2 (20)
,CAP_CODE               NUMBER  (7)
,MES_GARANTIA           NUMBER  (2)
,NUM_PREGUIA            VARCHAR2 (10)
,NUM_GUIA               VARCHAR2 (10)
,COD_CONCEREL           NUMBER  (8)
,COLUMNA_REL            NUMBER  (4)
,COD_CONCEPTO_DTO  		NUMBER(4)
,VAL_DTO           		NUMBER(14,4)
,TIP_DTO                NUMBER  (1)
,IND_CUOTA              NUMBER  (1)
,NUM_CUOTAS             NUMBER  (3)
,ORD_CUOTA              NUMBER  (3)
,IND_SUPERTEL           NUMBER  (1)
,IND_MANUAL             NUMBER  (1)
,PREF_PLAZA             VARCHAR2 (10)
,COD_TECNOLOGIA         VARCHAR2 (7)
,GLS_DESCRIP            VARCHAR2 (100)
,NUM_FACTURA            NUMBER  (10)
,FEC_ULTMOD             DATE
,NOM_USUARIO            VARCHAR2 (30)

	 */
	
	public Object[] toStruct_FA_CARGOS_QT()
	{
		Object[] obj={	 seqCargo,
						 codCliente,
						 numAbonado,
						 codProdContratado,
						 null,
						 idCargo,
						 codConcepto,
						 columna,
						 fecAlta!=null?(new Timestamp(fecAlta.getTime())):null,
						 impCargo,
						 codMoneda,
						 codPlanCom,
						 numUnidades,
						 indFactur,
						 numTransaccion,
						 numVenta,
						 numPaquete,
						 numTerminal,
						 codCiclFact,
						 numSerie,
						 numSerieMec,
						 capCode,
						 mesGarantia,
						 numPreguia,
						 numGuia,
						 codConcerel,
						 columnaRel,	
						 codConceptoDescuento,
						 valDescuento,
						 (tipDescuento!=null && "M".equals(tipDescuento))?"0":"1",
						 indCuota,
						 numCuotas,
						 ordCuota,
						 indSupertel,
						 indManual,
						 prefPlaza,
						 codTecnologia,
						 glsDescrip,
						 numFactura,
						 fecUltMod!=null?new Timestamp(fecUltMod.getTime()):null,
						 nomUsuario				
					 };		
		return obj;
	}
	
	
	
	public CargoOcasionalDTO()
	{
		this.fecAlta=new Date();
		this.fecUltMod=new Date();
	}
	
	
	
	public DescuentoProductoListDTO getDescuentos() {
		return descuentos;
	}



	public void setDescuentos(DescuentoProductoListDTO descuentos) {
		this.descuentos = descuentos;
	}



	public String getCapCode() {
		return capCode;
	}
	public void setCapCode(String capCode) {
		this.capCode = capCode;
	}
	public String getCodCiclFact() {
		return codCiclFact;
	}
	public void setCodCiclFact(String codCiclFact) {
		this.codCiclFact = codCiclFact;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodConceptoDescuento() {
		return codConceptoDescuento;
	}
	public void setCodConceptoDescuento(String codConceptoDescuento) {
		this.codConceptoDescuento = codConceptoDescuento;
	}
	public String getCodConcerel() {
		return codConcerel;
	}
	public void setCodConcerel(String codConcerel) {
		this.codConcerel = codConcerel;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getCodPlanCom() {
		return codPlanCom;
	}
	public void setCodPlanCom(String codPlanCom) {
		this.codPlanCom = codPlanCom;
	}
	public String getCodProdContratado() {
		return codProdContratado;
	}
	public void setCodProdContratado(String codProdContratado) {
		this.codProdContratado = codProdContratado;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getColumna() {
		return columna;
	}
	public void setColumna(String columna) {
		this.columna = columna;
	}
	public String getColumnaRel() {
		return columnaRel;
	}
	public void setColumnaRel(String columnaRel) {
		this.columnaRel = columnaRel;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecUltMod() {
		return fecUltMod;
	}
	public void setFecUltMod(Date fecUltMod) {
		this.fecUltMod = fecUltMod;
	}
	public String getGlsDescrip() {
		return glsDescrip;
	}
	public void setGlsDescrip(String glsDescrip) {
		this.glsDescrip = glsDescrip;
	}
	public String getIdCargo() {
		return idCargo;
	}
	public void setIdCargo(String idCargo) {
		this.idCargo = idCargo;
	}
	public String getImpCargo() {
		return impCargo;
	}
	public void setImpCargo(String impCargo) {
		this.impCargo = impCargo;
	}
	public String getIndCuota() {
		return indCuota;
	}
	public void setIndCuota(String indCuota) {
		this.indCuota = indCuota;
	}
	public String getIndFactur() {
		return indFactur;
	}
	public void setIndFactur(String indFactur) {
		this.indFactur = indFactur;
	}
	public String getIndManual() {
		return indManual;
	}
	public void setIndManual(String indManual) {
		this.indManual = indManual;
	}
	public String getIndSupertel() {
		return indSupertel;
	}
	public void setIndSupertel(String indSupertel) {
		this.indSupertel = indSupertel;
	}
	public String getMesGarantia() {
		return mesGarantia;
	}
	public void setMesGarantia(String mesGarantia) {
		this.mesGarantia = mesGarantia;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumCuotas() {
		return numCuotas;
	}
	public void setNumCuotas(String numCuotas) {
		this.numCuotas = numCuotas;
	}
	public String getNumFactura() {
		return numFactura;
	}
	public void setNumFactura(String numFactura) {
		this.numFactura = numFactura;
	}
	public String getNumGuia() {
		return numGuia;
	}
	public void setNumGuia(String numGuia) {
		this.numGuia = numGuia;
	}
	public String getNumPaquete() {
		return numPaquete;
	}
	public void setNumPaquete(String numPaquete) {
		this.numPaquete = numPaquete;
	}
	public String getNumPreguia() {
		return numPreguia;
	}
	public void setNumPreguia(String numPreguia) {
		this.numPreguia = numPreguia;
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
	public String getNumTerminal() {
		return numTerminal;
	}
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public String getNumUnidades() {
		return numUnidades;
	}
	public void setNumUnidades(String numUnidades) {
		this.numUnidades = numUnidades;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	public String getOrdCuota() {
		return ordCuota;
	}
	public void setOrdCuota(String ordCuota) {
		this.ordCuota = ordCuota;
	}
	public String getPrefPlaza() {
		return prefPlaza;
	}
	public void setPrefPlaza(String prefPlaza) {
		this.prefPlaza = prefPlaza;
	}
	public String getSeqCargo() {
		return seqCargo;
	}
	public void setSeqCargo(String seqCargo) {
		this.seqCargo = seqCargo;
	}
	public String getTipDescuento() {
		return tipDescuento;
	}
	public void setTipDescuento(String tipDescuento) {
		this.tipDescuento = tipDescuento;
	}
	public String getValDescuento() {
		return valDescuento;
	}
	public void setValDescuento(String valDescuento) {
		this.valDescuento = valDescuento;
	}
}

