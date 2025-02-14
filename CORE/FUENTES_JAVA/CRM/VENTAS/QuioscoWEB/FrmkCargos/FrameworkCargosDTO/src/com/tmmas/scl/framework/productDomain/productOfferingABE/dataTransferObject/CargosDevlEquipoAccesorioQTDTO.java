package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class CargosDevlEquipoAccesorioQTDTO implements Serializable{

	private static final long serialVersionUID = 1L;

	private long cod_Concepto;     
	private long cod_Producto; 	
	private String cod_Categoria; 	
	private long cod_Modpago; 	
	private String cod_Estado_Dev; 
	private String cod_Tipcontrato;
	private long num_Meses;	       
	private String cod_Antiguedad; 
	private String cod_Operacion; 	
	private long ind_Causa; 	
	private String cod_Causa;      
	private String des_Concepto;   
	private String cod_Moneda;     
	private double imp_Dev_Equipo;   
	private double imp_Dev_Acc;
	private String des_Moneda;
	
	
	public double getImp_Dev_Acc() {
		return imp_Dev_Acc;
	}
	public void setImp_Dev_Acc(double imp_Dev_Acc) {
		this.imp_Dev_Acc = imp_Dev_Acc;
	}
	public String getCod_Antiguedad() {
		return cod_Antiguedad;
	}
	public void setCod_Antiguedad(String cod_Antiguedad) {
		this.cod_Antiguedad = cod_Antiguedad;
	}
	public String getCod_Categoria() {
		return cod_Categoria;
	}
	public void setCod_Categoria(String cod_Categoria) {
		this.cod_Categoria = cod_Categoria;
	}
	public String getCod_Causa() {
		return cod_Causa;
	}
	public void setCod_Causa(String cod_Causa) {
		this.cod_Causa = cod_Causa;
	}
	public long getCod_Concepto() {
		return cod_Concepto;
	}
	public void setCod_Concepto(long cod_Concepto) {
		this.cod_Concepto = cod_Concepto;
	}
	public String getCod_Estado_Dev() {
		return cod_Estado_Dev;
	}
	public void setCod_Estado_Dev(String cod_Estado_Dev) {
		this.cod_Estado_Dev = cod_Estado_Dev;
	}
	public long getCod_Modpago() {
		return cod_Modpago;
	}
	public void setCod_Modpago(long cod_Modpago) {
		this.cod_Modpago = cod_Modpago;
	}
	public String getCod_Moneda() {
		return cod_Moneda;
	}
	public void setCod_Moneda(String cod_Moneda) {
		this.cod_Moneda = cod_Moneda;
	}
	public String getCod_Operacion() {
		return cod_Operacion;
	}
	public void setCod_Operacion(String cod_Operacion) {
		this.cod_Operacion = cod_Operacion;
	}
	public long getCod_Producto() {
		return cod_Producto;
	}
	public void setCod_Producto(long cod_Producto) {
		this.cod_Producto = cod_Producto;
	}
	public String getCod_Tipcontrato() {
		return cod_Tipcontrato;
	}
	public void setCod_Tipcontrato(String cod_Tipcontrato) {
		this.cod_Tipcontrato = cod_Tipcontrato;
	}
	public String getDes_Concepto() {
		return des_Concepto;
	}
	public void setDes_Concepto(String des_Concepto) {
		this.des_Concepto = des_Concepto;
	}
	public String getDes_Moneda() {
		return des_Moneda;
	}
	public void setDes_Moneda(String des_Moneda) {
		this.des_Moneda = des_Moneda;
	}
	public double getImp_Dev_Equipo() {
		return imp_Dev_Equipo;
	}
	public void setImp_Dev_Equipo(double imp_Dev_Equipo) {
		this.imp_Dev_Equipo = imp_Dev_Equipo;
	}
	public long getInd_Causa() {
		return ind_Causa;
	}
	public void setInd_Causa(long ind_Causa) {
		this.ind_Causa = ind_Causa;
	}
	public long getNum_Meses() {
		return num_Meses;
	}
	public void setNum_Meses(long num_Meses) {
		this.num_Meses = num_Meses;
	}     

}
