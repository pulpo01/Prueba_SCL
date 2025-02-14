package com.tmmas.scl.vendedor.dto;

import java.io.Serializable;

public class UsuarioSistemaDTO implements Serializable {
    private static final long serialVersionUID = 1L;

    private String nom_usuario;
    private String nom_operador;
    private String ind_adm;
    private String cod_oficina;
    private String cod_tipcomis;
    private long   cod_vendedor;
    private String ind_excep_eriesgo;
    private String des_ofician;
    private String cod_comuna;
    private String des_comuna;
    private String call_center;
    
	public String getCall_center() {
		return call_center;
	}
	public void setCall_center(String call_center) {
		this.call_center = call_center;
	}
	public String getCod_comuna() {
		return cod_comuna;
	}
	public void setCod_comuna(String cod_comuna) {
		this.cod_comuna = cod_comuna;
	}
	public String getCod_oficina() {
		return cod_oficina;
	}
	public void setCod_oficina(String cod_oficina) {
		this.cod_oficina = cod_oficina;
	}
	public String getCod_tipcomis() {
		return cod_tipcomis;
	}
	public void setCod_tipcomis(String cod_tipcomis) {
		this.cod_tipcomis = cod_tipcomis;
	}
	public long getCod_vendedor() {
		return cod_vendedor;
	}
	public void setCod_vendedor(long cod_vendedor) {
		this.cod_vendedor = cod_vendedor;
	}
	public String getDes_comuna() {
		return des_comuna;
	}
	public void setDes_comuna(String des_comuna) {
		this.des_comuna = des_comuna;
	}
	public String getDes_ofician() {
		return des_ofician;
	}
	public void setDes_ofician(String des_ofician) {
		this.des_ofician = des_ofician;
	}
	public String getInd_adm() {
		return ind_adm;
	}
	public void setInd_adm(String ind_adm) {
		this.ind_adm = ind_adm;
	}
	public String getInd_excep_eriesgo() {
		return ind_excep_eriesgo;
	}
	public void setInd_excep_eriesgo(String ind_excep_eriesgo) {
		this.ind_excep_eriesgo = ind_excep_eriesgo;
	}
	public String getNom_operador() {
		return nom_operador;
	}
	public void setNom_operador(String nom_operador) {
		this.nom_operador = nom_operador;
	}
	public String getNom_usuario() {
		return nom_usuario;
	}
	public void setNom_usuario(String nom_usuario) {
		this.nom_usuario = nom_usuario;
	}

}
