/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.dto.asociarango;

import java.io.Serializable;

import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;

public class EjecucionAsociaRangoDTO extends OOSSDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private RangoDTO[] rangosAdicionados;
	private RangoDTO[] rangosEliminados;
	private String comentario;

	public String getComentario() {
		return comentario;
	}

	public void setComentario(String comentario) {
		this.comentario = comentario;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer("EjecucionAsociaRangoDTO:\n");
		buffer.append("comentario = [").append(comentario).append("]\n");
		buffer.append(super.toString()).append("\n");

		if (rangosAdicionados == null)
			buffer.append("\nrangosAdicionados = null\n");
		else {
			buffer.append("\nrangosAdicionados:\n");

			for (int i = 0; i < rangosAdicionados.length; i++)
				buffer.append(rangosAdicionados[i]).append("\n");
		}

		if (rangosEliminados == null)
			buffer.append("\nrangosEliminados = null\n");
		else {
			buffer.append("\nrangosEliminados:\n");

			for (int i = 0; i < rangosEliminados.length; i++)
				buffer.append(rangosEliminados[i]).append("\n");
		}

		return buffer.toString();
	}

	public RangoDTO[] getRangosAdicionados() {
		return rangosAdicionados;
	}

	public void setRangosAdicionados(RangoDTO[] rangosAdicionados) {
		this.rangosAdicionados = rangosAdicionados;
	}

	public RangoDTO[] getRangosEliminados() {
		return rangosEliminados;
	}

	public void setRangosEliminados(RangoDTO[] rangosEliminados) {
		this.rangosEliminados = rangosEliminados;
	}
}
