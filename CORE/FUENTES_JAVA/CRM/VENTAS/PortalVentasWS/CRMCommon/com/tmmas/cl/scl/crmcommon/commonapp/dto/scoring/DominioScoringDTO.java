package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;

public class DominioScoringDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2253152935804100993L;

	private String codigo;

	private String valor;

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getValor() {
		return valor;
	}

	public void setValor(String valor) {
		this.valor = valor;
	}

	public static DominioScoringDTO[] obtenerArrayDominiosDesdeString(String string) {
		DominioScoringDTO[] toReturn = null;
		string = string.substring(1);
		string = string.substring(0, string.length() - 1);
		String[] stringArray = string.split(",");
		toReturn = new DominioScoringDTO[stringArray.length / 2];
		for (int i = 0; i < stringArray.length; i += 2) {
			toReturn[i / 2] = new DominioScoringDTO();
			toReturn[i / 2].setCodigo(stringArray[i].trim());
			toReturn[i / 2].setValor(stringArray[i + 1].trim());
		}
		return toReturn;
	}

	public String toString() {
		StringBuffer b = new StringBuffer();
		b.append("getCodigo() " + "[" + getCodigo() + "]\n");
		b.append("getValor() " + "[" + getValor() + "]\n");
		return b.toString();
	}
	
	public static String getDescripcion(DominioScoringDTO[] dominos, String codigo) {
		String descripcion = null;
		for (int i = 0; i < dominos.length; i++) {
			DominioScoringDTO dto = dominos[i];
			if (codigo.equals(dto.getCodigo())) {
				descripcion = dto.getValor();
				break;
			}
		}
		return descripcion;
	}
}
