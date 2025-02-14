package com.tmmas.cl.scl.integracionsicsa.common.dto.ws;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.VentaEncabezadoDTO;

public class VentaInDTO extends EntradaIntegracionSICSADTO implements Serializable{
	/**
     * 
     */
	private static final long serialVersionUID = 1L;

	private VentaEncabezadoDTO ventaEncabezadoDTO;
	private SerieDTO[] serieDTOs;
	
	public VentaEncabezadoDTO getVentaEncabezadoDTO() {
		return ventaEncabezadoDTO;
	}

	public void setVentaEncabezadoDTO(VentaEncabezadoDTO ventaEncabezadoDTO) {
		this.ventaEncabezadoDTO = ventaEncabezadoDTO;
	}

	public SerieDTO[] getSerieDTOs() {
		return serieDTOs;
	}

	public void setSerieDTOs(SerieDTO[] serieDTOs) {
		this.serieDTOs = serieDTOs;
	}

}
