package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsListTipoPagoOutDTO extends RetornoDTO
    implements Serializable {

            private static final long serialVersionUID = 1L;
            private TipoPagoDTO tipoPagoArrOutDTO[];
            private String resultadoTransaccion;

            public WsListTipoPagoOutDTO() {
            	resultadoTransaccion = "0";
            }

            public String getResultadoTransaccion() {
            	return resultadoTransaccion;
            }

            public void setResultadoTransaccion(String resultadoTransaccion) {
            	this.resultadoTransaccion = resultadoTransaccion;
            }

            public TipoPagoDTO[] getTipoPagoArrOutDTO() {
            	return tipoPagoArrOutDTO;
            }

            public void setTipoPagoArrOutDTO(TipoPagoDTO tipoPagoArrOutDTO[]) {
            	this.tipoPagoArrOutDTO = tipoPagoArrOutDTO;
            }
}
