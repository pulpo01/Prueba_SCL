package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class TarjetaCreditoResponseDTO  implements Serializable {
	/*
	 * Autor: Daniel Jara Oyarzún
	 * 
	 * */
	
	private static final long serialVersionUID = 1L;
	

	private TarjetaCreditoPacDTO[]  tarjetasDeCreditoDTO;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public TarjetaCreditoPacDTO[] getTarjetasDeCreditoDTO() {
		return tarjetasDeCreditoDTO;
	}
	public void setTarjetasDeCreditoDTO(TarjetaCreditoPacDTO[] tarjetasDeCreditoDTO) {
		this.tarjetasDeCreditoDTO = tarjetasDeCreditoDTO;
	}
	
	
	
}