package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;


public class PagoVistaClienteDTO implements Serializable {
	private static final long serialVersionUID = 1L;
    private double   impPago;        
    private DetallePagoVistaClienteDTO[] lstDetallePago;
    
	public DetallePagoVistaClienteDTO[] getLstDetallePago() {
		return lstDetallePago;
	}
	public void setLstDetallePago(DetallePagoVistaClienteDTO[] listaDetallePago) {
		this.lstDetallePago = listaDetallePago;
	}
	public double getImpPago() {
		return impPago;
	}
	public void setImpPago(double impPago) {
		this.impPago = impPago;
	}
}
