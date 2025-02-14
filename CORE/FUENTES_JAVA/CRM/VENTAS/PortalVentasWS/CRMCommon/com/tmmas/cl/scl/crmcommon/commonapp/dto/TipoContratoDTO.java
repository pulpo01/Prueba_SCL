package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class TipoContratoDTO implements Serializable
{

private static final long serialVersionUID = 1L;
private String codContrato;
private String desContrato;
private String canalVenta;
private String cantMeses;



public String getCanalVenta() {
	return canalVenta;
}
public void setCanalVenta(String canalVenta) {
	this.canalVenta = canalVenta;
}
public String getCantMeses() {
	return cantMeses;
}
public void setCantMeses(String cantMeses) {
	this.cantMeses = cantMeses;
}
public String getDesContrato() {
	return desContrato;
}
public void setDesContrato(String desContrato) {
	this.desContrato = desContrato;
}
public String getCodContrato() {
	return codContrato;
}
public void setCodContrato(String codContrato) {
	this.codContrato = codContrato;
}

}	