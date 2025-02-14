package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.retorno;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsMotivosDeDescuentoManualInDTO;

public class WsMotivosDeDescuentoManualDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private WsMotivosDeDescuentoManualInDTO[] CausalesDescuento; 
	private String resultadoTransaccion="0";
	private String codError="0";
	

	public WsMotivosDeDescuentoManualInDTO[] getCausalesDescuento() {
		return CausalesDescuento;
	}
	public void setCausalesDescuento(WsMotivosDeDescuentoManualInDTO[] causalesDescuento) {
		CausalesDescuento = causalesDescuento;
	}
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}

}
