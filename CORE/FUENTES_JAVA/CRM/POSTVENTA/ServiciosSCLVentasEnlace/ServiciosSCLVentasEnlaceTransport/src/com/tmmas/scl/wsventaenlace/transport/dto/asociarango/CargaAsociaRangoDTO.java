/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.dto.asociarango;

import java.io.Serializable;

import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;

/**
 * @author mwn40032
 *
 */
public class CargaAsociaRangoDTO extends OOSSDTO implements Serializable
{
	private Long numAbonado;
	private RangoDTO[] rangosAsociados;
	private RangoDTO[] rangosDisponibles;
	private String nomCliente;
	private Long numCelular;
	
	public Long getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}

	public String toString()
	{
		StringBuffer buffer = new StringBuffer("CargaAsociaRangoDTO: ");

		buffer.append(super.toString()).append("\n");
		
		buffer.append("nomCliente = [").append(nomCliente).append("]\n");
		
		buffer.append(numAbonado);
		
		if (rangosAsociados == null)
			buffer.append("\nrangosAsociados = null\n");
		else
		{
			buffer.append("\nrangosAsociados:\n");
			
			for(int i = 0; i < rangosAsociados.length; i++)
				buffer.append(rangosAsociados[i]).append("\n");
		}
		
		if (rangosDisponibles == null)
			buffer.append("\nrangosDisponibles = null\n");
		else
		{
			buffer.append("\nrangosDisponibles:\n");
			
			for(int i = 0; i < rangosDisponibles.length; i++)
				buffer.append(rangosDisponibles[i]).append("\n");
		}

		return buffer.toString();
	}

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public RangoDTO[] getRangosAsociados()
	{
		return rangosAsociados;
	}

	public void setRangosAsociados(RangoDTO[] rangosAsociados)
	{
		this.rangosAsociados = rangosAsociados;
	}

	public RangoDTO[] getRangosDisponibles()
	{
		return rangosDisponibles;
	}

	public void setRangosDisponibles(RangoDTO[] rangosDisponibles)
	{
		this.rangosDisponibles = rangosDisponibles;
	}

	public String getNomCliente()
	{
		return nomCliente;
	}

	public void setNomCliente(String nomCliente)
	{
		this.nomCliente = nomCliente;
	}

	public Long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
}
