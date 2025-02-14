package com.tmmas.scl.framework.customerDomain.dto;

import java.io.Serializable;
import java.util.Date;

public class VendedorDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String cod_tipcomis;

	private long cod_vendedor;

	private String nom_vendedor;

	private String cod_tipident;

	private String num_ident;

	private Date fec_contrato;

	private long cod_direccion;

	private String cod_oficina;

	private long ind_interno;

	private long ind_tipventa;

	private long cod_vende_raiz;

	private long cod_cliente;

	private long ind_dicom;

	private long ind_dicomclear;

	private String num_telef1;

	private String num_telef2;

	private String num_fax;

	private String num_pin;

	private Date fec_fincontrato;

	private String nom_responsable;

	private String cod_tipidresp;

	private String num_identresp;

	private String cod_password;

	private String ind_password;

	private boolean ve_indbloqueo;

	private long cod_cuenta;

	private String cod_tipidapod;

	private String num_identapod;

	private String e_mail;

	private String nom_apoderado;

	private String nom_contacto;

	private String num_telef3;

	private long cod_estado;

	private String cod_plaza;

	private long ind_oficina_propia;

	private long num_movil;

	private String plan_movil;

	public long getCod_cliente() {
		return cod_cliente;
	}

	public void setCod_cliente(long cod_cliente) {
		this.cod_cliente = cod_cliente;
	}

	public long getCod_cuenta() {
		return cod_cuenta;
	}

	public void setCod_cuenta(long cod_cuenta) {
		this.cod_cuenta = cod_cuenta;
	}

	public long getCod_direccion() {
		return cod_direccion;
	}

	public void setCod_direccion(long cod_direccion) {
		this.cod_direccion = cod_direccion;
	}

	public long getCod_estado() {
		return cod_estado;
	}

	public void setCod_estado(long cod_estado) {
		this.cod_estado = cod_estado;
	}

	public String getCod_oficina() {
		return cod_oficina;
	}

	public void setCod_oficina(String cod_oficina) {
		this.cod_oficina = cod_oficina;
	}

	public String getCod_password() {
		return cod_password;
	}

	public void setCod_password(String cod_password) {
		this.cod_password = cod_password;
	}

	public String getCod_plaza() {
		return cod_plaza;
	}

	public void setCod_plaza(String cod_plaza) {
		this.cod_plaza = cod_plaza;
	}

	public String getCod_tipcomis() {
		return cod_tipcomis;
	}

	public void setCod_tipcomis(String cod_tipcomis) {
		this.cod_tipcomis = cod_tipcomis;
	}

	public String getCod_tipidapod() {
		return cod_tipidapod;
	}

	public void setCod_tipidapod(String cod_tipidapod) {
		this.cod_tipidapod = cod_tipidapod;
	}

	public String getCod_tipident() {
		return cod_tipident;
	}

	public void setCod_tipident(String cod_tipident) {
		this.cod_tipident = cod_tipident;
	}

	public String getCod_tipidresp() {
		return cod_tipidresp;
	}

	public void setCod_tipidresp(String cod_tipidresp) {
		this.cod_tipidresp = cod_tipidresp;
	}

	public long getCod_vende_raiz() {
		return cod_vende_raiz;
	}

	public void setCod_vende_raiz(long cod_vende_raiz) {
		this.cod_vende_raiz = cod_vende_raiz;
	}

	public long getCod_vendedor() {
		return cod_vendedor;
	}

	public void setCod_vendedor(long cod_vendedor) {
		this.cod_vendedor = cod_vendedor;
	}

	public String getE_mail() {
		return e_mail;
	}

	public void setE_mail(String e_mail) {
		this.e_mail = e_mail;
	}

	public Date getFec_contrato() {
		return fec_contrato;
	}

	public void setFec_contrato(Date fec_contrato) {
		this.fec_contrato = fec_contrato;
	}

	public Date getFec_fincontrato() {
		return fec_fincontrato;
	}

	public void setFec_fincontrato(Date fec_fincontrato) {
		this.fec_fincontrato = fec_fincontrato;
	}

	public long getInd_dicom() {
		return ind_dicom;
	}

	public void setInd_dicom(long ind_dicom) {
		this.ind_dicom = ind_dicom;
	}

	public long getInd_dicomclear() {
		return ind_dicomclear;
	}

	public void setInd_dicomclear(long ind_dicomclear) {
		this.ind_dicomclear = ind_dicomclear;
	}

	public long getInd_interno() {
		return ind_interno;
	}

	public void setInd_interno(long ind_interno) {
		this.ind_interno = ind_interno;
	}

	public long getInd_oficina_propia() {
		return ind_oficina_propia;
	}

	public void setInd_oficina_propia(long ind_oficina_propia) {
		this.ind_oficina_propia = ind_oficina_propia;
	}

	public String getInd_password() {
		return ind_password;
	}

	public void setInd_password(String ind_password) {
		this.ind_password = ind_password;
	}

	public long getInd_tipventa() {
		return ind_tipventa;
	}

	public void setInd_tipventa(long ind_tipventa) {
		this.ind_tipventa = ind_tipventa;
	}

	public String getNom_apoderado() {
		return nom_apoderado;
	}

	public void setNom_apoderado(String nom_apoderado) {
		this.nom_apoderado = nom_apoderado;
	}

	public String getNom_contacto() {
		return nom_contacto;
	}

	public void setNom_contacto(String nom_contacto) {
		this.nom_contacto = nom_contacto;
	}

	public String getNom_responsable() {
		return nom_responsable;
	}

	public void setNom_responsable(String nom_responsable) {
		this.nom_responsable = nom_responsable;
	}

	public String getNom_vendedor() {
		return nom_vendedor;
	}

	public void setNom_vendedor(String nom_vendedor) {
		this.nom_vendedor = nom_vendedor;
	}

	public String getNum_fax() {
		return num_fax;
	}

	public void setNum_fax(String num_fax) {
		this.num_fax = num_fax;
	}

	public String getNum_ident() {
		return num_ident;
	}

	public void setNum_ident(String num_ident) {
		this.num_ident = num_ident;
	}

	public String getNum_identapod() {
		return num_identapod;
	}

	public void setNum_identapod(String num_identapod) {
		this.num_identapod = num_identapod;
	}

	public String getNum_identresp() {
		return num_identresp;
	}

	public void setNum_identresp(String num_identresp) {
		this.num_identresp = num_identresp;
	}

	public long getNum_movil() {
		return num_movil;
	}

	public void setNum_movil(long num_movil) {
		this.num_movil = num_movil;
	}

	public String getNum_pin() {
		return num_pin;
	}

	public void setNum_pin(String num_pin) {
		this.num_pin = num_pin;
	}

	public String getNum_telef1() {
		return num_telef1;
	}

	public void setNum_telef1(String num_telef1) {
		this.num_telef1 = num_telef1;
	}

	public String getNum_telef2() {
		return num_telef2;
	}

	public void setNum_telef2(String num_telef2) {
		this.num_telef2 = num_telef2;
	}

	public String getNum_telef3() {
		return num_telef3;
	}

	public void setNum_telef3(String num_telef3) {
		this.num_telef3 = num_telef3;
	}

	public String getPlan_movil() {
		return plan_movil;
	}

	public void setPlan_movil(String plan_movil) {
		this.plan_movil = plan_movil;
	}

	public boolean getVe_indbloqueo() {
		return ve_indbloqueo;
	}

	public void setVe_indbloqueo(boolean ve_indbloqueo) {
		this.ve_indbloqueo = ve_indbloqueo;
	}

}
