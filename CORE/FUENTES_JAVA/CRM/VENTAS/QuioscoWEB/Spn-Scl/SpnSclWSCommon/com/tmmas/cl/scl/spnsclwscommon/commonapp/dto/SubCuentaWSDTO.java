package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;
import java.util.Date;

public class SubCuentaWSDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String Cod_Subcuenta;
	private long   Cod_Cuenta;
	private String Des_Subcuenta;
	private long   Cod_Direccion;
	private Date   Fec_Alta;
		
	public long getCod_Cuenta() {
		return Cod_Cuenta;
	}
	public void setCod_Cuenta(long cod_Cuenta) {
		Cod_Cuenta = cod_Cuenta;
	}
	public long getCod_Direccion() {
		return Cod_Direccion;
	}
	public void setCod_Direccion(long cod_Direccion) {
		Cod_Direccion = cod_Direccion;
	}
	public String getCod_Subcuenta() {
		return Cod_Subcuenta;
	}
	public void setCod_Subcuenta(String cod_Subcuenta) {
		Cod_Subcuenta = cod_Subcuenta;
	}
	public String getDes_Subcuenta() {
		return Des_Subcuenta;
	}
	public void setDes_Subcuenta(String des_Subcuenta) {
		Des_Subcuenta = des_Subcuenta;
	}
	public Date getFec_Alta() {
		return Fec_Alta;
	}
	public void setFec_Alta(Date fec_Alta) {
		Fec_Alta = fec_Alta;
	}	

}
