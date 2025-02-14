package com.tmmas.cl.scl.integracionsicsa.common.dto.ws;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionsicsa.common.dto.PedidoEncabezadoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieDTO;

public class PedidoInDTO extends EntradaIntegracionSICSADTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private PedidoEncabezadoDTO pedidoEncabezadoDTO;
	private SerieDTO[] seriePedidoDTOs;
	
	public SerieDTO[] getSeriePedidoDTOs() {
		return seriePedidoDTOs;
	}
	public void setSeriePedidoDTOs(SerieDTO[] seriePedidoDTOs) {
		this.seriePedidoDTOs = seriePedidoDTOs;
	}
	public PedidoEncabezadoDTO getPedidoEncabezadoDTO() {
		return pedidoEncabezadoDTO;
	}
	public void setPedidoEncabezadoDTO(PedidoEncabezadoDTO pedidoEncabezadoDTO) {
		this.pedidoEncabezadoDTO = pedidoEncabezadoDTO;
	}
}
