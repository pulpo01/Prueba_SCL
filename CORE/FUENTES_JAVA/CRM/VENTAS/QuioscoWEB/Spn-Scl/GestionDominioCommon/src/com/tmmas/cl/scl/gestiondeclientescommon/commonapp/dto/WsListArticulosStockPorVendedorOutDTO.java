package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListArticulosStockPorVendedorOutDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private RetornoDTO retornoDTO; 
	
	private WsListArticulosStockPorVendedor_ArticuloDTO[] wsListArticulosStockPorVendedor_ArticuloDTO;

	public RetornoDTO getRetornoDTO() {
		return retornoDTO;
	}

	public void setRetornoDTO(RetornoDTO retornoDTO) {
		this.retornoDTO = retornoDTO;
	}

	public WsListArticulosStockPorVendedor_ArticuloDTO[] getWsListArticulosStockPorVendedor_ArticuloDTO() {
		return wsListArticulosStockPorVendedor_ArticuloDTO;
	}

	public void setWsListArticulosStockPorVendedor_ArticuloDTO(
			WsListArticulosStockPorVendedor_ArticuloDTO[] wsListArticulosStockPorVendedor_ArticuloDTO) {
		this.wsListArticulosStockPorVendedor_ArticuloDTO = wsListArticulosStockPorVendedor_ArticuloDTO;
	}

}
