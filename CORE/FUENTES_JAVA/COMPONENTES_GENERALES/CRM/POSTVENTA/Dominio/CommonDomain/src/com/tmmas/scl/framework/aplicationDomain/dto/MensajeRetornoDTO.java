package com.tmmas.scl.framework.aplicationDomain.dto;

import java.io.Serializable;

public class MensajeRetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String mensaje;
	private long   codigo;
	private long   cod_bodega;
	private long   cod_articulo;
	private long   tip_stock;
	/**
	 * @author rlozano
	 * @description se agrega parametro de numero de Movimiento del bloqueo y desbloque de serie simcard ,para ser seteado en dao.
	 * @return
	 */
	protected long numMovimientoBloqDesb;
	
	public long getNumMovimientoBloqDesb() {
		return numMovimientoBloqDesb;
	}
	public void setNumMovimientoBloqDesb(long numMovimientoBloqDesb) {
		this.numMovimientoBloqDesb = numMovimientoBloqDesb;
	}
	public long getCod_articulo() {
		return cod_articulo;
	}
	public void setCod_articulo(long cod_articulo) {
		this.cod_articulo = cod_articulo;
	}
	public long getCod_bodega() {
		return cod_bodega;
	}
	public void setCod_bodega(long cod_bodega) {
		this.cod_bodega = cod_bodega;
	}
	public long getCodigo() {
		return codigo;
	}
	public void setCodigo(long codigo) {
		this.codigo = codigo;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public long getTip_stock() {
		return tip_stock;
	}
	public void setTip_stock(long tip_stock) {
		this.tip_stock = tip_stock;
	}
}
