package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class TipoPagoDTO
    implements Serializable {

            private static final long serialVersionUID = 1L;
            private String tipValor;
            private String descripcionTipValor;


            public String getTipValor() {
            	return tipValor;
            }

            public void setTipValor(String tipValor) {
            	this.tipValor = tipValor;
            }

            public String getDescripcionTipValor() {
            	return descripcionTipValor;
            }

            public void setDescripcionTipValor(String descripcionTipValor) {
            	this.descripcionTipValor = descripcionTipValor;
            }
}
