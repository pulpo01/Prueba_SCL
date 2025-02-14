package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class DatosGenerDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String Cod_Abc;
	private Long Cod_123;
	private String Cod_Calclien;
	private Long Cod_DocAnex;
	
	private long cantAbonadosCarrier;
	private long cantAbonados;
	
	

	public long getCantAbonados() {
		return cantAbonados;
	}

	public void setCantAbonados(long cantAbonados) {
		this.cantAbonados = cantAbonados;
	}

	public long getCantAbonadosCarrier() {
		return cantAbonadosCarrier;
	}

	public void setCantAbonadosCarrier(long cantAbonadosCarrier) {
		this.cantAbonadosCarrier = cantAbonadosCarrier;
	}

	public Long getCod_DocAnex() {
		return Cod_DocAnex;
	}

	public void setCod_DocAnex(Long cod_DocAnex) {
		Cod_DocAnex = cod_DocAnex;
	}

	public void setCod_Abc(String cod_Abc) {
		Cod_Abc = cod_Abc;
	}

	public String getCod_Abc() {
		return Cod_Abc;
	}

	public void setCod_abc(String _Cod_Abc) {
		this.Cod_Abc = _Cod_Abc;
	}

	public Long getCod_123() {
		return Cod_123;
	}

	public void setCod_123(Long _Cod_123) {
		this.Cod_123 = _Cod_123;
	}

	public String getCod_Calclien() {
		return Cod_Calclien;
	}

	public void setCod_Calclien(String _Cod_Calclien) {
		this.Cod_Calclien = _Cod_Calclien;
	}
}
