package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class CargoRecurrenteDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;	
	
	private String idClienteServ;
	private String idAbonadoServ;
	private String codProdContratado;
	private String codCargoContratado;
	private String codClientePago;
	private String numAbonadoPago;
	private String codTipServ;
	private String codServicio;
	private String codPlanServ;
	private String indCargoPro;
	private String codConcepto;
	private Date fecAlta;
	private Date fecBaja;
	private Date fecDesdeCobr;
	private Date fecHastaCobr;
	private String indBloqueo;
	private String estBloqueo;
	private Date fecDesdebloc;	
	private Date fecHastabloc;
	private Date fecUltFactura;
	private String codUltCiclFact;
	private String numUltProceso;
	private Date fecUltMod;
	private String nomUsuario;
	
	public Object[] toStruct_FA_CARGOS_REC_QT()
	{
		Object[] obj={	 idClienteServ,
						 idAbonadoServ,
						 codProdContratado,
						 codCargoContratado,
						 codClientePago,
						 numAbonadoPago,
						 codTipServ,
						 codServicio,
						 codPlanServ,
						 indCargoPro,
						 codConcepto,
						 fecAlta!=null?new Timestamp(fecAlta.getTime()):null,
						 fecBaja!=null?new Timestamp(fecBaja.getTime()):null,
						 fecDesdeCobr!=null?new Timestamp(fecDesdeCobr.getTime()):null,
						 fecHastaCobr!=null?new Timestamp(fecHastaCobr.getTime()):null,
						 indBloqueo,
						 estBloqueo,
						 fecDesdebloc!=null?new Timestamp(fecDesdebloc.getTime()):null,	
						 fecDesdebloc!=null?new Timestamp(fecHastabloc.getTime()):null,
						 fecUltFactura!=null?new Timestamp(fecUltFactura.getTime()):null,
						 codUltCiclFact,
						 numUltProceso,
						 fecUltMod!=null?new Timestamp(fecUltMod.getTime()):null,
						 nomUsuario				
					 };
		
		return obj;
	}
	
	public CargoRecurrenteDTO()
	{		
		fecAlta				=	new Date();
		fecDesdebloc		=	new Date();
		fecDesdeCobr		=	new Date();
		fecBaja				=	new Date();
		fecHastabloc		=	new Date();
		fecHastaCobr		=	new Date();
		fecUltFactura		=	new Date();
		fecUltMod			=	new Date();
	}
	
	public String getCodCargoContratado() {
		return codCargoContratado;
	}
	public void setCodCargoContratado(String codCargoContratado) {
		this.codCargoContratado = codCargoContratado;
	}
	public String getCodClientePago() {
		return codClientePago;
	}
	public void setCodClientePago(String codClientePago) {
		this.codClientePago = codClientePago;
	}
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodProdContratado() {
		return codProdContratado;
	}
	public void setCodProdContratado(String codProdContratado) {
		this.codProdContratado = codProdContratado;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getCodTipServ() {
		return codTipServ;
	}
	public void setCodTipServ(String codTipServ) {
		this.codTipServ = codTipServ;
	}
	public String getCodUltCiclFact() {
		return codUltCiclFact;
	}
	public void setCodUltCiclFact(String codUltCiclFact) {
		this.codUltCiclFact = codUltCiclFact;
	}
	public String getEstBloqueo() {
		return estBloqueo;
	}
	public void setEstBloqueo(String estBloqueo) {
		this.estBloqueo = estBloqueo;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecBaja() {
		return fecBaja;
	}
	public void setFecBaja(Date fecBaja) {
		this.fecBaja = fecBaja;
	}
	public Date getFecDesdebloc() {
		return fecDesdebloc;
	}
	public void setFecDesdebloc(Date fecDesdebloc) {
		this.fecDesdebloc = fecDesdebloc;
	}
	public Date getFecDesdeCobr() {
		return fecDesdeCobr;
	}
	public void setFecDesdeCobr(Date fecDesdeCobr) {
		this.fecDesdeCobr = fecDesdeCobr;
	}
	public Date getFecHastabloc() {
		return fecHastabloc;
	}
	public void setFecHastabloc(Date fecHastabloc) {
		this.fecHastabloc = fecHastabloc;
	}
	public Date getFecHastaCobr() {
		return fecHastaCobr;
	}
	public void setFecHastaCobr(Date fecHastaCobr) {
		this.fecHastaCobr = fecHastaCobr;
	}
	public Date getFecUltFactura() {
		return fecUltFactura;
	}
	public void setFecUltFactura(Date fecUltFactura) {
		this.fecUltFactura = fecUltFactura;
	}
	public Date getFecUltMod() {
		return fecUltMod;
	}
	public void setFecUltMod(Date fecUltMod) {
		this.fecUltMod = fecUltMod;
	}
	public String getIdAbonadoServ() {
		return idAbonadoServ;
	}
	public void setIdAbonadoServ(String idAbonadoServ) {
		this.idAbonadoServ = idAbonadoServ;
	}

	public String getIndCargoPro() {
		return indCargoPro;
	}

	public void setIndCargoPro(String indCargoPro) {
		this.indCargoPro = indCargoPro;
	}

	public String getIdClienteServ() {
		return idClienteServ;
	}
	public void setIdClienteServ(String idClienteServ) {
		this.idClienteServ = idClienteServ;
	}
	public String getIndBloqueo() {
		return indBloqueo;
	}
	public void setIndBloqueo(String indBloqueo) {
		this.indBloqueo = indBloqueo;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumAbonadoPago() {
		return numAbonadoPago;
	}
	public void setNumAbonadoPago(String numAbonadoPago) {
		this.numAbonadoPago = numAbonadoPago;
	}
	public String getNumUltProceso() {
		return numUltProceso;
	}
	public void setNumUltProceso(String numUltProceso) {
		this.numUltProceso = numUltProceso;
	}
}
