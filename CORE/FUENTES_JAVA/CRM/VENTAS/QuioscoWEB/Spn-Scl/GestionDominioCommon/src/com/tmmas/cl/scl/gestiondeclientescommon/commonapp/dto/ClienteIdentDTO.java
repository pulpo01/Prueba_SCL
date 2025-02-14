package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ClienteIdentDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private long codCuenta;
	private String nomCliente;
	private String nomApeClien1;
	private String nomApeClien2;
	private String fecAlta;
	private int indPortable;
	private String codPlanTarif;
	private int codCategoria;
	
	public int getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(int codCategoria) {
		this.codCategoria = codCategoria;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(String fecAlta) {
		this.fecAlta = fecAlta;
	}
	public int getIndPortable() {
		return indPortable;
	}
	public void setIndPortable(int indPortable) {
		this.indPortable = indPortable;
	}
	public String getNomApeClien1() {
		return nomApeClien1;
	}
	public void setNomApeClien1(String nomApeClien1) {
		this.nomApeClien1 = nomApeClien1;
	}
	public String getNomApeClien2() {
		return nomApeClien2;
	}
	public void setNomApeClien2(String nomApeClien2) {
		this.nomApeClien2 = nomApeClien2;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	
}
