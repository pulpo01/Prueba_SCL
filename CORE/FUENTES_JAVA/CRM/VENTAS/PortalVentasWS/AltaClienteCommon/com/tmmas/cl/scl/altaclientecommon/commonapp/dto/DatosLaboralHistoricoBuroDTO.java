/*P-CSR-11002 JLGN 04-05-2011*/
package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class DatosLaboralHistoricoBuroDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	//Inicio Datos Laboral Historio
	private String cedulaHist;
	private String codTipPatronoHist;
	private String nombreHist;
	private String fecInicioHist;
	private String fecCompInicioHist;
	private String fecFinHist;
	private String fecCompFinHist;
	private String mesesLaboradosHist;
	//Fin Datos Laboral Historio
	
	public String getCedulaHist() {
		return cedulaHist;
	}
	public void setCedulaHist(String cedulaHist) {
		this.cedulaHist = cedulaHist;
	}
	public String getCodTipPatronoHist() {
		return codTipPatronoHist;
	}
	public void setCodTipPatronoHist(String codTipPatronoHist) {
		this.codTipPatronoHist = codTipPatronoHist;
	}
	public String getFecCompFinHist() {
		return fecCompFinHist;
	}
	public void setFecCompFinHist(String fecCompFinHist) {
		this.fecCompFinHist = fecCompFinHist;
	}
	public String getFecCompInicioHist() {
		return fecCompInicioHist;
	}
	public void setFecCompInicioHist(String fecCompInicioHist) {
		this.fecCompInicioHist = fecCompInicioHist;
	}
	public String getFecFinHist() {
		return fecFinHist;
	}
	public void setFecFinHist(String fecFinHist) {
		this.fecFinHist = fecFinHist;
	}
	public String getFecInicioHist() {
		return fecInicioHist;
	}
	public void setFecInicioHist(String fecInicioHist) {
		this.fecInicioHist = fecInicioHist;
	}
	public String getMesesLaboradosHist() {
		return mesesLaboradosHist;
	}
	public void setMesesLaboradosHist(String mesesLaboradosHist) {
		this.mesesLaboradosHist = mesesLaboradosHist;
	}
	public String getNombreHist() {
		return nombreHist;
	}
	public void setNombreHist(String nombreHist) {
		this.nombreHist = nombreHist;
	}
}
