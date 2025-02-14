package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;

public class OutWsClasifClienteDTO extends RetornoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//	cod_tipo: código del tipo de cliente
	private String codTipo;
	//	cod_segmento: código del segmento al cual pertenece el cliente
	private String codSegmento;
	//	des_segmento: descripción del segmento del cliente
	private String desSegmento;
	//	cod_color: código de color del cliente
	private String codColor;
	//des_color: descripción del color del cliente
	private String desColor;
	//	cod_calificacion: código de calificación del cliente
	private String codCalificacion;
	//	des_calificacion: descripción de la calificación del cliente
	private String desCalificacion;
	//	cod_categoria: código de la categoría del cliente
	private String codCategoria;
	//	des_categoria: descripción de la categoría del cliente
	private String desCategoria;
	public String getCodCalificacion() {
		return codCalificacion;
	}
	public void setCodCalificacion(String codCalificacion) {
		this.codCalificacion = codCalificacion;
	}
	public String getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(String codCategoria) {
		this.codCategoria = codCategoria;
	}
	public String getCodColor() {
		return codColor;
	}
	public void setCodColor(String codColor) {
		this.codColor = codColor;
	}
	public String getCodSegmento() {
		return codSegmento;
	}
	public void setCodSegmento(String codSegmento) {
		this.codSegmento = codSegmento;
	}
	public String getCodTipo() {
		return codTipo;
	}
	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}
	public String getDesCalificacion() {
		return desCalificacion;
	}
	public void setDesCalificacion(String desCalificacion) {
		this.desCalificacion = desCalificacion;
	}
	public String getDesCategoria() {
		return desCategoria;
	}
	public void setDesCategoria(String desCategoria) {
		this.desCategoria = desCategoria;
	}
	public String getDesColor() {
		return desColor;
	}
	public void setDesColor(String desColor) {
		this.desColor = desColor;
	}
	public String getDesSegmento() {
		return desSegmento;
	}
	public void setDesSegmento(String desSegmento) {
		this.desSegmento = desSegmento;
	}


}
