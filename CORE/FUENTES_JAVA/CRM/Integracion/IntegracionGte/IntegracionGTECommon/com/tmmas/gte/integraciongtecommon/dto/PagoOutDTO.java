package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;
public class PagoOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String fecha;
	private String hora;
	private String desPuntoAcceso;
    private long numeroTelefono;
    private PagoVistaClienteDTO[]  lstListadoPagos;
    private RespuestaDTO respuesta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getDesPuntoAcceso() {
		return desPuntoAcceso;
	}
	public void setDesPuntoAcceso(String desPuntoAcceso) {
		this.desPuntoAcceso = desPuntoAcceso;
	}
	public PagoVistaClienteDTO[] getLstListadoPagos() {
		return lstListadoPagos;
	}
	public void setLstListadoPagos(PagoVistaClienteDTO[] lstListadoPagos) {
		this.lstListadoPagos = lstListadoPagos;
	}
	public long getNumeroTelefono() {
		return numeroTelefono;
	}
	public void setNumeroTelefono(long numeroTelefono) {
		this.numeroTelefono = numeroTelefono;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getHora() {
		return hora;
	}
	public void setHora(String hora) {
		this.hora = hora;
	}

    
    
}
