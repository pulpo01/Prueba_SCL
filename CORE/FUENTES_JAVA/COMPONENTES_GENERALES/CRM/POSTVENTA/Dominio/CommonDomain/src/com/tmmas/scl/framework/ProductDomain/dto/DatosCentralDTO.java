package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class DatosCentralDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private int		cod_central;
	private String 	nom_central;	
	private String 	cod_hlr;     
	private String 	cod_subAlm;
	private String 	cod_tecnologia;
	
	public int getCod_central() {
		return cod_central;
	}
	public void setCod_central(int cod_central) {
		this.cod_central = cod_central;
	}
	public String getCod_hlr() {
		return cod_hlr;
	}
	public void setCod_hlr(String cod_hlr) {
		this.cod_hlr = cod_hlr;
	}
	public String getCod_subAlm() {
		return cod_subAlm;
	}
	public void setCod_subAlm(String cod_subAlm) {
		this.cod_subAlm = cod_subAlm;
	}
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public String getNom_central() {
		return nom_central;
	}
	public void setNom_central(String nom_central) {
		this.nom_central = nom_central;
	}     

	

}
