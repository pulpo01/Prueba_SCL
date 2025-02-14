package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ArticuloDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private int cod_proveedor; 
	private int cod_producto; 
	private int ind_agru; 
	private int ind_obs; 
	private int ind_oracle; 
	private int ind_seriado; 
	private int cod_fabricante; 
	private int cod_unidad; 
	private int mes_caducidad; 
	private int mes_fabricante; 
	private int mes_garantia; 
	private int mes_afijo; 
	private int tip_articulo; 
	private int cod_conceptoart; 
	private int cod_conceptoartalq; 
	private int cod_conceptodto; 
	private int cod_conceptodtoalq; 
	private int cod_articulo; 
	private int cod_grpconcepto; 
	private String ind_equiacc; 
	private String ind_proc; 
	private String tip_terminal; 
	private String cod_modelo; 
	private String cod_barras; 
	private String ref_fabricante; 
	private String des_articulo;
	
	
	public int getCod_articulo() {
		return cod_articulo;
	}
	public void setCod_articulo(int cod_articulo) {
		this.cod_articulo = cod_articulo;
	}
	public String getCod_barras() {
		return cod_barras;
	}
	public void setCod_barras(String cod_barras) {
		this.cod_barras = cod_barras;
	}
	public int getCod_conceptoart() {
		return cod_conceptoart;
	}
	public void setCod_conceptoart(int cod_conceptoart) {
		this.cod_conceptoart = cod_conceptoart;
	}
	public int getCod_conceptoartalq() {
		return cod_conceptoartalq;
	}
	public void setCod_conceptoartalq(int cod_conceptoartalq) {
		this.cod_conceptoartalq = cod_conceptoartalq;
	}
	public int getCod_conceptodto() {
		return cod_conceptodto;
	}
	public void setCod_conceptodto(int cod_conceptodto) {
		this.cod_conceptodto = cod_conceptodto;
	}
	public int getCod_conceptodtoalq() {
		return cod_conceptodtoalq;
	}
	public void setCod_conceptodtoalq(int cod_conceptodtoalq) {
		this.cod_conceptodtoalq = cod_conceptodtoalq;
	}
	public int getCod_fabricante() {
		return cod_fabricante;
	}
	public void setCod_fabricante(int cod_fabricante) {
		this.cod_fabricante = cod_fabricante;
	}
	public int getCod_grpconcepto() {
		return cod_grpconcepto;
	}
	public void setCod_grpconcepto(int cod_grpconcepto) {
		this.cod_grpconcepto = cod_grpconcepto;
	}
	public String getCod_modelo() {
		return cod_modelo;
	}
	public void setCod_modelo(String cod_modelo) {
		this.cod_modelo = cod_modelo;
	}
	public int getCod_producto() {
		return cod_producto;
	}
	public void setCod_producto(int cod_producto) {
		this.cod_producto = cod_producto;
	}
	public int getCod_proveedor() {
		return cod_proveedor;
	}
	public void setCod_proveedor(int cod_proveedor) {
		this.cod_proveedor = cod_proveedor;
	}
	public int getCod_unidad() {
		return cod_unidad;
	}
	public void setCod_unidad(int cod_unidad) {
		this.cod_unidad = cod_unidad;
	}
	public String getDes_articulo() {
		return des_articulo;
	}
	public void setDes_articulo(String des_articulo) {
		this.des_articulo = des_articulo;
	}
	public int getInd_agru() {
		return ind_agru;
	}
	public void setInd_agru(int ind_agru) {
		this.ind_agru = ind_agru;
	}
	public String getInd_equiacc() {
		return ind_equiacc;
	}
	public void setInd_equiacc(String ind_equiacc) {
		this.ind_equiacc = ind_equiacc;
	}
	public int getInd_obs() {
		return ind_obs;
	}
	public void setInd_obs(int ind_obs) {
		this.ind_obs = ind_obs;
	}
	public int getInd_oracle() {
		return ind_oracle;
	}
	public void setInd_oracle(int ind_oracle) {
		this.ind_oracle = ind_oracle;
	}
	public String getInd_proc() {
		return ind_proc;
	}
	public void setInd_proc(String ind_proc) {
		this.ind_proc = ind_proc;
	}
	public int getInd_seriado() {
		return ind_seriado;
	}
	public void setInd_seriado(int ind_seriado) {
		this.ind_seriado = ind_seriado;
	}
	public int getMes_afijo() {
		return mes_afijo;
	}
	public void setMes_afijo(int mes_afijo) {
		this.mes_afijo = mes_afijo;
	}
	public int getMes_caducidad() {
		return mes_caducidad;
	}
	public void setMes_caducidad(int mes_caducidad) {
		this.mes_caducidad = mes_caducidad;
	}
	public int getMes_fabricante() {
		return mes_fabricante;
	}
	public void setMes_fabricante(int mes_fabricante) {
		this.mes_fabricante = mes_fabricante;
	}
	public int getMes_garantia() {
		return mes_garantia;
	}
	public void setMes_garantia(int mes_garantia) {
		this.mes_garantia = mes_garantia;
	}
	public String getRef_fabricante() {
		return ref_fabricante;
	}
	public void setRef_fabricante(String ref_fabricante) {
		this.ref_fabricante = ref_fabricante;
	}
	public int getTip_articulo() {
		return tip_articulo;
	}
	public void setTip_articulo(int tip_articulo) {
		this.tip_articulo = tip_articulo;
	}
	public String getTip_terminal() {
		return tip_terminal;
	}
	public void setTip_terminal(String tip_terminal) {
		this.tip_terminal = tip_terminal;
	}
	
}
