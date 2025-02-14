package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;

public class OutWsClasifClienteDTO extends RetornoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//	cod_tipo: c�digo del tipo de cliente
	private String codTipo;
	//	cod_segmento: c�digo del segmento al cual pertenece el cliente
	private String codSegmento;
	//	des_segmento: descripci�n del segmento del cliente
	private String desSegmento;
	//	cod_color: c�digo de color del cliente
	private String codColor;
	//des_color: descripci�n del color del cliente
	private String desColor;
	//	cod_calificacion: c�digo de calificaci�n del cliente
	private String codCalificacion;
	//	des_calificacion: descripci�n de la calificaci�n del cliente
	private String desCalificacion;
	//	cod_categoria: c�digo de la categor�a del cliente
	private String codCategoria;
	//	des_categoria: descripci�n de la categor�a del cliente
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
