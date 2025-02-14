package com.tmmas.cl.scl.direccioncommon.commonapp.dto;

import java.io.Serializable;

public class DirecClienteListDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private DirecClienteDTO alldirecCliente[];

	/*
	 * private Long Cod_error; private String Des_error; private Long
	 * Num_evento;
	 */

	public DirecClienteListDTO() {

	}

	/*
	 * public Long getCod_error(){ return Cod_error; } public void
	 * setCod_error(Long _Cod_error){ this.Cod_error=_Cod_error; }
	 * 
	 * public String getDes_error(){ return Des_error; } public void
	 * setDes_error(String _Des_error){ this.Des_error=_Des_error; }
	 * 
	 * public Long getNum_evento(){ return Num_evento; } public void
	 * setNum_evento(Long _Num_evento){ this.Num_evento=_Num_evento; }
	 */
	public DirecClienteDTO[] getalldirecCliente() {
		return alldirecCliente;
	}

	public void setalldirecCliente(DirecClienteDTO iAlldirecCliente[]) {
		this.alldirecCliente = iAlldirecCliente;
	}
}
