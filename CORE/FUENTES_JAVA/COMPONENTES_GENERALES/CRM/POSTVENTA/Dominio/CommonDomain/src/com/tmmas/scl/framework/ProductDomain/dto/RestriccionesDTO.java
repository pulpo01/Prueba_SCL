package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class RestriccionesDTO  implements Serializable{

	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_modulo;
	private long   cod_producto;
	private String cod_actuacion;
    private String param_entrada;
    private long   num_transaccion;
	private String cod_evento;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
      
      
	public String getCod_actuacion() {
		return cod_actuacion;
	}
	public void setCod_actuacion(String cod_actuacion) {
		this.cod_actuacion = cod_actuacion;
	}
	public String getCod_evento() {
		return cod_evento;
	}
	public void setCod_evento(String cod_evento) {
		this.cod_evento = cod_evento;
	}
	public String getCod_modulo() {
		return cod_modulo;
	}
	public void setCod_modulo(String cod_modulo) {
		this.cod_modulo = cod_modulo;
	}
	public long getCod_producto() {
		return cod_producto;
	}
	public void setCod_producto(long cod_producto) {
		this.cod_producto = cod_producto;
	}
	public long getNum_transaccion() {
		return num_transaccion;
	}
	public void setNum_transaccion(long num_transaccion) {
		this.num_transaccion = num_transaccion;
	}
	public String getParam_entrada() {
		return param_entrada;
	}
	public void setParam_entrada(String param_entrada) {
		this.param_entrada = param_entrada;
	}	  	  
}
