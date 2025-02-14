/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 20/06/2007     Héctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsPlanTarifarioOutDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;   //TA_PLANTARIF 4 columnas de salida de 33
	//JLGN
	private String tipPlanTarif;  //TIP_PLANTARIF      VARCHAR2(1 BYTE)   entrada
	//private int codProducto;      //COD_PRODUCTO       NUMBER(1)
	private String codPlanTarif;  //COD_PLANTARIF      VARCHAR2(3 BYTE)
	private String desPlanTarif;  //DES_PLANTARIF      VARCHAR2(30 BYTE)
	private String codTiplan;     //COD_TIPLAN         VARCHAR2(5 BYTE)
	private String numAbonados;
	
	public String getTipPlanTarif() {
		return tipPlanTarif;
	}
	public void setTipPlanTarif(String tipPlanTarif) {
		this.tipPlanTarif = tipPlanTarif;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	/*public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}*/
	public String getCodTiplan() {
		return codTiplan;
	}
	public void setCodTiplan(String codTiplan) {
		this.codTiplan = codTiplan;
	}
	public String getDesPlanTarif() {
		return desPlanTarif;
	}
	public void setDesPlanTarif(String desPlanTarif) {
		this.desPlanTarif = desPlanTarif;
	}
	public String getNumAbonados() {
		return numAbonados;
	}
	public void setNumAbonados(String numAbonados) {
		this.numAbonados = numAbonados;
	}
}
