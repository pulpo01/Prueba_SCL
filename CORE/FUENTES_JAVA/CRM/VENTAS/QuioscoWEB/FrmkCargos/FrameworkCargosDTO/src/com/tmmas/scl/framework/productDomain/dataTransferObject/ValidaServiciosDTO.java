/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ValidaServiciosDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numMovimiento;
	private String codActAbo;
	private int codProducto;
	private String codTecnologia;
	private int tipPantalla;
	private int codConcepto;
	private String codModulo;
	private String codPlanTarifNue;
	private String codPlanTarifAnt;
	private int tipAbonado;
	private String codOS;
	private long codCliente;
	private long numAbonado;
	private int indFactur;
	private String codPlanServ;
	private String codOperacion;
	private String codTipContrato;
	private String tipCelular;
	private int numMeses;
	private String codAntiguedad;
	private int codCiclo;
	private long numCelular;
	private int tipServicio;
	private int codPlanCom;
	private String param1Mens;
	private String param2Mens;
	private String param3Mens;
	private int codArticulo;
	private String codCausa;
	private String codCausaNue;
	private int codVend;
	private String codCategoria;
	private int codModVenta;
	private String codCausinie;
	
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodAntiguedad() {
		return codAntiguedad;
	}
	public void setCodAntiguedad(String codAntiguedad) {
		this.codAntiguedad = codAntiguedad;
	}
	public int getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(int codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public String getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}
	public String getCodCausaNue() {
		return codCausaNue;
	}
	public void setCodCausaNue(String codCausaNue) {
		this.codCausaNue = codCausaNue;
	}
	public String getCodCausinie() {
		return codCausinie;
	}
	public void setCodCausinie(String codCausinie) {
		this.codCausinie = codCausinie;
	}
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public int getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(int codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public int getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(int codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getCodOperacion() {
		return codOperacion;
	}
	public void setCodOperacion(String codOperacion) {
		this.codOperacion = codOperacion;
	}
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public int getCodPlanCom() {
		return codPlanCom;
	}
	public void setCodPlanCom(int codPlanCom) {
		this.codPlanCom = codPlanCom;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodPlanTarifAnt() {
		return codPlanTarifAnt;
	}
	public void setCodPlanTarifAnt(String codPlanTarifAnt) {
		this.codPlanTarifAnt = codPlanTarifAnt;
	}
	public String getCodPlanTarifNue() {
		return codPlanTarifNue;
	}
	public void setCodPlanTarifNue(String codPlanTarifNue) {
		this.codPlanTarifNue = codPlanTarifNue;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
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
	public int getCodVend() {
		return codVend;
	}
	public void setCodVend(int codVend) {
		this.codVend = codVend;
	}
	public int getIndFactur() {
		return indFactur;
	}
	public void setIndFactur(int indFactur) {
		this.indFactur = indFactur;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public int getNumMeses() {
		return numMeses;
	}
	public void setNumMeses(int numMeses) {
		this.numMeses = numMeses;
	}
	public long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public String getParam1Mens() {
		return param1Mens;
	}
	public void setParam1Mens(String param1Mens) {
		this.param1Mens = param1Mens;
	}
	public String getParam2Mens() {
		return param2Mens;
	}
	public void setParam2Mens(String param2Mens) {
		this.param2Mens = param2Mens;
	}
	public String getParam3Mens() {
		return param3Mens;
	}
	public void setParam3Mens(String param3Mens) {
		this.param3Mens = param3Mens;
	}
	public int getTipAbonado() {
		return tipAbonado;
	}
	public void setTipAbonado(int tipAbonado) {
		this.tipAbonado = tipAbonado;
	}
	public String getTipCelular() {
		return tipCelular;
	}
	public void setTipCelular(String tipCelular) {
		this.tipCelular = tipCelular;
	}
	public int getTipPantalla() {
		return tipPantalla;
	}
	public void setTipPantalla(int tipPantalla) {
		this.tipPantalla = tipPantalla;
	}
	public int getTipServicio() {
		return tipServicio;
	}
	public void setTipServicio(int tipServicio) {
		this.tipServicio = tipServicio;
	}


}
