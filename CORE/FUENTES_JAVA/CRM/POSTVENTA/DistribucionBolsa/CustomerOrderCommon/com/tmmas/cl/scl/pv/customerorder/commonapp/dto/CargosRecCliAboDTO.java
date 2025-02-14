package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class CargosRecCliAboDTO implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long cod_clienteserv;
	private long num_abonadoserv;
	private long cod_clientepago;
	private long num_abonadopago;
	private ProductDTO[] ssActivar;
	private ProductDTO[] ssDesactivar;
	
	
	public long getCod_clientepago() {
		return cod_clientepago;
	}
	public void setCod_clientepago(long cod_clientepago) {
		this.cod_clientepago = cod_clientepago;
	}
	public long getCod_clienteserv() {
		return cod_clienteserv;
	}
	public void setCod_clienteserv(long cod_clienteserv) {
		this.cod_clienteserv = cod_clienteserv;
	}
	public long getNum_abonadopago() {
		return num_abonadopago;
	}
	public void setNum_abonadopago(long num_abonadopago) {
		this.num_abonadopago = num_abonadopago;
	}
	public long getNum_abonadoserv() {
		return num_abonadoserv;
	}
	public void setNum_abonadoserv(long num_abonadoserv) {
		this.num_abonadoserv = num_abonadoserv;
	}
	public ProductDTO[] getSsActivar() {
		return ssActivar;
	}
	public void setSsActivar(ProductDTO[] ssActivar) {
		this.ssActivar = ssActivar;
	}
	public ProductDTO[] getSsDesactivar() {
		return ssDesactivar;
	}
	public void setSsDesactivar(ProductDTO[] ssDesactivar) {
		this.ssDesactivar = ssDesactivar;
	}

}
