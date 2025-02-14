package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsConsultaPlanTarifarioInDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String tipProducto;  	//COD_TIPLAN      	VARCHAR2(5 BYTE)    entrada
	private String tipRed;  		//TIP_RED     		CHAR(1 BYTE)   		entrada
	private String tipPlanTarif; 	//TIP_PLANTARIF     VARCHAR2(1 BYTE)	entrada
	private int indFamiliar;  		//IND_FAMILIAR      NUMBER(1 BYTE)   	entrada
	private String codTecnologia;	//COD_TECNOLOGIA	VARCHAR2(1 BYTE)	entrada
	private String codSegmento;		//COD_SEGMENTO		VARCHAR2 (3 Byte)	entrada	
	private String codCategoria;	//COD_CATEGORIA		VARCHAR2 (3 Byte)	entrada	
	

	
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public String getCodSegmento() {
		return codSegmento;
	}
	public void setCodSegmento(String codSegmento) {
		this.codSegmento = codSegmento;
	}
	public int getIndFamiliar() {
		return indFamiliar;
	}
	public void setIndFamiliar(int indFamiliar) {
		this.indFamiliar = indFamiliar;
	}
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
	public String getTipProducto() {
		return tipProducto;
	}
	public void setTipProducto(String tipProducto) {
		this.tipProducto = tipProducto;
	}
	public String getTipRed() {
		return tipRed;
	}
	public void setTipRed(String tipRed) {
		this.tipRed = tipRed;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	
	
}
