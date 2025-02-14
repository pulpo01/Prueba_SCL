package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class AtributosMigracionDTO extends AtributosCargoDTO implements Serializable{
	         
	private static final long serialVersionUID = 1L;
	private String ind_paquete;
	private String ind_cuota;
	private String ind_equipo;
	private String cod_tecnologia;
	private String codTipPlantarifOrig;
	private String codTipPlantarifDes;
	private String numAbonado;
	protected String numeroCelular;
	protected String nombreUsuario;
	
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(String numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getCodTipPlantarifDes() {
		return codTipPlantarifDes;
	}
	public void setCodTipPlantarifDes(String codTipPlantarifDes) {
		this.codTipPlantarifDes = codTipPlantarifDes;
	}
	public String getCodTipPlantarifOrig() {
		return codTipPlantarifOrig;
	}
	public void setCodTipPlantarifOrig(String codTipPlantarifOrig) {
		this.codTipPlantarifOrig = codTipPlantarifOrig;
	}
	
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public String getInd_cuota() {
		return ind_cuota;
	}
	public void setInd_cuota(String ind_cuota) {
		this.ind_cuota = ind_cuota;
	}
	public String getInd_equipo() {
		return ind_equipo;
	}
	public void setInd_equipo(String ind_equipo) {
		this.ind_equipo = ind_equipo;
	}
	public String getInd_paquete() {
		return ind_paquete;
	}
	public void setInd_paquete(String ind_paquete) {
		this.ind_paquete = ind_paquete;
	}
	
	
	
}
