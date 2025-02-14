package com.tmmas.scl.framework.customerDomain.dataTransferObject;

public class ParametrosGeneralesDTO {
	
//	parametros de entrada para obtener el valor del parametro
	private String nombreparametro;
	private String codigomodulo;
	private String codigoproducto;
	private String Valorparametro;
	
	public String getValorparametro() {
		return Valorparametro;
	}
	public void setValorparametro(String valorparametro) {
		Valorparametro = valorparametro;
	}
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
	
	
}
