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
 * 27/09/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dto;

import java.io.Serializable;
import java.util.Date;

public class UsuarioAbonadoDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long num_abonado;      
	private String  nom_usuario;      
	private String  nom_apellido1;    
	private String  nom_apellido2;    
	private String  des_equipo;       
	private String  num_serie;        
	private String  des_procequi;     
	private String  des_terminal;     
	private String  des_modventa;     
	private String  num_seriemec;     
	private String  ind_propiedad;    
	private String  des_uso;          
	private String  ind_procequi;     
	private long ind_cuotas;       
	private long cod_modventa;     
	private String  des_tipcontrato;  
	private String  cod_tiplan;       
	private String  num_imei;
	private String CodTipContrato;
	private String numContrato;
	private String numAnexo;
	private long   cod_cliente;
	private DireccionDTO direccion;
	private long num_celular;
	private String cod_tecnologia;
	private Date fec_alta;
	private String codPlantarif;
	private String tip_plantarif;
	private String tip_terminal;
	private String cod_situacion;
	private String des_situacion;
	private String codTecDestino;
	private String nuevoPlanTarif;
	private long codArtEquipo;  	
	



	public long getCodArtEquipo() {
		return codArtEquipo;
	}
	public void setCodArtEquipo(long codArtEquipo) {
		this.codArtEquipo = codArtEquipo;
	}
	public String getCod_situacion() {
		return cod_situacion;
	}
	public void setCod_situacion(String cod_situacion) {
		this.cod_situacion = cod_situacion;
	}
	public String getTip_plantarif() {
		return tip_plantarif;
	}
	public void setTip_plantarif(String tip_plantarif) {
		this.tip_plantarif = tip_plantarif;
	}
	public String getTip_terminal() {
		return tip_terminal;
	}
	public void setTip_terminal(String tip_terminal) {
		this.tip_terminal = tip_terminal;
	}
	public String getCodPlantarif() {
		return codPlantarif;
	}
	public void setCodPlantarif(String codPlantarif) {
		this.codPlantarif = codPlantarif;
	}
	public String getCod_tiplan() {
		return cod_tiplan;
	}
	public void setCod_tiplan(String cod_tiplan) {
		this.cod_tiplan = cod_tiplan;
	}
	public String getDes_equipo() {
		return des_equipo;
	}
	public void setDes_equipo(String des_equipo) {
		this.des_equipo = des_equipo;
	}
	public String getDes_modventa() {
		return des_modventa;
	}
	public void setDes_modventa(String des_modventa) {
		this.des_modventa = des_modventa;
	}
	public String getDes_procequi() {
		return des_procequi;
	}
	public void setDes_procequi(String des_procequi) {
		this.des_procequi = des_procequi;
	}
	public String getDes_terminal() {
		return des_terminal;
	}
	public void setDes_terminal(String des_terminal) {
		this.des_terminal = des_terminal;
	}
	public String getDes_tipcontrato() {
		return des_tipcontrato;
	}
	public void setDes_tipcontrato(String des_tipcontrato) {
		this.des_tipcontrato = des_tipcontrato;
	}
	public String getDes_uso() {
		return des_uso;
	}
	public void setDes_uso(String des_uso) {
		this.des_uso = des_uso;
	}
	public String getInd_procequi() {
		return ind_procequi;
	}
	public void setInd_procequi(String ind_procequi) {
		this.ind_procequi = ind_procequi;
	}
	public String getInd_propiedad() {
		return ind_propiedad;
	}
	public void setInd_propiedad(String ind_propiedad) {
		this.ind_propiedad = ind_propiedad;
	}
	public String getNom_apellido1() {
		return nom_apellido1;
	}
	public void setNom_apellido1(String nom_apellido1) {
		this.nom_apellido1 = nom_apellido1;
	}
	public String getNom_apellido2() {
		return nom_apellido2;
	}
	public void setNom_apellido2(String nom_apellido2) {
		this.nom_apellido2 = nom_apellido2;
	}
	public String getNom_usuario() {
		return nom_usuario;
	}
	public void setNom_usuario(String nom_usuario) {
		this.nom_usuario = nom_usuario;
	}
	public String getNum_imei() {
		return num_imei;
	}
	public void setNum_imei(String num_imei) {
		this.num_imei = num_imei;
	}
	public String getNum_serie() {
		return num_serie;
	}
	public void setNum_serie(String num_serie) {
		this.num_serie = num_serie;
	}
	public String getNum_seriemec() {
		return num_seriemec;
	}
	public void setNum_seriemec(String num_seriemec) {
		this.num_seriemec = num_seriemec;
	}

	public long getCod_modventa() {
		return cod_modventa;
	}

	public void setCod_modventa(long cod_modventa) {
		this.cod_modventa = cod_modventa;
	}

	public long getInd_cuotas() {
		return ind_cuotas;
	}

	public void setInd_cuotas(long ind_cuotas) {
		this.ind_cuotas = ind_cuotas;
	}

	public long getNum_abonado() {
		return num_abonado;
	}

	public void setNum_abonado(long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public String getCodTipContrato() {
		return CodTipContrato;
	}
	public void setCodTipContrato(String codTipContrato) {
		CodTipContrato = codTipContrato;
	}
	public String getNumAnexo() {
		return numAnexo;
	}
	public void setNumAnexo(String numAnexo) {
		this.numAnexo = numAnexo;
	}
	public String getNumContrato() {
		return numContrato;
	}
	public void setNumContrato(String numContrato) {
		this.numContrato = numContrato;
	}
	public long getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(long cod_cliente) {
		this.cod_cliente = cod_cliente;
	}

	public DireccionDTO getDireccion() {
		return direccion;
	}
	public void setDireccion(DireccionDTO direccion) {
		this.direccion = direccion;
	}
	public String getCod_tecnologia() {
		return cod_tecnologia;
	}
	public void setCod_tecnologia(String cod_tecnologia) {
		this.cod_tecnologia = cod_tecnologia;
	}
	public Date getFec_alta() {
		return fec_alta;
	}
	public void setFec_alta(Date fec_alta) {
		this.fec_alta = fec_alta;
	}
	public long getNum_celular() {
		return num_celular;
	}
	public void setNum_celular(long num_celular) {
		this.num_celular = num_celular;
	}
	public String getDes_situacion() {
		return des_situacion;
	}
	public void setDes_situacion(String des_situacion) {
		this.des_situacion = des_situacion;
	}
	public String getCodTecDestino() {
		return codTecDestino;
	}
	public void setCodTecDestino(String codTecDestino) {
		this.codTecDestino = codTecDestino;
	}
	public String getNuevoPlanTarif() {
		return nuevoPlanTarif;
	}
	public void setNuevoPlanTarif(String nuevoPlanTarif) {
		this.nuevoPlanTarif = nuevoPlanTarif;
	}         
}
