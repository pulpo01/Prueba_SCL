package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class ParametrosGeneralesDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	//parametros de entrada para obtener el valor del parametro
	private String nombreparametro;
	private String codigomodulo;
	private String codigoproducto;
	
	//valor de salida depende de parametros de entrada
	private String valorparametro;
	
	public String getCodigomodulo() {
		return codigomodulo;
	}

	public void setCodigomodulo(String codigomodulo) {
		this.codigomodulo = codigomodulo;
	}

	public String getCodigoproducto() {
		return codigoproducto;
	}

	public void setCodigoproducto(String codigoproducto) {
		this.codigoproducto = codigoproducto;
	}

	public String getNombreparametro() {
		return nombreparametro;
	}

	public void setNombreparametro(String nombreparametro) {
		this.nombreparametro = nombreparametro;
	}

	public String getValorparametro() {
		return valorparametro;
	}

	public void setValorparametro(String valorparametro) {
		this.valorparametro = valorparametro;
	}

}
