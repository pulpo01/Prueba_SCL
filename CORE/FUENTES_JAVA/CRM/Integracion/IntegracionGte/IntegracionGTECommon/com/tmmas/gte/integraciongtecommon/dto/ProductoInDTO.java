package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 */

public class ProductoInDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private int codProducto;

	public int getCodProducto() {
		return codProducto;
	}

	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}


}