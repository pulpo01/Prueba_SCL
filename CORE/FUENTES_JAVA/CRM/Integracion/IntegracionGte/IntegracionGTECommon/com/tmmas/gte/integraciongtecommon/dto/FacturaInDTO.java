package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class FacturaInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long codCliente;             
    private int  cantidadIteracion; 
    private int  opcion;      /*la opcion es para una condicion dentro del pl
                               *OPCION = 1, es para facturas con pago e impagas
                               *OPCION = 2, es para facturas impagas
                               *OPCION = 3, es para facturas pagadas
                               *OPCION = 4, es para facturas no ciclo de un cliente
                               *OPCION = cualquier numero menos 1,2,3, 4 trae un mensaje de error 
                                */
    private String fechaDesde;
    private String fechaHasta;
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public int getCantidadIteracion() {
		return cantidadIteracion;
	}
	public void setCantidadIteracion(int cantidadIteracion) {
		this.cantidadIteracion = cantidadIteracion;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public int getOpcion() {
		return opcion;
	}
	public void setOpcion(int opcion) {
		this.opcion = opcion;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}

}