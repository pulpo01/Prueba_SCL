package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

public class DatosVentaDTO implements Serializable
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String num_venta;
	private String cod_cliente;
	private String num_transaccion;
	private String num_evento;
	private String cod_vendedor;
	private String flag_ciclo;
	private String cod_proceso;	
	
	public String getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(String cod_cliente) {
		this.cod_cliente = cod_cliente;
	}
	public String getCod_proceso() {
		return cod_proceso;
	}
	public void setCod_proceso(String cod_proceso) {
		this.cod_proceso = cod_proceso;
	}
	public String getCod_vendedor() {
		return cod_vendedor;
	}
	public void setCod_vendedor(String cod_vendedor) {
		this.cod_vendedor = cod_vendedor;
	}
	public String getFlag_ciclo() {
		return flag_ciclo;
	}
	public void setFlag_ciclo(String flag_ciclo) {
		this.flag_ciclo = flag_ciclo;
	}
	public String getNum_evento() {
		return num_evento;
	}
	public void setNum_evento(String num_evento) {
		this.num_evento = num_evento;
	}
	public String getNum_transaccion() {
		return num_transaccion;
	}
	public void setNum_transaccion(String num_transaccion) {
		this.num_transaccion = num_transaccion;
	}
	public String getNum_venta() {
		return num_venta;
	}
	public void setNum_venta(String num_venta) {
		this.num_venta = num_venta;
	}	
	
}
