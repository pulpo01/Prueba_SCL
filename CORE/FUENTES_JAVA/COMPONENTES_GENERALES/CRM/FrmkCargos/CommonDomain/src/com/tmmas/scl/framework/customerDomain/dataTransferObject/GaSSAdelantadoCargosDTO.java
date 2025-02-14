package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaSSAdelantadoCargosDTO  extends PrecioCargoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String numAbonado;
	private String codCliente;
	private String cadenaSS;
	private String codProducto;
	private String codTecnologia;
	private String tipPantalla;
	private String codModulo;
	private String codActabo;
	private String seqNumOs;
	private String codOS;
	private String codPlanServ;
	
	
	
	
	
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getSeqNumOs() {
		return seqNumOs;
	}
	public void setSeqNumOs(String seqNumOs) {
		this.seqNumOs = seqNumOs;
	}
	public String getTipPantalla() {
		return tipPantalla;
	}
	public void setTipPantalla(String tipPantalla) {
		this.tipPantalla = tipPantalla;
	}
	public String getCadenaSS() {
		return cadenaSS;
	}
	public void setCadenaSS(String cadenaSS) {
		this.cadenaSS = cadenaSS;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	
	
	
	
	
	/*
	private long cod_concepto; 
	private String cod_moneda; 
	private Timestamp fec_desde; 
	private Timestamp fec_hasta; 
	private double imp_cargo; 
	private String nom_usuario; 
	private long tipo_cargo; 
	private String tipo_seg_des; 
	private String tipo_seg_orig; 
	private String tipo_valor;
	private String des_concepto;
	private String des_moneda;
	*/
	
	}
